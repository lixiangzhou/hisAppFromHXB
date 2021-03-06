//
//  HXBBaseViewModel+HXB.m
//  hoomxb
//
//  Created by caihongji on 2018/2/26.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel+KEYCHAIN.h"

@implementation HXBBaseViewModel(KEYCHAIN)

static const char HXBRequestUserInfoViewModelKey = '\0';

- (void)setUserInfoModel:(HXBRequestUserInfoViewModel *)userInfoModel {
    [self willChangeValueForKey:@"userInfoModel"]; // KVO
    objc_setAssociatedObject(self, &HXBRequestUserInfoViewModelKey,
                             userInfoModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"userInfoModel"]; // KVO
}

- (HXBRequestUserInfoViewModel *)userInfoModel {
    return objc_getAssociatedObject(self, &HXBRequestUserInfoViewModelKey);
}

#pragma mark 通过keychain加载用户信息
- (void)downLoadUserInfo:(BOOL)isShowHud resultBlock:(void(^)(BOOL isSuccess))resultBlock {
    kWeakSelf
    [KeyChain downLoadUserInfoWithRequestBlock:^(NYBaseRequest *request) {
        request.showHud = isShowHud;
        request.hudDelegate = weakSelf;
    } resultBlock:^(HXBRequestUserInfoViewModel *viewModel, NSError *error) {
        BOOL result = NO;
        if(viewModel) {
            result = YES;
            weakSelf.userInfoModel = viewModel;
        }
        
        if(resultBlock) {
            resultBlock(result);
        }
    }];
}
@end
