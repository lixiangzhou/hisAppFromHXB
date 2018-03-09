//
//  HXBBaseViewModel+HXBBankCardInfo.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/3/7.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel+HXBBankCardInfo.h"
#import "HXBModifyTransactionPasswordAgent.h"

static const char HXBRequestBankCardViewModelKey = '\0';

@implementation HXBBaseViewModel (HXBBankCardInfo)

- (void)setBankCardModel:(HXBBankCardModel *)bankCardModel {
    [self willChangeValueForKey:@"bankCardModel"];
    objc_setAssociatedObject(self, &HXBRequestBankCardViewModelKey, bankCardModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"bankCardModel"];
}

- (HXBBankCardModel *)bankCardModel {
    return objc_getAssociatedObject(self, &HXBRequestBankCardViewModelKey);
}

- (void)getBankCardWithHud:(BOOL)isShowHud resultBlock:(void (^)(BOOL))resultBlock {
    kWeakSelf
    [HXBModifyTransactionPasswordAgent bankCardInfoWithRequestBlock:^(NYBaseRequest *request) {
        request.showHud = isShowHud;
        request.hudDelegate = weakSelf;
    } ResultBlock:^(HXBBankCardModel *viewModel, NSError *error) {
        BOOL result = NO;
        if (viewModel) {
            result = YES;
            weakSelf.bankCardModel = viewModel;
        }
        if (resultBlock) {
            resultBlock(result);
        }
    }];
}

@end
