//
//  HXBFinModel_AddRecortdModel_Plan.m
//  hoomxb
//
//  Created by HXB on 2017/5/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinModel_AddRecortdModel_Plan.h"

@implementation HXBFinModel_AddRecortdModel_Plan
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"dataList":[HXBFinModel_AddRecortdModel_Plan_dataList class],
             };
}
@end

@implementation HXBFinModel_AddRecortdModel_Plan_dataList

- (void)setAmount:(NSString *)amount {
    _amount = amount;
    _amount = [NSString hxb_getPerMilWithDouble:amount.floatValue];
    _amount_YUAN = _amount;
}

- (void)setJoinTime:(NSString *)joinTime {
    _joinTime = joinTime;
    _hxb_joinTime = [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:joinTime andDateFormat:@"yyyy-MM-dd  HH:mm"];
}
//- (void)setNickName:(NSString *)nickName {
//    _nickName = nickName;
//    if (nickName.length >= 6) {
//        _hxb_nickName = [NSString hiddenStr:nickName MidWithFistLenth:3 andLastLenth:4];
//    }else {
//        _hxb_nickName = nickName;
//    }
//}

@end
