//
//  HXBMyTopUpVCViewModel.m
//  hoomxb
//
//  Created by HXB-C on 2018/2/7.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyTopUpVCViewModel.h"
#import "HXBOpenDepositAccountAgent.h"
#import "HXBBankCardViewModel.h"
#import "HXBBaseRequestManager.h"

@interface HXBMyTopUpVCViewModel()
@property (nonatomic, strong) HXBBankCardViewModel *bankCardViewModel;
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
    if (![[HXBBaseRequestManager sharedInstance] isSendingRequest:self] && ![[HXBBaseRequestManager sharedInstance] isSendingRequest:self.bankCardViewModel]) {
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
    kWeakSelf
    [self.bankCardViewModel requestBankDataResultBlock:^(BOOL isSuccess) {
        weakSelf.bankCardModel = weakSelf.bankCardViewModel.bankCardModel;
        if (resultBlock) {        
            resultBlock(isSuccess);
        }
    }];
}

- (HXBBankCardViewModel *)bankCardViewModel {
    if (_bankCardViewModel == nil) {
        _bankCardViewModel = [[HXBBankCardViewModel alloc] initWithBlock:self.hugViewBlock];
    }
    return _bankCardViewModel;
}

@end
