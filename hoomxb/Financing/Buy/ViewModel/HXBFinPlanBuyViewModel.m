//
//  HXBFinPlanBuyViewModel.m
//  hoomxb
//
//  Created by lxz on 2018/2/26.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinPlanBuyViewModel.h"
#import "HXBOpenDepositAccountAgent.h"

@implementation HXBFinPlanBuyViewModel

- (instancetype)initWithBlock:(HugViewBlock)hugViewBlock {
    if (self = [super initWithBlock:hugViewBlock]) {
        _bestCouponModel = [[HXBBestCouponModel alloc] init];
        _bankCardModel = [[HXBBankCardModel alloc] init];
    }
    return self;
}

/**
 最优优惠券
 
 @param params 请求参数
 @param resultBlock 返回数据
 */
- (void)bestCouponListWithParams: (NSDictionary *)params
                     resultBlock: (void(^)(BOOL isSuccess))resultBlock {
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestMethod = NYRequestMethodPost;
    request.requestUrl = kHXB_Coupon_Best;
    request.requestArgument = params;
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        NSDictionary *data = responseObject[kResponseData];
        [_bestCouponModel yy_modelSetWithDictionary:data];
        if (resultBlock) resultBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) resultBlock(NO);
    }];
}

/**
 获取银行卡信息
 
 @param resultBlock 返回数据
 */
- (void)bankCardInfoWithResultBlock:(void(^)(BOOL isSuccess))resultBlock {
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestMethod = NYRequestMethodGet;
    request.requestUrl = kHXBUserInfo_BankCard;
    request.showHud = YES;
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        NSDictionary *data = responseObject[kResponseData];
        [_bankCardModel yy_modelSetWithDictionary:data];
        if (resultBlock) resultBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) resultBlock(NO);
    }];
}

/**
 获取充值短验(聪聪改)
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
