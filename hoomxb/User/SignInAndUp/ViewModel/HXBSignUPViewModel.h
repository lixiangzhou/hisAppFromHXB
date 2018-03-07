//
//  HXBSign_InAndUPViewModel.h
//  hoomxb
//
//  Created by HXB on 2017/5/31.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBSignUPAndLoginRequest_EnumManager.h"
@interface HXBSignUPViewModel : HXBBaseViewModel

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



/// 注册校验手机号
- (void)checkMobileRequestWithMobile: (NSString *)mobile resultBlock:(void(^)(BOOL isSuccess, NSString *message))resultBlock;
///
- (void)checkMobileRequestHUDWithMobile:(NSString *)mobile resultBlock:(void(^)(BOOL isSuccess))resultBlock;
@end
