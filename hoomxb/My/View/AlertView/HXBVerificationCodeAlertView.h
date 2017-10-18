//
//  HXBVerificationCodeAlertView.h
//  hoomxb
//
//  Created by HXB-C on 2017/7/14.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBVerificationCodeAlertView : UIView

/**
 验证码
 */
@property (nonatomic, copy) NSString *verificationCode;
//线的颜色
@property(nonatomic,copy) UIColor *lineColor;
/** 是否清楚输入框 */
@property (nonatomic, assign)  BOOL isCleanSmsCode;

/**
 getVerificationCode再次获取验证码
 */
@property (nonatomic, copy) void (^getVerificationCodeBlock)();

/** 协议 */
@property (nonatomic, assign) id<UITextFieldDelegate> delegate;

@end
