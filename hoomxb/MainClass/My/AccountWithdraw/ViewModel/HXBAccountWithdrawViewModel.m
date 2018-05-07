//
//  HXBAccountWithdrawViewModel.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/2/9.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBAccountWithdrawViewModel.h"
#import "HXBOpenDepositAccountAgent.h"
#import "HXBWithdrawModel.h"

@implementation HXBAccountWithdrawViewModel

- (void)accountWithdrawalWithAmount:(NSString *)amount resultBlock:(void (^)(BOOL))resultBlock {
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestUrl = kHXBAccount_Withdrawal;
    request.requestMethod = NYRequestMethodPost;
    request.requestArgument = @{@"amount": amount};
    
    kWeakSelf
    [self showHFBankWithContent:hfContentText];
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        [weakSelf hiddenHFBank];
        weakSelf.lazyCatReqModel = [HXBLazyCatRequestModel yy_modelWithDictionary: responseObject[@"data"]];
        if (resultBlock) {
            resultBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        [weakSelf hiddenHFBank];
        if (resultBlock) {
            resultBlock(NO);
        }
    }];
}

- (void)accountWithdrawaWithParameter:(NSMutableDictionary *)parameter
                     andRequestMethod: (NYRequestMethod)requestMethod
                          resultBlock: (void(^)(BOOL isSuccess))resultBlock {
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestUrl = kHXBSetWithdrawals_withdrawURL;
    request.requestMethod = requestMethod;
    request.requestArgument = parameter;
    request.showHud = YES;
    kWeakSelf
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        weakSelf.withdrawModel = [HXBWithdrawModel yy_modelWithJSON:responseObject[@"data"]];
        if (resultBlock) resultBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) resultBlock(NO);
    }];
}

/**
 获取充值短验
 @param amount 充值金额
 @param action 判断是否为提现或者充值
 @param type 短信验证码或是语言验证码
 @param callbackBlock 请求回调
 */
- (void)getVerifyCodeRequesWithRechargeAmount:(NSString *)amount andWithType:(NSString *)type  andWithAction:(NSString *)action andCallbackBlock: (void(^)(BOOL isSuccess,NSError *error))callbackBlock {
    kWeakSelf
    [HXBOpenDepositAccountAgent verifyCodeRequestWithResultBlock:^(NYBaseRequest *request) {
        request.requestArgument = @{
                                    @"amount" : amount,
                                    @"action":action,
                                    @"type":type
                                    };
        request.hudDelegate = weakSelf;
        request.showHud = YES;
    } resultBlock:^(id responseObject, NSError *error) {
        if (error) {
            callbackBlock(NO,error);
        }
        else {
            callbackBlock(YES,nil);
        }
    }];
}

@end
