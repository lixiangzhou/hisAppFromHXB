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
    return [NSString stringWithFormat:@"plan/%@",self.planID];
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodGet;
}
@end
