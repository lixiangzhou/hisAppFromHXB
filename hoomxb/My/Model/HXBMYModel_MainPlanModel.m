//
//  HXBMYModel_MianPlanModel.m
//  hoomxb
//
//  Created by HXB on 2017/5/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMYModel_MainPlanModel.h"
@implementation HXBMYModel_MainPlanModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"dataList":[HXBMYModel_MainPlanModel_DataList class],
             };
}
@end


@implementation HXBMYModel_MainPlanModel_DataList
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}
@end
