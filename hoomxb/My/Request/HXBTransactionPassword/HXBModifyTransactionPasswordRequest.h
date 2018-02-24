//
//  HXBModifyTransactionPasswordRequest.h
//  hoomxb
//
//  Created by HXB-C on 2017/6/9.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBModifyTransactionPasswordRequest : NSObject

/**
 修改交易密码---验证身份证

 @param IDcard 身份证号码
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)myTransactionPasswordWithIDcard:(NSString *)IDcard andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;

/**
 修改交易密码---同时验证身份证和验证码

 @param IDcard 身份证号码
 @param code 验证码
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)myTransactionPasswordWithIDcard:(NSString *)IDcard andWithCode:(NSString *)code andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;

/**
 修改交易密码---同时验证身份证和验证码
 
 @param IDcard 身份证号码
 @param code 验证码
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)myTransactionPasswordWithIDcard:(NSString *)IDcard andWithCode:(NSString *)code  andWithPassword:(NSString *)password andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;

@end
