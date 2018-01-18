//
//  HXBMYModel_Plan_planRequestModel.h
//  hoomxb
//
//  Created by HXB on 2017/6/30.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBMYModel_Plan_planRequestModel : NSObject
/**
 持有中
 */
@property (nonatomic,copy) NSString * currentPlanAmount;

///	string	退出中
@property (nonatomic,copy) NSString * exitingCount;
///	string	已退出
@property (nonatomic,copy) NSString * exitCount;
///	string	持有资产
@property (nonatomic,copy) NSString * assets;
///	string	累计收益
@property (nonatomic,copy) NSString * sumPlanInterest;
///	string	当前持有笔数
@property (nonatomic,copy) NSString * currentPlanCount;
@property (nonatomic,copy) NSString * exitFee;
///": false,
@property (nonatomic,copy) NSString * hasEverInvestFinancePlan;
@property (nonatomic,copy) NSString * ID;

@property (nonatomic,copy) NSString * joinFee;

@property (nonatomic,copy) NSString * lastUpdateTime;

@property (nonatomic,copy) NSString * rate;

@property (nonatomic,copy) NSString * serviceFee;

///": "FINANCE_PLAN",
@property (nonatomic,copy) NSString * subPointType;
@property (nonatomic,copy) NSString * sumBidCount;
@property (nonatomic,copy) NSString * sumInterestReinvestedAmount;
@property (nonatomic,copy) NSString * sumPlanAmount;
@property (nonatomic,copy) NSString * sumPlanCount;
@property (nonatomic,copy) NSString * total;
@property (nonatomic,copy) NSString * totalOverdueDays;
@property (nonatomic,copy) NSString * userId;
@property (nonatomic,copy) NSString * version;
@end
