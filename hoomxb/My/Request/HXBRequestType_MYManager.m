//
//  HXBRequestType_MY.m
//  hoomxb
//
//  Created by HXB on 2017/5/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRequestType_MYManager.h"
#import <limits.h>
static NSString *MY_PlanRequestType_HOLD_PLAN = @"HOLD_PLAN";
static NSString *MY_PlanRequestType_HOLD_PLAN_UI = @"";
static NSString *MY_PlanRequestType_EXITING_PLAN = @"EXITING_PLAN";
static NSString *MY_PlanRequestType_EXITING_PLAN_UI = @"";
static NSString *MY_PlanRequestType_EXIT_PLAN = @"EXIT_PLAN";
static NSString *MY_PlanRequestType_EXIT_PLAN_UI = @"";


@implementation HXBRequestType_MYManager
/// 根据枚举值返回对应的请求参数字符串 ———— 我的红利计划主界面
+ (HXBRequestType_MY_PlanRequestType)myPlan_requestTypeStr: (NSString *)typeStr{
    
    if ([typeStr isEqualToString:@"EXIT_PLAN"]) return HXBRequestType_MY_PlanRequestType_EXIT_PLAN;//已推出
    if ([typeStr isEqualToString:@"HOLD_PLAN"]) return HXBRequestType_MY_PlanRequestType_HOLD_PLAN;//持有中
    if ([typeStr isEqualToString:@"EXITING_PLAN"]) return HXBRequestType_MY_PlanRequestType_EXITING_PLAN;//推出中
    NSLog(@"🌶 %@, - 我的红利计划主界面  根据枚举值返回对应的请求参数字符串 出现错误",self.class);
    return HXBRequestType_MY_PlanRequestType_EXIT_PLAN;
}
/// 根据枚举值返回对应的请求参数字符串 ———— 我的红利计划主界面
+ (NSString *)myPlan_requestType: (HXBRequestType_MY_PlanRequestType)type{
    NSString *typeStr = @"";
    switch (type) {
        case HXBRequestType_MY_PlanRequestType_EXIT_PLAN:
            typeStr = MY_PlanRequestType_EXIT_PLAN;
            break;
            case HXBRequestType_MY_PlanRequestType_HOLD_PLAN:
            typeStr = MY_PlanRequestType_HOLD_PLAN;
            break;
            case HXBRequestType_MY_PlanRequestType_EXITING_PLAN:
            typeStr = MY_PlanRequestType_EXITING_PLAN;
            break;
    }
    if (!typeStr.length) {
        NSLog(@"%@ - 我的红利计划主界面—— 对应的请求参数字符串 返回错误,）",self.class);

    }
    return typeStr;
}
///红利计划相应的 计划状态
+ (NSString *)myPlan_ResponsStatus: (HXBRequestType_MY_PlanResponseStatus)status {
    NSString *statusStr = @"";
    switch (status) {
        case HXBRequestType_MY_PlanResponseStatus_PURCHASE_END:
            statusStr = @"PURCHASE_END";
            break;
            
        case HXBRequestType_MY_PlanResponseStatus_REDEMPTION_PERIOD:
            statusStr = @"REDEMPTION_PERIOD";
            break;
    }
    if (!statusStr.length) {
        NSLog(@"%@， - 我的红利计划主界面 -- 对应的相应参数字符串 输入错误",self.class);
    }
    return statusStr;
}

///把计划状态 变成枚举值
+ (HXBRequestType_MY_PlanResponseStatus)myPlan_ResponsStatusStr: (NSString *)responsStr {
    if ([responsStr isEqualToString:@"EXIT_PLAN"]) return HXBRequestType_MY_PlanResponseStatus_PURCHASE_END;//等待计息
    if ([responsStr isEqualToString:@"HOLD_PLAN"]) return HXBRequestType_MY_PlanResponseStatus_REDEMPTION_PERIOD;//收益中
    NSLog(@"%@， - 我的红利计划主界面 -- 对应的相应参数字符串 输入错误，",self.class);
    return LONG_MAX;
}


#pragma mark -  loan 界面
/// 根据枚举值返回对应的请求参数字符串 ———— 我的Loan界面
+ (HXBRequestType_MY_LoanRequestType)myLoan_RequestTypeStr: (NSString *)typeStr {
    if ([typeStr isEqualToString:loan_FINISH_LOAN]) return HXBRequestType_MY_LoanRequestType_FINISH_LOAN;
    if ([typeStr isEqualToString:loan_BID_LOAN]) return HXBRequestType_MY_LoanRequestType_BID_LOAN;
    if ([typeStr isEqualToString:loan_REPAYING_LOAN]) return HXBRequestType_MY_LoanRequestType_REPAYING_LOAN;
    NSLog(@"%@， - 我的Loan主界面 -- 对应的相应参数字符串 输入错误，",self.class);
    return LONG_MAX;
}
// 根据枚举值返回对应的请求参数字符串 ———— 我的Loan主界面
+ (void)myLoan_requestType: (HXBRequestType_MY_LoanRequestType)type andReturnParamBlock: (void(^)(NSString *type, NSString *UI_Type))returnParamBlock{
    switch (type) {
        case HXBRequestType_MY_LoanRequestType_REPAYING_LOAN:
            returnParamBlock(loan_REPAYING_LOAN,loan_REPAYING_LOAN_UI);
            break;
        case HXBRequestType_MY_LoanRequestType_FINISH_LOAN:
            returnParamBlock(loan_FINISH_LOAN,loan_FINISH_LOAN_UI);
            break;
        case HXBRequestType_MY_LoanRequestType_BID_LOAN:
            returnParamBlock(loan_BID_LOAN,loan_BID_LOAN_UI);
            break;
    }
}


@end