//
//  HXBMYModel_MianPlanModel.m
//  hoomxb
//
//  Created by HXB on 2017/5/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMYModel_MainPlanModel.h"
@implementation HXBMYModel_MainPlanModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"dataList":[HXBMYModel_MainPlanModel_DataList class],
             };
}
- (NSString *)description {
    return [self yy_modelDescription];
}
@end


@implementation HXBMYModel_MainPlanModel_DataList
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

- (NSString *)expectedSubsidyInterestAmount {
    if(_expectedSubsidyInterestAmount) {
        return [_expectedSubsidyInterestAmount notRounding:2];
    }
    return _expectedSubsidyInterestAmount;
}

- (NSString *)description {
    return [self yy_modelDescription];
}
@end
