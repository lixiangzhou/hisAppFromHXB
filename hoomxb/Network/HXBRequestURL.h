//
//  HXBRequestURL.h
//  hoomxb
//
//  Created by HXB on 2017/6/9.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//
#import <Foundation/Foundation.h>
#ifndef HXBRequestURL_h
#define HXBRequestURL_h

//MARK: ======================= 首页 =======================
#define kHXBHome_HomeURL @"/home"///用户信息
#define kHXBHome_PopView @"/popups"///首页弹窗

//MARK: ======================= 闪屏接口 界面 =======================
#define kHXBSplash            @"/splash"///闪屏接口
//MARK: ======================= 理财资产 界面 =======================
//列表
//红利计划列表
#define kHXBFinanc_PlanLisetURL(planListPage) [NSString stringWithFormat:@"/plan?page=%ld",(planListPage)]
#define kHXBFinanc_LoanListURL(loanListPage) [NSString stringWithFormat:@"/loan?page=%ld",(loanListPage)]//标的列表
#define kHXBFin_LoanTruansferURL @"/transfer"///债转列表
#define kHXBFinanc_PlanInvestList @"/plan/investlist"   // 合规 计划可投的新申请标的列表
//详情
#define kHXBFinanc_PlanDetaileURL(planID) [NSString stringWithFormat:@"/plan/%ld",(planID)]///计划详情
#define kHXBFinanc_LoanDetaileURL(loanID) [NSString stringWithFormat:@"loan/%ld",(loanID)]//散标详情
#define kHXBFin_LoanTruansfer_DetailURL(loanTruansferID) [NSString stringWithFormat:@"/transfer/%ld",(loanTruansferID)]//债转详情
//加入记录
#define kHXBFinanc_Loan_AddRecortdURL(loanID) [NSString stringWithFormat:@"/loan/%@/record",(loanID)]//加入记录
#define kHXBFinanc_Plan_AddRecortdURL(planID) [NSString stringWithFormat:@"/plan/%@/record",(planID)]//红利计划 加入记录
#define kHXBFinanc_LoanTruansfer_AddRecortdURL(loanTruanserID) [NSString stringWithFormat:@"/transfer/%@/transferRecord",(loanTruanserID)];//账户外债转加入记录

//MARK: ======================= 用户 =======================
#define kHXBUser_UserInfoURL @"/account/info"///用户信息
#define kHXBUser_LoginURL @"/user/login"//登录
#define kHXBUser_SignUPURL @"/user/signup"//注册
#define HXBAccount_ForgotPasswordURL @"/forgot"///忘记密码
#define kHXBUser_checkCaptchaURL @"/checkCaptcha"///校验 图片验证码
#define kHXBUser_smscodeURL @"/verifycode/send"//@"/send/smscode"///发送短信接口
#define kHXBUser_CheckMobileURL @"/checkMobile"///校验手机号
#define kHXBUser_CheckExistMobileURL @"/checkExistMobile"///忘记密码校验手机号
#define kHXBUser_realnameURL @"/user/realname"///实名认证
#define kHXBUser_riskModifyScoreURL @"/user/riskModifyScore"///风险评测
#define kHXBUser_financialAdvisorURL @"/account/advisor" //获取理财顾问信息
#define kHXBUser_AccountInfoURL @"/account"///账户内数据总览


//MARK: ======================= 账户内 =======================
#define kHXBMY_CapitalRecordURL @"/account/tradlist"///交易记录
#define kHXBMY_PlanListURL @"/account/plan"//账户内  planlist
#define kHXBMY_PlanDetaileURL(planID) [NSString stringWithFormat:@"/account/plan/%@",(planID)]
#define kHXBMY_PlanQuitURL(planID) [NSString stringWithFormat:@"/account/plan/quit/%@/cancel",(planID)]
#define kHXBMY_PlanAssetsURL @"/account/plan"// plan 资金统计
#define kHXBMY_PlanBeforeQuitURL(planBID) [NSString stringWithFormat:@"account/plan/quit/%@/confirm",(planID)]// plan 计划预退出
#define kHXBMY_PlanQuitResultURL(planID) [NSString stringWithFormat:@"/account/plan/quit/%@/result",(planID)] /// plan 获取计划退出结果
#define kHXBMY_PlanCancelBuyURL(planID) [NSString stringWithFormat:@"/account/plan/cancelbuy/%@/confirm",(planID)]// plan 冷静期计划取消加入前确认
#define kHXBMY_PlanCancelBuyResultURL(planID) [NSString stringWithFormat:@"/account/plan/cancelbuy/%@/result",(planID)] /// plan 冷静期计划取消加入结果

#define kHXBMY_LoanListURL @"/account/loan"//账户内  loanlist
#define kHXBMY_LoanTruansferListURL @"/account/transfer"//账户内 loanTruansfer
#define kHXBMY_LoanAssetsURL @"/account/loanAssets"//loan资金统计
#define kHXBMY_AccountListInfoURL @"/account/coupon"///账户内优惠券列表
#define kHXBMY_CouponExchangeInfoURL @"/coupon/exchange"///兑换优惠券

///账户内的plan 交易记录
#define kHXBFin_loanRecordURL(planID) [NSString stringWithFormat:@"/account/plan/%@/loanRecord",(planID)]
#define kHXBMY_LoanAccountRequestURL @"/account/loanAssets"///账户内 账户内Loan资产
#define kHXBMY_PlanAccountRequestURL @"/account/planAssets"///账户内 账户内Plan资产


///账户内转让记录
#define kHXBFin_CreditorRecordURL(planID) [NSString stringWithFormat:@"/transfer/%@/transferRecord",(planID)]
//账户内债权转让确认页
#define kHXBFin_TransferRecordURL(planID) [NSString stringWithFormat:@"/account/transfer/%@/confirm",(planID)]
//债权转让功能接口
#define kHXBFin_TransferResultURL @"account/transfer/transfersale"


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
#define kHXBSetWithdrawals_recordtURL    @"/account/withdraw/record"//提现记录

//MARK: ======================= 账户外购买 ==========================
#define kHXBFin_Plan_ConfirmBuyReslut       @"/plan/purchase"              /// 计划购买
#define kHXBFin_Loan_ConfirmBuyReslut       @"/loan/purchase"             /// 散标购买
#define kHXBFin_Transfer_ConfirmBuyReslut   @"/transfer/purchase"         /// 债权购买

//MARK: ======================= 账户内购买 ==========================
#define kHXBFin_Buy_PlanURL(planID) [NSString stringWithFormat:@"/plan/%@/confirm",(planID)]
#define kHXBFin_Buy_LoanURL(LoanID) [NSString stringWithFormat:@"/loan/%@/confirm",(LoanID)]

//MARK: ======================= 公告 ==========================
#define kHXBHome_AnnounceURL @"/announce"//公告
//MARK: ======================= 存管 ==========================
#define kHXBOpenDepositAccount_Escrow @"/user/escrow" //用户开通存管账户
#define kHXBUserInfo_UnbindBankCard @"/account/bankcard/unbind" // 解绑银行卡操作
#define kHXBUserInfo_BankCard @"/account/bankcard"//@"/account/user/card" //用户获取绑定银行卡信息
#define kHXBWithdraw @"/account/withdraw" //提现页面
#define kHXBAccount_quickpay_smscode @"/account/smscode/" //代扣充值获取手机验证码
#define kHXBAccount_quickpay @"/account/quickpay" //代扣充值接口 短验和语音统一为一个借口
#define kHXBAccount_Bindcard @"/account/bindcard" //绑卡
#define kHXBUser_checkCardBin @"/user/checkCardBin" //卡bin校验

//MARK: ======================= 协议 ==========================
//协议或合同名    端口号后链接    状态    账户内连接
#define kHXB_Negotiate_SginUPURL @"/agreement/signup"///《注册服务协议》
#define kHXB_Negotiate_CertificationURL @"/agreement/realname"///《红小宝认证服务协议》
#define kHXB_Negotiate_ServePlanURL @"/agreement/plan"///《红利计划服务协议书》
#define kHXB_Negotiate_ServePlanMonthURL @"/agreement/planMonth"///《按月付息服务协议书》
#define kHXB_Negotiate_ServePlan_AccountURL(productID) [NSString stringWithFormat: @"/acount/plan/%@/agreement",(productID)]///账户内服务协议 plan
#define kHXB_Negotiate_ServeMonthPlan_AccountURL(productID) [NSString stringWithFormat: @"/acount/planMonth/%@/agreement",(productID)]///账户内按月付息服务协议
#define kHXB_Negotiate_ServeLoan_AccountURL(productID) [NSString stringWithFormat: @"/acount/loan/%@/agreement/",(productID)]///账户内《借款协议》
#define kHXB_Negotiate_ServeLoanURL @"/agreement/loan"///《借款服务协议书》
#define kHXB_Negotiate_Anti_MoneyLaunderingURL @"/agreement/antimoney"///《反洗钱告知暨客户出借承诺书》
#define kHXB_Negotiate_LoanTruansferURL @"/agreement/debts"///《债权转让及受让协议》
#define kHXB_Negotiate_ServeCreditor_AccountURL(productID) [NSString stringWithFormat: @"/account/transfer/%@/agreement",(productID)]///账户内《债权转让及受让协议》
#define kHXB_Negotiate_depository @"/agreement/depository" ///《存管开户协议》
#define kHXB_Negotiate_thirdpart @"/agreement/thirdpart" ///《恒丰银行股份有限公司杭州分行网络交易资金账户三方协议》
#define kHXB_Negotiate_authorize @"/agreement/authorize" ///《红小宝平台授权协议》
#define kHXB_Negotiate_couponExchangeInstructionsUrl @"/discount/explain" ///优惠券使用说明

#define kHXB_Negotiate_AddTrustURL @"/landing/trust"///增信页

#define kHXB_Agreement_Hint @"/agreement/hint"//网络借贷协议书

//MARK: ======================= H5界面 =======================
#define kHXBH5_RiskEvaluationURL [NSString stringWithFormat:@"%@/riskvail",[KeyChain h5host]]//风险评测
#define kHXBH5_InviteDetailURL [NSString stringWithFormat:@"%@/account/invite",[KeyChain h5host]]//邀请好友 /invite/detail
#define kHXBUser_QuestionsURL           @"/questions"///常见问题

//MARK: ======================= 优惠券 ==========================
#define kHXB_Coupon_Query @"/coupon/query" // 选择优惠券列表
#define kHXB_Coupon_Best @"/coupon/best" // 匹配最优优惠券

//MARK: ======================= 邀请好友 ==========================
#define kHXB_Invite_List @"/account/invite/list" // 邀请好友列表
#define kHXB_Invite_OverView @"/account/invite/overview" // 邀请好友奖励

//MARK: ======================= 友盟分享 =======================
#define kHXBUMShareURL   @"/share"//获取分享时所需要的数据
#endif
