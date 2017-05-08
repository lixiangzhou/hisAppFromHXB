//
//  HXBFinanctingModel_HomePage.h
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBFinHomePageModel_PlanList : NSObject
//MARK: ======================= 目前返回字段 ==========================

///总金额,本期开放的额度,计划金额（元）
@property (nonatomic,copy) NSString *amount;
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
///红利计划ID
@property (nonatomic,copy) NSString *ID;
///加入
@property (nonatomic,copy) NSString *joined;
///锁天
@property (nonatomic,copy) NSString *lockDays;
///锁定期限(月),计划期限
@property (nonatomic,copy) NSString *lockPeriod;
///计划名称
@property (nonatomic,copy) NSString *name;
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



//MARK: -====================== 未知字段 ============================
///最终注册总金额
@property (nonatomic,copy) NSString *finishRatio;
///开始预定时间
@property (nonatomic,copy) NSString *beginSellingTime;
///统一的状态
@property (nonatomic,copy) NSString *unifyStatus;
///注册金额起点
@property (nonatomic,copy) NSString *minRegisterAmount;
///本期基准利率
@property (nonatomic,copy) NSString *baseInterestRate;

///财务状况
@property (nonatomic,copy) NSString *financeStatus;
///U计划分类
@property (nonatomic,copy) NSString *category;
///本期加息利率
@property (nonatomic,copy) NSString *extraInterestRate;
///加入人次
@property (nonatomic,copy) NSString *joinCount;
///U计划预期年化收益率
@property (nonatomic,copy) NSString *expectedRate;
@end

