//
//  HXBWithdrawalsRequest.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBWithdrawalsRequest.h"

@implementation HXBWithdrawalsRequest

/**
 获取到账时间

 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)paymentDateRequestWithSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{
    NYBaseRequest *paymentDateAPI = [[NYBaseRequest alloc] init];
    paymentDateAPI.requestUrl = kHXBSetWithdrawals_withdrawArriveTimeURL;
    paymentDateAPI.requestMethod = NYRequestMethodPost;
    //    alterLoginPasswordAPI.requestArgument = requestArgument;
    [paymentDateAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
        NSInteger status =  [responseObject[@"status"] integerValue];
        if (status != 0) {
            kHXBResponsShowHUD
        }
        if (successDateBlock) {
            successDateBlock(responseObject);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
//        [HxbHUDProgress showTextWithMessage:@"请求失败"];
        if (failureBlock) {
            failureBlock(error);
        }
    }];

}

@end
