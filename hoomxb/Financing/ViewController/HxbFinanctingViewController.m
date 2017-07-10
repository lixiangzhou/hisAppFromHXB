//
//  HxbFinanctingViewController.m
//  hoomxb
//
//  Created by HXB on 2017/4/22.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBToolCountDownButton.h"///倒计时button


#import "HxbFinanctingViewController.h"
#import "UIScrollView+HXBScrollView.h"//上拉刷新
#import "HXBFinanctingView_HomePage.h"//最主要的view
#import "HXBFinancing_PlanDetailsViewController.h"//红利计划详情页
#import "HXBFinancing_LoanDetailsViewController.h"//散标详情页
#import "HXBFin_DetailLoanTruansfer_ViewController.h"//债转的详情页

#import "HXBFinanctingRequest.h"//网络请求工具类
#import "HXBFinHomePageViewModel_PlanList.h"//红利计划列表viewmodel
#import "HXBFinHomePageViewModel_LoanList.h"//散标列表的ViewModel
#import "HXBFinHomePageModel_PlanList.h"//红利计划列表model
#import "HXBFinHomePageModel_LoanList.h"//散标列表的Model


#import "HXBFinDetailViewModel_PlanDetail.h"//红利计划的ViewModel
#import "HXBFinDetailViewModel_LoanDetail.h"//散标详情的ViewMOdel

#import "HXBFinDetailModel_PlanDetail.h"//红利计划的Model
#import "HXBFinDatailModel_LoanDetail.h"//散标详情的MOdel
#import "HXBFinHomePageViewModel_LoanTruansferViewModel.h"
@interface HxbFinanctingViewController ()
@property (nonatomic,strong) HXBFinanctingView_HomePage *homePageView;//最主要的view

//散标是否为第一次加载
@property (nonatomic,assign) BOOL isFirstLoadNetDataLoan;
//红利计划是否为第一次加载
@property (nonatomic,assign) BOOL isFirstLoadNetDataPlan;

//首页的网络请求类
@property (nonatomic,strong) HXBFinanctingRequest *finantingRequest;
//红利计划列表的数据数组
@property (nonatomic,strong) NSArray <HXBFinHomePageViewModel_PlanList*>* finPlanListVMArray;
//散标列表的数据数组
@property (nonatomic,strong) NSArray <HXBFinHomePageViewModel_LoanList*>* finLoanListVMArray;

@property (nonatomic,strong) HXBToolCountDownButton *countDownButton;

///MARK: ------------ 定时管理 -----------
@property (nonatomic,strong) HXBBaseContDownManager *contDwonManager;

@end




@implementation HxbFinanctingViewController
#pragma mark - setter 方发
//主要是给数据源赋值然后刷新UI
- (void)setFinPlanListVMArray:(NSArray<HXBFinHomePageViewModel_PlanList *> *)finPlanListVMArray {
    _finPlanListVMArray = finPlanListVMArray;
    self.homePageView.finPlanListVMArray = finPlanListVMArray;
    [self.contDwonManager countDownWithModelArray:finPlanListVMArray andModelDateKey:nil  andModelCountDownKey:nil];
}
- (void)setFinLoanListVMArray:(NSArray<HXBFinHomePageViewModel_LoanList *> *)finLoanListVMArray {
    _finLoanListVMArray = finLoanListVMArray;
    self.homePageView.finLoanListVMArray = finLoanListVMArray;
}
- (void) pan: (UIPanGestureRecognizer *)pan {
    NSLog(@"%@",pan);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
    self.view.backgroundColor = [UIColor whiteColor];
    self.countDownButton = [[HXBToolCountDownButton alloc]init];
    
    [self.countDownButton setValue:@1 forKey:@"selected"];
    // NAV
    self.isHiddenNavigationBar = true;
    //初始化属性
    [self creatProperty];
    
    //rootView
    [self setup];
    
    //点击事件
    [self clickCell];
    
    //中间的toolBar 被点击或者被滚动
    [self clickMidToolBarView];
    
    //上拉刷新与下拉加载
    [self registerRefresh];
    [self planLoadDateWithIsUpData:true];
    
    //创建定时器
    [self creatCountDownManager];
}
- (void)creatCountDownManager {
    __weak typeof (self)weakSelf = self;
    
    self.contDwonManager = [HXBBaseContDownManager countDownManagerWithCountDownStartTime: 3600 andCountDownUnit:1 andModelArray: self.finPlanListVMArray andModelDateKey:@"countDownLastStr" andModelCountDownKey:@"countDownString" andModelDateType:PYContDownManagerModelDateType_OriginalTime];
    [self.contDwonManager countDownWithChangeModelBlock:^(HXBFinHomePageViewModel_PlanList *model, NSIndexPath *index) {
        if (weakSelf.finPlanListVMArray.count > index.row) {
            UITableView *tableView = (UITableView *)[weakSelf.homePageView valueForKey:@"planListTableView"];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:index];
            [cell setValue:model.countDownString forKey:@"countDownString"];
        }
    }];
    //要与服务器时间想比较
    //    self.contDwonManager.clientTime = [HXBDate       ]
    //    [self.contDwonManager stopWenScrollViewScrollBottomWithTableView:self.planListTableView];
    self.contDwonManager.isAutoEnd = true;
    //开启定时器
    [self.contDwonManager resumeTimer];
}

- (void)creatProperty {
    self.isFirstLoadNetDataLoan = true;
    self.isFirstLoadNetDataPlan = true;
    self.finantingRequest = [HXBFinanctingRequest sharedFinanctingRequest];
}
- (void)setup {
    self.view.backgroundColor = [UIColor whiteColor];
    //防止跳转的时候，tableView向上或者向下移动
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    };
    //创建自视图
    self.homePageView = [[HXBFinanctingView_HomePage alloc]initWithFrame:CGRectMake(0, HxbNaVigationStatusBarY, self.view.width, self.view.height - HxbNaVigationStatusBarY - HxbTabBarHeight)];
    [self.view addSubview:self.homePageView];
}

#pragma mark - 处理点击事件
- (void)clickMidToolBarView {
    kWeakSelf
    [self.homePageView setSwitchBottomScrollViewBlock:^(NSInteger index, NSString *title, UIButton *button) {
        //网络数据请求
        if ([title isEqualToString:@"红利计划"] && self.isFirstLoadNetDataPlan) {
            [weakSelf planLoadDateWithIsUpData:true];
        }else if ([title isEqualToString:@"散标列表"] && self.isFirstLoadNetDataLoan) {
            [weakSelf loanLoadDateWithIsUpData:true];
        }
    }];
}
- (void)clickCell {
    //点击了红利计划列表的cell，跳转了红利计划详情页
    [self clickPlanListCell];
    //点击了散标列表页测cell， 跳转详情页
    [self clickLoanListCell];
    //点击了债转列表页测cell， 跳转详情页
    [self clickLoanTruansferCell];
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
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"红利计划##" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = leftBarButtonItem;
    planDetailsVC.planID = model.planListModel.ID;
    planDetailsVC.isPlan = true;
    planDetailsVC.isFlowChart = true;
    planDetailsVC.hidesBottomBarWhenPushed = true;
    planDetailsVC.planListViewModel = model;

    [self.navigationController pushViewController:planDetailsVC animated:true];
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
    [self.homePageView setClickLoanTruansferCellBlock:^(NSIndexPath *index, id model){
        [weakSelf pushLoanTruansferCellViewControllerWithModel:model];
    }];
}

- (void)pushLoanTruansferCellViewControllerWithModel: (HXBFinHomePageViewModel_LoanTruansferViewModel *)cellModel {
    HXBFin_DetailLoanTruansfer_ViewController *loanTruansfer_VC = [[HXBFin_DetailLoanTruansfer_ViewController alloc]init];
    loanTruansfer_VC.loanTransfer_ViewModel = cellModel;
    [self.navigationController pushViewController:loanTruansfer_VC animated:true];
    
}
- (void)pushLoanListCellViewControllerWithModel: (HXBFinHomePageViewModel_LoanList *)model {
    HXBFinancing_LoanDetailsViewController *loanDetailsVC = [[HXBFinancing_LoanDetailsViewController alloc]init];
    loanDetailsVC.loanID = model.loanListModel.loanId;
    loanDetailsVC.loanListViewMode = model;
 
    loanDetailsVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:loanDetailsVC animated:true];
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
}
//MARK:  红利计划上啦刷新
- (void)setupPlanRefresh {
    kWeakSelf
    [self.homePageView setPlanRefreshFooterBlock:^{
        NSLog(@"加载了");
        [weakSelf planLoadDateWithIsUpData:false];
    }];
    [self.homePageView setPlanRefreshHeaderBlock:^{
        NSLog(@"刷新了");
         [weakSelf planLoadDateWithIsUpData:true];
    }];
}
//MARK: 散标刷新加载
- (void)setupLoanRefresh {
    kWeakSelf
    [self.homePageView setLoanRefreshFooterBlock:^{
        NSLog(@"加载了");
        [weakSelf loanLoadDateWithIsUpData:false];
    }];
    [self.homePageView setLoanRefreshHeaderBlock:^{
        NSLog(@"刷新了");
        [weakSelf loanLoadDateWithIsUpData:true];
    }];
}

//MARK: 债转的刷新加载
- (void)setUPLoanTruansferRefresh {
    kWeakSelf
    [self.homePageView setLoanTruansferFooterBlock:^{
        
    }];
    [self.homePageView setLoanTruansferHeaderBlock:^{
        
    }];
}

#pragma mark - 网络数据请求
- (void)planLoadDateWithIsUpData: (BOOL)isUPData {
    __weak typeof(self)weakSelf = self;
    [self.finantingRequest planBuyListWithIsUpData:isUPData andSuccessBlock:^(NSArray<HXBFinHomePageViewModel_PlanList *> *viewModelArray) {
        weakSelf.finPlanListVMArray = viewModelArray;
        //结束下拉刷新与上拉刷新
        weakSelf.homePageView.isStopRefresh_Plan = true;
        weakSelf.isFirstLoadNetDataPlan = false;
    } andFailureBlock:^(NSError *error) {
        weakSelf.homePageView.isStopRefresh_Plan = true;
    }];
} 

- (void)loanLoadDateWithIsUpData: (BOOL)isUpData {
    __weak typeof(self)weakSelf = self;
    [self.finantingRequest loanBuyListWithIsUpData:isUpData andSuccessBlock:^(NSArray<HXBFinHomePageViewModel_LoanList *> *viewModelArray) {
        weakSelf.finLoanListVMArray = viewModelArray;
        //结束下拉刷新与上拉刷新
        weakSelf.homePageView.isStopRefresh_loan = true;
        weakSelf.isFirstLoadNetDataLoan = false;
    } andFailureBlock:^(NSError *error) {
        //结束下拉刷新与上拉刷新
        weakSelf.homePageView.isStopRefresh_loan = true;
    }];
}
/// 债转的数据请求
- (void)loanTruansferLoandDataWithIsUPData: (BOOL)isUPData {
    kWeakSelf
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    [self.homePageView.contDwonManager cancelTimer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.homePageView.contDwonManager resumeTimer];
    [self.homePageView loadData];
}
@end
