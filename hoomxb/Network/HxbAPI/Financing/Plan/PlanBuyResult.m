//
//  PlanBuyResult.m
//  hoomxb
//
//  Created by HXB on 2017/4/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "PlanBuyResult.h"
//192.168.1.21:3000/plan/buy/result      POST   计划购买结果
@implementation PlanBuyResult
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/plan/buy/result";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodPost;
}

- (id)requestArgument {
    return @{
             };
}


@end
