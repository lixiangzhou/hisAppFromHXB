//
//  HXBMyCouponListModel.h
//  hoomxb
//
//  Created by hxb on 2017/10/31.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBMyCouponListModel : NSObject

/** 允许使用的业务范围*/
@property (nonatomic, copy) NSString *allowBusinessCategory;
/** 优惠券类型*/
@property (nonatomic, copy) NSString *couponType;
/** 运营文案*/
@property (nonatomic, copy) NSString *tag;
/** 生效时间*/
@property (nonatomic, assign) long activeTime;
/** 失效时间*/
@property (nonatomic, assign) long expireTime;
/** 抵扣率*/
@property (nonatomic, copy) NSString *dicountRate;
/** 满减券 减500元*/
@property (nonatomic, copy) NSString *derateAmount;
/** 抵扣券最少投资金额*/
@property (nonatomic, copy) NSString *minInvestAmount;
/** 满减券最小投资金额*/
@property (nonatomic, copy) NSString *allowDerateInvest;
/** 最大抵扣金额*/
@property (nonatomic, copy) NSString *maxDiscountAmount;
/** 计划id和投资金额算出来的实际减免金额*/
@property (nonatomic, copy) NSString *valueActual;
/** 状态 AVAILABLE未使用,FROZEN冻结中,USED已使用,DISABLED已作废*/
@property (nonatomic, copy) NSString *status;
/** 是否最优优惠券*/
@property (nonatomic, assign) BOOL best;
/** 是否最优优惠券*/
@property (nonatomic, copy) NSString *ID;

#pragma mark ---  杨老板拼接好的字段
/** 优惠券类型文本 ‘满减券’,’抵扣券’*/
@property (nonatomic, copy) NSString *couponTypeText;
/** 状态文本:’未使用’,’冻结中’,’已使用’,’已作废’*/
@property (nonatomic, copy) NSString *statusText;
/** 是否适用标的*/
@property (nonatomic, assign) BOOL isForLoan;
/** 是否适用计划*/
@property (nonatomic, assign) BOOL isForPlan;
/** 是否适用债权转让*/
@property (nonatomic, assign) BOOL isForTransfer;
/** ‘散标 债权 红利计划’*/
@property (nonatomic, copy) NSString *forProductText;
/** ‘(1/3/个月)’*/
@property (nonatomic, copy) NSString *forProductLimit;
/** 是否被用于了标的*/
@property (nonatomic, assign) BOOL isUsedForLoan;
/** 是否被用于了计划*/
@property (nonatomic, assign) BOOL isUsedForPlan;
/** 是否被用于了债权转让*/
@property (nonatomic, assign) BOOL isUsedForTransfer;
@property (nonatomic, copy) NSString *summaryTitle;
@property (nonatomic, copy) NSString *summarySubtitle;
@property (nonatomic, copy) NSString *summaryContent;

@end
