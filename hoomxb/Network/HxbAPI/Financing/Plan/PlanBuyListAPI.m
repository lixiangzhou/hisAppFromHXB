//
//  PlanBuyListAPI.m
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "PlanBuyListAPI.h"
//192.168.1.21:3000/plan/list 红利计划列表
@implementation PlanBuyListAPI
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/plan/list";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodPost;
}

- (id)requestArgument {
    return @{
             };
}

@end
