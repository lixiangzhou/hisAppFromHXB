//
//  HXBTenderDetailModel.h
//  hoomxb
//
//  Created by lxz on 2018/1/19.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBTenderDetailModel : NSObject
/// 标的名称
@property (nonatomic, copy) NSString *title;

/// 年利率
@property (nonatomic, copy) NSString *interest;

/// 标的金额
@property (nonatomic, copy) NSString *amount;

/// 期限
@property (nonatomic, copy) NSString *months;

/// 等级
@property (nonatomic, copy) NSString *riskLevel;

/// id
@property (nonatomic, copy) NSString *loanId;

@end
