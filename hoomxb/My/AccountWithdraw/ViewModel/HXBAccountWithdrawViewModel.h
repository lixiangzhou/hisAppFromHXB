//
//  HXBAccountWithdrawViewModel.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/2/9.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"

@interface HXBAccountWithdrawViewModel : HXBBaseViewModel

/**
 账户提现

 @param parameter 请求参数
 @param resultBlock 返回结果
 */
- (void)accountWithdrawaWithParameter: (NSMutableDictionary *)parameter
                          resultBlock: (void(^)(BOOL isSuccess))resultBlock;

/**
 获取充值短验
 @param amount 充值金额
 @param action 判断是否为提现或者充值
 @param type 短信验证码或是语言验证码
 @param callbackBlock 请求回调
 */
- (void)getVerifyCodeRequesWithRechargeAmount:(NSString *)amount andWithType:(NSString *)type  andWithAction:(NSString *)action andCallbackBlock: (void(^)(BOOL isSuccess,NSError *error))callbackBlock;

@end
