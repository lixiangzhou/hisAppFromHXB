//
//  HXBFin_LoanTruansfer_BuyResoutViewModel.m
//  hoomxb
//
//  Created by HXB on 2017/7/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_LoanTruansfer_BuyResoutViewModel.h"

@implementation HXBFin_LoanTruansfer_BuyResoutViewModel
/**
 投资金额
 */
- (NSString *)buyAmount_new {
    if (self.buyAmount) {
        _buyAmount_new = [NSString hxb_getPerMilWithDouble:self.buyAmount.floatValue];
    }
    return _buyAmount_new;
}

/**
 实际买入本金
 */
- (NSString *)principal_new {
    if (self.principal) {
        _principal_new = [NSString hxb_getPerMilWithDouble:self.principal.floatValue];
    }
    return _principal_new;
}
/**
 公允利息
 */
- (NSString *)interest_new {
    if (self.interest) {
        _interest_new = [NSString hxb_getPerMilWithDouble:self.interest.floatValue];
    }
    return _interest_new;
}

/**
 下一还款日
 */
- (NSString *)nextRepayDate_new {
    if (self.nextRepayDate) {
        _nextRepayDate_new = [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:self.nextRepayDate andDateFormat:@"yyyy-MM-dd"];
    }
    return _nextRepayDate_new;
}
@end
