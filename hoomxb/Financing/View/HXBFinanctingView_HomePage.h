//
//  HXBFinanctingView_HomePage.h
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBFinHomePageViewModel_PlanList;
@class HXBFinHomePageViewModel_LoanList;

@interface HXBFinanctingView_HomePage : UIView
///MARK: ----------  model的数组 （数据源） ---------------
//红利计划列表的数据数组
@property (nonatomic,strong) NSArray <HXBFinHomePageViewModel_PlanList *>* finPlanListVMArray;
//散标列表的数据数组
@property (nonatomic,strong) NSArray <HXBFinHomePageViewModel_LoanList *>* finLoanListVMArray;


//MARK: ----------  点击了中间的toolBarView按钮 ---------------
@property (nonatomic,copy) void(^switchBottomScrollViewBlock)(NSInteger index, NSString *title, UIButton *option);


//MARK: ----------  点击cell ---------------
///点击红利计划列表后回调，跳转详情页
@property (nonatomic,copy) void(^clickPlanListCellBlock)(NSIndexPath *indexPath, id model);
///点击散标列表后回调，跳转详情页
@property (nonatomic,copy) void(^clickLoanListCellBlock)(NSIndexPath *index, id model);
///点击债转的cell 跳转详情页
@property (nonatomic,copy) void(^clickLoanTruansferCellBlock)(NSIndexPath *index, id Model);


//MARK: - --------- 关于刷新 -----------------
///是否停止刷新
@property (nonatomic,assign) BOOL isStopRefresh_Plan;
@property (nonatomic,assign) BOOL isStopRefresh_loan;
@property (nonatomic,assign) BOOL isStopRefresh_LoanTruansfer;

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

