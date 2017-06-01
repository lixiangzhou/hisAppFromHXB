//
//  HXBSignUPAndLoginRequest.h
//  hoomxb
//
//  Created by HXB on 2017/5/31.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "NYBaseRequest.h"
///登录注册相关地 一些请求都在这里了
/// 图形验证码， 教研图片验证码， 注册，登录
@interface HXBSignUPAndLoginRequest : NSObject

/**
 * 注册 请求
 * @param mobile 手机号
 * @param smscode 短信验证码
 * @param password 密码
 * @param inviteCode 邀请码
 * @param successBlock 成功的回调
 * @param failureBlock 失败的回调
 */
+ (void)signUPRequetWithMobile: (NSString *)mobile
                    andSmscode: (NSString *)smscode
                   andPassword: (NSString *)password
                 andInviteCode: (NSString *)inviteCode
               andSuccessBlock: (void(^)())successBlock
               andFailureBlock: (void(^)(NSError *error))failureBlock;



/**
 * 登录 请求
 * @param  mobile   是	string	用户名
 * @param  password 是	string	密码
 * @param  captcha  否	string	图验(只有在登录错误超过3次才需要输入图验)
 
 */
+ (void)loginRequetWithfMobile: (NSString *)mobile
                   andPassword: (NSString *)password
                    andCaptcha: (NSString *)captcha
               andSuccessBlock: (void(^)(BOOL isSuccess))successBlock
               andFailureBlock: (void(^)(NSError *error))failureBlock ;


/**
 * 图验 请求 登录失败三次 才会调用此方法
 * @param successBlock 成功的回调
 * @param failureBlock 是被的回调
 */
+ (void)captchaRequestWithSuccessBlock: (void(^)(id responseObject))successBlock
                       andFailureBlock: (void(^)(NSError *error))failureBlock;

/**
 * 校验图片验证码
 * @param captcha 图验code
 * @param successBlock 成功的回调
 * @param failureBlock 失败的回调
 */
+ (void)checkCaptcharRequestWithCaptcha: (NSString *)captcha
                        andSuccessBlock: (void(^)(BOOL isSuccessBlock))successBlock
                        andFailureBlock: (void(^)(NSError *error))failureBlock;

/**
 * 发送短信的接口
 * @param mobile    用户名
 * @param action    signup(参照通用短信发送类型)
 * @param captcha 	校验图片二维码 的数字
 */
+ (void)smscodeRequestWithMobile: (NSString *)mobile
                       andAction: (NSString *)action
                      andCaptcha: (NSString *)captcha
                 andSuccessBlock: (void(^)(BOOL isSuccessBlock))successBlock
                 andFailureBlock: (void(^)(NSError *error))failureBlock;


/**
 * 发送短信的接口
 * @param mobile    用户名
 */
+ (void)checkMobileRequestWithMobile: (NSString *)mobile
                     andSuccessBlock: (void(^)(BOOL isSuccessBlock))successBlock
                     andFailureBlock: (void(^)(NSError *error))failureBlock;
@end
