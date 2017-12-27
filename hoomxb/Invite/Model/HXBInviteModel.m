//
//  HXBInviteModel.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2017/11/9.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBInviteModel.h"

@implementation HXBInviteModel

- (NSString *)registTime_new {
    if (!_registTime_new) {
        _registTime_new = [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:[NSString stringWithFormat:@"%lf", self.registTime] andDateFormat:@"yyyy-MM-dd"];
    }
    return _registTime_new;
}



@end
