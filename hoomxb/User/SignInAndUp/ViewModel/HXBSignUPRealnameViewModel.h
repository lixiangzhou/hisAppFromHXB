//
//  HXBSignUPRealnameViewModel.h
//  hoomxb
//
//  Created by lxz on 2018/2/26.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"

@interface HXBSignUPRealnameViewModel : HXBBaseViewModel

/**
 修改交易密码

 @param idCard idCard
 @param resultBlock 结果回调
 */
- (void)modifyTransactionPasswordWithIdCard:(NSString *)idCard resultBlock:(void(^)(BOOL isSuccess))resultBlock;
@end
