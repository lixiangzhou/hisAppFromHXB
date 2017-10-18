//
//  HXBMYModel_AssetStatistics_Plan.h
//  hoomxb
//
//  Created by HXB on 2017/5/22.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
///plan资金统计，没有model
@interface HXBMYModel_AssetStatistics_Plan : NSObject
///持有中
@property (nonatomic,copy) NSString *currentPlanCount;
///退出中
@property (nonatomic,copy) NSString *exitingCount;
///已退出
@property (nonatomic,copy) NSString *exitCount;
///持有资产
@property (nonatomic,copy) NSString *assets;
///累计收益
@property (nonatomic,copy) NSString *sumPlanInterest;
///当前持有笔数
@property (nonatomic,copy) NSString *currentPlanAmount;//
@property (nonatomic,copy) NSString *exitFee;//
@property (nonatomic,copy) NSString *hasEverInvestFinancePlan;//false
@property (nonatomic,copy) NSString *ID;//
@property (nonatomic,copy) NSString *joinFee;//
@property (nonatomic,copy) NSString *lastUpdateTime;/// 1493729160000
@property (nonatomic,copy) NSString *rate;//
@property (nonatomic,copy) NSString *serviceFee;//
@property (nonatomic,copy) NSString *subPointType;///@"FINANCE_PLAN",
@property (nonatomic,copy) NSString *sumBidCount;//
@property (nonatomic,copy) NSString *sumInterestReinvestedAmount;//
@property (nonatomic,copy) NSString *sumPlanAmount;
@property (nonatomic,copy) NSString *sumPlanCount;
@property (nonatomic,copy) NSString *total;
@property (nonatomic,copy) NSString *totalOverdueDays;
@property (nonatomic,copy) NSString *userId;
@property (nonatomic,copy) NSString *version;
@end
