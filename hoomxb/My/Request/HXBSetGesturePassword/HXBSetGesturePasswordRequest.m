//
//  HXBSetGesturePasswordRequest.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/4.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBSetGesturePasswordRequest.h"

@implementation HXBSetGesturePasswordRequest


/**
 版本更新
 
 @param password 登录密码
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)setGesturePasswordRequestWithPassword:(NSString *)password andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{
    NYBaseRequest *versionUpdateAPI = [[NYBaseRequest alloc] init];
    versionUpdateAPI.requestUrl = kHXBSetGesturePasswordRequest_CheckLoginPasswordURL;
    versionUpdateAPI.requestMethod = NYRequestMethodPost;
    versionUpdateAPI.requestArgument = @{
                                         @"password" : password
                                         };
    [versionUpdateAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
        NSInteger status =  [responseObject[@"status"] integerValue];
        if (status != 0) {
            [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
            if (failureBlock) {
                failureBlock(responseObject);
            }
            return;
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

/**
 风险评测

 @param score 测评分数
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)riskModifyScoreRequestWithScore:(NSString *)score andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{
    NYBaseRequest *versionUpdateAPI = [[NYBaseRequest alloc] init];
    versionUpdateAPI.requestUrl = kHXBUser_riskModifyScoreURL;
    versionUpdateAPI.requestMethod = NYRequestMethodPost;
    versionUpdateAPI.requestArgument = @{
                                         @"score" : score
                                         };
    [versionUpdateAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
        NSInteger status =  [responseObject[@"status"] integerValue];
        if (status != 0) {
            [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
            if (failureBlock) {
                failureBlock(responseObject);
            }
            return;
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
