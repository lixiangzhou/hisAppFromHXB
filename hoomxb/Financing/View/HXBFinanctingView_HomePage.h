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
@property (nonatomic,copy) void(^midToolBarViewClickWithBlock)(NSInteger index, NSString *title, UIButton *option);


//MARK: ----------  点击cell ---------------
///点击红利计划列表后回调，跳转详情页
@property (nonatomic,copy) void(^clickPlanListCellBlock)(NSIndexPath *indexPath, id model);
///点击散标列表后回调，跳转详情页
@property (nonatomic,copy) void(^clickLoanListCellBlock)(NSIndexPath *index, id model);



//MARK: - --------- 关于刷新 -----------------
///是否停止刷新
@property (nonatomic,assign) BOOL isStopRefresh_Plan;
@property (nonatomic,assign) BOOL isStopRefresh_loan;
///红利计划上拉加载
@property (nonatomic,copy) void(^planRefreshFooterBlock)();
///红利计划下拉刷新
@property (nonatomic,copy) void(^planRefreshHeaderBlock)();
///散标上拉加载
@property (nonatomic,copy) void(^loanRefreshFooterBlock)();
///散标下拉刷新
@property (nonatomic,copy) void(^loanRefreshHeaderBlock)();


///MARK: ------------ 定时管理 -----------
@property (nonatomic,strong) HXBBaseContDownManager *contDwonManager;

@end
///注意 在滚动的时候停止定时器 否则会发生cell 的重用问题
