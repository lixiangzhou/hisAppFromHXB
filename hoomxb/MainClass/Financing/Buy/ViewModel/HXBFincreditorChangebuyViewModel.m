//
//  HXBFincreditorChangebuyViewModel.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/3/8.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBFincreditorChangebuyViewModel.h"
#import "HXBOpenDepositAccountAgent.h"
#import "HXBBaseRequestManager.h"

@implementation HXBFincreditorChangebuyViewModel

- (instancetype)init {
    self = [super init];
    if(self) {
        self.isFilterHugHidden = NO;
    }
    
    return self;
}

/// 添加load框，知道所有请求结束再消失
- (void)hideProgress:(NYBaseRequest *)request {
    if (![[HXBBaseRequestManager sharedInstance] isSendingRequest:self]) {
        [super hideProgress:request];
    }
}

- (BOOL)erroStateCodeDeal:(NYBaseRequest *)request {
    if ([request.requestUrl containsString:@"purchase"]) {
        return NO;
    } else {
        return [super erroStateCodeDeal:request];
    }
}

- (instancetype)initWithBlock:(HugViewBlock)hugViewBlock {
    if (self = [super initWithBlock:hugViewBlock]) {
        _resultModel = [[HXBLazyCatRequestModel alloc] init];
    }
    return self;
}

/**
 债权充值结果
 
 @param parameter 购买参数
 @param resultBlock 返回结果
 */
- (void)rechargeWithParameter : (NSDictionary *)parameter
                  resultBlock : (void(^)(BOOL isSuccess))resultBlock {
    kWeakSelf
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestMethod = NYRequestMethodPost;
    request.requestUrl = @"/account/quickrecharge";
    request.requestArgument = parameter;
    request.delayInterval = RequestDelayInterval;
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

/**
 债权购买结果
 
 @param parameter 购买参数
 @param resultBlock 返回结果
 */
- (void)loanTransformBuyReslutWithParameter : (NSDictionary *)parameter
                                resultBlock : (void(^)(BOOL isSuccess))resultBlock {
    kWeakSelf
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestMethod = NYRequestMethodPost;
    request.requestUrl = kHXBFin_Transfer_ConfirmBuyReslut;
    request.requestArgument = parameter;
    request.delayInterval = RequestDelayInterval;
    [self showHFBankWithContent:hfContentText];
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        [weakSelf hiddenHFBank];
        NSDictionary *data = responseObject[kResponseData];
        [weakSelf.resultModel yy_modelSetWithDictionary:data];
        if (resultBlock) resultBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        [weakSelf hiddenHFBank];
        if (request.responseObject) {
            NSInteger status = [request.responseObject[kResponseStatus] integerValue];
            weakSelf.errorMessage = request.responseObject[kResponseMessage];
            NSString *errorType = request.responseObject[kResponseErrorData][@"errorType"];
            if (status) {
                if ([errorType isEqualToString:@"TOAST"]) {
                    [HxbHUDProgress showTextWithMessage:request.responseObject[@"message"]];
                    status = kBuy_Toast;
                } else if ([errorType isEqualToString:@"RESULT"]) {
                    status = kBuy_Result;
                } else if ([errorType isEqualToString:@"PROCESSING"]) {
                    status = kBuy_Processing;
                }
                weakSelf.errorCode = status;
            }
        }
        if (resultBlock) resultBlock(NO);
    }];
}

@end
