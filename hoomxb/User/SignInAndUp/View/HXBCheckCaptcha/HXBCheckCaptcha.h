//
//  HXBCheckCaptcha.h
//  hoomxb
//
//  Created by HXB on 2017/6/2.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
///图形验证码的view
@interface HXBCheckCaptcha : UIView
@property (nonatomic, strong) UIImage *checkCaptchaImage;
///验证码是否正确
@property (nonatomic, assign) BOOL isCorrect;
///点击了确认按钮
- (void)clickTrueButtonFunc:(void (^)(NSString *checkCaptChaStr))clickTrueButtonBlock;
///点击了图形验证码
- (void)clickCheckCaptchaImageViewFunc: (void(^)())clickCheckCaptchaImageViewBlock;
@end
