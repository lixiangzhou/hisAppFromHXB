//
//  HXBFinanctingView_HomePage.h
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBFinHomePageViewModel_PlanList;
@class HXBFinHomePageViewModel_LoanList;
@class HXBFinHomePageViewModel_LoanTruansferViewModel;

@interface HXBFinanctingView_HomePage : UIView
///MARK: ----------  model的数组 （数据源） ---------------
//红利计划列表的数据数组
@property (nonatomic,strong) NSArray <HXBFinHomePageViewModel_PlanList *>* finPlanListVMArray;
//散标列表的数据数组
@property (nonatomic,strong) NSArray <HXBFinHomePageViewModel_LoanList *>* finLoanListVMArray;
///债转的数据
@property (nonatomic,strong) NSArray <HXBFinHomePageViewModel_LoanTruansferViewModel *>* finLoanTruansferVMArray;

//MARK: ----------  点击了中间的toolBarView按钮 ---------------
@property (nonatomic,copy) void(^switchBottomScrollViewBlock)(NSInteger index, NSString *title, UIButton *option);


//MARK: ----------  点击cell ---------------
///点击红利计划列表后回调，跳转详情页
@property (nonatomic,copy) void(^clickPlanListCellBlock)(NSIndexPath *indexPath, id model);
///点击散标列表后回调，跳转详情页
@property (nonatomic,copy) void(^clickLoanListCellBlock)(NSIndexPath *index, id model);
///点击债转的cell 跳转详情页
@property (nonatomic,copy) void(^clickLoanTruansferCellBlock)(HXBFinHomePageViewModel_LoanTruansferViewModel* model,NSIndexPath *index);


//MARK: - --------- 关于刷新 -----------------
///是否停止刷新
@property (nonatomic,assign) BOOL isStopRefresh_Plan;
@property (nonatomic,assign) BOOL isStopRefresh_loan;
@property (nonatomic,assign) BOOL isStopRefresh_LoanTruansfer;

@property (nonatomic, assign) BOOL isPlanLastPage;      //计划是否最后一页
@property (nonatomic, assign) BOOL isPlanShowLoadMore;  //计划是否显示加载更多

@property (nonatomic, assign) BOOL isLoanLastPage;      //计划是否最后一页
@property (nonatomic, assign) BOOL isLoanShowLoadMore;  //计划是否显示加载更多

@property (nonatomic, assign) BOOL isLoanTruansferLastPage;         //计划是否最后一页
@property (nonatomic, assign) BOOL isLoanTruansferShowLoadMore;     //计划是否显示加载更多


///红利计划上拉加载
@property (nonatomic,copy) void(^planRefreshFooterBlock)();
///红利计划下拉刷新
@property (nonatomic,copy) void(^planRefreshHeaderBlock)();
///散标上拉加载
@property (nonatomic,copy) void(^loanRefreshFooterBlock)();
///散标下拉刷新
@property (nonatomic,copy) void(^loanRefreshHeaderBlock)();
///债转上啦加载
@property (nonatomic,copy) void(^loanTruansferFooterBlock)();
///债转下拉刷新
@property (nonatomic,copy) void(^loanTruansferHeaderBlock)();

///刷新UI
- (void)loadData;
@end

