//
//  HXBMY_LoanListViewController.m
//  hoomxb
//
//  Created by HXB on 2017/5/16.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_LoanListViewController.h"
#import "HXBMainListView_Loan.h"
#import "HXBMYViewModel_MainLoanViewModel.h"
#import "HXBMYRequest.h"
#import "HXBMY_PlanList_DetailViewController.h"
#import "HXBMYModel_AssetStatistics_Loan.h"
#import "HXBMY_LoanList_DetailViewController.h"
#import "HXBMYModel_Loan_LoanRequestModel.h"///资产
#import "HXBMy_Loan_Swipe.h"
@interface HXBMY_LoanListViewController ()

@property (nonatomic,strong) HXBMainListView_Loan *loanListView;

@property (nonatomic,strong) NSArray <HXBMYViewModel_MainLoanViewModel *>*loan_BID_ViewModelArray;
@property (nonatomic,strong) NSArray <HXBMYViewModel_MainLoanViewModel *>*loan_REPAYING_ViewModelArray;
@property (nonatomic,strong) HXBMYModel_Loan_LoanRequestModel *loanAccountModel;
@end

@implementation HXBMY_LoanListViewController

//MARK: 销毁
kDealloc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"散标理财";
    //防止跳转的时候，tableView向上或者向下移动
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    };
    [self setUP];
}

//设置
- (void)setUP {
    ///请求资产统计的网络请求
    [self assetStatisticsLoadData];
    ///view的创建
    [self setupView];
    ///网络请求
    [self downLoadDataWitRequestType:HXBRequestType_MY_LoanRequestType_REPAYING_LOAN andIsUpData:true];
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
    [[KeyChainManage sharedInstance] downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        self.loanListView.userInfoViewModel = viewModel;
    } andFailure:^(NSError *error) {
        
    }];
}

//搭建UI
- (void)setupView {
    self.loanListView = [[HXBMainListView_Loan alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.loanListView];
}
#pragma mark - 下载数据
- (void)downLoadDataWitRequestType: (HXBRequestType_MY_LoanRequestType) requestType andIsUpData: (BOOL)isUpData{
    //资产统计网络请求
    HXBMYRequest *request = [[HXBMYRequest alloc]init];
    [request loanAssets_AccountRequestSuccessBlock:^(HXBMYModel_Loan_LoanRequestModel *viewModel) {
        self.loanListView.loanAccountModel = viewModel;
        self.loanAccountModel = viewModel;
    } andFailureBlock:^(NSError *error) {
        
    }];
    
    ///这里面没有产生循环引用 block里面不能用weakSelf
    [[HXBMYRequest sharedMYRequest] myLoan_requestWithLoanType:requestType andUpData:isUpData andSuccessBlock:^(NSArray<HXBMYViewModel_MainLoanViewModel *> *viewModelArray) {
        //数据的分发
        [self handleViewModelArrayWithViewModelArray:viewModelArray];
        [self.loanListView endRefresh];
    } andFailureBlock:^(NSError *error) {
        [self.loanListView endRefresh];
    }];
}
///网络数据请求数据处理
- (void)handleViewModelArrayWithViewModelArray: (NSArray<HXBMYViewModel_MainLoanViewModel *>*)loanViewModelArray{
    switch (loanViewModelArray.firstObject.requestType) {
        case HXBRequestType_MY_LoanRequestType_REPAYING_LOAN://收益中
            self.loanListView.repaying_ViewModelArray = loanViewModelArray;
            self.loan_REPAYING_ViewModelArray = loanViewModelArray;
            break;
        case HXBRequestType_MY_LoanRequestType_BID_LOAN://投标中
            self.loanListView.bid_ViewModelArray = loanViewModelArray;
            self.loan_BID_ViewModelArray = loanViewModelArray;
            break;
        case HXBRequestType_MY_LoanRequestType_FINISH_LOAN: //已结清 预留字段
            break;
    }
}

#pragma mark - 注册事件
- (void) registerEvent {
    // 中部的toolBarView的选中的option变化时候调用
    [self setupMidToolBarViewChangeSelect];
    
    //点击cell的时候调用
}
//MARK:  中部的toolBarView的选中的option变化时候调用
- (void) setupMidToolBarViewChangeSelect {
    //根据type来对相应的 界面进行网络请求 如果
    __weak typeof (self)weakSelf = self;
    [self.loanListView changeMidSelectOptionFuncWithBlock:^(UIButton *button, NSString *title, NSInteger index, HXBRequestType_MY_LoanRequestType type) {
        switch (type) {
                
            case HXBRequestType_MY_LoanRequestType_REPAYING_LOAN:
                if (!weakSelf.loan_REPAYING_ViewModelArray.count) [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_LoanRequestType_REPAYING_LOAN andIsUpData:true];
                break;
                
                
            case HXBRequestType_MY_LoanRequestType_FINISH_LOAN:
                break;
                
                
            case HXBRequestType_MY_LoanRequestType_BID_LOAN:
                if (!weakSelf.loan_BID_ViewModelArray.count) [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_LoanRequestType_BID_LOAN andIsUpData:true];
                break;
        }
    }];
}

//MARK: - 刷新 加载 注册
- (void) registerRefresh {
    [self refresh_bid];
    [self refresh_repying];
}
- (void) refresh_bid {
    __weak typeof(self)weakSelf = self;
    [self.loanListView bid_RefreashWithDownBlock:^{
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_LoanRequestType_BID_LOAN andIsUpData:false];
    } andUPBlock:^{
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_LoanRequestType_BID_LOAN andIsUpData:true];
        [self assetStatisticsLoadData];
    }];
}
- (void) refresh_repying {
    __weak typeof (self)weakSelf = self;
    [self.loanListView erpaying_RefreashWithDownBlock:^{
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_LoanRequestType_REPAYING_LOAN andIsUpData:false];
    } andUPBlock:^{
        [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_LoanRequestType_REPAYING_LOAN andIsUpData:true];
        [self assetStatisticsLoadData];
    }];
}

///切换底部的ScrollView的时候调用
- (void)registerSwichScrollViewCallBack {
    __weak typeof(self)weakSelf = self;
    [self.loanListView switchBottomScrollViewCallBackFunc:^(NSInteger index, NSString *title, UIButton *option) {
        if ([title isEqualToString:HXBRequestType_MY_REPAYING_LOAN_UI]) {
            if (!weakSelf.loan_REPAYING_ViewModelArray.count){///在收益中刷新
                [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_LoanRequestType_REPAYING_LOAN andIsUpData:true];
            }
        }
        if ([title isEqualToString:HXBRequestType_MY_BID_LOAN_UI]) {///投标中刷新
            if (!weakSelf.loan_BID_ViewModelArray.count) {
                [weakSelf downLoadDataWitRequestType:HXBRequestType_MY_LoanRequestType_BID_LOAN andIsUpData:true];
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
        [weakSelf.navigationController pushViewController:planListDetailViewController animated:true];
    }];
    [self.loanListView clickLoan_bid_CellFuncWithBlock:^(HXBMYViewModel_MainLoanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex) {
//        HXBMY_LoanList_DetailViewController *planListDetailViewController = [[HXBMY_LoanList_DetailViewController alloc]init];
//        planListDetailViewController.loanDetailViewModel = loanViewModel;
//        [weakSelf.navigationController pushViewController:planListDetailViewController animated:true];
        NSLog(@"散标列表暂无详情页");
    }];
}
@end
