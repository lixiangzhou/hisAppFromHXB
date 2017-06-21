//
//  HxbHomePageModel_DataList.h
//  hoomxb
//
//  Created by HXB-C on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 name               计划名称
 lockPeriod         锁定期限
 expectedRate		预期年化收益率
 unifyStatus		状态
 tag                活动文案
 baseInterestRate	基础利率
 extraInterestRate	加息利率
 diffTime           倒计时时间差
 */
@interface HxbHomePageModel_DataList : NSObject

/**
 计划名称
 */
@property (nonatomic, copy) NSString *name;
/**
 锁定期限
 */
@property (nonatomic, copy) NSString *lockPeriod;
/**
 预期年化收益率
 */
@property (nonatomic, copy) NSString *expectedRate;
/**
 状态
 */
@property (nonatomic, copy) NSString *unifyStatus;
/**
 活动文案
 */
@property (nonatomic, copy) NSString *tag;
/**
 基础利率
 */
@property (nonatomic, copy) NSString *baseInterestRate;
/**
 加息利率
 */
@property (nonatomic, copy) NSString *extraInterestRate;
/**
 倒计时时间差
 */
@property (nonatomic, copy) NSString *diffTime;

/**
 id
 */
@property (nonatomic, copy) NSString *ID;
@end
