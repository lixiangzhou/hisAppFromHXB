//
//  HXBFinModel_Buy_LoanModel.h
//  hoomxb
//
//  Created by HXB on 2017/6/21.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBFinModel_Buy_LoanModel : NSObject
///投标资金
@property (nonatomic,copy) NSString *bidAmount;
///余额
@property (nonatomic,copy) NSString *balance;
///月份
@property (nonatomic,copy) NSString *months;
///利息
@property (nonatomic,copy) NSString *interest;
/// loan type": "DEBX",
@property (nonatomic,copy) NSString *loanType;
/// 月收益 ": 88.85
@property (nonatomic,copy) NSString *monthReturn;
@end
