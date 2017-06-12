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

/// ======================= 展示hud 并 判断请求是否成功 =======================
#define kHXBResponsShowHUD if ([responseObject[@"status"] intValue]) {\
if (failureBlock) {\
    failureBlock(nil);\
[HxbHUDProgress showTextWithMessage:responseObject[@"message"]];\
return;\
}\
}






//MARK: ======================= 理财资产 界面 =======================
#define kHXBFinanc_Plan_AddRecortdURL(planID) [NSString stringWithFormat:@"/plan/%@/record",(planID)]//红利计划






//MARK: ======================= 用户 =======================
#define HXBAccount_ForgotPasswordURL @"/forgot"///忘记密码







//MARK: ======================= 账户内 =======================






//MARK: ======================= 账户设置 =======================
#define kHXBSetUPAccount_MobifyPassword_LoginRequestURL @"/account/password"//修改登录密码
#define kHXBSetTransaction_MobifyPassword_CheckIdentityAuthURL @"/checkIdentityAuth"//修改交易密码--验证用户身份信息接口
#define kHXBSetTransaction_MobifyPassword_SendSmscodeURL @"/send/smscode/base"//修改交易密码--发送验证码
#define kHXBSetTransaction_MobifyPassword_CheckIdentitySmsURL @"/account/checkIdentitySms"//修改交易密码--校验身份证和短信接口
#define kHXBSetTransaction_MobifyPassword_CashpwdEditURL @"/account/cashpwd/edit"//修改交易密码--修改交易密码接口




//MARK: ======================= 充值提现 =======================
#endif
