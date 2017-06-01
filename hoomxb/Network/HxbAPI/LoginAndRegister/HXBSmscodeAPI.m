//
//  HXBSmscode.m
//  hoomxb
//
//  Created by HXB on 2017/5/31.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBSmscodeAPI.h"

@implementation HXBSmscodeAPI
- (NSString *)requestUrl {
    return @"/send/smscode";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodPost;
}
@end
