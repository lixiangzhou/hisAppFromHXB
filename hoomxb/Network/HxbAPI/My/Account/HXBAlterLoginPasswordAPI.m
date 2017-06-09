//
//  HXBAlterLoginPasswordAPI.m
//  hoomxb
//
//  Created by HXB on 2017/6/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBAlterLoginPasswordAPI.h"

@implementation HXBAlterLoginPasswordAPI
- (NSString *)requestUrl {
    return @"/checkIdentityAuth";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodPost;
}
@end
