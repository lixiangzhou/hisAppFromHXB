//
//  HXBBannerViewModel.m
//  hoomxb
//
//  Created by caihongji on 2018/2/5.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBannerViewModel.h"
#import "HXBRequestUserInfoViewModel.h"

@implementation HXBBannerViewModel

#pragma mark  加载用户信息

- (void)loadUserInfoWithBlock:(void(^)(BOOL isSuccess))resultBlock {
    [KeyChain downLoadUserInfoWithRequestBlock:^(NYBaseRequest *request) {
        request.showHud = NO;
        request.hudDelegate = self;
    } resultBlock:^(HXBRequestUserInfoViewModel *viewModel, NSError *error) {
        if(error) {
            if(resultBlock) {
                resultBlock(NO);
            }
        }
        else {
            if(resultBlock) {
                resultBlock(YES);
            }
        }
        
    }];
}

@end
