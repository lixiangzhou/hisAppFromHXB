//
//  HXBFinanctingView_HomePage.m
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
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
    self.loanListTableView.loanListViewModelArray = finLoanListVMArray;

}
- (void)setFinLoanTruansferVMArray:(NSArray<HXBFinHomePageViewModel_LoanTruansferViewModel *> *)finLoanTruansferVMArray {
    _finLoanTruansferVMArray = finLoanTruansferVMArray;
    self.loanTruansferTableView.loanTruansferViewModel = finLoanTruansferVMArray;
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
    self.toolBarViewOptionStrArray = @[
                                       @"红利计划",
                                       @"散标",
                                       @"债权转让" //债权转让，以后打开
                                       ];
    
    
    //设置toolBarView
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
    self.toolBarView = [[HXBBaseToolBarView alloc]initWithFrame:CGRectZero andOptionStrArray:self.toolBarViewOptionStrArray topNavigationToolBar:YES];
    self.toolBarView.barAnimaViewSpacing = kScrAdaptationW(83);
    self.toolBarView.barAnimaViewH = kScrAdaptationH(2);
    self.toolBarView.isAnima_ItemBottomBarView = YES;
    self.toolBarView.isColorChange = YES;
    self.toolBarView.animaTime_ItemBottomBarView = .5;
    self.toolBarView.barAnimaViewBottomSpacing = kScrAdaptationH(5);
    self.toolBarView.itemTextFont = kHXBFont_PINGFANGSC_REGULAR(17);
    self.toolBarView.label_Item_CenterY_Difference = kScrAdaptationH(15);
   
    self.toolBarView.itemBarAnimaViewColor = [UIColor whiteColor];
    self.toolBarView.itemTitleColor_select = [UIColor whiteColor];
    self.toolBarView.itemTextColor_Normal = [UIColor colorWithWhite:1 alpha:0.5];
    
    //边框
//    self.toolBarView.layer.borderWidth = .2;
//    self.toolBarView.layer.borderColor = [UIColor grayColor].CGColor;
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
                             self.loanListTableView,
                             self.loanTruansferTableView //债权转让，以后打开
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
    self.planListTableView = [[HXBFinancting_PlanListTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.planListTableView.expectedYearRateLable_ConstStr = @"平均历史年化收益";
//    self.planListTableView.lockPeriodLabel_ConstStr = @"期限(月)";
    
    //监听contentOffset
//    [self.planListTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    //点击cell的block
    [self.planListTableView setClickPlanListCellBlock:^(NSIndexPath *indexPage, id model) {
        if (weakSelf.clickPlanListCellBlock) {
            weakSelf.clickPlanListCellBlock(indexPage,model);
        }
    }];

    //红利计划下拉刷新
    [self.planListTableView hxb_headerWithRefreshBlock:^{
        if (weakSelf.planRefreshHeaderBlock)
            weakSelf.planRefreshHeaderBlock();
    }];
}

//MARK:散标列表
- (void)setupLoanListTableView {
    self.loanListTableView = [[HXBFinancting_LoanListTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.loanListTableView.expectedYearRateLable_ConstStr = @"年利率";
    self.loanListTableView.lockPeriodLabel_ConstStr = @"期限(月)";
    self.loanListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    kWeakSelf
    [self.loanListTableView setClickLoanListCellBlock:^(NSIndexPath *index, id model) {
        if (weakSelf.clickLoanListCellBlock) {
            weakSelf.clickLoanListCellBlock(index, model);
        }
    }];
    
    //上拉刷新，下拉加载
    [self.loanListTableView hxb_headerWithRefreshBlock:^{
        if (weakSelf.loanRefreshHeaderBlock) weakSelf.loanRefreshHeaderBlock();
    }];
}

//MARK: 债转
- (void)setUPLoanTransferTableView {
    kWeakSelf
    self.loanTruansferTableView = [[HXBFin_LoanTransferTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.loanTruansferTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //上拉刷新，下拉加载（判断条数是否）
    [self.loanTruansferTableView hxb_headerWithRefreshBlock:^{
        if (weakSelf.loanTruansferHeaderBlock) weakSelf.loanTruansferHeaderBlock();
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
    self.scrollToolBarView = [[HXBBaseScrollToolBarView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) andTopView:nil andTopViewH:0 andMidToolBarView:self.toolBarView andMidToolBarViewMargin:0 andMidToolBarViewH:HXBStatusBarAndNavigationBarHeight andBottomViewSet:self.bottomViewArray];
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

- (void)setIsStopRefresh_Plan:(BOOL)isStopRefresh_Plan {
    _isStopRefresh_Plan = isStopRefresh_Plan;
    [self.planListTableView.mj_header endRefreshing];
}

- (void)setIsStopRefresh_loan:(BOOL)isStopRefresh_loan {
    _isStopRefresh_loan = isStopRefresh_loan;
    [self.loanListTableView.mj_header endRefreshing];
}

- (void)setIsStopRefresh_LoanTruansfer:(BOOL)isStopRefresh_LoanTruansfer {
    _isStopRefresh_LoanTruansfer = isStopRefresh_LoanTruansfer;
    [self.loanTruansferTableView.mj_header endRefreshing];
}

#pragma mark 底部加载更多控件以及状态控制的属性设置方法

- (void)setIsPlanLastPage:(BOOL)isPlanLastPage {
    _isPlanLastPage = isPlanLastPage;
    if (isPlanLastPage) {
        [self.planListTableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.planListTableView.mj_footer endRefreshing];
    }
}

- (void)setIsLoanLastPage:(BOOL)isLoanLastPage {
    _isLoanLastPage = isLoanLastPage;
    if (isLoanLastPage) {
        [self.loanListTableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.loanListTableView.mj_footer endRefreshing];
    }
}

- (void)setIsLoanTruansferLastPage:(BOOL)isLoanTruansferLastPage {
    _isLoanTruansferLastPage = isLoanTruansferLastPage;
    if (isLoanTruansferLastPage) {
        [self.loanTruansferTableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.loanTruansferTableView.mj_footer endRefreshing];
    }
}

- (void)setIsPlanShowLoadMore:(BOOL)isPlanShowLoadMore {
    _isPlanShowLoadMore = isPlanShowLoadMore;
    kWeakSelf
    if (isPlanShowLoadMore) {
        [self.planListTableView hxb_footerWithRefreshBlock:^{
            if (weakSelf.planRefreshFooterBlock) {
                weakSelf.planRefreshFooterBlock();
            }
        }];
    } else {
        self.planListTableView.mj_footer = nil;
    }
}

- (void)setIsLoanShowLoadMore:(BOOL)isLoanShowLoadMore {
    _isLoanShowLoadMore = isLoanShowLoadMore;
    kWeakSelf
    if (isLoanShowLoadMore) {
        [self.loanListTableView hxb_footerWithRefreshBlock:^{
            if (weakSelf.loanRefreshFooterBlock) {
                weakSelf.loanRefreshFooterBlock();
            }
        }];
    } else {
        self.loanListTableView.mj_footer = nil;
    }
}

- (void)setIsLoanTruansferShowLoadMore:(BOOL)isLoanTruansferShowLoadMore {
    _isLoanTruansferShowLoadMore = isLoanTruansferShowLoadMore;
    kWeakSelf
    if (isLoanTruansferShowLoadMore) {
        [self.loanTruansferTableView hxb_footerWithRefreshBlock:^{
            if (weakSelf.loanTruansferFooterBlock) {
                weakSelf.loanTruansferFooterBlock();
            }
        }];
    } else {
        self.loanTruansferTableView.mj_footer = nil;
    }
}

@end
