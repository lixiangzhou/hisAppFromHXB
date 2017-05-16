//
//  HXBFinancing_PlanAddRecortdAPI.m
//  hoomxb
//
//  Created by HXB on 2017/5/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinancing_PlanAddRecortdAPI.h"
///理财模块的加入记录接口
@implementation HXBFinancing_PlanAddRecortdAPI
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/financeplan/financeplanalllenders.action";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodPost;
}
@end
