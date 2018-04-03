//
//  HXBVerificationCodeAlertVC
//  hoomxb
//
//  Created by HXB-C on 2017/6/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//  只是验证码弹窗

#import <UIKit/UIKit.h>
#import "HXBVerificationCodeAlertView.h"
@interface HXBVerificationCodeAlertVC : UIViewController
@property (nonatomic, strong) HXBVerificationCodeAlertView *verificationCodeAlertView;
/**
 messagetitle
 */
@property (nonatomic, copy) NSString *messageTitle;

/**
 子标题
 */
@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, copy) NSString *leftBtnStr;/// 左侧按钮名称 未设置默认“取消”
@property (nonatomic, copy) NSString *rightBtnStr;/// 右侧按钮名称 未设置默认“确定”

//是否有语音验证码
@property (nonatomic, assign) BOOL isSpeechVerificationCode;

/**
 是否清空
 */
@property (nonatomic, assign) BOOL isCleanPassword;
/**
 确认按钮
 */
@property (nonatomic, copy) void(^sureBtnClick)(NSString *pwd);

//getSpeechVerificationCodeBlock获取语音验证码
@property (nonatomic, copy) void (^getSpeechVerificationCodeBlock)();
/**
 getVerificationCodeBlock
 */
@property (nonatomic, copy) void(^getVerificationCodeBlock)();
@property (nonatomic, copy) void (^cancelBtnClickBlock)();

@end
