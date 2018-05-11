//
//  HXBLazyCatResultBuyModel.m
//  hoomxb
//
//  Created by caihongji on 2018/5/2.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBLazyCatResultBuyModel.h"

@implementation HXBLazyCatResultBuyModel

/**
 投资金额
 */
- (NSString *)buyAmount_new {
    _buyAmount_new = self.buyAmount ? [NSString hxb_getPerMilWithDouble:self.buyAmount.floatValue] : @"--";
    return _buyAmount_new;
}

/**
 实际买入本金
 */
- (NSString *)principal_new {
    _principal_new = self.principal ? [NSString hxb_getPerMilWithDouble:self.principal] : @"--";
    return _principal_new;
}
/**
 公允利息
 */
- (NSString *)interest_new {
    _interest_new = self.interest ? [NSString hxb_getPerMilWithDouble:self.interest] : @"--";
    return _interest_new;
}

/**
 下一还款日
 */
- (NSString *)nextRepayDate_new {
    _nextRepayDate_new = self.nextRepayDate ? [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:self.nextRepayDate andDateFormat:@"yyyy-MM-dd"] : @"--";
    return _nextRepayDate_new;
}

@end
