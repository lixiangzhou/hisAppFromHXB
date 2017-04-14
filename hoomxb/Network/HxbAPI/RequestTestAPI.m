//
//  RequestTestAPI.m
//  NetWorkingTest
//
//  Created by HXB-C on 2017/3/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "RequestTestAPI.h"
//#define REQUEST_URL @"http://192.168.1.227:9000/list"
@implementation RequestTestAPI
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/api/user/signupPost";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodPost;
}

- (id)requestArgument {
    return @{
             
             };
}

@end
