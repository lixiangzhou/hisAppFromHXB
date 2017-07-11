//
//  HXBFinanctingView_HomePage.m
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinanctingView_HomePage.h"
#import "HXBBaseScrollToolBarView.h"
#import "HXBBaseToolBarView.h"//选项栏
#import "HXBFinancting_PlanListTableView.h"//计划列表View
#import "HXBFinancting_LoanListTableView.h"//散标列表View
#import "HXBFinancing_PlanDetailsViewController.h"//红利详情页
#import "HXBFinHomePageViewModel_PlanList.h"//红利计划的Viewmodel
#import "HXBFinancting_PlanListTableViewCell.h"//红利计划的cell
#import "HXBFin_LoanTransferTableView.h"//债转


@interface HXBFinanctingView_HomePage()
//ScrollToolBarView
@property (nonatomic,strong) HXBBaseScrollToolBarView *scrollToolBarView;
//toolBarView
@property (nonatomic,strong) HXBBaseToolBarView *toolBarView;
//toolBarView的option标题数组
@property (nonatomic,strong) NSArray <NSString *>*toolBarViewOptionStrArray;
//scrollToolBarView 底部的scrollView的集合
@property (nonatomic,strong) NSArray <UIScrollView *>*bottomViewArray;
//bottomViewArray里面的红利计划view
@property (nonatomic,strong) HXBFinancting_PlanListTableView *planListTableView;
//bottomViewArray里面的散标列表View
@property (nonatomic,strong) HXBFinancting_LoanListTableView *loanListTableView;
//债转
@property (nonatomic,strong) HXBFin_LoanTransferTableView *loanTruansferTableView;
@end

@implementation HXBFinanctingView_HomePage

#pragma mark - setter 主要是进行了UI的刷新
- (void)setFinPlanListVMArray:(NSArray<HXBFinHomePageViewModel_PlanList *> *)finPlanListVMArray {
    _finPlanListVMArray = finPlanListVMArray;
    self.planListTableView.planListViewModelArray = finPlanListVMArray;
}
- (void)setFinLoanListVMArray:(NSArray<HXBFinHomePageViewModel_LoanList *> *)finLoanListVMArray {
    _finLoanListVMArray = finLoanListVMArray;
    self.loanListTableView.loanListViewModelArray =finLoanListVMArray;
}


//MARK: - 关于刷新 停止
- (void)setIsStopRefresh_loan:(BOOL)isStopRefresh_loan {
    _isStopRefresh_loan = isStopRefresh_loan;
    if (isStopRefresh_loan) {
        [self.loanListTableView endRefresh];
    }
}
- (void)setIsStopRefresh_Plan:(BOOL)isStopRefresh_Plan {
    _isStopRefresh_Plan = isStopRefresh_Plan;
    if (isStopRefresh_Plan) {
        [self.planListTableView.mj_footer endRefreshing];
        [self.planListTableView.mj_header endRefreshing];
    }
}
- (void)setIsStopRefresh_LoanTruansfer:(BOOL)isStopRefresh_LoanTruansfer {
    _isStopRefresh_LoanTruansfer = isStopRefresh_LoanTruansfer;
    if (isStopRefresh_LoanTruansfer) {
        [self.loanTruansferTableView.mj_footer endRefreshing];
        [self.loanTruansferTableView.mj_header endRefreshing];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupSubView];
    }
    return self;
}


- (void)setupSubView {
    self.toolBarViewOptionStrArray = @[@"红利计划",@"散标列表"];
    
    
//设置toolBarVie
    [self setupToolBarView];
    
//搭建底部的ScrollView
    [self setupBottomScrollViewArray];
    
    //为底部的scrollView添加定时器
    [self setupCountDownManager];
    
//搭建ScrollToolBarView
    [self setupScrollToolBarView];
    //定时器
    [self setupCountDownManager];
}

//设置toolBarView
- (void)setupToolBarView {
    self.toolBarView = [[HXBBaseToolBarView alloc]initWithFrame:CGRectZero andOptionStrArray:self.toolBarViewOptionStrArray];
    self.toolBarView.isAnima_ItemBottomBarView = true;
    self.toolBarView.animaTime_ItemBottomBarView = .5;
    self.toolBarView.itemBarAnimaViewColor = [UIColor blueColor];
    //边框
    self.toolBarView.layer.borderWidth = .2;
    self.toolBarView.layer.borderColor = [UIColor grayColor].CGColor;
}

//设置底部的scrollView数组
- (void)setupBottomScrollViewArray {
    //红利计划列表
    [self setupPlanListTableView];
    //散标列表
    [self setupLoanListTableView];
    //债权
    [self setUPLoanTransferTableView];

    self.bottomViewArray = @[
                             self.planListTableView,
                             self.loanListTableView
                            ];
}

//MARK: 定时器管理者
- (void)setupCountDownManager {
    NSMutableArray *arrayM = [[NSMutableArray alloc]init];
    [arrayM addObjectsFromArray:self.finPlanListVMArray];
//    [arrayM addObjectsFromArray:self.finLoanListVMArray];
   
}


//MARK:红利计划列表
- (void)setupPlanListTableView {
    kWeakSelf
    self.planListTableView = [[HXBFinancting_PlanListTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.planListTableView.expectedYearRateLable_ConstStr = @"预期年化";
    self.planListTableView.lockPeriodLabel_ConstStr = @"计划期限";
    //监听contentOffset
    [self.planListTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    //点击cell的block
    [self.planListTableView setClickPlanListCellBlock:^(NSIndexPath *indexPage, id model) {
        if (weakSelf.clickPlanListCellBlock) {
            weakSelf.clickPlanListCellBlock(indexPage,model);
        }
    }];
    
    //上拉刷新，下拉加载
    [self.planListTableView hxb_GifFooterWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
         if (weakSelf.planRefreshFooterBlock) weakSelf.planRefreshFooterBlock();
    } andSetUpGifFooterBlock:^(MJRefreshBackGifFooter *footer) {
       
    }];
    [self.planListTableView hxb_GifHeaderWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
        if (weakSelf.planRefreshHeaderBlock) weakSelf.planRefreshHeaderBlock();
    } andSetUpGifHeaderBlock:^(MJRefreshGifHeader *gifHeader) {
        
    }];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
    }
}
//MARK:散标列表
- (void)setupLoanListTableView {
    self.loanListTableView = [[HXBFinancting_LoanListTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.loanListTableView.expectedYearRateLable_ConstStr = @"年利率";
    self.loanListTableView.lockPeriodLabel_ConstStr = @"期限";
    kWeakSelf
    [self.loanListTableView setClickLoanListCellBlock:^(NSIndexPath *index, id model) {
        if (weakSelf.clickLoanListCellBlock) {
            weakSelf.clickLoanListCellBlock(index, model);
        }
    }];
    
    //上拉刷新，下拉加载
    [self.loanListTableView hxb_GifFooterWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
        if (weakSelf.loanRefreshFooterBlock) weakSelf.loanRefreshFooterBlock();
    } andSetUpGifFooterBlock:^(MJRefreshBackGifFooter *footer) {
    }];
    [self.loanListTableView hxb_GifHeaderWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
        if (weakSelf.loanRefreshHeaderBlock) weakSelf.loanRefreshHeaderBlock();
    } andSetUpGifHeaderBlock:^(MJRefreshGifHeader *gifHeader) {
        
    }];
}

//MARK: 债转
- (void)setUPLoanTransferTableView {
    kWeakSelf
    self.loanTruansferTableView = [[HXBFin_LoanTransferTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];

    //上拉刷新，下拉加载
    [self.loanTruansferTableView hxb_GifFooterWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
        if (weakSelf.loanRefreshFooterBlock) weakSelf.loanRefreshFooterBlock();
    } andSetUpGifFooterBlock:^(MJRefreshBackGifFooter *footer) {
    }];
    [self.loanTruansferTableView hxb_GifHeaderWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
        if (weakSelf.loanTruansferHeaderBlock) weakSelf.loanTruansferHeaderBlock();
    } andSetUpGifHeaderBlock:^(MJRefreshGifHeader *gifHeader) {
        
    }];
    
    //cell的点击
    [self.loanTruansferTableView clickCellWithBlock:^(id cellModel, NSIndexPath *index) {
        if (weakSelf.clickLoanTruansferCellBlock) {
            weakSelf.clickLoanTruansferCellBlock(cellModel, index);
        }
    }];
}

//搭建ScrollToolBarView
- (void)setupScrollToolBarView {
    self.scrollToolBarView = [[HXBBaseScrollToolBarView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) andTopView:nil andTopViewH:0 andMidToolBarView:self.toolBarView andMidToolBarViewMargin:0 andMidToolBarViewH:30 andBottomViewSet:self.bottomViewArray];
    [self addSubview:self.scrollToolBarView];
    //点击事件的分发
    kWeakSelf
    [self.scrollToolBarView switchBottomScrollViewCallBack:^(NSInteger index, NSString *title, UIButton *option) {
        if (weakSelf.switchBottomScrollViewBlock){
            weakSelf.switchBottomScrollViewBlock(index,title,option);
            NSLog(@"%@",title);
        }
    }];
}

// 刷新UI
- (void)loadData {
    [self.loanListTableView reloadData];
    [self.planListTableView reloadData];
}
@end
