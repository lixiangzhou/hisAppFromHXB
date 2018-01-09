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
    return @{@"ID" : @"id"};
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

@end

@implementation HXBFinDetailModel_PlanDetail_DataList
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}
@end
