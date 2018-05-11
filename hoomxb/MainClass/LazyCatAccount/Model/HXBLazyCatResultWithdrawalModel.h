//
//  HXBLazyCatResultWithdrawalModel.h
//  hoomxb
//
//  Created by caihongji on 2018/5/2.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBLazyCatResultPageModel.h"

@interface HXBLazyCatResultWithdrawalModel : HXBLazyCatResultPageModel
//金额
@property (nonatomic, assign) NSString *amount;
//证件号
@property (nonatomic, copy) NSString* cardNo;
//时间戳
@property (nonatomic, copy) NSString* arrivalTime;
//类型， WITHDRAW
@property (nonatomic, copy) NSString* businessType;
/// 银行类型
@property (nonatomic, copy) NSString *bankType;
@end
