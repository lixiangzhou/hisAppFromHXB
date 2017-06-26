//
//  HXBEnumerateTransitionManager.h
//  hoomxb
//
//  Created by HXB on 2017/6/26.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#pragma  mark ========== plan ======================
///计划类型（PURCHASE_END：收益中，PURCHASEING：等待计息)
///收益中
static NSString *const MY_PlanResponsType_PURCHASE_END_Plan = @"PURCHASE_END";
///等待计息
static NSString *const MY_PlanResponsType_PURCHASEING_Plan = @"PURCHASEING";

static NSString *const MY_PlanRequestType_HOLD_PLAN         = @"HOLD_PLAN";
static NSString *const MY_PlanRequestType_HOLD_PLAN_UI      = @"等待计息";
static NSString *const MY_PlanRequestType_EXITING_PLAN      = @"EXITING_PLAN";
static NSString *const MY_PlanRequestType_EXITING_PLAN_UI   = @"退出中";
static NSString *const MY_PlanRequestType_EXIT_PLAN         = @"EXIT_PLAN";
static NSString *const MY_PlanRequestType_EXIT_PLAN_UI      = @"已退出";

//MARK: 红利计划请求
/** 红利计划 主界面的请求参数
 * HOLD_PLAN（持有中）
 * EXITING_PLAN（退出中）
 * EXIT_PLAN（已退出）
 */
typedef enum : NSUInteger {
    ///持有中
    HXBRequestType_MY_PlanRequestType_HOLD_PLAN = 1,
    ///EXITING_PLAN（退出中）
    HXBRequestType_MY_PlanRequestType_EXITING_PLAN = 2,
    /// EXIT_PLAN（已退出）
    HXBRequestType_MY_PlanRequestType_EXIT_PLAN = 3,
} HXBRequestType_MY_PlanRequestType;


//MARK: 红利计划response
/** 红利计划相应的 计划状态
 REDEMPTION_PERIOD：收益中，
 PURCHASE_END：等待计息
 */
typedef enum : NSUInteger {
    ///REDEMPTION_PERIOD：收益中，
    HXBRequestType_MY_PlanResponseStatus_REDEMPTION_PERIOD,
    ///PURCHASE_END：等待计息
    HXBRequestType_MY_PlanResponseStatus_PURCHASE_END,
}HXBRequestType_MY_PlanResponseStatus;



@interface HXBEnumerateTransitionManager : NSObject
#pragma  mark ========== plan ======================

/**
红利计划相应的 计划状态
 */
+ (NSString *)myPlan_ResponsStatus: (HXBRequestType_MY_PlanResponseStatus)status;
/**
 把计划状态 变成枚举值
 */
+ (HXBRequestType_MY_PlanResponseStatus)myPlan_ResponsStatusStr: (NSString *)responsStr;
/**
 根据枚举值返回对应的请求参数字符串 ———— 我的红利计划主界面
 */
+ (HXBRequestType_MY_PlanRequestType)myPlan_requestTypeStr: (NSString *)typeStr;
/** 
 根据枚举值返回对应的请求参数字符串 ———— 我的红利计划主界面
 */
+ (NSString *)myPlan_requestType: (HXBRequestType_MY_PlanRequestType)type andTypeBlock: (void(^)(NSString *typeUI, NSString *type))typeBlock;

@end
