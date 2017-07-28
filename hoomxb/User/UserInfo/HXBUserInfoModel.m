//
//  HXBUserInfoModel.m
//  hoomxb
//
//  Created by HXB on 2017/6/1.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBUserInfoModel.h"

@implementation HXBUserInfoModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"userAssets" : [HXBRequestUserInfoAPI_UserAssets class],
             @"userInfo" : [HXBRequestUserInfoAPI_UserInfo class]
             };
}
@end

@implementation HXBRequestUserInfoAPI_UserAssets

- (void)setEarnTotal:(NSString *)earnTotal
{
    _earnTotal = earnTotal;
    if ([_earnTotal doubleValue]<0) {
        _earnTotal = @"0.00";
    }
}

- (void)setLenderEarned:(NSString *)lenderEarned
{
    _lenderEarned = lenderEarned;
    if ([_lenderEarned doubleValue]<0) {
        _lenderEarned = @"0.00";
    }
}

- (void)setFinancePlanAssets:(NSString *)financePlanAssets
{
    _financePlanAssets = financePlanAssets;
    if ([_financePlanAssets doubleValue]<0) {
        _financePlanAssets = @"0.00";
    }
}

- (void)setFinancePlanSumPlanInterest:(NSString *)financePlanSumPlanInterest
{
    _financePlanSumPlanInterest = financePlanSumPlanInterest;
    if ([_financePlanSumPlanInterest doubleValue]<0) {
        _financePlanSumPlanInterest = @"0.00";
    }
}

@end
@implementation HXBRequestUserInfoAPI_UserInfo
@end
