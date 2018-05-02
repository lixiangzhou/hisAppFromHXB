//
//  HXBMyTopUpVCViewModel.m
//  hoomxb
//
//  Created by HXB-C on 2018/2/7.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyTopUpVCViewModel.h"
#import "HXBOpenDepositAccountAgent.h"

@implementation HXBMyTopUpVCViewModel

- (void)accountQuickChargeWithAmount:(NSString *)amount resultBlock:(void (^)(BOOL))resultBlock {
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestUrl = kHXBAccount_Quickcharge;
    request.requestMethod = NYRequestMethodPost;
    request.requestArgument = @{@"amount" : amount};
    kWeakSelf
    [request loadData:^(NYBaseRequest *request, id responseObject) {        
        weakSelf.lazyCatReqModel = [HXBLazyCatRequestModel yy_modelWithDictionary: responseObject[@"data"]];
        if (resultBlock) {
            resultBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) {
            resultBlock(NO);
        }
    }];
}

- (void)accountRechargeResultRequestWithSmscode:(NSString *)smscode andWithQuickpayAmount:(NSString *)amount andCallBackBlock:(void(^)(BOOL isSuccess))callBackBlock
{
    NYBaseRequest *versionUpdateAPI = [[NYBaseRequest alloc] initWithDelegate:self];
    versionUpdateAPI.requestUrl = kHXBAccount_quickpay;
    versionUpdateAPI.requestMethod = NYRequestMethodPost;
    versionUpdateAPI.requestArgument = @{
                                         @"smscode" : smscode,
                                         @"amount" : amount
                                         };
    versionUpdateAPI.showHud = YES;
    [versionUpdateAPI loadData:^(NYBaseRequest *request, id responseObject) {
        if (callBackBlock) {
            callBackBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (callBackBlock) {
            callBackBlock(NO);
        }
    }];
    
}

/**
 获取充值短验
 @param amount 充值金额
 @param action 判断是否为提现或者充值
 @param type 短信验证码或是语言验证码
 @param callbackBlock 请求回调
 */
- (void)getVerifyCodeRequesWithRechargeAmount:(NSString *)amount andWithType:(NSString *)type  andWithAction:(NSString *)action andCallbackBlock: (void(^)(BOOL isSuccess, NSError *error))callbackBlock {
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
