//
//  HXBCode.h
//  hoomxb
//
//  Created by HXB on 2017/6/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 code 码
 */
typedef enum : NSUInteger {
    ///弹出图验
    kHXBCode_Enum_Captcha = 102,
    ///token无权限
    kHXBCode_Enum_TokenNotJurisdiction = 401,
    ///未登录
    kHXBCode_Enum_NotSigin = 402,
    ///服务器时间与系统时间相差过大
    kHXBCode_Enum_RequestOverrun = 412,
    //没有连接网络
    kHXBCode_Enum_NoConnectionNetwork = -1009,
    //服务器错误
    kHXBCode_Enum_NoServerFaile = 500,
    //交易密码错误
    kHXBTransaction_Password_Error = 3014,
    //短信验证码错误
    kHXBSMS_Code_Error = 3015,
    //购买过于频繁
    kHXBBuying_Too_Frequently = 3413,
    //恒丰银行处理中
    kHXBHengfeng_treatment = 3016,
    //余额不足
    kHXBNot_Sufficient_Funds = 3408,
    //已售罄
    kHXBSold_Out = 999,
    //购买处理中
    kHXBPurchase_Processing = -999,
} kHXBCode_Enum;

/**
 code 码
 */
typedef enum : NSUInteger {
    /// 登录跳转注册
    kHXBUmengEnum_loginToRegist = 1000,
    /// 注册下一步
    kHXBUmengEnum_registFirst = 1001,
    /// 注册
    kHXBUmengEnum_registSuccess = 1002,
    /// 引导开户
    kHXBUmengEnum_registSuccess_lead = 1003,
    /// 注册成功返回
    kHXBUmengEnum_registSuccess_return = 1004,
    /// 弹框
    kHXBUmengEnum_alertBtn = 1005,
    /// 提交按钮
    kHXBUmengEnum_commitBtn = 1006,
    /// 充值
    kHXBUmengEnum_topup_money = 1007,
    /// 提现
    kHXBUmengEnum_withdraw_money = 1008,
    
} kHXBUmeng_Enum;
static NSString *const kHXBUmeng_loginToRegist = @"1000";
static NSString *const kHXBUmeng_registFirst = @"1001";
static NSString *const kHXBUmeng_registSuccess = @"1002";
static NSString *const kHXBUmeng_registSuccess_lead = @"1003";
static NSString *const kHXBUmeng_registSuccess_return = @"1004";
static NSString *const kHXBUmeng_alertBtn = @"1005";
static NSString *const kHXBUmeng_commitBtn = @"1006";
static NSString *const kHXBUmeng_topup_money = @"1007";
static NSString *const kHXBUmeng_withdraw_money = @"1008";


@interface HXBCode : NSObject

@end
