//
//  HXBMyPlanDetailsExitModel.h
//  hoomxb
//
//  Created by hxb on 2018/3/12.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBMyPlanDetailsExitModel : NSObject

/// 确认退出
@property (nonatomic,copy) NSString *endLockingTime; /// 计划退出时间
@property (nonatomic,copy) NSString *amount;/// 计划计入本金
@property (nonatomic,copy) NSString *earnInterestNow;/// 当前已赚
@property (nonatomic,copy) NSString *totalEarnInterest;/// 预期收益
@property (nonatomic,assign) BOOL isInLockPeriodQuit;/// 是否是锁定期内退出
@property (nonatomic,copy) NSString *quitDesc; /// "预计退出日之前均可撤销，期间会继续享有收益。"

/// 冷静期
@property (nonatomic,copy) NSString *coolingTime; /// 冷静期时间（分）
@property (nonatomic,copy) NSString *cancelAmount;  /// 计划计入本金
@property (nonatomic,copy) NSString *couponAmount; /// 使用优惠券金额
@property (nonatomic,copy) NSString *cancelTime; /// 取消时间
@property (nonatomic,copy) NSString *cancelBuyDesc; /// 取消计划描述
@property (nonatomic,copy) NSString *couponUseDesc; /// 优惠券使用描述


@end
