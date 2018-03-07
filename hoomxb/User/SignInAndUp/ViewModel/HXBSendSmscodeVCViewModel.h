//
//  HXBSendSmscodeVCViewModel.h
//  hoomxb
//
//  Created by HXB-C on 2018/2/27.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBSignUPAndLoginRequest_EnumManager.h"
@interface HXBSendSmscodeVCViewModel : HXBBaseViewModel

/**
 获取充值短验
 @param mobile 手机号
 @param action 获取短信的事件
 @param captcha 图验(只有在登录错误超过3次才需要输入图验)
 @param callbackBlock 请求回调
 */
- (void)getVerifyCodeRequesWithMobile: (NSString *)mobile
                                andAction: (HXBSignUPAndLoginRequest_sendSmscodeType)action
                               andCaptcha: (NSString *)captcha
                              andType: (NSString *)type
                         andCallbackBlock: (void(^)(BOOL isSuccess,NSError *error))callbackBlock;


/**
* 注册 请求
* @param mobile 手机号
* @param smscode 短信验证码
* @param password 密码
* @param inviteCode 邀请码
* @param resultBlock 结果的回调
*/
- (void)signUPRequetWithMobile: (NSString *)mobile smscode: (NSString *)smscode password: (NSString *)password inviteCode: (NSString *)inviteCode resultBlock:(void (^)(BOOL isSuccess))resultBlock;
@end
