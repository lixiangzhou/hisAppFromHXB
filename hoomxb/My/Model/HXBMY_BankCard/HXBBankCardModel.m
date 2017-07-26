//
//  HXBBankCardModel.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/9.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBankCardModel.h"

@implementation HXBBankCardModel

- (NSString *)quota
{
    if ((self.single.length>0) && ![self.single isEqualToString:@"无"]) {
        _quota = [NSString stringWithFormat:@"单笔限额：%@，",self.single];
    }
    if ([self.single isEqualToString:@"无"]) {
        _quota = [NSString stringWithFormat:@"单笔限额：%@限额，",self.single];
    }
    if ((self.day.length>0) && ![self.day isEqualToString:@"无"]) {
        _quota = [NSString stringWithFormat:@"%@单日限额：%@，",_quota,self.day];
    }
    if ([self.day isEqualToString:@"无"]) {
        _quota = [NSString stringWithFormat:@"%@单日限额：%@限额，",_quota,self.day];
    }
    if (_quota.length <= 0) {
        _quota = @" ";
    }else
    {
        _quota = [_quota substringToIndex:_quota.length - 1];
    }
    return _quota;
    
}
@end
