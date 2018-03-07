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
 * 忘记密码校验手机号
 * @param mobile    用户名
 */
+ (void)checkExistMobileRequestWithMobile: (NSString *)mobile
                          andSuccessBlock: (void(^)(BOOL isExist))successBlock
                          andFailureBlock: (void(^)(NSError *error,NYBaseRequest *request))failureBlock ;

/**
 * 安全认证
 * @param userName 用户名
 * @param identityCard 身份证
 * @param password 交易密码
 */
+ (void)realnameRequestWithUserName: (NSString *)userName
                    andIdentityCard: (NSString *)identityCard
                        andPassword: (NSString *)password
                    andSuccessBlock: (void(^)(BOOL isExist))successBlock
                    andFailureBlock: (void(^)(NSError *error,NYBaseRequest *request))failureBlock;

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
