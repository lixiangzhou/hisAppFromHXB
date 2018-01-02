//
//  HXBFinRecommendListBaseModel.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/1/2.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBFinRecommendListBaseModel : NSObject
// 锁定期限(月),计划期限
@property (nonatomic, copy) NSString *lockPeriod;
// 开始销售时间
@property (nonatomic, copy) NSString *beginSellingTime;
// 最小注册金额
@property (nonatomic, copy) NSString *minRegisterAmount;
// 基础利率
@property (nonatomic, copy) NSString *baseInterestRate;
// 计划状态
@property (nonatomic, copy) NSString *unifyStatus;
// 分类
@property (nonatomic, copy) NSString *category;
///    string    本期加息利率
@property (nonatomic, copy) NSString *extraInterestRate;
///    string    加入次数
@property (nonatomic, copy) NSString *joinCount;
///    string    年化利率
@property (nonatomic, copy) NSString *expectedRate;
///    string    计划名称
@property (nonatomic, copy) NSString *name;
///    string    计划id
@property (nonatomic,copy) NSString *ID;
///string    计划倒计时
@property (nonatomic, copy) NSString *diffTime;
@property (nonatomic, assign) BOOL showMoneyOff;
@property (nonatomic, assign) BOOL showDiscount;
///最终注册总金额
@property (nonatomic, copy) NSString *finishRatio;
//提示文案右边的提示文案
@property (nonatomic, copy) NSString *tag;
///总金额,本期开放的额度,计划金额（元）
@property (nonatomic, copy) NSString *amount;
///财务状况
@property (nonatomic, copy) NSString *financeStatus;
/**
 销售截止时间
 账户外：
 1、    销售截止时间之前，如果满额：【已满额】。
 2、    到销售截止时间之后，锁定期之前：【销售结束】。
 */
@property (nonatomic, assign) double endSellingTime;

@property (nonatomic, copy) NSString *beginResellingTime;

@property (nonatomic, assign) double lastDays;
// 还款方式
@property (nonatomic, copy) NSString *featuredSlogan;
/**
 是否有可用抵扣券
 */
@property (nonatomic, assign) BOOL hasDiscountCoupon;
/**
 是否有可用满减券
 */
@property (nonatomic, assign) BOOL hasMoneyOffCoupon;
@property (nonatomic, copy) NSString *cashType;
@property (nonatomic, copy) NSString *cashDrawDay;
@end
