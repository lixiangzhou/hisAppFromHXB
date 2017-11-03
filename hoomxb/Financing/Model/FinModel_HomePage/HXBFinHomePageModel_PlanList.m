//
//  HXBFinanctingModel_HomePage.m
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinHomePageModel_PlanList.h"

@implementation HXBFinHomePageModel_PlanList
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

- (BOOL)hasCoupon {
    if (self.hasDiscountCoupon || self.hasMoneyOffCoupon) {
        _hasCoupon = YES;
    } else {
         _hasCoupon = NO;
    }
    return _hasCoupon;
}

@end
