//
//  HXBFinLoanBuyViewModel.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/3/8.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinLoanBuyViewModel.h"
#import "HXBOpenDepositAccountAgent.h"

@implementation HXBFinLoanBuyViewModel

- (instancetype)initWithBlock:(HugViewBlock)hugViewBlock {
    if (self = [super initWithBlock:hugViewBlock]) {
        _resultModel = [[HXBLazyCatRequestModel alloc] init];
    }
    return self;
}

- (BOOL)erroStateCodeDeal:(NYBaseRequest *)request {
    if ([request.requestUrl containsString:@"result"]) {
        return NO;
    } else {
        return [super erroStateCodeDeal:request];
    }
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

    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        NSDictionary *data = responseObject[kResponseData];
        [weakSelf.resultModel yy_modelSetWithDictionary:data];
        if (resultBlock) resultBlock(YES);
        
    } failure:^(NYBaseRequest *request, NSError *error) {
//        if (request.responseObject) {
//            NSInteger status = [request.responseObject[kResponseStatus] integerValue];
//            weakSelf.errorMessage = request.responseObject[kResponseMessage];
//            NSString *errorType = request.responseObject[kResponseErrorData][@"errorType"];
//            if (status) {
//                if ([errorType isEqualToString:@"TOAST"]) {
//                    [HxbHUDProgress showTextWithMessage:request.responseObject[@"message"]];
//                    status = kBuy_Toast;
//                } else if ([errorType isEqualToString:@"RESULT"]) {
//                    status = kBuy_Result;
//                } else if ([errorType isEqualToString:@"PROCESSING"]) {
//                    status = kBuy_Processing;
//                }
//                weakSelf.errorCode = status;
//            }
//        }
        if (resultBlock) resultBlock(NO);
    }];
}

@end
