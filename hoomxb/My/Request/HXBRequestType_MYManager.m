//
//  HXBRequestType_MY.m
//  hoomxb
//
//  Created by HXB on 2017/5/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRequestType_MYManager.h"
#import <limits.h>



@implementation HXBRequestType_MYManager


/////红利计划相应的 计划状态
//+ (NSString *)myPlan_ResponsStatus: (HXBRequestType_MY_PlanResponseStatus)status {
//    NSString *statusStr = @"";
//    switch (status) {
//        case HXBRequestType_MY_PlanResponseStatus_PURCHASE_END:
//            statusStr = MY_PlanResponsType_PURCHASE_END_Plan;
//            break;
//            
//        case HXBRequestType_MY_PlanResponseStatus_REDEMPTION_PERIOD:
//            statusStr = MY_PlanResponsType_PURCHASEING_Plan;
//            break;
//    }
//    if (!statusStr.length) {
//        NSLog(@"%@， - 我的红利计划主界面 -- 对应的相应参数字符串 输入错误",self.class);
//    }
//    return statusStr;
//}
//
/////把计划状态 变成枚举值
//+ (HXBRequestType_MY_PlanResponseStatus)myPlan_ResponsStatusStr: (NSString *)responsStr {
//    if ([responsStr isEqualToString:MY_PlanResponsType_PURCHASE_END_Plan]) return HXBRequestType_MY_PlanResponseStatus_PURCHASE_END;//等待计息
//    if ([responsStr isEqualToString:MY_PlanResponsType_PURCHASEING_Plan]) return HXBRequestType_MY_PlanResponseStatus_REDEMPTION_PERIOD;//收益中
//    NSLog(@"%@无法判断 （等待计息 还是 收益中），",self.class);
//    return LONG_MAX;
//}
//
//
//#pragma mark -  loan 界面
///// 根据枚举值返回对应的请求参数字符串 ———— 我的Loan界面
//+ (HXBRequestType_MY_LoanRequestType)myLoan_RequestTypeStr: (NSString *)typeStr {
//    if ([typeStr isEqualToString:HXBRequestType_MY_FINISH_LOAN]) return HXBRequestType_MY_LoanRequestType_FINISH_LOAN;
//    if ([typeStr isEqualToString:HXBRequestType_MY_BID_LOAN]) return HXBRequestType_MY_LoanRequestType_BID_LOAN;
//    if ([typeStr isEqualToString:HXBRequestType_MY_REPAYING_LOAN]) return HXBRequestType_MY_LoanRequestType_REPAYING_LOAN;
//    NSLog(@"%@， - 我的Loan主界面 -- 对应的相应参数字符串 输入错误，",self.class);
//    return LONG_MAX;
//}
//
//+ (HXBRequestType_MY_LoanResponsType)myLoan_ResponsType: (NSString *)responsType {
//    if ([responsType isEqualToString:HXBRequestType_MY_XYRZ_Loan]) return HXBRequestType_MY_LoanResponsType_XYRZ;
//    if ([responsType isEqualToString:HXBRequestType_MY_SDRZ_Loan]) return HXBRequestType_MY_LoanResponsType_SDRZ;
//    NSLog(@"%@ - 我的loan 列表 -- 转化 收益和 等待计息失败",self.class);
//    return LONG_MAX;
//}
//
///// 根据枚举值返回对应的请求参数字符串 ———— 我的Loan主界面
//+ (void)myLoan_requestType: (HXBRequestType_MY_LoanRequestType)type andReturnParamBlock: (void(^)(NSString *type, NSString *UI_Type))returnParamBlock{
//    switch (type) {
//        case HXBRequestType_MY_LoanRequestType_REPAYING_LOAN:
//            returnParamBlock(HXBRequestType_MY_REPAYING_LOAN,HXBRequestType_MY_REPAYING_LOAN_UI);
//            break;
//        case HXBRequestType_MY_LoanRequestType_FINISH_LOAN:
//            returnParamBlock(HXBRequestType_MY_FINISH_LOAN,HXBRequestType_MY_FINISH_LOAN_UI);
//            break;
//        case HXBRequestType_MY_LoanRequestType_BID_LOAN:
//            returnParamBlock(HXBRequestType_MY_BID_LOAN,HXBRequestType_MY_BID_LOAN_UI);
//            break;
//    }
//}
@end
