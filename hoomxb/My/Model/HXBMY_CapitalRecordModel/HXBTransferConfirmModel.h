//
//  HXBTransferConfirmModel.h
//  hoomxb
//
//  Created by HXB-C on 2017/9/21.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBTransferConfirmModel : NSObject

/**
 总期数
 */
@property (nonatomic, assign) int termsInTotal;

/**
 预计回收金额
 */
@property (nonatomic, copy) NSString *expectRecoveryAmount;
/**
 剩余期数
 */
@property (nonatomic, assign) int termsLeft;
/**
 当前债权价值
 */
@property (nonatomic, copy) NSString *currentTransValue;
/**
 预计手续费
 */
@property (nonatomic, copy) NSString *transFee;

/**
 债权id
 */
@property (nonatomic, assign) int loanId;

/**
 费率
 */
@property (nonatomic, assign) double rate;

@end
