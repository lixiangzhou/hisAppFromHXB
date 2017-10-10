//
//  HXBEnumerateTransitionManager.m
//  hoomxb
//
//  Created by HXB on 2017/6/26.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBEnumerateTransitionManager.h"

@implementation HXBEnumerateTransitionManager

#pragma mark - ======================== plan 枚举的转化方法 =============================

/// 根据枚举值返回对应的请求参数字符串 ———— 我的红利计划主界面
+ (HXBRequestType_MY_PlanRequestType)myPlan_requestTypeStr: (NSString *)typeStr{
    
    if ([typeStr isEqualToString:MY_PlanRequestType_EXIT_PLAN]) return HXBRequestType_MY_PlanRequestType_EXIT_PLAN;//已退出
    if ([typeStr isEqualToString:MY_PlanRequestType_HOLD_PLAN]) return HXBRequestType_MY_PlanRequestType_HOLD_PLAN;//持有中
    if ([typeStr isEqualToString:MY_PlanRequestType_EXITING_PLAN]) return HXBRequestType_MY_PlanRequestType_EXITING_PLAN;//退出中
    NSLog(@"🌶 %@, - 我的红利计划主界面  根据枚举值返回对应的请求参数字符串 出现错误",self.class);
    return HXBRequestType_MY_PlanRequestType_EXIT_PLAN;
}

/// 根据枚举值返回对应的请求参数字符串 ———— 我的红利计划主界面
+ (NSString *)myPlan_requestType: (HXBRequestType_MY_PlanRequestType)type andTypeBlock: (void(^)(NSString *typeUI, NSString *type))typeBlock{
    NSString *typeStr = @"";
    NSString *typeStrUI = @"";
    switch (type) {
        case HXBRequestType_MY_PlanRequestType_EXIT_PLAN:
            typeStr = MY_PlanRequestType_EXIT_PLAN;
            typeStrUI = MY_PlanRequestType_EXIT_PLAN_UI;
            break;
        case HXBRequestType_MY_PlanRequestType_HOLD_PLAN:
            typeStr = MY_PlanRequestType_HOLD_PLAN;
            typeStrUI = MY_PlanRequestType_HOLD_PLAN_UI;
            break;
        case HXBRequestType_MY_PlanRequestType_EXITING_PLAN:
            typeStrUI = MY_PlanRequestType_EXITING_PLAN_UI;
            typeStr = MY_PlanRequestType_EXITING_PLAN;
            break;
    }
    if (!typeStr.length) {
        NSLog(@"%@ - 我的红利计划主界面—— 对应的请求参数字符串 返回错误,）",self.class);
    }
    typeBlock(typeStrUI,typeStr);
    return typeStr;
}

///红利计划相应的 计划状态
+ (NSString *)myPlan_ResponsStatus: (HXBRequestType_MY_PlanResponseStatus)status {
    NSString *statusStr = @"";
    switch (status) {
        case HXBRequestType_MY_PlanResponseStatus_PURCHASE_END:
            statusStr = @"退出";
            break;
            
        case HXBRequestType_MY_PlanResponseStatus_REDEMPTION_PERIOD:
            statusStr = @"等待计息";
            break;
    }
    if (!statusStr.length) {
        NSLog(@"%@， - 我的红利计划主界面 -- 对应的相应参数字符串 输入错误",self.class);
    }
    return statusStr;
}

///把计划状态 变成枚举值
+ (HXBRequestType_MY_PlanResponseStatus)myPlan_ResponsStatusStr: (NSString *)responsStr {
    if ([responsStr isEqualToString:MY_PlanResponsType_PURCHASE_END_Plan]) return HXBRequestType_MY_PlanResponseStatus_PURCHASE_END;//收益中
    if ([responsStr isEqualToString:MY_PlanResponsType_PURCHASEING_Plan]) return HXBRequestType_MY_PlanResponseStatus_REDEMPTION_PERIOD;//等待计息
    NSLog(@"%@无法判断 （等待计息 还是 收益中），",self.class);
    return LONG_MAX;
}




#pragma mark =========================== loan =========================
#pragma mark -  loan 界面
/// 根据枚举值返回对应的请求参数字符串 ———— 我的Loan界面
+ (HXBRequestType_MY_LoanRequestType)myLoan_RequestTypeStr: (NSString *)typeStr {
//    if ([typeStr isEqualToString:HXBRequestType_MY_FINISH_LOAN]) return HXBRequestType_MY_LoanRequestType_BID_LOAN;
    if ([typeStr isEqualToString:HXBRequestType_MY_BID_LOAN]) return HXBRequestType_MY_LoanRequestType_BID_LOAN;
    if ([typeStr isEqualToString:HXBRequestType_MY_REPAYING_LOAN]) return HXBRequestType_MY_LoanRequestType_REPAYING_LOAN;
    NSLog(@"%@， - 我的Loan主界面 -- 对应的相应参数字符串 输入错误，",self.class);
    return LONG_MAX;
}

+ (HXBRequestType_MY_LoanResponsType)myLoan_ResponsType: (NSString *)responsType {
    if ([responsType isEqualToString:HXBRequestType_MY_XYRZ_Loan]) return HXBRequestType_MY_LoanResponsType_XYRZ;
    if ([responsType isEqualToString:HXBRequestType_MY_SDRZ_Loan]) return HXBRequestType_MY_LoanResponsType_SDRZ;
    NSLog(@"%@ - 我的loan 列表 -- 转化 收益和 等待计息失败",self.class);
    return LONG_MAX;
}

/// 根据枚举值返回对应的请求参数字符串 ———— 我的Loan主界面
+ (void)myLoan_requestType: (HXBRequestType_MY_LoanRequestType)type andReturnParamBlock: (void(^)(NSString *type, NSString *UI_Type))returnParamBlock{
    switch (type) {
        case HXBRequestType_MY_LoanRequestType_REPAYING_LOAN:
            returnParamBlock(HXBRequestType_MY_REPAYING_LOAN,HXBRequestType_MY_REPAYING_LOAN_UI);
            break;
        case HXBRequestType_MY_LoanRequestType_Truansfer:
            returnParamBlock(HXBRequestType_MY_FINISH_LOAN,HXBRequestType_MY_FINISH_LOAN_UI);
            break;
        case HXBRequestType_MY_LoanRequestType_BID_LOAN:
            returnParamBlock(HXBRequestType_MY_BID_LOAN,HXBRequestType_MY_BID_LOAN_UI);
            break;
    }
}

#pragma mark =========================== loanTruansfer =========================
/**
 状态
 TRANSFERING：正在转让，
 TRANSFERED：转让完毕，
 CANCLE：已取消，
 CLOSED_CANCLE：结标取消，
 OVERDUE_CANCLE：逾期取消，
 PRESALE：转让预售
 */
+ (NSString *)Fin_LoanTruansfer_StatusWith_request:(NSString *)request {
    if ([request isEqualToString:@"TRANSFERING"])       return @"正在转让";
    if ([request isEqualToString:@"TRANSFERED"])        return @"转让完毕";
    if ([request isEqualToString:@"CANCLE"])            return @"已取消";
    if ([request isEqualToString:@"CLOSED_CANCLE"])     return @"结标取消";
    if ([request isEqualToString:@"OVERDUE_CANCLE"])    return @"逾期取消";
    if ([request isEqualToString:@"PRESALE"])           return @"转让预售";
    NSLog(@"🌶 loanTruansfer 数据错误%@",self);
    return @"数据错误";
}
@end
