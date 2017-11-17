//
//  HXBMY_PlanModel_LoanRecordModel.h
//  hoomxb
//
//  Created by HXB on 2017/6/28.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
///交易记录的model
@interface HXBMY_PlanModel_LoanRecordModel : NSObject
/**
 	投资金额
 */
@property (nonatomic,copy) NSString * amount;///": 6500,
/**
 
 */
@property (nonatomic,copy) NSString * ID;//": 6500,
/**
 	投资时间
 */
@property (nonatomic,copy) NSString * lendTime;///": 6500,
/**
 	散标id
 */
@property (nonatomic,copy) NSString * loanId;///": 6500,
/**
 状态
 */
@property (nonatomic,copy) NSString * status;///": 6500,
/**
 新状态（收益中，转出中，已结清）
 */
@property (nonatomic,copy) NSString *statusText;
/**
 待转让金额
 */
@property (nonatomic, copy) NSString *rollOutleft;
@end
