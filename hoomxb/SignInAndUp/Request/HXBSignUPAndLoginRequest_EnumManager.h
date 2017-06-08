//
//  HXBSignUPAndLoginRequest_EnumManager.h
//  hoomxb
//
//  Created by HXB on 2017/6/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 错误码
///输入验证码
static NSInteger const HXBSignUPAndLoginRequestError_captcha102 = 102;



///	String	REGISTER (注册)
static NSString *const kTypeKey_signup;
///	String	RESETPASSWORD (重置登录密码)
static NSString *const kTypeKey_forgot;
///	String	RESETCASHPWD (重置交易密码)
static NSString *const kTypeKey_tradpwd;
///	String	CHECKOLDMOBILE (校验老的手机号)
static NSString *const kTypeKey_oldmobile;
///	String	UPDATEMOBILE (修改绑定手机号)
static NSString *const kTypeKey_newmobile;

/**通用短信发送类型*/
typedef enum : NSUInteger {
    ///String	REGISTER (注册)
    HXBSignUPAndLoginRequest_sendSmscodeType_signup,
    ///String	RESETPASSWORD (重置登录密码)
    HXBSignUPAndLoginRequest_sendSmscodeType_forgot,
    ///String	RESETCASHPWD (重置交易密码)
    HXBSignUPAndLoginRequest_sendSmscodeType_tradpwd,
    ///String	CHECKOLDMOBILE (校验老的手机号)
    HXBSignUPAndLoginRequest_sendSmscodeType_oldmobile,
    ///String	UPDATEMOBILE (修改绑定手机号)
    HXBSignUPAndLoginRequest_sendSmscodeType_newmobile,
} HXBSignUPAndLoginRequest_sendSmscodeType;

///枚举管理类
@interface HXBSignUPAndLoginRequest_EnumManager : NSObject
+ (NSString *)getKeyWithHXBSignUPAndLoginRequest_sendSmscodeType: (HXBSignUPAndLoginRequest_sendSmscodeType) type;
+ (HXBSignUPAndLoginRequest_sendSmscodeType)getValueForKey: (NSString *)key;
@end
