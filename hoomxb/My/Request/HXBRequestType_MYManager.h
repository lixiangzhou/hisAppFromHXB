//
//  HXBRequestType_MY.h
//  hoomxb
//
//  Created by HXB on 2017/5/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString *MY_PlanRequestType_HOLD_PLAN;
static NSString *MY_PlanRequestType_HOLD_PLAN_UI;
static NSString *MY_PlanRequestType_EXITING_PLAN;
static NSString *MY_PlanRequestType_EXITING_PLAN_UI;
static NSString *MY_PlanRequestType_EXIT_PLAN;
static NSString *MY_PlanRequestType_EXIT_PLAN_UI;

//MARK: ====================================== 账户内 红利 计划 枚举 ================================
//MARK: 红利计划请求
/** 红利计划 主界面的请求参数
 * HOLD_PLAN（持有中）
 * EXITING_PLAN（退出中）
 * EXIT_PLAN（已退出）
*/
typedef enum : NSUInteger {
    ///持有中
    HXBRequestType_MY_PlanRequestType_HOLD_PLAN,
    ///EXITING_PLAN（退出中）
    HXBRequestType_MY_PlanRequestType_EXITING_PLAN,
    /// EXIT_PLAN（已退出）
    HXBRequestType_MY_PlanRequestType_EXIT_PLAN,
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


//MARK: ====================================== 账户内 散标 枚举 ================================
typedef enum : NSUInteger {
    ///已结清
    HXBRequestType_MY_LoanRequestType_FINISH_LOAN,
    ///收益中
    HXBRequestType_MY_LoanRequestType_REPAYING_LOAN,
    ///投标中
    HXBRequestType_MY_LoanRequestType_BID_LOAN
   
}HXBRequestType_MY_LoanRequestType;




#pragma mark - 散标
//MARK: ----- request loan -------
///已结清
static NSString *const loan_FINISH_LOAN = @"FINISH_LOAN";
///已结清的UI 显示
static NSString *const loan_FINISH_LOAN_UI = @"已结清";
///收益中
static NSString *const loan_REPAYING_LOAN = @"REPAYING_LOAN";
///收益中的UI显示
static NSString *const loan_REPAYING_LOAN_UI = @"收益中";
///投标中
static NSString *const loan_BID_LOAN = @"BID_LOAN";
///投标中的UI显示
static NSString *const loan_BID_LOAN_UI = @"投标中";

//MARK: ------ respons loan --------



///关于请求的一些枚举值的处理
@interface HXBRequestType_MYManager : NSObject


#pragma mark - 账户内 红利 计划 枚举

/// 根据枚举值返回对应的请求参数字符串 ———— 我的红利计划主界面
+ (HXBRequestType_MY_PlanRequestType)myPlan_requestTypeStr: (NSString *)typeStr;
/// 根据枚举值返回对应的请求参数字符串 ———— 我的红利计划主界面
+ (NSString *)myPlan_requestType: (HXBRequestType_MY_PlanRequestType)type andTypeBlock: (void(^)(NSString *typeUI, NSString *type))typeBlock;


///红利计划相应的 计划状态
+ (NSString *)myPlan_ResponsStatus: (HXBRequestType_MY_PlanResponseStatus)status;
///把计划状态 变成枚举值
+ (HXBRequestType_MY_PlanResponseStatus)myPlan_ResponsStatusStr: (NSString *)responsStr;


#pragma mark - 账户内 loan 枚举处理
/// 根据枚举值返回对应的请求参数字符串 ———— 我的Loan界面
+ (HXBRequestType_MY_LoanRequestType)myLoan_RequestTypeStr: (NSString *)typeStr;
/**
 *  根据枚举值返回对应的请求参数字符串 ———— 我的Loan主界面
 *  ///type 是程序表示， UI_Type是UI显示表示
 */
+ (void)myLoan_requestType: (HXBRequestType_MY_LoanRequestType)type andReturnParamBlock: (void(^)(NSString *type, NSString *UI_Type))returnParamBlock;
@end
