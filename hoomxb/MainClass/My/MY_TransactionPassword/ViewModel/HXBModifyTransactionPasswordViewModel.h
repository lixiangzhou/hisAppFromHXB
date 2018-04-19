//
//  HXBModifyTransactionPasswordViewModel.h
//  hoomxb
//
//  Created by lxz on 2018/2/26.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBBaseViewModel+KEYCHAIN.h"

@interface HXBModifyTransactionPasswordViewModel : HXBBaseViewModel
/**
 获取修改交易密码的验证码API
 
 @param action 验证码类型
 @param resultBlock 返回结果
 */
- (void)myTraderPasswordGetverifyCodeWithAction: (NSString *)action
                                    resultBlock: (void(^)(BOOL isSuccess))resultBlock;

/**
 修改交易密码
 
 @param idCard idCard
 @param resultBlock 结果回调
 */
- (void)modifyTransactionPasswordWithIdCard:(NSString *)idCard resultBlock:(void(^)(BOOL isSuccess))resultBlock;
/**
 修改交易密码
 
 @param idCard idCard
 @param code 短信码
 @param resultBlock 结果回调
 */
- (void)modifyTransactionPasswordWithIdCard:(NSString *)idCard code:(NSString *)code resultBlock:(void(^)(BOOL isSuccess))resultBlock;

@end
