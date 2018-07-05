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
#import "HXBFinancting_LoanTransferTableView.h"//债转


@interface HXBFinanctingView_HomePage()
//ScrollToolBarView
@property (nonatomic,strong) HXBBaseScrollToolBarView *scrollToolBarView;
//toolBarView
@property (nonatomic,strong) HXBBaseToolBarView *toolBarView;
//红利计划view
@property (nonatomic,strong) HXBFinancting_PlanListTableView *planListTableView;
//散标列表View
@property (nonatomic,strong) HXBFinancting_LoanListTableView *loanListTableView;
//债转
@property (nonatomic,strong) HXBFinancting_LoanTransferTableView *loanTruansferTableView;
@end

@implementation HXBFinanctingView_HomePage

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupSubView];
    }
    return self;
}


- (void)setupSubView {
    //设置toolBarView
    [self setupToolBarView];
    
    //搭建底部的ScrollView
    [self setupBottomScrollViewArray];
    
    //搭建ScrollToolBarView
    [self setupScrollToolBarView];
}

//设置toolBarView
- (void)setupToolBarView {
    self.toolBarView = [[HXBBaseToolBarView alloc]initWithFrame:CGRectZero andOptionStrArray:@[@"红利智投", @"散标", @"债权转让"] topNavigationToolBar:YES];
    self.toolBarView.barAnimaViewSpacing = kScrAdaptationW(85);
    self.toolBarView.barAnimaViewH = kScrAdaptationH(3);
    self.toolBarView.isAnima_ItemBottomBarView = YES;
    self.toolBarView.isColorChange = NO;
    self.toolBarView.animaTime_ItemBottomBarView = .5;
    self.toolBarView.barAnimaViewBottomSpacing = kScrAdaptationH(0);
    self.toolBarView.itemBarAnimaViewColor = UIColorFromRGB(0xFF3B2D);
    self.toolBarView.itemTextFont = kHXBFont_PINGFANGSC_REGULAR(15);
    self.toolBarView.label_Item_CenterY_Difference = kScrAdaptationH(15);
   
    self.toolBarView.itemTitleColor_select = UIColorFromRGB(0xFF3B2D);
    self.toolBarView.itemTextColor_Normal = kHXBColor_333333_100;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *bgView = [UIView new];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.toolBarView insertSubview:bgView atIndex:0];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.toolBarView);
        }];
        
        UIView *bottomView = [UIView new];
        bottomView.backgroundColor = UIColorFromRGB(0xECECEC);
        [self.toolBarView insertSubview:bottomView belowSubview:self.toolBarView.itemBarAnimaView];
        kWeakSelf
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@1);
            make.bottom.left.right.equalTo(weakSelf.toolBarView);
        }];
    });
}

//设置底部的scrollView数组
- (void)setupBottomScrollViewArray {
    //红利计划列表
    [self setupPlanListTableView];
    //散标列表
    [self setupLoanListTableView];
    //债权
    [self setUPLoanTransferTableView];
}

//搭建ScrollToolBarView
- (void)setupScrollToolBarView {
    self.scrollToolBarView = [[HXBBaseScrollToolBarView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) andTopView:nil andTopViewH:0 andMidToolBarView:self.toolBarView andMidToolBarViewMargin:0 andMidToolBarViewH:HXBStatusBarAndNavigationBarHeight andBottomViewSet:@[self.planListTableView, self.loanListTableView, self.loanTruansferTableView]];
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

// MARK: - 列表的创建
//MARK: 红利计划列表
- (void)setupPlanListTableView {
    kWeakSelf
    self.planListTableView = [[HXBFinancting_PlanListTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];

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
    self.loanListTableView = [[HXBFinancting_LoanListTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
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
    self.loanTruansferTableView = [[HXBFinancting_LoanTransferTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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

#pragma mark - 结束下拉刷新的方法

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

#pragma mark - 底部加载更多控件以及状态控制的属性设置方法

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


@end
