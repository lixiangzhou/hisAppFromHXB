//
//  HxbFinanctingViewController.m
//  hoomxb
//
//  Created by HXB on 2017/4/22.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBToolCountDownButton.h"///倒计时button


#import "HxbFinanctingViewController.h"
#import "UIScrollView+HXBScrollView.h"//上拉刷新
#import "HXBFinanctingView_HomePage.h"//最主要的view
#import "HXBFinancing_PlanDetailsViewController.h"//红利计划详情页
#import "HXBFinancing_LoanDetailsViewController.h"//散标详情页
#import "HXBFin_DetailLoanTruansfer_ViewController.h"//债转的详情页

#import "HXBFinHomePageViewModel_PlanList.h"//红利计划列表viewmodel
#import "HXBFinHomePageViewModel_LoanList.h"//散标列表的ViewModel
#import "HXBFinHomePageModel_PlanList.h"//红利计划列表model
#import "HXBFinHomePageModel_LoanList.h"//散标列表的Model


#import "HXBFinDetailViewModel_PlanDetail.h"//红利计划的ViewModel
#import "HXBFinDetailViewModel_LoanDetail.h"//散标详情的ViewMOdel

#import "HXBFinDetailModel_PlanDetail.h"//红利计划的Model
#import "HXBFinDatailModel_LoanDetail.h"//散标详情的MOdel
#import "HXBFinHomePageViewModel_LoanTruansferViewModel.h"

#import "HXBFinanceListViewModel.h" // 请求ViewModel


@interface HxbFinanctingViewController ()
@property (nonatomic,strong) HXBFinanctingView_HomePage *homePageView;//最主要的view

//散标是否为第一次加载
@property (nonatomic,assign) BOOL isFirstLoadNetDataLoan;
//红利计划是否为第一次加载
@property (nonatomic,assign) BOOL isFirstLoadNetDataPlan;
//散标第一次加载
@property (nonatomic,assign) BOOL isFirstLoadNetDataLoanTruansfer;

//倒计时按钮
@property (nonatomic,strong) HXBToolCountDownButton *countDownButton;

///MARK: ------------ 定时管理 -----------
@property (nonatomic,strong) HXBBaseContDownManager *contDwonManager;
@property (nonatomic, strong) HXBFinanceListViewModel *viewModel;
@end



@implementation HxbFinanctingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.countDownButton = [[HXBToolCountDownButton alloc]init];
    kWeakSelf
    self.viewModel = [[HXBFinanceListViewModel alloc] initWithBlock:^UIView *{
        return weakSelf.view;
    }];
    
    [self.countDownButton setValue:@1 forKey:@"selected"];
    
    //初始化属性
    [self creatProperty];//实例化请求单利
    
    //rootView
    [self setup];
    
    //点击事件
    [self clickCell];
    
    //中间的toolBar 被点击或者被滚动
    [self clickMidToolBarView];
    
    //上拉刷新与下拉加载
    [self registerRefresh];
    [self planLoadDateWithIsUpData:YES];
    
//    //创建定时器
//    [self creatCountDownManager];
}


- (void)creatCountDownManager {
    kWeakSelf
    self.contDwonManager = [HXBBaseContDownManager countDownManagerWithCountDownStartTime: 3600
                                                                         andCountDownUnit:1
                                                                            andModelArray:self.viewModel.planListViewModelArray
                                                                          andModelDateKey:@"countDownLastStr"
                                                                     andModelCountDownKey:@"countDownString" andModelDateType:PYContDownManagerModelDateType_OriginalTime];
    
    [self.contDwonManager countDownWithChangeModelBlock:^(HXBFinHomePageViewModel_PlanList *model, NSIndexPath *index) {
        if (weakSelf.viewModel.planListViewModelArray.count > index.section) {
            UITableView *tableView = (UITableView *)[weakSelf.homePageView valueForKey:@"planListTableView"];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index.row];
            
            //更新列表中对应的字段值
            HXBFinHomePageViewModel_PlanList* pageModel = [weakSelf.viewModel.planListViewModelArray safeObjectAtIndex:index.row];
            [pageModel setValue:model.countDownLastStr forKey:@"countDownLastStr"];
            [pageModel setValue:model.countDownString forKey:@"countDownString"];
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell setValue:pageModel.countDownString forKey:@"countDownString"];
        }
    }];
    //要与服务器时间想比较
    //    self.contDwonManager.clientTime = [HXBDate       ]
    //    [self.contDwonManager stopWenScrollViewScrollBottomWithTableView:self.planListTableView];
    self.contDwonManager.isAutoEnd = YES;
    //开启定时器
    [self.contDwonManager resumeTimer];
}

- (void)creatProperty {
    self.isFirstLoadNetDataLoan = YES;
    self.isFirstLoadNetDataPlan = YES;
    self.isFirstLoadNetDataLoanTruansfer = YES;
}
- (void)setup {
    //防止跳转的时候，tableView向上或者向下移动
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    };
    //创建自视图
    self.homePageView = [[HXBFinanctingView_HomePage alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - HXBTabbarHeight)];
    [self.view addSubview:self.homePageView];
    //后台进入前台倒计时刷新问题
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(starCountDown) name:kHXBNotification_starCountDown object:nil];
}

- (void)starCountDown
{
    [self planLoadDateWithIsUpData:YES];
    [self loanLoadDateWithIsUpData:YES];
    [self loanTruansferLoandDataWithIsUPData:YES];
}
#pragma mark - 处理点击事件
- (void)clickMidToolBarView {
    kWeakSelf
    [self.homePageView setSwitchBottomScrollViewBlock:^(NSInteger index, NSString *title, UIButton *button) {
        //网络数据请求
        if ([title isEqualToString:@"红利智投"] && weakSelf.isFirstLoadNetDataPlan) {
            [weakSelf planLoadDateWithIsUpData:YES];
        }else if ([title isEqualToString:@"散标"] && weakSelf.isFirstLoadNetDataLoan) {
            [weakSelf loanLoadDateWithIsUpData:YES];
        }else if (index == 2 && weakSelf.isFirstLoadNetDataLoanTruansfer) {
            [weakSelf loanTruansferLoandDataWithIsUPData:YES];
        }
    }];
}
- (void)clickCell {
    
    [self clickPlanListCell];       //点击了红利计划列表的cell，跳转了红利计划详情页
    [self clickLoanListCell];       //点击了散标列表页测cell， 跳转详情页
    [self clickLoanTruansferCell];  //点击了债转列表页测cell， 跳转详情页
}
//MARK: - 点击了红利计划列表页的 cell
- (void) clickPlanListCell {
    __weak typeof(self)weakSelf = self;
    [self.homePageView setClickPlanListCellBlock:^(NSIndexPath *index, HXBFinHomePageViewModel_PlanList *model) {
        [weakSelf pushPlanDetailsViewControllerWithModel:model];
    }];
    
}
- (void)pushPlanDetailsViewControllerWithModel: (HXBFinHomePageViewModel_PlanList *)model {
    HXBFinancing_PlanDetailsViewController *planDetailsVC = [[HXBFinancing_PlanDetailsViewController alloc]init];
    planDetailsVC.title = model.planListModel.name;
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"红利智投##" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = leftBarButtonItem;
    planDetailsVC.planID = model.planListModel.ID;
    planDetailsVC.isPlan = YES;
    planDetailsVC.isFlowChart = YES;
    planDetailsVC.planListViewModel = model;

    [self.navigationController pushViewController:planDetailsVC animated:YES];
}
//MARK: - 点击了散标列表页的 cell
- (void) clickLoanListCell {
    __weak typeof (self) weakSelf = self;
    [self.homePageView setClickLoanListCellBlock:^(NSIndexPath *index, id model) {
        [weakSelf pushLoanListCellViewControllerWithModel:model];
    }];
}
//MARK:- 点击了债转的 cell
- (void)clickLoanTruansferCell {
    kWeakSelf
    [self.homePageView setClickLoanTruansferCellBlock:^(HXBFinHomePageViewModel_LoanTruansferViewModel* model,NSIndexPath *index){
        [weakSelf pushLoanTruansferCellViewControllerWithModel:model];
    }];
}

- (void)pushLoanTruansferCellViewControllerWithModel: (HXBFinHomePageViewModel_LoanTruansferViewModel *)cellModel {
    HXBFin_DetailLoanTruansfer_ViewController *loanTruansfer_VC = [[HXBFin_DetailLoanTruansfer_ViewController alloc]init];
    loanTruansfer_VC.loanTransfer_ViewModel = cellModel;
    loanTruansfer_VC.loanID = cellModel.loanTruansferListModel.transferId;
    loanTruansfer_VC.title = cellModel.loanTruansferListModel.title;
    [self.navigationController pushViewController:loanTruansfer_VC animated:YES];
    
}
- (void)pushLoanListCellViewControllerWithModel: (HXBFinHomePageViewModel_LoanList *)model {
    HXBFinancing_LoanDetailsViewController *loanDetailsVC = [[HXBFinancing_LoanDetailsViewController alloc]init];
    loanDetailsVC.loanID = model.loanListModel.loanId;
    loanDetailsVC.loanListViewMode = model;
    [self.navigationController pushViewController:loanDetailsVC animated:YES];
}

- (void)clickLeftBarButtonItem {
    [self popoverPresentationController];
}
#pragma mark - 上啦刷新与下拉加载
- (void) registerRefresh{
    //红利计划上拉刷新与下拉加载
    [self setupPlanRefresh];
    
    //散标上拉刷新与下拉加载
    [self setupLoanRefresh];
    
    //债转的刷新加载
    [self setUPLoanTruansferRefresh];
}
//MARK:  红利计划上啦刷新
- (void)setupPlanRefresh {
    kWeakSelf
    [self.homePageView setPlanRefreshFooterBlock:^{
        NSLog(@"加载了");
        [weakSelf planLoadDateWithIsUpData:NO];
    }];
    [self.homePageView setPlanRefreshHeaderBlock:^{
        NSLog(@"刷新了");
         [weakSelf planLoadDateWithIsUpData:YES];
    }];
}
//MARK: 散标刷新加载
- (void)setupLoanRefresh {
    kWeakSelf
    [self.homePageView setLoanRefreshFooterBlock:^{
        NSLog(@"加载了");
        [weakSelf loanLoadDateWithIsUpData:NO];
    }];
    [self.homePageView setLoanRefreshHeaderBlock:^{
        NSLog(@"刷新了");
        [weakSelf loanLoadDateWithIsUpData:YES];
    }];
}

//MARK: 债转的刷新加载
- (void)setUPLoanTruansferRefresh {
    kWeakSelf
    [self.homePageView setLoanTruansferFooterBlock:^{
        [weakSelf loanTruansferLoandDataWithIsUPData:NO];
    }];
    [self.homePageView setLoanTruansferHeaderBlock:^{
        [weakSelf loanTruansferLoandDataWithIsUPData:YES];
    }];
}

#pragma mark - 网络数据请求
/// 计划的数据请求
- (void)planLoadDateWithIsUpData: (BOOL)isUPData {
    
    if (self.viewModel.planListViewModelArray.count <= 0) {
        id responseObject = [PPNetworkCache httpCacheForURL:@"/plan" parameters:nil];
        self.viewModel.planListViewModelArray = [self.viewModel updatePlanListModelWithResponseObject:responseObject];
    }
    kWeakSelf
    [self.viewModel planListWithIsUpData:isUPData financeType:HXBFinance_Plan resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.isFirstLoadNetDataPlan = NO;
            weakSelf.homePageView.isPlanShowLoadMore = weakSelf.viewModel.isPlanShowLoadMore;
            weakSelf.homePageView.isPlanLastPage = weakSelf.viewModel.isPlanLastPage;
        }
        // 更换数据源之前， 要先取消定时器，然后再重新设置， 否则由于线程同步问题会引发crash
        if(weakSelf.contDwonManager) {
            [weakSelf.contDwonManager cancelTimer];
            weakSelf.contDwonManager = nil;
        }
        [weakSelf creatCountDownManager];
        weakSelf.homePageView.finPlanListVMArray = self.viewModel.planListViewModelArray;
        weakSelf.homePageView.isStopRefresh_Plan = YES;
    }];
}

/// 散标的数据请求
- (void)loanLoadDateWithIsUpData: (BOOL)isUpData {
    kWeakSelf
    [self.viewModel loanListWithIsUpData:isUpData financeType:HXBFinance_Loan resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.isFirstLoadNetDataLoan = NO;
            weakSelf.homePageView.isLoanShowLoadMore = weakSelf.viewModel.isLoanShowLoadMore;
            weakSelf.homePageView.isLoanLastPage = weakSelf.viewModel.isLoanLastPage;
        }
        weakSelf.homePageView.finLoanListVMArray = weakSelf.viewModel.loanListViewModelArray;
        weakSelf.homePageView.isStopRefresh_loan = YES;
    }];
}

/// 债转的数据请求
- (void)loanTruansferLoandDataWithIsUPData: (BOOL)isUPData {
    kWeakSelf
    [self.viewModel loanTruansferListWithIsUpData:isUPData financeType:HXBFinance_LoanTransfer resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.isFirstLoadNetDataLoanTruansfer = NO;
            weakSelf.homePageView.isLoanTruansferShowLoadMore = weakSelf.viewModel.isLoanTruansferShowLoadMore;
            weakSelf.homePageView.isLoanTruansferLastPage = weakSelf.viewModel.isLoanTruansferLastPage;
        }
        weakSelf.homePageView.finLoanTruansferVMArray = weakSelf.viewModel.loanTruansferViewModelArray;
        weakSelf.homePageView.isStopRefresh_LoanTruansfer = YES;
    }];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self transparentNavigationTitle];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self hideNavigationBar:animated];
    [self planLoadDateWithIsUpData:YES];
    [self loanLoadDateWithIsUpData:YES];
    [self loanTruansferLoandDataWithIsUPData:YES];
}
@end
