//
//  HXBOpenDepositAccountRequest.h
//  hoomxb
//
//  Created by HXB-C on 2017/7/20.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
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
 @param action 判断是否为提现或者充值
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)accountRechargeRequestWithRechargeAmount:(NSString *)amount andWithAction:(NSString *)action andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;
- (void)accountRechargeRequestWithRechargeAmount:(NSString *)amount andWithType:(NSString *)type  andWithAction:(NSString *)action andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;//短信和语音

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
 @param isToast 是否需要提示信息
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
+ (void)checkCardBinResultRequestWithBankNumber:(NSString *)bankNumber andisToastTip:(BOOL)isToast andSuccessBlock: (void(^)(HXBCardBinModel *cardBinModel))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;


@end
