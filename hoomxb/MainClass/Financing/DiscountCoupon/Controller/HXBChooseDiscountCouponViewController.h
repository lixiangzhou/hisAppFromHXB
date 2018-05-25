//
//  HXBChooseDiscountCouponViewController.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2017/10/25.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"

@class HXBCouponModel;
@class HXBChooseDiscountCouponViewController;

@protocol HXBChooseDiscountCouponViewControllerDelegate <NSObject>

- (void)chooseDiscountCouponViewController:(HXBChooseDiscountCouponViewController *)chooseDiscountCouponViewController didSendModel:(HXBCouponModel *)model;

@end

@interface HXBChooseDiscountCouponViewController : HXBBaseViewController

/** 产品id*/
@property (nonatomic, copy) NSString *planid;
/** 优惠券id*/
@property (nonatomic, copy) NSString *couponid;
/** 购买金额 */
@property (nonatomic, copy) NSString *investMoney;
/** 产品类型 */
@property (nonatomic, copy) NSString *type;
/** 是否勾选不使用优惠券 */
@property (nonatomic, assign) BOOL isSelectCoupon;
/** delegate */
@property (nonatomic, assign) id <HXBChooseDiscountCouponViewControllerDelegate> delegate;

@end
