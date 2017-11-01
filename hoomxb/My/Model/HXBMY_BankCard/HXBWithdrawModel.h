//
//  HXBWithdrawModel.h
//  hoomxb
//
//  Created by HXB-C on 2017/10/31.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXBBankCardModel;
@interface HXBWithdrawModel : NSObject
/**
 可用余额
 */
@property (nonatomic, assign) double balanceAmount;
/**
 银行卡模型
 */
@property (nonatomic, strong) HXBBankCardModel *bankCard;
/**
 提现处理中的个数
 */
@property (nonatomic, assign) int inprocessCount;

/**
 最小提现金额
 */
@property (nonatomic, assign) int minWithdrawAmount;

/**
 注册手机号
 */
@property (nonatomic, copy) NSString *mobileNumber;
@end
