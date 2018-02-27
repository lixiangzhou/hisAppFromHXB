//
//  HXBMY_LoanListViewController.m
//  hoomxb
//
//  Created by HXB on 2017/5/16.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_LoanListViewController.h"
#import "HXBMainListView_Loan.h"
#import "HXBMYViewModel_MainLoanViewModel.h"
#import "HXBMYRequest.h"
#import "HXBMYModel_AssetStatistics_Loan.h"
#import "HXBMY_LoanList_DetailViewController.h"
#import "HXBMYModel_Loan_LoanRequestModel.h"///资产
#import "HXBMy_Loan_Swipe.h"
#import "HXBMY_LoanListViewModel.h"
#import "HXBBaseViewModel+KEYCHAIN.h"

@interface HXBMY_LoanListViewController ()

@property (nonatomic,strong) HXBMainListView_Loan *loanListView;

@property (nonatomic, strong) HXBMY_LoanListViewModel* viewModel;
///是否是首次进入页面
@property (nonatomic, assign) BOOL isFirstEntry;
@end

@implementation HXBMY_LoanListViewController

//MARK: 销毁
kDealloc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isColourGradientNavigationBar = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"散标债权";
    //防止跳转的时候，tableView向上或者向下移动
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    };
    [self setUP];
    
    self.isFirstEntry = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self downLoadDataWitRequestType:HXBRequestType_MY_LoanRequestType_REPAYING_LOAN andIsUpData:YES];
    self.isFirstEntry = NO;
}

/**
 再次获取网络数据
 */
- (void)getNetworkAgain
{
     [self downLoadDataWitRequestType:HXBRequestType_MY_LoanRequestType_REPAYING_LOAN andIsUpData:YES];
    ///请求资产统计的网络请求
    [self assetStatisticsLoadData];
}
//设置
- (void)setUP {
    ///请求资产统计的网络请求
    [self assetStatisticsLoadData];
    ///view的创建
    [self setupView];
    ///网络请求
//    [self downLoadDataWitRequestType:HXBRequestType_MY_LoanRequestType_REPAYING_LOAN andIsUpData:YES];
    ///事件的传递
    [self registerEvent];
    //刷新  加载
    [self registerRefresh];
    //cell的点击事件的注册
    [self registerCilickCellEvent];
    // 当底部的tableView 左右切换 事件的注册
    [self registerSwichScrollViewCallBack];
}

/// userinfo 数据请求
- (void)assetStatisticsLoadData {
    kWeakSelf
    [_viewModel downLoadUserInfo:YES resultBlock:^(BOOL isSuccess) {
        if (isSuccess) weakSelf.loanListView.userInfoViewModel = weakSelf.viewModel.userInfoModel;
    }];
}

//搭建UI
- (void)setupView {
    self.loanListView = [[HXBMainListView_Loan alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.loanListView];
}

#pragma mark 初始化 viewModel
- (HXBMY_LoanListViewModel *)viewModel {
    if(!_viewModel) {
        kWeakSelf
        _viewModel = [[HXBMY_LoanListViewModel alloc] initWithBlock:^UIView *{
            return weakSelf.view;
        }];
    }
    
    return _viewModel;
}

#pragma mark - 下载数据
- (void)downLoadDataWitRequestType: (HXBRequestType_MY_LoanRequestType) requestType andIsUpData: (BOOL)isUpData {
    //资产统计网络请求
    
    kWeakSelf
    BOOL isShowHud = self.isFirstEntry? YES : NO;
    [self.viewModel loanAssets_AccountRequestSuccessBlock:isShowHud andResultBlock:^(BOOL isSuccess) {
        weakSelf.loanListView.loanAccountModel = weakSelf.viewModel.loanAcccountModel;
    }];
    
    [self getLoanDataWitRequestType:requestType andIsUpData:isUpData];
    //如果是下拉刷新， 则刷新所有列表数据
    if(isUpData) {
        switch (requestType) {
            case HXBRequestType_MY_LoanRequestType_REPAYING_LOAN://收益中
                [self getLoanDataWitRequestType:HXBRequestType_MY_LoanRequestType_BID_LOAN andIsUpData:isUpData];
                [self downLoadDataLoantruansferIsUPData:isUpData isSynFreshList:NO];
                break;
            case HXBRequestType_MY_LoanRequestType_BID_LOAN://投标中
                [self getLoanDataWitRequestType:HXBRequestType_MY_LoanRequestType_REPAYING_LOAN andIsUpData:isUpData];
                [self downLoadDataLoantruansferIsUPData:isUpData isSynFreshList:NO];
                break;
            default:
                break;
        }
    }
}

- (void)getLoanDataWitRequestType:(HXBRequestType_MY_LoanRequestType) requestType andIsUpData: (BOOL)isUpData {
    kWeakSelf
    [self.viewModel myLoan_requestWithLoanType:requestType andUpData:isUpData andResultBlock:^(BOOL isSuccess) {
        [weakSelf.loanListView endRefresh];
        if(isSuccess){
            [weakSelf handleViewModelArrayWithViewModelArray:requestType];
        }
    }];
}

///转让中的网络请求
- (void)downLoadDataLoantruansferIsUPData:(BOOL)isUpData  isSynFreshList:(BOOL)isSyn{
    kWeakSelf
    [self.viewModel myLoanTruansfer_requestWithLoanTruansferWithIsUPData:isUpData andResultBlock:^(BOOL isSuccess) {
        [weakSelf.loanListView endRefresh];
        if(isSuccess) {
            [weakSelf handleViewModelArrayWithViewModelArray:HXBRequestType_MY_LoanRequestType_Truansfer];
        }
    }];
   
    if(isUpData && isSyn) {
        [self getLoanDataWitRequestType:HXBRequestType_MY_LoanRequestType_BID_LOAN andIsUpData:isUpData];
        [self getLoanDataWitRequestType:HXBRequestType_MY_LoanRequestType_REPAYING_LOAN andIsUpData:isUpData];
    }
}

///网络数据请求数据处理
- (void)handleViewModelArrayWithViewModelArray: (HXBRequestType_MY_LoanRequestType)requestType{
    switch (requestType) {
        case HXBRequestType_MY_LoanRequestType_REPAYING_LOAN://收益中
        {
            self.loanListView.repaying_ViewModelArray = self.viewModel.repaying_Loan_array;
            self.loanListView.isRepayingShowLoadMore = self.viewModel.isRepayingShowLoadMore;
            self.loanListView.isRepayingLastPage = self.viewModel.isRepayingLastPage;
            break;
        }
        case HXBRequestType_MY_LoanRequestType_BID_LOAN://投标中
        {
            self.loanListView.bid_ViewModelArray = self.viewModel.bid_Loan_array;
            self.loanListView.isBidShowLoadMore = self.viewModel.isBidShowLoadMore;
            self.loanListView.isBidLastPage = self.viewModel.isBidLastPage;
            break;
        }
        case HXBRequestType_MY_LoanRequestType_Truansfer: //转让中
        {
            self.loanListView.loanTruansferViewModelArray = self.viewModel.loanTruanfserViewModelArray;
            self.loanListView.isTruanfserShowLoadMore = self.viewModel.isTruanfserShowLoadMore;
            self.loanListView.isTruanfserLastPage = self.viewModel.isTruanfserLastPage;
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
    [self.loanListView changeMidSelectOptionFuncWithBlock:^(UIButton *button, NSString *title, NSInteger index, HXBRequestType_MY_LoanRequestType type) {
        switch (type) {
                
            case HXBRequestType_MY_LoanRequestType_REPAYING_LOAN:
                if (!weakSelf.viewModel.repaying_Loan_array.count) [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_LoanRequestType_REPAYING_LOAN andIsUpData:YES];
                break;
                
            case HXBRequestType_MY_LoanRequestType_BID_LOAN:
                if (!weakSelf.viewModel.bid_Loan_array.count) [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_LoanRequestType_BID_LOAN andIsUpData:YES];
                break;
                //转让中
            case HXBRequestType_MY_LoanRequestType_Truansfer:
                if (!weakSelf.viewModel.loanTruanfserViewModelArray.count) {
                    [weakSelf downLoadDataLoantruansferIsUPData:YES isSynFreshList:YES];
                }
                break;
        }
    }];
}

//MARK: - 刷新 加载 注册
- (void) registerRefresh {
    [self refresh_bid];
    [self refresh_repying];
    [self refresh_loanTruansfer];
}
- (void) refresh_bid {
    __weak typeof(self)weakSelf = self;
    [self.loanListView bid_RefreashWithDownBlock:^{
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_LoanRequestType_BID_LOAN andIsUpData:NO];
    } andUPBlock:^{
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_LoanRequestType_BID_LOAN andIsUpData:YES];
        [weakSelf assetStatisticsLoadData];
    }];
}
- (void) refresh_repying {
    __weak typeof (self)weakSelf = self;
    [self.loanListView erpaying_RefreashWithDownBlock:^{
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_LoanRequestType_REPAYING_LOAN andIsUpData:NO];
    } andUPBlock:^{
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_LoanRequestType_REPAYING_LOAN andIsUpData:YES];
        [weakSelf assetStatisticsLoadData];
    }];
}
- (void) refresh_loanTruansfer {
    kWeakSelf
    [self.loanListView loanTruansfer_RefreashWithDownBlock:^{
        [weakSelf downLoadDataLoantruansferIsUPData:NO isSynFreshList:YES];
    } andUPBlock:^{
        [weakSelf downLoadDataLoantruansferIsUPData:YES isSynFreshList:YES];
        [weakSelf assetStatisticsLoadData];
    }];
}
///切换底部的ScrollView的时候调用
- (void)registerSwichScrollViewCallBack {
    __weak typeof(self)weakSelf = self;
    [self.loanListView switchBottomScrollViewCallBackFunc:^(NSInteger index, NSString *title, UIButton *option) {
        if ([title isEqualToString:HXBRequestType_MY_REPAYING_LOAN_UI]) {
            if (!weakSelf.viewModel.repaying_Loan_array.count){///在收益中刷新
                [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_LoanRequestType_REPAYING_LOAN andIsUpData:YES];
            }
        }
        if ([title isEqualToString:HXBRequestType_MY_BID_LOAN_UI]) {///投标中刷新
            if (!weakSelf.viewModel.bid_Loan_array.count) {
                [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_LoanRequestType_BID_LOAN andIsUpData:YES];
            }
        }
        //转让中
        if (index == 2) {
            if (!weakSelf.viewModel.loanTruanfserViewModelArray.count) {
                [weakSelf downLoadDataLoantruansferIsUPData:YES isSynFreshList:YES];
            }
        }
    }];
}

#pragma mark - 点击cell 事件的注册
- (void)registerCilickCellEvent {
    kWeakSelf
    [self.loanListView clickLoan_repaying_CellFuncWithBlock:^(HXBMYViewModel_MainLoanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex) {
        HXBMY_LoanList_DetailViewController *planListDetailViewController = [[HXBMY_LoanList_DetailViewController alloc]init];
        planListDetailViewController.loanDetailViewModel = loanViewModel;
        [weakSelf.navigationController pushViewController:planListDetailViewController animated:YES];
    }];
    [self.loanListView clickLoan_bid_CellFuncWithBlock:^(HXBMYViewModel_MainLoanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex) {
//        HXBMY_LoanList_DetailViewController *planListDetailViewController = [[HXBMY_LoanList_DetailViewController alloc]init];
//        planListDetailViewController.loanDetailViewModel = loanViewModel;
//        [weakSelf.navigationController pushViewController:planListDetailViewController animated:YES];
        NSLog(@"散标列表暂无详情页");
    }];
}
@end
