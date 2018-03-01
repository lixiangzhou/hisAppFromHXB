//
//  HXBTransactionPasswordConfirmationViewModel.h
//  hoomxb
//
//  Created by lxz on 2018/2/26.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"

@interface HXBTransactionPasswordConfirmationViewModel : HXBBaseViewModel
/**
 修改交易密码
 
 @param idCard idCard
 @param password 新交易密码
 @param resultBlock 结果回调
 */
- (void)modifyTransactionPasswordWithIdCard:(NSString *)idCard password:(NSString *)password resultBlock:(void(^)(BOOL isSuccess))resultBlock;
@end
