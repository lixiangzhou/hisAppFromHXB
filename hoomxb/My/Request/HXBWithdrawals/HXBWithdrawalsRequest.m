//
//  HXBWithdrawalsRequest.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBWithdrawalsRequest.h"

@implementation HXBWithdrawalsRequest

/**
 提现

 @param requestArgument 提现传入的请求参数字典
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)withdrawalsRequestWithRequestArgument:(NSMutableDictionary *)requestArgument andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{
    NYBaseRequest *alterLoginPasswordAPI = [[NYBaseRequest alloc] init];
    alterLoginPasswordAPI.requestUrl = kHXBSetWithdrawals_withdrawURL;
    alterLoginPasswordAPI.requestMethod = NYRequestMethodPost;
    alterLoginPasswordAPI.requestArgument = requestArgument;
    [alterLoginPasswordAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
        NSInteger status =  [responseObject[@"status"] integerValue];
        [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
        if (status != 0) {
            if (failureBlock) {
                failureBlock(responseObject);
            }
            return;
        }
        if (successDateBlock) {
            successDateBlock(responseObject);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        [HxbHUDProgress showTextWithMessage:@"请求失败"];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

- (void)bankCardListRequestWithRequestArgument:(NSMutableDictionary *)requestArgument andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{
    NYBaseRequest *alterLoginPasswordAPI = [[NYBaseRequest alloc] init];
    alterLoginPasswordAPI.requestUrl = kHXBSetWithdrawals_withdrawURL;
    alterLoginPasswordAPI.requestMethod = NYRequestMethodPost;
    alterLoginPasswordAPI.requestArgument = requestArgument;
    [alterLoginPasswordAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
        NSInteger status =  [responseObject[@"status"] integerValue];
        [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
        if (status != 0) {
            if (failureBlock) {
                failureBlock(responseObject);
            }
            return;
        }
        if (successDateBlock) {
            successDateBlock(responseObject);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        [HxbHUDProgress showTextWithMessage:@"请求失败"];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}


@end
