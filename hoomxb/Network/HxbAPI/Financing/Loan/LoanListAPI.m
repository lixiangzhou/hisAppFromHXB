//
//  LoanListAPI.m
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "LoanListAPI.h"
//192.168.1.21:3000/loan/list 散标列表
@implementation LoanListAPI
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/loan/list";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodGet;
}

- (id)requestArgument {
    return @{
             };
}

@end
