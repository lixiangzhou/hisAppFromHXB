//
//  HXBFinancingPlanDetailViewModel.h
//  hoomxb
//
//  Created by lxz on 2018/1/15.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBFinDetailModel_PlanDetail.h"
#import "HXBFinDetailViewModel_PlanDetail.h"
#import "HXBFin_PlanDetailView_TopView.h"
#import "HXBFinBase_FlowChartView.h"
#import "HXBFin_Plan_Buy_ViewController.h"

@interface HXBFinancingPlanDetailViewModel : HXBBaseViewModel

/// 红利计划详情页
@property (nonatomic, strong) HXBFinDetailViewModel_PlanDetail *planDetailModel;
/// 等待加入状态
@property (nonatomic, assign) BOOL statusCanJoinIn;
/// 是否有利率
@property (nonatomic, assign) BOOL hasExtraInterestRate;
/// tableView Title
@property (nonatomic, strong) NSArray <NSString *> *tableViewTitleArray;
/// 收益字段
@property (nonatomic, copy) NSString *profitString;

/// 倒计时
- (NSString *)countDownString:(CGFloat)countDown;
/// 设置 顶部视图数据
- (void)setTopViewManagerData:(HXBFin_PlanDetailView_TopViewManager *)manager;

/// 设置数据
- (void)setFlowChartViewManagerData:(HXBFinBase_FlowChartView_Manager *)manager;
/// 获取一个将要push 的 HXBFin_Plan_Buy_ViewController，内部会设置要数据
- (HXBFin_Plan_Buy_ViewController *)getAPlanBuyController;
/// 红利计划详情页
- (void)requestPlanDetailWithPlanId:(NSString *)planId resultBlock:(void (^)(BOOL isSuccess))resultBlock;

@end
