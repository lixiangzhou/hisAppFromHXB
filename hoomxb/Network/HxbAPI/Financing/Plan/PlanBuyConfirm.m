//
//  PlanBuyConfirm.m
//  hoomxb
//
//  Created by HXB on 2017/4/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "PlanBuyConfirm.h"

//192.168.1.21:3000/plan/buy/confirm   POST   计划购买确认

@implementation PlanBuyConfirm
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/plan/buy/confirm";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodPost;
}

@end
