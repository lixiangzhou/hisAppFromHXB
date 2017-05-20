//
//  HXBRequestAPI_MYPlanDetailAPI.m
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRequestAPI_MYPlanDetailAPI.h"

@implementation HXBRequestAPI_MYPlanDetailAPI
- (NSString *)requestUrl {
    return @"/financeplan/my_plan_detail.action";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodPost;
}
@end
