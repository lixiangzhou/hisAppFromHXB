//
//  HXBRequestURL.h
//  hoomxb
//
//  Created by HXB on 2017/6/9.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//
#import <Foundation/Foundation.h>
#ifndef HXBRequestURL_h
#define HXBRequestURL_h

#pragma mark - 通用接口说


#pragma mark - 红利计划

#pragma mark - 标的

#pragma mark - 用户
///忘记密码
#define HXBAccount_ForgotPasswordURL @"/forgot"

#pragma mark - 账户内

#pragma mark - 账户设置
/// ------------------- 修改密码
#define kHXBSetUPAccount_MobifyPassword_LoginRequestURL @"/account/password"//修改登录密码

/// ------------------- 修改交易密码--验证用户身份信息接口
#define kHXBSetTransaction_MobifyPassword_CheckIdentityAuthURL @"/checkIdentityAuth"

/// ------------------- 修改交易密码--发送验证码
#define kHXBSetTransaction_MobifyPassword_SendSmscodeURL @"/send/smscode/base"

/// ------------------- 修改交易密码--校验身份证和短信接口
#define kHXBSetTransaction_MobifyPassword_CheckIdentitySmsURL @"/account/checkIdentitySms"

/// ------------------- 修改交易密码--修改交易密码接口
#define kHXBSetTransaction_MobifyPassword_CashpwdEditURL @"/account/cashpwd/edit"

/// ------------------ code 处理

#pragma mark - 充值提现


#pragma mark - 账户设置
#pragma mark - 账户设置
#endif /* HXBRequestURL_h */
