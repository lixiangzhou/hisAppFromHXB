//
//  HXBUserInfoModel.h
//  hoomxb
//
//  Created by HXB on 2017/6/1.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXBRequestUserInfoAPI_UserAssets,HXBRequestUserInfoAPI_UserInfo;

///用户相关的Model
@interface HXBUserInfoModel : NSObject
///资金相关
@property (nonatomic,strong) HXBRequestUserInfoAPI_UserAssets *userAssets;
///用户相关
@property (nonatomic,strong) HXBRequestUserInfoAPI_UserInfo *userInfo;


@end


///用户资产
@interface HXBRequestUserInfoAPI_UserAssets : NSObject
/// 总资产
@property (nonatomic,copy) NSString *assetsTotal;
///    累计收益
@property (nonatomic,copy) NSString *earnTotal;
///    红利计划-持有资产
@property (nonatomic,copy) NSString *financePlanAssets;
///    红利计划-累计收益
@property (nonatomic,copy) NSString *financePlanSumPlanInterest;
///    散标债权-持有资产
@property (nonatomic,copy) NSString *lenderPrincipal;
///    散标债权-累计收益
@property (nonatomic,copy) NSString *lenderEarned;
///    可用余
@property (nonatomic,copy) NSString *availablePoint;

///    冻结余额
@property (nonatomic,copy) NSString *frozenPoint;
@property (nonatomic,copy) NSString *hasRecharge;
/// 持有总资产
@property (nonatomic,strong) NSNumber *holdingTotalAssets;
/// 持有总资产
@property (nonatomic, assign) double holdingAmount;
/**
 用户可出借总金额
 */
@property (nonatomic,copy) NSString *userRiskAmount;
/**
 用户可购买产品风险类型集合:
 保守型：[“AA”,”A”,”CONSERVATIVE”];
 稳健性：[“AA”,”A”, “B”,”CONSERVATIVE”, “PRUDENT”];
 激进型：[“D”, “AA”, “A”,”PROACTIVE”, “B”,”C”,”CONSERVATIVE”, “PRUDENT”]
 */
@property (nonatomic,strong) NSArray *userRisk;


@end


@interface HXBRequestUserInfoAPI_UserInfo : NSObject

///    int    用户id
@property (nonatomic,copy) NSString *userId;
///    String    用户名称
@property (nonatomic,copy) NSString *username;
///    用户手机
@property (nonatomic,copy) NSString *mobile;
///    是否安全认证-(不在使用)
@property (nonatomic,copy) NSString *isAllPassed;
///    String    是否手机号
@property (nonatomic,copy) NSString *isMobilePassed;
///    是否实名
@property (nonatomic,copy) NSString *isIdPassed;
///    是否有交易密码
@property (nonatomic,copy) NSString *isCashPasswordPassed;
/// 上次登录时间
@property (nonatomic,copy) NSString *lastLoginTime;
///    登录时间
@property (nonatomic,copy) NSString *loginTime;
///    是否投资 true:
@property (nonatomic,copy) NSString *hasEverInvest;
///    是否投资 true:
@property (nonatomic,copy) NSString *hasEverInvestLoan;
///    是否投资 true:
@property (nonatomic,copy) NSString *hasEverInvestFinancePlan;
///    int    是否绑卡 1：已绑卡， 0：未绑卡
@property (nonatomic,copy) NSString *hasBindCard;
///是否开同存管
@property (nonatomic,copy) NSString *isEscrow;
/// 真实姓名
@property (nonatomic,copy) NSString *realName;
/// 身份证 640121197904299980
@property (nonatomic,copy) NSString *idNo;
/**
 1: 是新手；0: 不是新手
 */
@property (nonatomic, copy) NSString* isNewbie;

/**
 性别：‘0’：男，‘1’：女
 */
@property (nonatomic, copy) NSString *gender;
/**
 最小充值金额
 */
@property (nonatomic, assign) int minChargeAmount;

/**
 最小提现金额
 */
@property (nonatomic, assign) int minWithdrawAmount;
/**
 最小充值金额——new
 */
@property (nonatomic, strong) NSString *minChargeAmount_new;

/**
 最小提现金额——new
 */
@property (nonatomic, strong) NSString *minWithdrawAmount_new;
/**
 是否评估
 */
@property (nonatomic, copy) NSString *riskType;
/**
 是否开通存管账户
 */
@property (nonatomic, assign) BOOL isCreateEscrowAcc;
/**
 是否解绑身份证
 */
@property (nonatomic, assign) BOOL isUnbundling;
/**
 ip
 */
@property (nonatomic,copy) NSString *ip;
/**
 是否投资
 */
@property (nonatomic,copy) NSString *hasRecharge;
/**
 是否有理财顾问
 */
@property (nonatomic,assign) BOOL isDisplayAdvisor;



@end
