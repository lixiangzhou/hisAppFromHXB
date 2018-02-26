//
//  HXBTransactionPasswordConfirmationViewModel.m
//  hoomxb
//
//  Created by lxz on 2018/2/26.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBTransactionPasswordConfirmationViewModel.h"
#import "HXBModifyTransactionPasswordAgent.h"

@implementation HXBTransactionPasswordConfirmationViewModel

- (void)modifyTransactionPasswordWithIdCard:(NSString *)idCard password:(NSString *)password resultBlock:(void(^)(BOOL isSuccess))resultBlock {
    kWeakSelf
    [[HXBModifyTransactionPasswordAgent new] modifyTransactionPasswordWithRequestBlock:^(NYBaseRequest *request) {
        request.requestUrl = kHXBSetTransaction_MobifyPassword_CashpwdEditURL;
        request.requestArgument = @{ @"cashPassword" : password,
                                    @"identity" : idCard };
        request.hudDelegate = weakSelf;
    } resultBlock:^(BOOL isSuccess, NSError *error) {
        if (isSuccess) {
            [weakSelf showToast:@"修改成功"];
        }
        resultBlock(isSuccess);
    }];
}

@end
