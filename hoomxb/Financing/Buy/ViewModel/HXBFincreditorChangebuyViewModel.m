//
//  HXBFincreditorChangebuyViewModel.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/3/8.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBFincreditorChangebuyViewModel.h"
#import "HXBOpenDepositAccountAgent.h"

@implementation HXBFincreditorChangebuyViewModel

- (instancetype)initWithBlock:(HugViewBlock)hugViewBlock {
    if (self = [super initWithBlock:hugViewBlock]) {
        _resultModel = [[HXBFin_LoanTruansfer_BuyResoutViewModel alloc] init];
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
 债权购买结果
 
 @param loanID 债权id
 @param parameter 购买参数
 @param resultBlock 返回结果
 */
- (void)loanTransformBuyReslutWithLoanID: (NSString *)loanID
                              parameter : (NSDictionary *)parameter
                             resultBlock: (void(^)(BOOL isSuccess))resultBlock {
    kWeakSelf
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestMethod = NYRequestMethodPost;
    request.requestUrl = kHXBFin_BuyReslut_LoanTruansferURL(loanID);
    request.requestArgument = parameter;
    request.showHud = YES;
    request.hudShowContent = @"安全支付";
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        NSDictionary *data = responseObject[kResponseData];
        [weakSelf.resultModel yy_modelSetWithDictionary:data];
        if (resultBlock) resultBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
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
