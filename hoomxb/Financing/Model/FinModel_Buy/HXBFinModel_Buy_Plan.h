//
//  HXBFinModel_Buy_Plan.h
//  hoomxb
//
//  Created by HXB on 2017/6/16.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBFinModel_Buy_Plan : NSObject
///	int	计划产品ID
@property (nonatomic,copy) NSString *ID;
///	int	期限
@property (nonatomic,copy) NSString *lockPeriod;
///	String	预期收益
@property (nonatomic,copy) NSString *expectedAmount;
///	String	预期年利率
@property (nonatomic,copy) NSString *expectedRate;
///	String	购买金额
@property (nonatomic,copy) NSString *amountStr;
///String	计划产品名称
@property (nonatomic,copy) NSString *name;
@end
