//
//  HXBMY_PlanListViewController.m
//  hoomxb
//
//  Created by HXB on 2017/5/16.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_PlanListViewController.h"
#import "HXBMYViewModel_MianPlanViewModel.h"
#import "HXBMainListView_Plan.h"
#import "HXBMYRequest.h"

@interface HXBMY_PlanListViewController ()
#pragma mark - view
@property (nonatomic,strong) HXBMainListView_Plan *planListView;//里面有toolblarView


#pragma mark -  关于plan list 的 数据
///持有中
@property (nonatomic,strong) NSArray <HXBMYViewModel_MianPlanViewModel *>*hold_Plan_array;
///plan 推出中
@property (nonatomic,strong) NSArray <HXBMYViewModel_MianPlanViewModel *>*exiting_Plan_array;
///plan 已退出
@property (nonatomic,strong) NSArray <HXBMYViewModel_MianPlanViewModel *>*exit_Plan_array;

@end

@implementation HXBMY_PlanListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUP];
    ///网络请求
    [self downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_HOLD_PLAN andIsUpData:true];
}

//设置
- (void)setUP {
    ///view的创建
    [self setupView];
    ///网络请求
    [self downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_HOLD_PLAN andIsUpData:true];
    ///事件的传递
    [self registerEvent];
}

//搭建UI
- (void)setupView {
    self.planListView = [[HXBMainListView_Plan alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.planListView];
}


#pragma mark - 下载数据
- (void)downLoadDataWitRequestType: (HXBRequestType_MY_PlanRequestType) requestType andIsUpData: (BOOL)isUpData{
    [[HXBMYRequest sharedMYRequest] myPlan_requestWithPlanType:requestType andUpData:isUpData andSuccessBlock:^(NSArray<HXBMYViewModel_MianPlanViewModel *> *viewModelArray) {
        //数据的分发
        [self handleViewModelArrayWithViewModelArray:viewModelArray];
    
    } andFailureBlock:^(NSError *error) {
        
    }];
}

- (void)handleViewModelArrayWithViewModelArray: (NSArray <HXBMYViewModel_MianPlanViewModel *>*)planViewModelArray{
    switch (planViewModelArray.firstObject.requestType) {
        case HXBRequestType_MY_PlanRequestType_HOLD_PLAN://持有中
            self.planListView.hold_Plan_array = planViewModelArray;
            self.hold_Plan_array = planViewModelArray;
            break;
        case HXBRequestType_MY_PlanRequestType_EXIT_PLAN: //已经推出
            self.exit_Plan_array = planViewModelArray;
            self.planListView.exit_Plan_array = planViewModelArray;
            break;
        case HXBRequestType_MY_PlanRequestType_EXITING_PLAN://正在推出
            self.planListView.exiting_Plan_array = planViewModelArray;
            self.exiting_Plan_array = planViewModelArray;
            break;
    }
}




#pragma mark - 注册事件
- (void) registerEvent {
    // 中部的toolBarView的选中的option变化时候调用
    [self setupMidToolBarViewChangeSelect];
}
// 中部的toolBarView的选中的option变化时候调用
- (void) setupMidToolBarViewChangeSelect {
    __weak typeof (self)weakSelf = self;
    [self.planListView changeMidSelectOptionFuncWithBlock:^(UIButton *button, NSString *title, NSInteger index, HXBRequestType_MY_PlanRequestType type) {
        switch (type) {
            case HXBRequestType_MY_PlanRequestType_HOLD_PLAN:
                if (!self.hold_Plan_array.count) [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_EXITING_PLAN andIsUpData:true];
                break;
                
            case HXBRequestType_MY_PlanRequestType_EXIT_PLAN:
                if (!self.exit_Plan_array.count) [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_EXIT_PLAN andIsUpData:true];
                break;
            case HXBRequestType_MY_PlanRequestType_EXITING_PLAN:
                if (!self.exiting_Plan_array.count) [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_EXITING_PLAN andIsUpData:true];
                break;
        }
    }];
}

//MARK: - 刷新 加载 时间注册
- (void) refresh_hold {
    __weak typeof(self)weakSelf = self;
    [self.planListView hold_RefreashWithDownBlock:^{
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_HOLD_PLAN andIsUpData:true];
    } andUPBlock:^{
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_HOLD_PLAN andIsUpData:false];
    }];
}
- (void) refresh_exit {
    __weak typeof (self)weakSelf = self;
    [self.planListView hold_RefreashWithDownBlock:^{
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_EXIT_PLAN andIsUpData:true];
    } andUPBlock:^{
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_EXIT_PLAN andIsUpData:false];
    }];
}
- (void) refresh_exiting {
    __weak typeof (self)weakSelf = self;
    [self.planListView hold_RefreashWithDownBlock:^{
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_EXITING_PLAN andIsUpData:true];
    } andUPBlock:^{
//       weakSelf d 
    }];
}
@end
