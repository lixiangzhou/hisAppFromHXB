//
//  HXBMY_PlanListViewController.m
//  hoomxb
//
//  Created by HXB on 2017/5/16.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_PlanListViewController.h"
#import "HXBMY_PlanList_DetailViewController.h"

#import "HXBMYViewModel_MianPlanViewModel.h"// plan ViewModel
#import "HXBMYModel_MainPlanModel.h"//plan model
#import "HXBMainListView_Plan.h"
#import "HXBMYModel_Plan_planRequestModel.h"
#import "HXBMy_Plan_Swipe.h"
#import "HXBMyPlanListViewModel.h"
#import "HXBBaseViewModel+KEYCHAIN.h"

@interface HXBMY_PlanListViewController ()
#pragma mark - view
@property (nonatomic,strong) HXBMainListView_Plan *planListView;//里面有toolblarView

#pragma mark -  关于plan list 的 数据

@property (nonatomic, strong) HXBMyPlanListViewModel* viewModel;
///是否是首次进入页面
@property (nonatomic, assign) BOOL isFirstEntry;
@end

@implementation HXBMY_PlanListViewController
//MARK: 销毁
kDealloc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isTransparentNavigationBar = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title  = @"红利智投";
    [self setUP];
    //防止跳转的时候，tableView向上或者向下移动
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    };
    self.isFirstEntry = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ///网络请求
    [self downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_HOLD_PLAN andIsUpData:YES];
    ///请求资产统计的网络请求
    [self assetStatisticsLoadData];
    self.isFirstEntry = NO;
}

//设置
- (void)setUP {
    self.isRedColorWithNavigationBar = YES;
    ///view的创建
    [self setupView];
    ///网络请求
//    [self downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_HOLD_PLAN andIsUpData:YES];
    ///事件的传递
    [self registerEvent];
    //刷新  加载
    [self registerRefresh];
    //cell 点击的加载
    [self registerClickCell];

}

#pragma 获取viewModel

- (HXBMyPlanListViewModel *)viewModel {
    if(!_viewModel) {
        kWeakSelf
        _viewModel = [[HXBMyPlanListViewModel alloc] initWithBlock:^UIView *{
            return weakSelf.view;
        }];
    }
    
    return _viewModel;
}

/**
 再次获取网络数据
 */
- (void)getNetworkAgain
{
    [self downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_HOLD_PLAN andIsUpData:YES];
    ///请求资产统计的网络请求
    [self assetStatisticsLoadData];
}

///资产统计网络请求
- (void)assetStatisticsLoadData {
    kWeakSelf
    [self.viewModel downLoadUserInfo:YES resultBlock:^(BOOL isSuccess) {
        if (isSuccess) weakSelf.planListView.userInfoViewModel = weakSelf.viewModel.userInfoModel;
    }];
}

//搭建UI
- (void)setupView {
    self.planListView = [[HXBMainListView_Plan alloc]initWithFrame:CGRectMake(0, HXBStatusBarAndNavigationBarHeight, kScreenWidth, kScreenHeight - HXBStatusBarAndNavigationBarHeight)];
    [self.view addSubview:self.planListView];
}


#pragma mark - 下载数据
- (void)downLoadDataWitRequestType: (HXBRequestType_MY_PlanRequestType) requestType andIsUpData: (BOOL)isUpData{
    __weak typeof (self)weakSelf = self;
    //请求资产数据
    
    [self.viewModel myPlanAssetStatistics_requestWithSuccessBlock:self.isFirstEntry andResultBlock:^(BOOL isSuccess) {
        if(isSuccess) {
            weakSelf.planListView.planAccountModel = weakSelf.viewModel.planAcccountModel;
        }
        
    }];
    
    [self getDataWitRequestType:requestType andIsUpData:isUpData];
    //如果是下拉刷新， 则刷新所有列表数据
    if(isUpData) {
        switch (requestType) {
            case HXBRequestType_MY_PlanRequestType_HOLD_PLAN://持有中
                [self getDataWitRequestType:HXBRequestType_MY_PlanRequestType_EXIT_PLAN andIsUpData:isUpData];
                [self getDataWitRequestType:HXBRequestType_MY_PlanRequestType_EXITING_PLAN andIsUpData:isUpData];
                break;
            case HXBRequestType_MY_PlanRequestType_EXIT_PLAN: //已经推出
                [self getDataWitRequestType:HXBRequestType_MY_PlanRequestType_HOLD_PLAN andIsUpData:isUpData];
                [self getDataWitRequestType:HXBRequestType_MY_PlanRequestType_EXITING_PLAN andIsUpData:isUpData];
                break;
            case HXBRequestType_MY_PlanRequestType_EXITING_PLAN://正在推出
                [self getDataWitRequestType:HXBRequestType_MY_PlanRequestType_HOLD_PLAN andIsUpData:isUpData];
                [self getDataWitRequestType:HXBRequestType_MY_PlanRequestType_EXIT_PLAN andIsUpData:isUpData];
                break;
        }
    }
}

- (void)getDataWitRequestType: (HXBRequestType_MY_PlanRequestType) requestType andIsUpData: (BOOL)isUpData{
    kWeakSelf
    [self.viewModel myPlan_requestWithPlanType:requestType andUpData:isUpData andResultBlock:^(BOOL isSuccess) {
        [weakSelf.planListView endRefresh];
        if(isSuccess) {
            //数据的分发
            [weakSelf handleViewModelArrayWithViewModelArray:requestType];
        }
    }];
}

///网络数据请求数据处理
- (void)handleViewModelArrayWithViewModelArray: (HXBRequestType_MY_PlanRequestType) requestType{
    
    switch (requestType) {
        case HXBRequestType_MY_PlanRequestType_HOLD_PLAN://持有中
        {
            self.planListView.hold_Plan_array = self.viewModel.hold_Plan_array;
            self.planListView.isHoldPlanShowLoadMore = self.viewModel.isHoldPlanShowLoadMore;
            self.planListView.isHoldPlanLastPage = self.viewModel.isHoldPlanLastPage;
            break;
        }
        case HXBRequestType_MY_PlanRequestType_EXIT_PLAN: //已经推出
        {
            self.planListView.exit_Plan_array = self.viewModel.exit_Plan_array;
            self.planListView.isExitedShowLoadMore = self.viewModel.isExitedShowLoadMore;
            self.planListView.isExitedLastPage = self.viewModel.isExitedLastPage;
            break;
        }
        case HXBRequestType_MY_PlanRequestType_EXITING_PLAN://正在推出
        {
            self.planListView.exiting_Plan_array = self.viewModel.exiting_Plan_array;
            self.planListView.isExitingShowLoadMore = self.viewModel.isExitingShowLoadMore;
            self.planListView.isExitingLastPage = self.viewModel.isExitingLastPage;
            break;
        }
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
                if (!weakSelf.viewModel.hold_Plan_array.count) [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_HOLD_PLAN andIsUpData:YES];
                break;
                
                //退出中
            case HXBRequestType_MY_PlanRequestType_EXITING_PLAN:
                if (!weakSelf.viewModel.exiting_Plan_array.count) [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_EXITING_PLAN andIsUpData:YES];
                break;
            
                //已退出
            case HXBRequestType_MY_PlanRequestType_EXIT_PLAN:
                if (!weakSelf.viewModel.exit_Plan_array.count) [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_EXIT_PLAN andIsUpData:YES];
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
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_HOLD_PLAN andIsUpData:NO];
    } andUPBlock:^{
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_HOLD_PLAN andIsUpData:YES];
        [weakSelf assetStatisticsLoadData];
    }];
}
- (void) refresh_exiting {
    __weak typeof (self)weakSelf = self;
    [self.planListView exiting_RefreashWithDownBlock:^{
        [weakSelf assetStatisticsLoadData];
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_EXITING_PLAN andIsUpData:NO];
    } andUPBlock:^{
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_EXITING_PLAN andIsUpData:YES];
        [weakSelf assetStatisticsLoadData];
    }];
}
- (void) refresh_exit {
    __weak typeof (self)weakSelf = self;
    [self.planListView exit_RefreashWithDownBlock:^{
        [weakSelf assetStatisticsLoadData];
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_EXIT_PLAN andIsUpData:NO];
    } andUPBlock:^{
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_PlanRequestType_EXIT_PLAN andIsUpData:YES];
        [weakSelf assetStatisticsLoadData];
    }];
}

#pragma mark - cell点击事件的注册
- (void)registerClickCell {
    //持有中
    kWeakSelf
    [self.planListView clickLoan_hold_CellFuncWithBlock:^(HXBMYViewModel_MianPlanViewModel *planViewModel, NSIndexPath *clickLoanCellIndex) {
        HXBMY_PlanList_DetailViewController *planListDetailVC = [[HXBMY_PlanList_DetailViewController alloc]init];
        planListDetailVC.planViewModel = planViewModel;
        planListDetailVC.cake = 5;
        planListDetailVC.type = HXBRequestType_MY_PlanRequestType_HOLD_PLAN;
        [weakSelf.navigationController pushViewController:planListDetailVC animated:YES];
    }];
    //退出中
    [self.planListView clickLoan_exiting_CellFuncWithBlock:^(HXBMYViewModel_MianPlanViewModel *planViewModel, NSIndexPath *clickLoanCellIndex) {
        HXBMY_PlanList_DetailViewController *planListDetailVC = [[HXBMY_PlanList_DetailViewController alloc]init];
        planListDetailVC.planViewModel = planViewModel;
        planListDetailVC.cake = 5;
        planListDetailVC.type = HXBRequestType_MY_PlanRequestType_EXITING_PLAN;
        [weakSelf.navigationController pushViewController:planListDetailVC animated:YES];
    }];
    //已退出
    [self.planListView clickLoan_exit_CellFuncWithBlock:^(HXBMYViewModel_MianPlanViewModel *planViewModel, NSIndexPath *clickLoanCellIndex) {
        HXBMY_PlanList_DetailViewController *planListDetailVC = [[HXBMY_PlanList_DetailViewController alloc]init];
        planListDetailVC.cake = 4;
        planListDetailVC.planViewModel = planViewModel;
        planListDetailVC.type = HXBRequestType_MY_PlanRequestType_EXIT_PLAN;
        [weakSelf.navigationController pushViewController:planListDetailVC animated:YES];
    }];
}

@end
