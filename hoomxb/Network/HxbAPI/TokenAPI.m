
//
//  TokenAPI.m
//  NetWorkingTest
//
//  Created by HXB-C on 2017/3/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "TokenAPI.h"

@implementation TokenAPI

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/token";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodGet;
}

@end
