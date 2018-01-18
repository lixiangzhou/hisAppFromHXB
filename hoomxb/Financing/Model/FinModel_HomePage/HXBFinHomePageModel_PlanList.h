//
//  HXBFinanctingModel_HomePage.h
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBFinHomePageModel_PlanList : NSObject

// 锁定期限(月),计划期限
@property (nonatomic, copy) NSString *lockPeriod;
// 新手标志
@property (nonatomic, assign) int novice;
// 开始销售时间
@property (nonatomic, copy) NSString *beginSellingTime;
// 最小注册金额
@property (nonatomic, copy) NSString *minRegisterAmount;
// 基础利率
@property (nonatomic, copy) NSString *baseInterestRate;
// 计划状态
@property (nonatomic, copy) NSString *unifyStatus;

///    string    本期加息利率
@property (nonatomic, copy) NSString *extraInterestRate;

///    string    年化利率
@property (nonatomic, copy) NSString *expectedRate;
///    string    计划名称
@property (nonatomic, copy) NSString *name;
///    string    计划id
@property (nonatomic,copy) NSString *ID;

@property (nonatomic, assign) BOOL showMoneyOff;
@property (nonatomic, assign) BOOL showDiscount;
/// 按月
@property (nonatomic, copy) NSString *incomeApproach;
///最终注册总金额
@property (nonatomic, copy) NSString *interestDate;



//提示文案右边的提示文案
@property (nonatomic, copy) NSString *tag;
///总金额,本期开放的额度,计划金额（元）
@property (nonatomic, copy) NSString *amount;
///财务状况
@property (nonatomic, copy) NSString *financeStatus;
/**
 销售截止时间
 账户外：
 1、    销售截止时间之前，如果满额：【已满额】。
 2、    到销售截止时间之后，锁定期之前：【销售结束】。
 */
@property (nonatomic, assign) double endSellingTime;

@property (nonatomic, copy) NSString *beginResellingTime;

@property (nonatomic, assign) double lastDays;
// 还款方式
@property (nonatomic, copy) NSString *featuredSlogan;
/**
 是否有可用抵扣券
 */
@property (nonatomic, assign) BOOL hasDiscountCoupon;
/**
 是否有可用满减券
 */
@property (nonatomic, assign) BOOL hasMoneyOffCoupon;
@property (nonatomic, copy) NSString *cashType;
@property (nonatomic, copy) NSString *cashDrawDay;
// 分类
@property (nonatomic, copy) NSString *category;
///    string    加入次数
@property (nonatomic, copy) NSString *joinCount;
///最终注册总金额
@property (nonatomic, copy) NSString *finishRatio;


///可用金额
@property (nonatomic,copy) NSString *avalibleAmount;
///平均出价数
@property (nonatomic,copy) NSString *averageBidCount;
///平均中标利率
@property (nonatomic,copy) NSString *averageBidInterest;
///投标数
@property (nonatomic,copy) NSString *bidCount;
///借算
@property (nonatomic,copy) NSString *borrowCount;
///显示时间
@property (nonatomic,copy) NSString *displayTime;
///赚取利息
@property (nonatomic,copy) NSString *earnInterest;
///预期年利率
@property (nonatomic,copy) NSString *expectedYearRate;
///融资余额
@property (nonatomic,copy) NSString *financeLeftAmount;
///资金使用率
@property (nonatomic,copy) NSString *fundsUseRate;
///加入
@property (nonatomic,copy) NSString *joined;
///锁天
@property (nonatomic, assign) int lockDays;

///过程比
@property (nonatomic,copy) NSString *processRatio;
///省
@property (nonatomic,copy) NSString *provinces;
///销售金额
@property (nonatomic,copy) NSString *saleAmount;
///地位
@property (nonatomic,copy) NSString *status;
///子点计数
@property (nonatomic,copy) NSString *subPointCount;
///string	计划倒计时
@property (nonatomic,copy) NSString *diffTime;


//MARK: -====================== 辅助字段 ============================
/**
 是否有优惠券
 */
@property (nonatomic, assign) BOOL hasCoupon;

@end

