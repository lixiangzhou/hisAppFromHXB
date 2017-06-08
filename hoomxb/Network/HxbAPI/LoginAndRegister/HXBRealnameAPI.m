//
//  HXBRealnameAPI.m
//  hoomxb
//
//  Created by HXB on 2017/6/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRealnameAPI.h"

@implementation HXBRealnameAPI
- (NSString *)requestUrl {
    return @"/user/realname";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodPost;
}
@end
