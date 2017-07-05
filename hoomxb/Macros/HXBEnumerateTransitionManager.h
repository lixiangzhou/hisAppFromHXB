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
static NSString *const MY_PlanResponsType_PURCHASE_END_Plan = @"PURCHASE_END";//收益中
///等待计息
static NSString *const MY_PlanResponsType_PURCHASEING_Plan = @"PURCHASEING";//等待计息

static NSString *const MY_PlanRequestType_HOLD_PLAN         = @"HOLD_PLAN";
static NSString *const MY_PlanRequestType_HOLD_PLAN_UI      = @"债权匹配中";
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
    ///REDEMPTION_PERIOD：等待计息，
    HXBRequestType_MY_PlanResponseStatus_REDEMPTION_PERIOD,
    ///PURCHASE_END：收益中
    HXBRequestType_MY_PlanResponseStatus_PURCHASE_END,
}HXBRequestType_MY_PlanResponseStatus;



#pragma mark ====================== loan =============================

/// 返回的type （投标中，收益中）
typedef enum : NSInteger{
    ///收益中
    HXBRequestType_MY_LoanResponsType_XYRZ,
    ///投标中
    HXBRequestType_MY_LoanResponsType_SDRZ
}HXBRequestType_MY_LoanResponsType;


//MARK: 账户内 散标 枚举
typedef enum : NSUInteger {
    ///收益中
    HXBRequestType_MY_LoanRequestType_REPAYING_LOAN = 1,
    ///投标中
    HXBRequestType_MY_LoanRequestType_BID_LOAN,
    ///已结清
    HXBRequestType_MY_LoanRequestType_FINISH_LOAN
}HXBRequestType_MY_LoanRequestType;


//MARK: ----- request loan -------
///已结清
static NSString *const HXBRequestType_MY_FINISH_LOAN = @"FINISH_LOAN";
///已结清的UI 显示
static NSString *const HXBRequestType_MY_FINISH_LOAN_UI = @"已结清";
///收益中
static NSString *const HXBRequestType_MY_REPAYING_LOAN = @"REPAYING_LOAN";
///收益中的UI显示
static NSString *const HXBRequestType_MY_REPAYING_LOAN_UI = @"收益中";
///投标中
static NSString *const HXBRequestType_MY_BID_LOAN = @"BID_LOAN";
///投标中的UI显示
static NSString *const HXBRequestType_MY_BID_LOAN_UI = @"投标中";

//MARK: loan 列表页 返回的type
///我的账户内散标（收益中） XYRZ
static NSString *const HXBRequestType_MY_XYRZ_Loan = @"XYRZ";
///我的账户内散标（投标中） SDRZ
static NSString *const HXBRequestType_MY_SDRZ_Loan = @"SDRZ";

#pragma mark ================================ MY ===============================
//MARK:  --------------------------------- 交易记录 - 筛选 ----------------------------
/**
 枚举 - 交易记录筛选
 */
typedef enum : NSUInteger {
    ///全部
    kHXBEnum_MY_CapitalRecord_Type_All = 0,
    ///充值
    kHXBEnum_MY_CapitalRecord_Type_topUP = 1,
    ///提现
    kHXBEnum_MY_CapitalRecord_Type_withdraw = 2,
    ///红利计划
    kHXBEnum_MY_CapitalRecord_Type_Plan = 3,
    ///散标债权
    kHXBEnum_MY_CapitalRecord_Type_Loan = 4
}kHXBEnum_MY_CapitalRecord_Type;
///全部
static NSString *const kHXBString_MY_CapitalRecord_Type_All = @"全部";
///充值
static NSString *const kHXBString_MY_CapitalRecord_Type_topUP = @"充值";
///提现
static NSString *const kHXBString_MY_CapitalRecord_Type_withdraw = @"提现";
///红利计划
static NSString *const kHXBString_MY_CapitalRecord_Type_Plan = @"红利计划";
///散标债权
static NSString *const kHXBString_MY_CapitalRecord_Type_Loan = @"散标债权";



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




#pragma mark ================================ loan ===============================
/// 根据枚举值返回对应的请求参数字符串 ———— 我的Loan界面
+ (HXBRequestType_MY_LoanRequestType)myLoan_RequestTypeStr: (NSString *)typeStr;

/**
 *  根据枚举值返回对应的请求参数字符串 ———— 我的Loan主界面
 *  type 是程序表示， UI_Type是UI显示表示
 */
+ (void)myLoan_requestType: (HXBRequestType_MY_LoanRequestType)type andReturnParamBlock: (void(^)(NSString *type, NSString *UI_Type))returnParamBlock;

///根据loan  返回的type （投标中，收益中）的类型，生成枚举类型
+ (HXBRequestType_MY_LoanResponsType)myLoan_ResponsType: (NSString *)responsType;




@end
