//
//  HXBCheckCaptchaViewModel.h
//  hoomxb
//
//  Created by lxz on 2018/3/7.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"

@interface HXBCheckCaptchaViewModel : HXBBaseViewModel

@property (nonatomic, strong) UIImage *captchaImage;

/// 图验 请求 登录失败三次 才会调用此方法
- (void)captchaRequestWithResultBlock:(void(^)(BOOL isSuccess))resultBlock;

@end
