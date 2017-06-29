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
    CGFloat balance = self.capitalRecordModel.balance.floatValue;
    self.balance = [NSString stringWithFormat:@"账户余额%.2f元",balance];
}


- (NSString *)balance {
    if (!_balance) {
        [self setUPBalance];
    }
    return _balance;
}
- (NSString *)time {
    if (!_time) {
        _time = [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:self.capitalRecordModel.time andDateFormat:@"yy-mm-dd hh:mm"];
    }
    return _time;
}

/**
 收入金额  （支出金额为负数）
 */
- (NSString *) income {
    if (!_income) {
        ///	是否是收入
        if (self.capitalRecordModel.isPlus) {
            CGFloat inComeFloat = self.capitalRecordModel.income.floatValue;
            self.inComeStrColor = [UIColor redColor];
            _income = [NSString stringWithFormat:@"%.2f",inComeFloat];
        }else {
            CGFloat pay = self.capitalRecordModel.pay.floatValue;
            _income = [NSString stringWithFormat:@"%.2f",pay];
            self.inComeStrColor = [UIColor blueColor];
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
