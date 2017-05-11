//
//  HXBFinDetailModel_PlanDetail.m
//  hoomxb
//
//  Created by HXB on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinDetailModel_PlanDetail.h"

@implementation HXBFinDetailModel_PlanDetail;
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"dataList":[HXBFinDetailModel_PlanDetail_DataList class]};
}
@end

@implementation HXBFinDetailModel_PlanDetail_DataList
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id" : @"ID"};
}
@end
