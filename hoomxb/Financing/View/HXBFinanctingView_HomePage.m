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
#define kWeakSelf __weak typeof (self)weakSelf = self;


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
    
    self.toolBarViewOptionStrArray = @[@"红利计划",@"散标列表"];
    
//设置toolBarView
    [self setupToolBarView];
    
//搭建底部的ScrollView
    [self setupBottomScrollViewArray];
    
//搭建ScrollToolBarView
    [self setupScrollToolBarView];
}

//设置toolBarView
- (void)setupToolBarView {
    self.toolBarView = [[HXBBaseToolBarView alloc]initWithFrame:CGRectZero andOptionStrArray:self.toolBarViewOptionStrArray];
    self.toolBarView.isAnima_ItemBottomBarView = true;
    self.toolBarView.animaTime_ItemBottomBarView = .5;
    self.toolBarView.itemBarAnimaViewColor = [UIColor blueColor];
}

//设置底部的scrollView数组
- (void)setupBottomScrollViewArray {
    //红利计划列表
    [self setupPlanListTableView];
    //散标列表
    [self setupLoanListTableView];
    self.bottomViewArray = @[
                             self.planListTableView,
                             self.loanListTableView
                            ];
}
//MARK:红利计划列表
- (void)setupPlanListTableView {
    __weak typeof (self)weakSelf = self;
    self.planListTableView = [[HXBFinancting_PlanListTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.planListTableView setClickPlanListCellBlock:^(NSIndexPath *indexPage, id model) {
        if (weakSelf.clickPlanListCellBlock) {
            weakSelf.clickPlanListCellBlock(indexPage,model);
        }
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
}

//搭建ScrollToolBarView
- (void)setupScrollToolBarView {
    self.scrollToolBarView = [[HXBBaseScrollToolBarView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) andTopView:nil andTopViewH:0 andMidToolBarView:self.toolBarView andMidToolBarViewMargin:0 andMidToolBarViewH:30 andBottomViewSet:self.bottomViewArray];
    [self addSubview:self.scrollToolBarView];
}
@end
