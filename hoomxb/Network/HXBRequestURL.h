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

//MARK: ======================= 理财资产 界面 =======================
//plan
#define kHXBFinanc_PlanLisetURL(planListPage) [NSString stringWithFormat:@"/plan?page=%ld",(planListPage)]//红利计划列表
#define kHXBFinanc_Plan_AddRecortdURL(planID) [NSString stringWithFormat:@"/plan/%@/record",(planID)]//红利计划 加入记录
//loan
#define kHXBFinanc_LoanListURL(loanListPage) [NSString stringWithFormat:@"/loan?page=%ld",(loanListPage)]//标的列表
#define kHXBFinanc_LoanDetaileURL(loanID) [NSString stringWithFormat:@"loan/%ld",(loanID)]//散标详情
#define kHXBFinanc_Loan_AddRecortdURL(loanID) [NSString stringWithFormat:@"/loan/%@/record",(loanID)]//加入记录


//MARK: ======================= 用户 =======================
#define kHXBUser_UserInfoURL @"/user/info"///用户信息
#define kHXBUser_LoginURL @"/user/login"//登录
#define kHXBUser_SignUPURL @"/user/signup"//注册
#define HXBAccount_ForgotPasswordURL @"/forgot"///忘记密码
#define kHXBUser_checkCaptchaURL @"/checkCaptcha"///校验 图片验证码
#define kHXBUser_smscodeURL @"/send/smscode"///发送短信接口
#define kHXBUser_CheckMobileURL @"/checkMobile"///校验手机号
#define kHXBUser_CheckExistMobileURL @"/checkExistMobile"///忘记密码校验手机号
#define kHXBUser_realnameURL @"/user/realname"///实名认证

//MARK: ======================= 账户内 =======================
#define kHXBMY_CapitalRecordURL @"/account/tradlist"///交易记录
#define kHXBMY_PlanListURL @"/account/plan"//账户内  planlist
#define kHXBMY_PlanDetaileURL(planID) [NSString stringWithFormat:@"/account/plan/%@",(planID)]
#define kHXBMY_PlanAssetsURL @"/account/plan"// plan 资金统计

#define kHXBMY_LoanListURL @"/account/loan"//账户内  loanlist
#define kHXBMY_LoanAssetsURL @"/account/loanAssets"//loan资金统计
///账户内的plan 交易记录
#define kHXBFin_loanRecordURL(planID) [NSString stringWithFormat:@"/account/plan/%@/loanRecord",(planID)]
#define kHXBMY_LoanAccountRequestURL @"/account/loanAssets"///账户内 账户内Loan资产
#define kHXBMY_PlanAccountRequestURL @"/account/planAssets"///账户内 账户内Plan资产

//MARK: ======================= 账户设置 =======================
#define kHXBSetUPAccount_MobifyPassword_LoginRequestURL @"/account/password"//修改登录密码
#define kHXBSetTransaction_MobifyPassword_CheckIdentityAuthURL @"/checkIdentityAuth"//修改交易密码--验证用户身份信息接口
#define kHXBSetTransaction_MobifyPassword_SendSmscodeURL @"/send/smscode/base"//修改交易密码--发送验证码
#define kHXBSetTransaction_MobifyPassword_CheckIdentitySmsURL @"/account/checkIdentitySms"//修改交易密码--校验身份证和短信接口

#define kHXBSetGesturePasswordRequest_CheckLoginPasswordURL @"/user/checkLoginPassword"//校验登录密码
#define kHXBSetTransaction_MobifyPassword_CashpwdEditURL @"/account/cashpwd/edit"//修改交易密码--修改交易密码接口
#define kHXBSetTransaction_MobifyPhoneNumber_CashMobileEditURL @"/account/mobile"//修改手机号--修改手机号接口

#define kHXBMY_VersionUpdateURL @"/update"//版本更新


//MARK: ======================= 充值提现 =======================
#define kHXBSetWithdrawals_withdrawURL   @"/account/withdraw"//提现
#define kHXBSetWithdrawals_banklistURL   @"/banklist"//提现
#define kHXBSetWithdrawals_withdrawArriveTimeURL   @"/account/withdraw/arriveTime"//到账时间


//MARK: ======================= 购买 ==========================
#define kHXBFin_Plan_ConfirmBuyReslutURL(planID) [NSString stringWithFormat:@"/plan/%@/result",(planID)]//确认购买
#define kHXBFin_Buy_PlanURL(planID) [NSString stringWithFormat:@"/plan/%@/confirm",(planID)]//购买
#define kHXBFin_Buy_LoanURL(LoanID) [NSString stringWithFormat:@"/loan/%@/confirm",(LoanID)]
#define kHXBFin_BuyReslut_LoanURL(loanID) [NSString stringWithFormat:@"/loan/%@/result",(loanID)]
#endif
