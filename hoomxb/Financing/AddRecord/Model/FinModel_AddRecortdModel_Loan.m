//
//  FinModel_AddRecortdModel_Loan.m
//  hoomxb
//
//  Created by HXB on 2017/5/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "FinModel_AddRecortdModel_Loan.h"

@implementation FinModel_AddRecortdModel_Loan
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"loanLenderRecord_list":[HXBFinModel_AddRecortdModel_loanLenderRecord_list_Loan class],
             };
}
@end


@implementation HXBFinModel_AddRecortdModel_loanLenderRecord_list_Loan

///	int	投资人名称
//- (void)setUsername:(NSString *)username {
//    _username = username;
//    _username = [NSString hiddenStr:username MidWithFistLenth:3 andLastLenth:4];
//}
///	int	投资金额
- (void) setAmount:(NSString *)amount {
    _amount = amount;
    _amount = [NSString hxb_getPerMilWithDouble:amount.floatValue];
}
///	int	投资时间
- (void)setLendTime:(NSString *)lendTime {
    
    _lendTime = [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:lendTime andDateFormat:@"yyyy-MM-dd HH:mm"];
}
///": -2,
-(void)setIndex:(NSString *)index {
    _index = index;
}
///": "NORMAL_BID",
-(void)setLoanLenderType:(NSString *)loanLenderType {
    _loanLenderType = loanLenderType;
}
///": "ALL"
- (void)setType:(NSString *)type {
    _type = type;
}
@end
