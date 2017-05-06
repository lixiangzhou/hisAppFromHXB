//
//  HXBFinancing_planList.m
//  hoomxb
//
//  Created by HXB on 2017/5/6.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinancing_planListAPI.h"

@implementation HXBFinancing_planListAPI
//192.168.1.21:8070/financeplan/queryForIndexUplanListNew.action 红利计划列表
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/financeplan/queryForIndexUplanListNew.action";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodPost;
}

- (id)requestArgument {
    return@{
            @"version" : @"1.0",
            @"userId" : @"1",
            @"start" : @(1),
            @"num" : @"20",
            @"pageNumber" : @1,
            @"pageSize" : @(20)//每页的个数
            };
}

@end
