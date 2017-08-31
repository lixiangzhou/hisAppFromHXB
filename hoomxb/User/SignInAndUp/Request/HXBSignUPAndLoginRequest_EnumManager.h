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
static NSString *const kTypeKey_signup = @"signup";
///	String	RESETPASSWORD (重置登录密码)
static NSString *const kTypeKey_forgot = @"forgot" ;
///	String	RESETCASHPWD (重置交易密码)
static NSString *const kTypeKey_tradpwd = @"tradpwd";
///	String	CHECKOLDMOBILE (校验老的手机号)
static NSString *const kTypeKey_oldmobile = @"oldmobile";
///	String	UPDATEMOBILE (修改绑定手机号)
static NSString *const kTypeKey_newmobile = @"newmobile";

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

/**开户页面的跳转*/
typedef enum : NSUInteger {
    ///充值
    HXBRechargeAndWithdrawalsLogicalJudgment_Recharge,
    ///提现
    HXBRechargeAndWithdrawalsLogicalJudgment_Withdrawals,
    //注册
    HXBRechargeAndWithdrawalsLogicalJudgment_signup,
    //修改手机号
    HXBChangePhone,
    ///其他的
    HXBRechargeAndWithdrawalsLogicalJudgment_Other
} HXBRechargeAndWithdrawalsLogicalJudgment;


///枚举管理类
@interface HXBSignUPAndLoginRequest_EnumManager : NSObject
+ (NSString *)getKeyWithHXBSignUPAndLoginRequest_sendSmscodeType: (HXBSignUPAndLoginRequest_sendSmscodeType) type;
+ (HXBSignUPAndLoginRequest_sendSmscodeType)getValueForKey: (NSString *)key;
@end
