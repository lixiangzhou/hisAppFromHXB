//
//  HXBMYModel_PlanDetailModel.m
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMYModel_PlanDetailModel.h"

@implementation HXBMYModel_PlanDetailModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

- (NSString *)expectedSubsidyInterestAmount {
    if(_expectedSubsidyInterestAmount) {
        return [_expectedSubsidyInterestAmount notRounding:2];
    }
    return _expectedSubsidyInterestAmount;
}
@end
