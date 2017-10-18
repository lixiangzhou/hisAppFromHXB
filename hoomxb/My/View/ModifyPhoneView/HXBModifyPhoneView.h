//
//  HXBModifyPhoneView.h
//  hoomxb
//
//  Created by HXB-C on 2017/6/24.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBModifyPhoneView : UIView

/**
 获取验证码回调的方法
 */
@property (nonatomic, copy) void(^getValidationCodeButtonClickBlock)(NSString *phoneNumber);

/**
 确认修改按钮点击回调的Block
 */
@property (nonatomic, copy) void(^sureChangeBtnClickBlock)(NSString *phoneNumber,NSString *verificationCode);

/**
 获取验证码成功
 */
- (void)getCodeSuccessfully;
/**
 发送验证码失败
 */
- (void)sendCodeFail;
@end
