//
//  HXBMYModel_PlanDetailModel.h
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>



/// 我的 界面的 红利计划详情页的Model
@interface HXBMYModel_PlanDetailModel : NSObject
///对应的账户外的详情的状态 (能不能购买)
@property (nonatomic,assign) kHXBEnum_Fin_Plan_UnifyStatus unifyStatus;
///
@property (nonatomic,copy) NSString *remainAmount;
///用户的可投金额
@property (nonatomic,copy) NSString *userRemainAmount;
///递增
@property (nonatomic,copy) NSString *registerMultipleAmount;
/**
 加入金额
 */
@property (nonatomic,copy) NSString * finalAmount;
///	string	计划名称
@property (nonatomic,copy) NSString *name;
///	string	已获收益
@property (nonatomic,copy) NSString *earnAmount;
///	string	预期收益率 新手产品基础利率也取此字段）
@property (nonatomic,copy) NSString *expectedRate;
///	string	投资期限
@property (nonatomic,copy) NSString *lockPeriod;
///	string	退出时间
@property (nonatomic,copy) NSString *endLockingTime;
///	string	完成时间
@property (nonatomic,copy) NSString *redFinishTime;
///	string	待转让金额
@property (nonatomic,copy) NSString *redProgressLeft;
///	string	计入金额
@property (nonatomic,copy) NSString *amount;

///	string	处理方式 （HXB：当日提取至红小宝账户，INVEST：收益再投资）
@property (nonatomic,copy) NSString *cashType;

///	string	加入时间
@property (nonatomic,copy) NSString *registerTime;

///	string	预期收益
@property (nonatomic,copy) NSString *totalInterest;
///	string	状态（PURCHASE_END：收益中，PURCHASEING：等待计息）
@property (nonatomic,copy) NSString *status;
// 退出方式
@property (nonatomic,copy) NSString *exitWay;
///	Int	剩余天数
@property (nonatomic,copy) NSString *lastDays;
/// 按月付息日
@property (nonatomic, copy) NSString *cashDrawDay;
/// 收益方式文案，文案规则：HXB返回：按月付息，INVEST返回：收益复投
@property (nonatomic, copy) NSString *incomeApproach;
/// interestDate 按月付息日具体文案，拼接规则：每月+cashDrawDay+日付息
@property (nonatomic, copy) NSString *interestDate;

@property (nonatomic, copy) NSString *subsidyInterestRate;///贴息收益率
@property (nonatomic, copy) NSString *expectedSubsidyInterestAmount;///贴息预期收益
@property (nonatomic, copy) NSString *novice;///新手标志(1:是 0:否)
@property (nonatomic, copy) NSString *lockDays;///新手计划锁定期/天

@property (nonatomic,copy) NSString *type;//": "HOLD_PLAN",
@property (nonatomic,copy) NSString *isUseCoupon;//": "0",
@property (nonatomic,copy) NSString *contractUrl;//": "http://172.16.3.27:28131/account/wapContract.action?type=uplan",
@property (nonatomic,copy) NSString *ID;//": "156688",
@property (nonatomic,copy) NSString *category;//": "A",

@property (nonatomic,copy) NSString *subPointId;//": "1291978",
@property (nonatomic,copy) NSString *contractName;//": "理财计划服务协议"

#pragma mark --- 2.6.0计划退出新增字段
@property (nonatomic,copy) NSString *quitStatus;    // 退出状态
@property (nonatomic,copy) NSString *quitDate;      // 退出日期
@property (nonatomic,copy) NSString *repealDate;    // 可撤销退出截止日期
@property (nonatomic,copy) NSString *quitSubTitle;  // button副标题。


@end

/*
 "data": {
 "remainAmount": "900.0",
 "redProgressLeft": "0",
 "type": "HOLD_PLAN",
 "endLockingTime": "1543481700000",
 "registerTime": "1516354134000",
 "isUseCoupon": "0",
 "amount": "100.0",
 "id": "355",
 "expectedRate": "10.30",
 "name": "新手 180119期gtfrgtrf",
 "userRemainAmount": "9900.00",
 "subPointId": "9957",
 "subsidyInterestRate": "0.0",
 "exitWay": "正常退出",
 "lockPeriod": "10",
 "singleMaxRegisterAmount": "10000.0",
 "earnAmount": "0.0",
 "novice": "1",
 "expectedSubsidyInterestAmount": "0.00",
 "status": "PURCHASEING",
 "cashType": "INVEST",
 "totalInterest": "8.6528800707235004",
 "contractUrl": "/account/wapContract.action?type=uplan",
 "category": "B",
 "registerMultipleAmount": "100",
 "diffTime": -1516358313183,
 "featuredSlogan": "收益复投",
 "hasDiscountCoupon": false,
 "hasMoneyOffCoupon": false,
 "lastDays": 313,
 "incomeApproach": "收益复投",
 "quitStatus": "QUIT"，
 "quitDate":"1495852295000",
 "repealDate":"1495852295000",
 "quitSubTitle": "（继续持有依然可以享受当前年化收益）"
 }

*/
