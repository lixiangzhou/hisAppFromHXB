//
//  HXBMY_PlanListViewController.m
//  hoomxb
//
//  Created by HXB on 2017/5/16.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_PlanListViewController.h"
#import "HXBMY_PlanList_DetailViewController.h"

#import "HXBMYViewModel_MianPlanViewModel.h"// plan ViewModel
#import "HXBMYModel_MainPlanModel.h"//plan model
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
//MARK: 销毁
kDealloc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUP];
    ///网络请求
    [self downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_HOLD_PLAN andIsUpData:true];
    //防止跳转的时候，tableView向上或者向下移动
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    };
}

//设置
- (void)setUP {
    
    ///请求资产统计的网络请求
    [self assetStatisticsLoadData];
    ///view的创建
    [self setupView];
    ///网络请求
    [self downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_HOLD_PLAN andIsUpData:true];
    ///事件的传递
    [self registerEvent];
    //刷新  加载
    [self registerRefresh];
    //cell 点击的加载
    [self registerClickCell];
}

///资产统计网络请求
- (void)assetStatisticsLoadData {
    [[HXBMYRequest sharedMYRequest] myPlanAssetStatistics_requestWithSuccessBlock:^(HXBMYModel_AssetStatistics_Plan *model) {
        self.planListView.planAssetStatisticsModel = model;
    } andFailureBlock:^(NSError *error) {}];
}

//搭建UI
- (void)setupView {
    self.planListView = [[HXBMainListView_Plan alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.planListView];
}


#pragma mark - 下载数据
- (void)downLoadDataWitRequestType: (HXBRequestType_MY_PlanRequestType) requestType andIsUpData: (BOOL)isUpData{
    __weak typeof (self)weakSelf = self;
    [[HXBMYRequest sharedMYRequest] myPlan_requestWithPlanType:requestType andUpData:isUpData andSuccessBlock:^(NSArray<HXBMYViewModel_MianPlanViewModel *> *viewModelArray) {
        //数据的分发
        [weakSelf handleViewModelArrayWithViewModelArray:viewModelArray];
        [weakSelf.planListView endRefresh];
    } andFailureBlock:^(NSError *error) {
        [weakSelf.planListView endRefresh];
    }];
}
///网络数据请求数据处理
- (void)handleViewModelArrayWithViewModelArray: (NSArray<HXBMYViewModel_MianPlanViewModel *>*)planViewModelArray{
//    如果 没有值就直接return
    if (!planViewModelArray.count) return;
    //
    switch (planViewModelArray.firstObject.requestType) {
        case HXBRequestType_MY_PlanRequestType_HOLD_PLAN://持有中
            self.planListView.hold_Plan_array = planViewModelArray;
            self.planListView.hold_Plan_array = [[NSArray alloc]init];
            self.hold_Plan_array = planViewModelArray;
            break;
        case HXBRequestType_MY_PlanRequestType_EXIT_PLAN: //已经推出
            self.exit_Plan_array = planViewModelArray;
            self.planListView.exit_Plan_array = planViewModelArray;
            self.planListView.exit_Plan_array = [[NSArray alloc]init];
            break;
        case HXBRequestType_MY_PlanRequestType_EXITING_PLAN://正在推出
            self.planListView.exiting_Plan_array = planViewModelArray;
            self.exiting_Plan_array = planViewModelArray;
            self.planListView.exiting_Plan_array = [[NSArray alloc]init];
            break;
    }
}




#pragma mark - 注册事件
- (void) registerEvent {
    // 中部的toolBarView的选中的option变化时候调用
    [self setupMidToolBarViewChangeSelect];
}
//MARK:  中部的toolBarView的选中的option变化时候调用
- (void) setupMidToolBarViewChangeSelect {
    //根据type来对相应的 界面进行网络请求 如果
    __weak typeof (self)weakSelf = self;
    [self.planListView changeMidSelectOptionFuncWithBlock:^(UIButton *button, NSString *title, NSInteger index, HXBRequestType_MY_PlanRequestType type) {
        switch (type) {
                //持有中
            case HXBRequestType_MY_PlanRequestType_HOLD_PLAN:
                if (!weakSelf.hold_Plan_array.count) [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_HOLD_PLAN andIsUpData:true];
                break;
                
                //退出中
            case HXBRequestType_MY_PlanRequestType_EXITING_PLAN:
                if (!weakSelf.exiting_Plan_array.count) [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_EXITING_PLAN andIsUpData:true];
                break;
            
                //已退出
            case HXBRequestType_MY_PlanRequestType_EXIT_PLAN:
                if (!weakSelf.exit_Plan_array.count) [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_EXIT_PLAN andIsUpData:true];
                break;
        }
    }];
}

//MARK: - 刷新 加载 注册
- (void) registerRefresh {
    [self refresh_hold];
    [self refresh_exiting];
    [self refresh_exit];
}
- (void) refresh_hold {
    __weak typeof(self)weakSelf = self;
    [self.planListView hold_RefreashWithDownBlock:^{
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_HOLD_PLAN andIsUpData:false];
    } andUPBlock:^{
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_HOLD_PLAN andIsUpData:true];
    }];
}
- (void) refresh_exiting {
    __weak typeof (self)weakSelf = self;
    [self.planListView exiting_RefreashWithDownBlock:^{
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_EXITING_PLAN andIsUpData:false];
    } andUPBlock:^{
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_EXITING_PLAN andIsUpData:true];
    }];
}
- (void) refresh_exit {
    __weak typeof (self)weakSelf = self;
    [self.planListView exit_RefreashWithDownBlock:^{
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_EXIT_PLAN andIsUpData:false];
    } andUPBlock:^{
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_EXIT_PLAN andIsUpData:true];
    }];
}

#pragma mark - cell点击事件的注册
- (void)registerClickCell {
    //持有中
    kWeakSelf
    [self.planListView clickLoan_hold_CellFuncWithBlock:^(HXBMYViewModel_MianPlanViewModel *planViewModel, NSIndexPath *clickLoanCellIndex) {
        HXBMY_PlanList_DetailViewController *planListDetailVC = [[HXBMY_PlanList_DetailViewController alloc]init];
        planListDetailVC.planViewModel = planViewModel;
        [weakSelf.navigationController pushViewController:planListDetailVC animated:true];
    }];
    //退出中
    
    [self.planListView clickLoan_exiting_CellFuncWithBlock:^(HXBMYViewModel_MianPlanViewModel *planViewModel, NSIndexPath *clickLoanCellIndex) {
        HXBMY_PlanList_DetailViewController *planListDetailVC = [[HXBMY_PlanList_DetailViewController alloc]init];
        planListDetailVC.planViewModel = planViewModel;
        [weakSelf.navigationController pushViewController:planListDetailVC animated:true];
    }];
    //已退出
    [self.planListView clickLoan_exit_CellFuncWithBlock:^(HXBMYViewModel_MianPlanViewModel *planViewModel, NSIndexPath *clickLoanCellIndex) {
        HXBMY_PlanList_DetailViewController *planListDetailVC = [[HXBMY_PlanList_DetailViewController alloc]init];
        planListDetailVC.planViewModel = planViewModel;
        [weakSelf.navigationController pushViewController:planListDetailVC animated:true];
    }];
}

@end
