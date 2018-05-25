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

- (void)accountRechargeResultRequestWithSmscode:(NSString *)smscode andWithQuickpayAmount:(NSString *)amount andCallBackBlock:(void(^)(BOOL isSuccess))callBackBlock
{
    NYBaseRequest *versionUpdateAPI = [[NYBaseRequest alloc] initWithDelegate:self];
    versionUpdateAPI.requestUrl = kHXBAccount_quickpay;
    versionUpdateAPI.requestMethod = NYRequestMethodPost;
    versionUpdateAPI.requestArgument = @{
                                         @"smscode" : smscode,
                                         @"amount" : amount
                                         };
    versionUpdateAPI.showHud = YES;
    [versionUpdateAPI loadData:^(NYBaseRequest *request, id responseObject) {
        if (callBackBlock) {
            callBackBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (callBackBlock) {
            callBackBlock(NO);
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
- (void)getVerifyCodeRequesWithRechargeAmount:(NSString *)amount andWithType:(NSString *)type  andWithAction:(NSString *)action andCallbackBlock: (void(^)(BOOL isSuccess, NSError *error))callbackBlock {
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
