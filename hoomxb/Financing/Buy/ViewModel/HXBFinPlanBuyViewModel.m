//
//  HXBFinPlanBuyViewModel.m
//  hoomxb
//
//  Created by lxz on 2018/2/26.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinPlanBuyViewModel.h"

@implementation HXBFinPlanBuyViewModel

- (void)downLoadUserInfoWithResultBlock:(void(^)(HXBRequestUserInfoViewModel *viewModel))resultBlock {
    [KeyChain downLoadUserInfoWithResultBlock:^(NYBaseRequest *request) {
        request.hudDelegate = self;
        request.showHud = YES;
    } resultBlock:^(HXBRequestUserInfoViewModel *viewModel, NSError *error) {
        if (resultBlock) {
            resultBlock(viewModel);
        }
    }];
}

@end
