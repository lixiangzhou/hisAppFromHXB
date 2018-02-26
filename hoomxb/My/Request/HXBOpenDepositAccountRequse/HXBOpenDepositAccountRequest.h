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
 快捷充值

 @param amount 充值金额
 @param action 判断是否为提现或者充值
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)accountRechargeRequestWithRechargeAmount:(NSString *)amount andWithAction:(NSString *)action andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;
- (void)accountRechargeRequestWithRechargeAmount:(NSString *)amount andWithType:(NSString *)type  andWithAction:(NSString *)action andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;//短信和语音




@end
