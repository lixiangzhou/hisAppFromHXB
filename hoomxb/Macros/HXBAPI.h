//
//  HXBAPI.h
//  TR7TreesV3
//
//  Created by hoomsun on 16/6/16.
//  Copyright © 2016年 hoomsun. All rights reserved.
//

#ifndef HXBAPI_h
#define HXBAPI_h

// FOUNDATION_EXPORT NSString * const kString;   --> .h & .m (stringInstance == kString)


// 调用富友web前 需先做permission判断
//#import "FYUserLevelAPI.h"
//#import "UserPermissioHongXiaoBao/PrefixHeader.pchnModel.h"

//新版接口宏定义
#define FORCE_LOGOUT_URL                              @"ab"
#define FAQ_URL                                       @"https://www.hoomxb.com/app-files/questions"    //常见问题url
#define PLAN_FAQ_URL                                  @"https://hoomxb.com/app-files/common_questions.html"
#define PLAN_SAFE_GUARD_URL                           @"https://hoomxb.com/app-files/plan-safeguard.html"
//#define BASEURL                                       @"https://api.hoomxb.com"
//#define BASEURL                                       @"http://10.1.80.11:9001"

//叶

#define BASEURL                                       @"http://192.168.1.186:3000"//后台


//#define BASEURL                                       @"http://192.168.1.133:3000"//王鹏 端测试
//#define BASEURL                                       @"http://192.168.1.186:3000"//杜宇 测试
//#define BASEURL                                       @"http://192.168.1.166:3000"//杜宇 测试


//http://192.168.1.133:3000
//http://192.168.1.21:3000
//#define BASEURL                                       @"http://120.25.102.84:9001"
//#define BASEURL                                       @"http://10.1.80.146:6666"//

//// 本机服务器-njm

//#define BASEURL                                         @"http://10.1.81.125:9001"
//#define BASEURL                                         @"http://10.1.81.125:9001"
//#define BASEURL                                         @"http://10.1.81.125:9009"

//曹曹曹曹曹曹曹曹曹曹
//#define BASEURL                                       @"http://10.1.80.10:9001"
#define FYCallBackUrl                                 @"/fyCallback/app/0"
#define TOKENURL                                      @"/token"
static NSString *const HXBTokenInvalidCode = @"401";

//#define REGISTERCHECK                                 @"registerCheck"
//#define LOGIN                                         @"login"
//#define UPDATEGESTURE                                 @"updateGesture"
//#define DELETEGESTURE                                 @"deleteGesture"
//#define GETNEWVISON                                   @"versionCheck"
//#define UPDATELOGINPWD                                @"updateLoginPwd"
//#define BANNERS                                       @"banners"
//#define INVITATIONS                                   @"invitations"
//#define BANKCARDS                                     @"bankcards"
//#define FEEDBACKS                                     @"feedbacks"
//#define TOPPRODUCT                                    @"topProduct" //首页热销数据（现在直接返回首页标数据） 
//#define PRODUCTDETAILS                                @"productDetails"     //产品全部详细信息
//#define PRODUCTS                                      @"products"  //产品基础信息
//#define PRODUCTSINVESTRECORD                          @"productInvestRecord" //产品投资记录
//#define VERIFYCODE                                    @"verifyCode"     //获取短信验证码
//#define CHECKVERIFYCODE                               @"checkVerifyCode" //验证码验证
//#define ACCOUNTINFO                                   @"accountInfo"
//#define CUSTOMERS                                     @"customers"  ///
//#define BindingBankCard                               @"bindBankcard"
//#define UPDATEPAYPWD                                  @"updatePayPwd"
//#define VERIFYPAYPWD                                  @"verifyPayPwd"
//#define USERASSET                                     @"userAssets"
//#define ASSETSCATEGORY                                @"assetsCategory"
//#define ASSETSLIST                                    @"assetList"
//#define INVESTRECORD                                  @"investRecord"
//#define FORGETLOGINPWD                                @"forgetLoginPwd"
//#define CREDITASSETDETAIL                             @"creditAssetDetail"
//#define BALANCEDETAIL                                 @"balanceDetail"  //余额的收支明细记录
//
//
////-------暂未修改接口----------
//#define CAR_LOAN_URL                                  @"http://114.55.68.185:9999"
//
//#define BASEURL_existsNickName                        @"common/existsNickName"
//
//#define SANBIAO_DETAIL_RURL_Personal                  @"rersonalX"
//#define SANBIAO_DETAIL_RURL_work                      @"workinfo"
//#define SANBIAO_DETAIL_RURL_financial                 @"financialinfo"
//#define PRODUCTDETAILS_judgeAmt                       @"judgeAmt"
//#define PAYBASE_URL                                   @"http://www-1.fuiou.com:9057/jzh/"
//#define FASTPAY_URL                                   @"app/500001.action"
//#define FASTWITHDRAWCASH_URL                          @"app/500003.action"
//#define PAY_BANK_OPEN_URL                             @"openbank"
////已投项目的访问页
//#define INVEST_LIMIT                                  @"investorreccc"
//#define MONEY_RECOND                                  @"moneymecordX/listToPhone"
//#define SIGNATURE                                     @"encryption"
//#define INVEST_IMMEDIATELY                            @"deducts"
//#define GESTURE_TOLOGIN_URL                           @"phonegesture"
//#define GESTURE_UPDATE_URL                            @"updategesture"
//#define REALNAME_URL                                  @"insertusercode"
//#define CESSION_OF_CLAIM                              @"debt/list"


////交易记录 只用余额支付
//#define ACCOUT_PAY                                    @"deducts1"
////交易密码身份验证
////验证码加载
//#define Get_Code                                      @"code"
////充值提现加载银行卡以及真实姓名
//#define PANANDCASH                                    @"getphoneneedbandata"
//
////启动页面图片
//#define LAUNCHSCREEN                                  @"getphoneflashimgname"
////债权转让ID
//#define LOANINVESTORID                                @"getdedtdatatophone"
////债权转让立即认购
//#define STARTDEBTASSIGNMENTREQUEST                    @"startDebtAssignmentRequest"
//
////已投项目筛选显示
//#define SIFT                                          @"choicehahaha"
//// 我——债权转让
//#define changeDedtstatus                              @"changeDedtstatus"
//
////我——债权撤回
//#define changeDedtstatus1                             @"changeDedtstatus1"
//
////车贷
//#define CAR_URL                                       @"seltoPhoneList"
////车贷产品详情
//#define CAR_PRODUCT_DATA                              @"getcardata"
//
////我里的债权转让数据（可转让）
//#define TRANSLOAN1       @"dedtlist01"
//
////我里的债权转让数据（已转让）
//#define TRANSLOAN2       @"dedtlist02"
//
////我里的债权转让数据（已认购）
//#define TRANSLOAN3       @"dedtlist03"
//
////我里的债权转让数据（转让中）
//#define TRANSLOAN4       @"dedtlist04"
//
////获取电话号码
//#define GETTEL           @"getCustomServiceTel"
//
////pdf
//#define  GETPDF          @"debtxagreement"
//
////优质债权，车贷购买确认投资
//#define  SAVE_INVEST    @"saveinvest"
//
////优质债权、车贷第二个界面的剩余可投判断金额
//#define LOKING_AMOUNT   @"getlockingamount"
//
//#pragma mark 我的理财提现接口
////提现的URL
//#define TIXIAN_URL  @"saveCashreCord"
//
//// 服务器时间的获取
//#define  GETSEVERDATE  @"getSeverDate"
//
////充值支付完成后提交
//#define TOPUPAFTERPAY   @"getphone/recharge"
//
//
//// 获取每日收益以及理财资产接口
//#define GETEVERYDAYPROFIT  @"dayDayinterest"
//
////订单锁定
//#define LOCKING_ORDER    @"orders"
//
////支付成功回调
//#define PURCHASECALLBACK @"purchaseCallback"
//
////充值提交
//#define TOP_UP @"topUpCallback"
//
////申请提现
//#define WITHDRAW @"withdraw"
//
////提现手续费
//#define  FEEFORWITHDRAW  @"withdrawServiceFee"
//
////获取最新余额
//#define GETBANLANCE       @"balance"
//
////获取余额订单
//#define BANLANCE_ODER    @"topUpOrders"



#endif /* HXBAPI_h */
