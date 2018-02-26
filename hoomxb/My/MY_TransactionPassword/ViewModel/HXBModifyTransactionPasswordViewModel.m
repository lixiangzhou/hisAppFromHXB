//
//  HXBModifyTransactionPasswordViewModel.m
//  hoomxb
//
//  Created by lxz on 2018/2/26.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBModifyTransactionPasswordViewModel.h"
#import "HXBModifyTransactionPasswordAgent.h"
#import "HXBSignUPRealnameViewModel.h"
#import "HXBSignUPAndLoginRequest_EnumManager.h"

@implementation HXBModifyTransactionPasswordViewModel

- (void)myTraderPasswordGetverifyCodeWithAction:(NSString *)action
                                    resultBlock: (void(^)(BOOL isSuccess))resultBlock {
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestUrl = kHXBUser_smscodeURL;
    request.requestMethod = NYRequestMethodPost;
    request.requestArgument = @{@"action" : action};
    
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        if (resultBlock) resultBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) resultBlock(NO);
    }];
}

- (void)modifyTransactionPasswordWithIdCard:(NSString *)idCard resultBlock:(void(^)(BOOL isSuccess))resultBlock {
    [[HXBSignUPRealnameViewModel new] modifyTransactionPasswordWithIdCard:idCard resultBlock:resultBlock];
}

- (void)modifyTransactionPasswordWithIdCard:(NSString *)idCard code:(NSString *)code resultBlock:(void(^)(BOOL isSuccess))resultBlock {
    kWeakSelf
    [[HXBModifyTransactionPasswordAgent new] modifyTransactionPasswordWithRequestBlock:^(NYBaseRequest *request) {
        request.requestUrl = kHXBSetTransaction_MobifyPassword_CashpwdEditURL;
        request.requestArgument =  @{ @"identity" : idCard,
                                     @"action" : kTypeKey_tradpwd,
                                     @"smscode" : code };
        request.hudDelegate = weakSelf;
        request.showHud = YES;
    } resultBlock:^(BOOL isSuccess, NSError *error) {
        resultBlock(isSuccess);
    }];
}

@end
