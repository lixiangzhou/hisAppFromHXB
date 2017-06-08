//
//  HXBSignUPAndLoginRequest_EnumManager.m
//  hoomxb
//
//  Created by HXB on 2017/6/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBSignUPAndLoginRequest_EnumManager.h"
#import <limits.h>

///	String	REGISTER (注册)
static NSString *const kTypeKey_signup = @"signup";
///	String	RESETPASSWORD (重置登录密码)
static NSString *const kTypeKey_forgot = @"forgot" ;
///	String	RESETCASHPWD (重置交易密码)
static NSString *const kTypeKey_tradpwd = @"tradpwd";
///	String	CHECKOLDMOBILE (校验老的手机号)
static NSString *const kTypeKey_oldmobile = @"oldmobile";
///	String	UPDATEMOBILE (修改绑定手机号)
static NSString *const kTypeKey_newmobile = @"newmobile";


@implementation HXBSignUPAndLoginRequest_EnumManager
+ (NSString *)getKeyWithHXBSignUPAndLoginRequest_sendSmscodeType: (HXBSignUPAndLoginRequest_sendSmscodeType) type {
    
    NSString *key = nil;
    switch (type) {
        case HXBSignUPAndLoginRequest_sendSmscodeType_forgot:
            key = kTypeKey_forgot;
            break;
        case HXBSignUPAndLoginRequest_sendSmscodeType_signup:
            key = kTypeKey_signup;
            break;
        case HXBSignUPAndLoginRequest_sendSmscodeType_tradpwd:
            key = kTypeKey_tradpwd;
            break;
        case HXBSignUPAndLoginRequest_sendSmscodeType_newmobile:
            key = kTypeKey_newmobile;
            break;
        case HXBSignUPAndLoginRequest_sendSmscodeType_oldmobile:
            key = kTypeKey_oldmobile;
            break;
    }
    return key;
}
+ (HXBSignUPAndLoginRequest_sendSmscodeType)getValueForKey: (NSString *)key {
    if ([key isEqualToString:kTypeKey_signup]) return HXBSignUPAndLoginRequest_sendSmscodeType_signup;
    if ([key isEqualToString:kTypeKey_forgot]) return HXBSignUPAndLoginRequest_sendSmscodeType_forgot;
    if ([key isEqualToString:kTypeKey_tradpwd]) return HXBSignUPAndLoginRequest_sendSmscodeType_tradpwd;
    if ([key isEqualToString:kTypeKey_oldmobile]) return HXBSignUPAndLoginRequest_sendSmscodeType_oldmobile;
    if ([key isEqualToString:kTypeKey_newmobile]) return HXBSignUPAndLoginRequest_sendSmscodeType_newmobile;
    NSLog(@"🌶 %@ 没有找到相应的key",self);
    return LONG_MAX;
}
@end
