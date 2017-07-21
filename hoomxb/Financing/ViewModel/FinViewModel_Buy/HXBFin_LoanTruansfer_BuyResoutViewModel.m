//
//  HXBFin_LoanTruansfer_BuyResoutViewModel.m
//  hoomxb
//
//  Created by HXB on 2017/7/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_LoanTruansfer_BuyResoutViewModel.h"

@implementation HXBFin_LoanTruansfer_BuyResoutViewModel
/**
 投资金额
 */
- (NSString *)buyAmount {
    if (!_buyAmount) {
        _buyAmount = [NSString hxb_getPerMilWithDouble:self.loanTruansferModel.buyAmount.floatValue];
    }
    return _buyAmount;
}

/**
 实际买入本金
 */
- (NSString *)principal {
    if (!_principal) {
        _principal = [NSString hxb_getPerMilWithDouble:self.loanTruansferModel.principal.floatValue];
    }
    return _principal;
}
/**
 公允利息
 */
- (NSString *)interest {
    if (!_interest) {
        _interest = [NSString stringWithFormat:@"%.2lf",self.loanTruansferModel.interest.floatValue];
    }
    return _interest;
}
/**
 是否当期已还：
 1为已还，
 0为未还
 */
- (BOOL)isRepayed {
    return self.loanTruansferModel.isRepayed;
}
@end
