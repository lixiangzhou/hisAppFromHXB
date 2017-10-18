//
//  HXBFinModel_BuyResout_LoanTruansferModel.h
//  hoomxb
//
//  Created by HXB on 2017/7/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseModel.h"

@interface HXBFinModel_BuyResout_LoanTruansferModel : HXBBaseModel
/**
 状态
 */
@property (nonatomic,copy) NSString * status;
/**
 投资金额
 */
@property (nonatomic,copy) NSString * buyAmount;
/**
 实际买入本金
 */
@property (nonatomic,copy) NSString * principal;
/**
 公允利息
 */
@property (nonatomic,copy) NSString * interest;
/**
 是否当期已还：
 1为已还，
 0为未还
 */
@property (nonatomic,assign) BOOL isRepayed;
/**
 下一个还款日
 */
@property (nonatomic,copy) NSString *nextRepayDate;
@end
