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
    [self setUPPay];
    [self setUPTime];
    [self setUPBalance];
}
- (void)setUPBalance {
    CGFloat balance = self.capitalRecordModel.balance.floatValue;
    self.balance = [NSString stringWithFormat:@"账户余额%.2f元",balance];
}
- (void)setUPTime {
    HXBBaseHandDate *handDate = [HXBBaseHandDate sharedHandleDate];
    _time = [handDate stringFromDate:self.capitalRecordModel.time andDateFormat:nil];
}
- (void)setUPPay {
    CGFloat pay = self.capitalRecordModel.pay.floatValue;
    _pay = [NSString stringWithFormat:@"%.2f元",pay];
}
- (NSString *)balance {
    if (!_balance) {
        [self setUPBalance];
    }
    return _balance;
}
- (NSString *)time {
    if (!_time) {
        [self setUPTime];
    }
    return _time;
}

- (NSString *)pay {
    if (!_pay) {
        [self setUPPay];
    }
    return _pay;
}
@end
