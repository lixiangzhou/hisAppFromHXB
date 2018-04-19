//
//  HXBCardBinModel.h
//  hoomxb
//
//  Created by HXB-C on 2017/9/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBCardBinModel : NSObject

/**
 卡类型（debit：储蓄卡 credit：信用卡）
 */
@property (nonatomic, copy) NSString *cardType;
/**
 银行编码
 */
@property (nonatomic, copy) NSString *bankCode;
/**
 银行名称
 */
@property (nonatomic, copy) NSString *bankName;
/**
 银行提现限额
 */
@property (nonatomic, copy) NSString *quota;

/**
 是否为信用卡
 */
@property (nonatomic, assign) BOOL creditCard;

/**
 是否是支持的银行
 */
//@property (nonatomic, assign) BOOL support;

/***************新增属性*********************/
/**
 是否为储蓄卡
 */
//@property (nonatomic, assign) BOOL isDebit;

@end
