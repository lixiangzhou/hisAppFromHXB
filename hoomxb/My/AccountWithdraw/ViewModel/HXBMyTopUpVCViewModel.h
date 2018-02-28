//
//  HXBMyTopUpVCViewModel.h
//  hoomxb
//
//  Created by HXB-C on 2018/2/7.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBBaseViewModel+KEYCHAIN.h"

@interface HXBMyTopUpVCViewModel : HXBBaseViewModel

/**
 快捷充值确认
 
 @param smscode 短信验证码
 @param amount 充值金额
 @param callBackBlock 成功回调
 */
- (void)accountRechargeResultRequestWithSmscode:(NSString *)smscode andWithQuickpayAmount:(NSString *)amount andCallBackBlock:(void(^)(BOOL isSuccess))callBackBlock;

/**
 获取充值短验
 @param amount 充值金额
 @param action 判断是否为提现或者充值
 @param type 短信验证码或是语言验证码
 @param callbackBlock 请求回调
 */
- (void)getVerifyCodeRequesWithRechargeAmount:(NSString *)amount andWithType:(NSString *)type  andWithAction:(NSString *)action andCallbackBlock: (void(^)(BOOL isSuccess,NSError *error))callbackBlock;
@end
