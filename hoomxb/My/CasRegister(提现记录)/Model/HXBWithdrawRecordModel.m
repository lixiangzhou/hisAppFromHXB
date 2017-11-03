//
//  HXBWithdrawRecordModel.m
//  hoomxb
//
//  Created by HXB-C on 2017/10/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBWithdrawRecordModel.h"

@implementation HXBWithdrawRecordModel

- (BOOL)isBlueColor {
    _isBlueColor = [self.status isEqualToString:@"INPROCESS"] || [self.status isEqualToString:@"UNKNOW"];
    return _isBlueColor;
}


- (NSString *)bankLastNum {
    _bankLastNum = [NSString stringWithFormat:@"（尾号%@）",[self.bankNum substringFromIndex:self.bankNum.length - 4]];
    return _bankLastNum;
}

- (NSString *)applyTimeStr {
    _applyTimeStr = [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:self.applyTime andDateFormat:@"yyyy-MM-dd HH:mm"];
    return _applyTimeStr;
}
- (NSString *)cashAmount {
    _cashAmount = [NSString stringWithFormat:@"%.2lf",_cashAmount.doubleValue];
    return _cashAmount;
}

@end
