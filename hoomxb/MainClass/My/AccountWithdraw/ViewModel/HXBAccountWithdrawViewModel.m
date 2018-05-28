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
    request.delayInterval = RequestDelayInterval;
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

@end
