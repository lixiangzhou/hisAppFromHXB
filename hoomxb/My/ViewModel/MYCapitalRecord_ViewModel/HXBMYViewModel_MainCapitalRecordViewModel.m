//
//  HXBMYViewModel_MainCapitalRecordViewModel.m
//  hoomxb
//
//  Created by HXB on 2017/5/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMYViewModel_MainCapitalRecordViewModel.h"
#import "HXBMYModel_CapitalRecordDetailModel.h"
@implementation HXBMYViewModel_MainCapitalRecordViewModel

- (void)setCapitalRecordModel:(HXBMYModel_CapitalRecordDetailModel *)capitalRecordModel {
    _capitalRecordModel = capitalRecordModel;
    [self setUPBalance];
}
- (void)setUPBalance {
    NSString *balance = self.capitalRecordModel.balance;
    self.balance = [NSString stringWithFormat:@"账户余额%@元",balance];
}


- (NSString *)balance {
    if (!_balance) {
        [self setUPBalance];
    }
    return _balance;
}
- (NSString *)time {
    if (!_time) {
        _time = [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:self.capitalRecordModel.time andDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return _time;
}

/**
 收入金额  （支出金额为负数）
 */
- (NSString *) income {
    if (!_income) {
        ///	是否是收入
        NSString *incomeStr = nil;
        if ([self.capitalRecordModel.isPlus isEqualToString:@"false"]) {
            CGFloat pay = self.capitalRecordModel.pay.floatValue;
            incomeStr = [NSString hxb_getPerMilWithDouble:pay];
            _income = [NSString stringWithFormat:@"- %@",incomeStr];
            self.inComeStrColor = COLOR(113,203,97,1);
        }else {
            CGFloat inComeFloat = self.capitalRecordModel.income.floatValue;
            self.inComeStrColor = COLOR(245, 81, 81, 1);
            incomeStr = [NSString hxb_getPerMilWithDouble:inComeFloat];
            _income = [NSString stringWithFormat:@"+ %@", incomeStr];
        }
    }
    return _income;
}
/**
  income 颜色
 */
- (UIColor *)inComeStrColor  {
    if (!_inComeStrColor) {
        [self income];
    }
    return _inComeStrColor;
}


@end
