//
//  HxbIndexPlanListAPI.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbIndexPlanListAPI.h"

@implementation HxbIndexPlanListAPI

- (NSString *)requestUrl {
    return @"/financeplan/queryForIndexUplanListNew.action";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodGet;
}
@end
