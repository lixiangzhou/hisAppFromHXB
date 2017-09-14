//
//  HXBOpenDepositAccountRequest.h
//  hoomxb
//
//  Created by HXB-C on 2017/7/20.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXBCardBinModel;
@interface HXBOpenDepositAccountRequest : NSObject

/**
 开通存管账户

 @param requestArgument 存款账户的字典数据
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)openDepositAccountRequestWithArgument:(NSDictionary *)requestArgument andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;

/**
 单独绑卡

 @param requestArgument 绑卡的字典数据
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)bindBankCardRequestWithArgument:(NSDictionary *)requestArgument andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;

/**
 快捷充值

 @param amount 充值金额
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)accountRechargeRequestWithRechargeAmount:(NSString *)amount andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;


/**
 快捷充值确认

 @param smscode 短信验证码
 @param amount 充值金额
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)accountRechargeResultRequestWithSmscode:(NSString *)smscode andWithQuickpayAmount:(NSString *)amount andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;

/**
 卡bin校验
 
 @param bankNumber 银行卡号
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
+ (void)checkCardBinResultRequestWithSmscode:(NSString *)bankNumber andSuccessBlock: (void(^)(HXBCardBinModel *cardBinModel))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;


@end
