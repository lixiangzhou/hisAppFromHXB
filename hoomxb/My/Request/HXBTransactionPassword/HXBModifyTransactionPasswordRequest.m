//
//  HXBModifyTransactionPasswordRequest.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/9.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBModifyTransactionPasswordRequest.h"
#import "NYBaseRequest.h"
#import "HXBSignUPAndLoginRequest_EnumManager.h"
@implementation HXBModifyTransactionPasswordRequest

/**
修改交易密码---验证身份证

@param IDcard 身份证号码
@param successDateBlock 成功回调
@param failureBlock 失败回调
*/
- (void)myTransactionPasswordWithIDcard:(NSString *)IDcard andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{

    
    NYBaseRequest *alterLoginPasswordAPI = [[NYBaseRequest alloc] init];
    alterLoginPasswordAPI.requestUrl = kHXBSetTransaction_MobifyPassword_CheckIdentityAuthURL;
    alterLoginPasswordAPI.requestMethod = NYRequestMethodPost;
    alterLoginPasswordAPI.requestArgument = @{
                                       @"identity" : IDcard
                                      };
    NSLog(@"%@",IDcard);
    [alterLoginPasswordAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"身份证验证%@",responseObject);
        NSInteger status =  [responseObject[@"status"] integerValue];
        if (status != 0) {
            
            [HxbHUDProgress showTextWithMessage:@"身份证号码不对"];
            if (failureBlock) {
                failureBlock(nil);
            }
            return;
        }
        if (successDateBlock) {
            successDateBlock(responseObject);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        NSLog(@"%@",error);
        [HxbHUDProgress showTextWithMessage:@"身份证号码不对"];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}
/**
 修改交易密码---获取短信验证码
 
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)myTransactionPasswordWithSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{
    NYBaseRequest *alterLoginPasswordAPI = [[NYBaseRequest alloc] init];
    alterLoginPasswordAPI.requestUrl = kHXBSetTransaction_MobifyPassword_SendSmscodeURL;
    alterLoginPasswordAPI.requestMethod = NYRequestMethodPost;
    NSLog(@"%@",kTypeKey_tradpwd);
    
    alterLoginPasswordAPI.requestArgument = @{
                                              @"action" : kTypeKey_tradpwd
                                              };
    [alterLoginPasswordAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"验证码验证%@",responseObject);
        NSInteger status =  [responseObject[@"status"] integerValue];
        if (status != 0) {
            [HxbHUDProgress showTextWithMessage:@"验证码发送失败"];
            if (failureBlock) {
                failureBlock(nil);
            }
            return;
        }
        if (successDateBlock) {
            successDateBlock(responseObject);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        NSLog(@"%@",error);
         [HxbHUDProgress showTextWithMessage:@"验证码发送失败"];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

/**
 修改交易密码---同时验证身份证和验证码
 
 @param IDcard 身份证号码
 @param code 验证码
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)myTransactionPasswordWithIDcard:(NSString *)IDcard andWithCode:(NSString *)code andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{
    NYBaseRequest *alterLoginPasswordAPI = [[NYBaseRequest alloc] init];
    alterLoginPasswordAPI.requestUrl = kHXBSetTransaction_MobifyPassword_CheckIdentitySmsURL;
    alterLoginPasswordAPI.requestMethod = NYRequestMethodPost;
    alterLoginPasswordAPI.requestArgument = @{
                                              @"identity" : IDcard,
                                              @"action" : kTypeKey_tradpwd,
                                              @"smscode" : code
                                              };
    [alterLoginPasswordAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"同时验证身份证和验证码：%@",responseObject);
        NSInteger status =  [responseObject[@"status"] integerValue];
        if (status != 0) {
            [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
            if (failureBlock) {
                failureBlock(nil);
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


/**
 修改交易密码---同时验证身份证和验证码
 
 @param IDcard 身份证号码
 @param code 验证码
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)myTransactionPasswordWithIDcard:(NSString *)IDcard andWithCode:(NSString *)code  andWithPassword:(NSString *)password andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{
    NYBaseRequest *alterLoginPasswordAPI = [[NYBaseRequest alloc] init];
    alterLoginPasswordAPI.requestUrl = kHXBSetTransaction_MobifyPassword_CashpwdEditURL;
    alterLoginPasswordAPI.requestMethod = NYRequestMethodPost;
    alterLoginPasswordAPI.requestArgument = @{
                                              @"cashPassword" : password,
                                              @"identity" : IDcard
                                              };
    [alterLoginPasswordAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
        NSInteger status =  [responseObject[@"status"] integerValue];
        if (status != 0) {
            [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
            if (failureBlock) {
                failureBlock(nil);
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
