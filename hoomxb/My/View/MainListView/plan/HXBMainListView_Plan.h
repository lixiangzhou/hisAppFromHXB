//
//  HXBMainListView_Plan.h
//  hoomxb
//
//  Created by HXB on 2017/5/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBMYModel_AssetStatistics_Plan;

#import "HXBMYViewModel_MianPlanViewModel.h"

/// 我的 plan listView
@interface HXBMainListView_Plan : UIView

#pragma mark - 数据源
///资产统计
@property (nonatomic,strong) HXBMYModel_AssetStatistics_Plan *planAssetStatisticsModel;
///持有中
@property (nonatomic,strong) NSArray <HXBMYViewModel_MianPlanViewModel *>*hold_Plan_array;
///plan 推出中
@property (nonatomic,strong) NSArray <HXBMYViewModel_MianPlanViewModel *>*exiting_Plan_array;
///plan 已退出
@property (nonatomic,strong) NSArray <HXBMYViewModel_MianPlanViewModel *>*exit_Plan_array;


#pragma mark - 刷新
///资产统计的刷新
- (void)requestAssetStatisticsWithBlockFunc: (void(^)())assetStatisticsWithBlock;

///停止刷新
- (void)endRefresh;

///上拉下拉刷新 hold
- (void) hold_RefreashWithDownBlock:(void(^)())downBlock andUPBlock: (void(^)())UPBlock;
///上拉下拉刷新 exiting
- (void) exiting_RefreashWithDownBlock:(void(^)())downBlock andUPBlock: (void(^)())UPBlock;
///上拉下拉刷新 exit
- (void) exit_RefreashWithDownBlock:(void(^)())downBlock andUPBlock: (void(^)())UPBlock;


#pragma mark - 中间的toolBarView的select Option 改变的时候
- (void)changeMidSelectOptionFuncWithBlock:(void (^)(UIButton *button, NSString *title, NSInteger index, HXBRequestType_MY_PlanRequestType requestType))changeMidSelectOptionBlock;

#pragma mark - cell的点击事件
///hold 点击
- (void)clickLoan_hold_CellFuncWithBlock:(void (^)(HXBMYViewModel_MianPlanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex))clickPlanCellBlock;
///exiting 点击
- (void)clickLoan_exiting_CellFuncWithBlock:(void (^)(HXBMYViewModel_MianPlanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex))clickPlanCellBlock;
///exit 点击
- (void)clickLoan_exit_CellFuncWithBlock:(void (^)(HXBMYViewModel_MianPlanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex))clickPlanCellBlock;
    
@end
