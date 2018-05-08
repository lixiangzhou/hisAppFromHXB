//
//  HXBFinPlanBuyViewModel.m
//  hoomxb
//
//  Created by lxz on 2018/2/26.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinPlanBuyViewModel.h"
#import "HXBOpenDepositAccountAgent.h"
#import "HXBBaseRequestManager.h"

@implementation HXBFinPlanBuyViewModel

/// 添加load框，知道所有请求结束再消失
- (void)hideProgress:(NYBaseRequest *)request {
    if (![[HXBBaseRequestManager sharedInstance] isSendingRequest:self]) {
        [super hideProgress:request];
    }
}

- (instancetype)initWithBlock:(HugViewBlock)hugViewBlock {
    if (self = [super initWithBlock:hugViewBlock]) {
        _bestCouponModel = [[HXBBestCouponModel alloc] init];
        _resultModel = [[HXBLazyCatRequestModel alloc] init];
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
    kWeakSelf
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestMethod = NYRequestMethodPost;
    request.requestUrl = kHXB_Coupon_Best;
    request.requestArgument = params;
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        NSDictionary *data = responseObject[kResponseData];
        [weakSelf.bestCouponModel yy_modelSetWithDictionary:data];
        if (resultBlock) resultBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) resultBlock(NO);
    }];
}

/**
 计划购买
 
 @param parameter 请求参数
 @param resultBlock 返回数据
 */
- (void)planBuyReslutWithParameter: (NSDictionary *)parameter
                       resultBlock: (void(^)(BOOL isSuccess))resultBlock {
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestMethod = NYRequestMethodPost;
    request.requestUrl = kHXBFin_Plan_ConfirmBuyReslut;
    request.requestArgument = parameter;
    request.delayInterval = RequestDelayInterval;
    kWeakSelf
    [self showHFBankWithContent:hfContentText];
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        [weakSelf hiddenHFBank];
        NSDictionary *data = responseObject[kResponseData];
        [weakSelf.resultModel yy_modelSetWithDictionary:data];
        if (resultBlock) resultBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        [weakSelf hiddenHFBank];
        if (resultBlock) resultBlock(NO);
    }];
}


@end
