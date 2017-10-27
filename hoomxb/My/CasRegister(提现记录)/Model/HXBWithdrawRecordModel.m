//
//  HXBWithdrawRecordModel.m
//  hoomxb
//
//  Created by HXB-C on 2017/10/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBWithdrawRecordModel.h"

@implementation HXBWithdrawRecordModel

- (BOOL)isBlueColor
{
    _isBlueColor = [self.cashDrawStatus isEqualToString:@"CASHDRAW_IN_PROCESS"];
    return _isBlueColor;
}

@end
