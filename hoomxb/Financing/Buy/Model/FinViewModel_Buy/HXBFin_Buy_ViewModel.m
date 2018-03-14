//
//  HXBFin_Buy_ViewModel.m
//  hoomxb
//
//  Created by 肖扬 on 2017/9/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_Buy_ViewModel.h"
#import "HXBOpenDepositAccountAgent.h"

@implementation HXBFin_Buy_ViewModel

- (void)requestForBankCardResultBlock: (void(^)(BOOL isSuccess))resultBlock {
    NYBaseRequest *bankCardAPI = [[NYBaseRequest alloc] initWithDelegate:self];
    bankCardAPI.requestUrl = kHXBUserInfo_BankCard;
    bankCardAPI.requestMethod = NYRequestMethodGet;
    kWeakSelf
    [bankCardAPI loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        weakSelf.bankCardModel = [HXBBankCardModel yy_modelWithJSON:responseObject[@"data"]];
        if (resultBlock) {
            resultBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        [weakSelf showToast:@"银行卡请求失败"];
        if (resultBlock) {
            resultBlock(NO);
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
