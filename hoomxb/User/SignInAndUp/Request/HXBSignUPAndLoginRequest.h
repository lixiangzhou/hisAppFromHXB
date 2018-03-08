//
//  HXBSignUPAndLoginRequest.h
//  hoomxb
//
//  Created by HXB on 2017/5/31.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "NYBaseRequest.h"
#import "HXBSignUPAndLoginRequest_EnumManager.h"//枚举管理类

///登录注册相关地 一些请求都在这里了
/// 图形验证码， 教研图片验证码， 注册，登录
@interface HXBSignUPAndLoginRequest : NSObject


/**
 * 忘记密码
 *@param mobile     手机号
 *@param smscode	短信
 *@param captcha	图验
 *@param password	新密码
 */
+ (void)forgotPasswordRequestWithMobile: (NSString *)mobile
                             andSmscode: (NSString *)smscode
                             andCaptcha: (NSString *)captcha
                            andPassword: (NSString *)password
                        andSuccessBlock: (void(^)(BOOL isExist))successBlock
                        andFailureBlock: (void(^)(NSError *error))failureBlock;




@end
