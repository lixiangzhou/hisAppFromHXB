//
//  HXBVerificationCodeAlertView.h
//  hoomxb
//
//  Created by HXB-C on 2017/7/14.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBVerificationCodeAlertView : UIView

/**
 验证码
 */
@property (nonatomic, copy) NSString *verificationCode;


/**
 getVerificationCode再次获取验证码
 */
@property (nonatomic, copy) void (^getVerificationCodeBlock)();

/** 协议 */
@property (nonatomic, assign) id<UITextFieldDelegate> delegate;

@end
