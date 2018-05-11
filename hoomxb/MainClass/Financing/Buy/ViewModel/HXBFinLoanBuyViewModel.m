//
//  HXBFinLoanBuyViewModel.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/3/8.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinLoanBuyViewModel.h"
#import "HXBOpenDepositAccountAgent.h"
#import "HXBBaseRequestManager.h"

@implementation HXBFinLoanBuyViewModel

///// 添加load框，知道所有请求结束再消失
- (void)hideProgress:(NYBaseRequest *)request {
    if (![[HXBBaseRequestManager sharedInstance] isSendingRequest:self]) {
        [super hideProgress:request];
    }
}

- (instancetype)initWithBlock:(HugViewBlock)hugViewBlock {
    if (self = [super initWithBlock:hugViewBlock]) {
        _resultModel = [[HXBLazyCatRequestModel alloc] init];
    }
    return self;
}

/**
 散标购买
 
 @param parameter 请求参数
 @param resultBlock 返回数据
 */
- (void)loanBuyReslutWithParameter: (NSDictionary *)parameter
                       resultBlock: (void(^)(BOOL isSuccess))resultBlock {
    kWeakSelf
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestMethod = NYRequestMethodPost;
    request.requestUrl = kHXBFin_Loan_ConfirmBuyReslut;
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

@end
