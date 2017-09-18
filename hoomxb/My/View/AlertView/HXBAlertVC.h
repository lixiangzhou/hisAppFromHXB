//
//  HXBAlertVC.h
//  hoomxb
//
//  Created by HXB-C on 2017/6/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBAlertVC : UIViewController

/**
 messagetitle
 */
@property (nonatomic, copy) NSString *messageTitle;
/**
 message
 */
@property (nonatomic, copy) NSString *messageLabelText;

/**
 是否是验证码
 */
@property (nonatomic, assign) BOOL isCode;
/**
 是否是电话
 */
@property (nonatomic, assign) BOOL isMobile;


/**
 确认按钮
 */
@property (nonatomic, copy) void(^sureBtnClick)(NSString *pwd);

///**
// 忘记密码按钮
// */
@property (nonatomic, copy) void(^forgetBtnClick)();

/**
 getVerificationCodeBlock
 */
@property (nonatomic, copy) void(^getVerificationCodeBlock)();

@end
