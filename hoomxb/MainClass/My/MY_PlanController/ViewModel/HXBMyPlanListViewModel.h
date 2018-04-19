//
//  HXBMyPlanListViewModel.h
//  hoomxb
//
//  Created by caihongji on 2018/1/26.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBMYViewModel_MianPlanViewModel.h"
#import "HXBMYModel_Plan_planRequestModel.h"
#import "HXBBaseViewModel.h"

@interface HXBMyPlanListViewModel : HXBBaseViewModel
///资金统计model
@property (nonatomic, strong) HXBMYModel_Plan_planRequestModel* planAcccountModel;

///plan 持有中
@property (nonatomic,strong) NSMutableArray <HXBMYViewModel_MianPlanViewModel *> *hold_Plan_array;
@property (nonatomic, assign) BOOL isHoldPlanLastPage; //持有中是否最后一页
@property (nonatomic, assign) BOOL isHoldPlanShowLoadMore; //持有中是否显示加载更多

///plan 退出中
@property (nonatomic,strong) NSMutableArray <HXBMYViewModel_MianPlanViewModel *> *exiting_Plan_array;
@property (nonatomic, assign) BOOL isExitingLastPage; //退出中是否最后一页
@property (nonatomic, assign) BOOL isExitingShowLoadMore; //退出中是否显示加载更多

///plan 已退出
@property (nonatomic,strong) NSMutableArray <HXBMYViewModel_MianPlanViewModel *> *exit_Plan_array;
@property (nonatomic, assign) BOOL isExitedLastPage; //已退出是否最后一页
@property (nonatomic, assign) BOOL isExitedShowLoadMore; //退出中是否显示加载更多

/**
 资金统计的Request plan

 @param isShowHug 是否显示加载框
 @param resultBlock 结果回调
 */
- (void)myPlanAssetStatistics_requestWithSuccessBlock:(BOOL)isShowHug andResultBlock: (void(^)(BOOL isSuccess))resultBlock;

/**
 红利计划 列表的网络数据请求

 @param planRequestType 计划列表类型
 @param isUPData 是否是下拉刷新
 @param resultBlock 结果回调
 */
- (void)myPlan_requestWithPlanType: (HXBRequestType_MY_PlanRequestType)planRequestType
                         andUpData: (BOOL)isUPData
                   andResultBlock: (void(^)(BOOL isSuccess))resultBlock;
@end
