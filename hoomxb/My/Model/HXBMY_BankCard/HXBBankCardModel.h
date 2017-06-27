//
//  HXBBankCardModel.h
//  hoomxb
//
//  Created by HXB-C on 2017/6/9.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBBankCardModel : NSObject
/**
 银行编码
 */
@property (nonatomic, copy) NSString *bankCode;
/**
 银行名称
 */
@property (nonatomic, copy) NSString *bankType;
/**
 银行卡号
 */
@property (nonatomic, copy) NSString *cardId;
/**
 所属银行城市
 */
@property (nonatomic, copy) NSString *city;
/**
 创建时间
 */
@property (nonatomic, copy) NSString *createTime;

/**
 是非是默认银行卡
 */
@property (nonatomic, assign) BOOL *defaultBank;
/**
 存款地点
 */
@property (nonatomic, copy) NSString *deposit;
/**
 name
 */
@property (nonatomic, copy) NSString *name;
/**
 province
 */
@property (nonatomic, copy) NSString *province;
/**
 status
 */
@property (nonatomic, copy) NSString *status;
/**
 userBankId
 */
@property (nonatomic, copy) NSString *userBankId;
/**
 userId
 */
@property (nonatomic, copy) NSString *userId;

/**
 提现金额
 */
@property (nonatomic, copy) NSString *amount;
/**
 到账时间
 */
@property (nonatomic, copy) NSString *arrivalTime;
@end
