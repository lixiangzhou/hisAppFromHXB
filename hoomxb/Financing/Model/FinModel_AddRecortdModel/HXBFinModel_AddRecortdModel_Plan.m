//
//  HXBFinModel_AddRecortdModel_Plan.m
//  hoomxb
//
//  Created by HXB on 2017/5/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
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
    _amount_YUAN = [NSString stringWithFormat:@"%@元",amount];
}

- (void)setJoinTime:(NSString *)joinTime {
    _joinTime = joinTime;
    _hxb_joinTime = [[HXBBaseHandDate sharedHandleDate] stringFromDate:joinTime andDateFormat:@"yyyy-MM-dd  HH:mm"];
}
- (void)setNickName:(NSString *)nickName {
    _nickName = nickName;
    if (nickName.length >= 6) {
        NSString *str = [nickName substringWithRange:NSMakeRange(0, 3)];
        NSString *strLast = [nickName substringWithRange:NSMakeRange(nickName.length - 2, 2)];
        NSMutableString *strMid = @"".mutableCopy;
        for (NSInteger i = (nickName.length - 5); i > 0; i --) {
            [strMid appendString:@"*"];
        }
        _hxb_nickName = [NSString stringWithFormat:@"%@%@%@",str,strMid,strLast];
    }else {
        _hxb_nickName = nickName;
    }
}

@end
