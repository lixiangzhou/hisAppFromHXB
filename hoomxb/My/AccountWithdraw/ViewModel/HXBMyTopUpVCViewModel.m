//
//  HXBMyTopUpVCViewModel.m
//  hoomxb
//
//  Created by HXB-C on 2018/2/7.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyTopUpVCViewModel.h"

@implementation HXBMyTopUpVCViewModel

- (void)accountRechargeResultRequestWithSmscode:(NSString *)smscode andWithQuickpayAmount:(NSString *)amount andCallBackBlock:(void(^)(BOOL isSuccess))callBackBlock
{
    NYBaseRequest *versionUpdateAPI = [[NYBaseRequest alloc] init];
    versionUpdateAPI.requestUrl = kHXBAccount_quickpay;
    versionUpdateAPI.requestMethod = NYRequestMethodPost;
    versionUpdateAPI.requestArgument = @{
                                         @"smscode" : smscode,
                                         @"amount" : amount
                                         };
    
    [versionUpdateAPI startWithHUDStr:kLoadIngText Success:^(NYBaseRequest *request, id responseObject) {
        NSInteger status =  [responseObject[@"status"] integerValue];
        if (status != 0) {
            if (callBackBlock) {
                callBackBlock(NO);
            }
        }
        else {
            if (callBackBlock) {
                callBackBlock(YES);
            }
        }
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        [HxbHUDProgress showTextWithMessage:@"请求失败"];
        if (callBackBlock) {
            callBackBlock(NO);
        }
    }];
    
}

@end
