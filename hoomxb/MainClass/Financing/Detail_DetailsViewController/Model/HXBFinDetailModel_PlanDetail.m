//
//  HXBFinDetailModel_PlanDetail.m
//  hoomxb
//
//  Created by HXB on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinDetailModel_PlanDetail.h"

@implementation HXBFinDetailModel_PlanDetail;
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"dataList":[HXBFinDetailModel_PlanDetail_DataList class]};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"ID" : @"id"
             };
}

//- (NSString *)potRemainAmount {
//    return [NSString hxb_getPerMilWithIntegetNumber:[self.remainAmount floatValue]];
//}
//
//-(NSString *)potUserRemainAmount {
//    return [NSString hxb_getPerMilWithIntegetNumber:[self.userRemainAmount floatValue]];
//}

- (NSString *)cashType {
    if (!_cashType) {
        _cashType = @"INVEST";
    }
    return _cashType;
}
- (NSString *)showExtendLockPeriod {
    if (_lockPeriod.length) {
        if ([_novice isEqualToString:@"1"]) {
            return [NSString stringWithFormat:@"%@个月", _lockPeriod];
        }
        return [NSString stringWithFormat:@"%@个月", _extendLockPeriod];
    }
    if (_lockDays) {
        return [NSString stringWithFormat:@"%@天", _lockDays];
    }
    return  @"--";
}
@end

@implementation HXBFinDetailModel_PlanDetail_DataList
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}
@end
