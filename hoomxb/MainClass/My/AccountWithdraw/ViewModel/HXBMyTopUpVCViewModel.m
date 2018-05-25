//
//  HXBMyTopUpVCViewModel.m
//  hoomxb
//
//  Created by HXB-C on 2018/2/7.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyTopUpVCViewModel.h"
#import "HXBOpenDepositAccountAgent.h"
#import "HXBBaseRequestManager.h"

@interface HXBMyTopUpVCViewModel()
@end

@implementation HXBMyTopUpVCViewModel

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

- (void)accountQuickChargeWithAmount:(NSString *)amount resultBlock:(void (^)(BOOL))resultBlock {
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestUrl = kHXBAccount_Quickcharge;
    request.requestMethod = NYRequestMethodPost;
    request.requestArgument = @{@"amount" : amount};
    request.delayInterval = RequestDelayInterval;
    kWeakSelf
    [self showHFBankWithContent:hfContentText];
    [request loadData:^(NYBaseRequest *request, id responseObject) {
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

- (void)requestBankData:(void(^)(BOOL isSuccess))resultBlock {
    NYBaseRequest *bankCardAPI = [[NYBaseRequest alloc] initWithDelegate:self];
    bankCardAPI.requestUrl = kHXBUserInfo_BankCard;
    bankCardAPI.requestMethod = NYRequestMethodGet;
    bankCardAPI.showHud = YES;
    kWeakSelf
    [bankCardAPI loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        weakSelf.bankCardModel = [HXBBankCardModel yy_modelWithJSON:responseObject[@"data"]];
        if (resultBlock) {
            resultBlock(YES);
        }
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        
        NSDictionary *responseObject = request.responseObject;
        
        if (responseObject) {
            [weakSelf showToast:@"银行卡请求失败"];
        }
        if (resultBlock) {
            resultBlock(NO);
        }
    }];
    
}

@end
