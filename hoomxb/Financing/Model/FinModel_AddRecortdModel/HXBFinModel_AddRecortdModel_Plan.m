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
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"amount"]) {
        _amount_YUAN = [NSString stringWithFormat:@"%@,元",value];
    }
}
@end
