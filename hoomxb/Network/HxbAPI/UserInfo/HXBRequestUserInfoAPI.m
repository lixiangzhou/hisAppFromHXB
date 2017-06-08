//
//  HXBRequestUserInfoAPI.m
//  hoomxb
//
//  Created by HXB on 2017/5/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRequestUserInfoAPI.h"

@implementation HXBRequestUserInfoAPI



- (NSString *)requestUrl {
    return @"/user/info";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodGet;
}
@end

