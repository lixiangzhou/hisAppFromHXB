//
//  HXBSignInViewModel.h
//  hoomxb
//
//  Created by lxz on 2018/3/7.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"

@interface HXBSignInViewModel : HXBBaseViewModel

/**
 登录请求
 @param resultBlock 是否成功，是否需要弹图验
 */
- (void)loginRequetWithMobile: (NSString *)mobile password: (NSString *)password captcha: (NSString *)captcha resultBlock:(void(^)(BOOL isSuccess, BOOL needPopCaptcha))resultBlock;

- (void)checkExistMobile:(NSString *)mobile resultBlock:(void(^)(BOOL isSuccess))resultBlock;
@end
