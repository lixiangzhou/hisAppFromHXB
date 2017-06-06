//
//  HXBFinancing_PlanDetaileAPI.m
//  hoomxb
//
//  Created by HXB on 2017/5/9.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinancing_PlanDetaileAPI.h"
///192.168.1.21:8070/financeplan/financeplandetail.action
@implementation HXBFinancing_PlanDetaileAPI
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"/plan/%ld",self.planID];
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodGet;
}

//- (id)requestArgument {
//    return @{
//             @"version" : @"1.0",
//             @"userId" : @"1",
//             @"financePlanId" : @"1",
//             @"platform" : @"IOS"
//             };
//}
@end
