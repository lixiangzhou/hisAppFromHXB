//
//  HXBCaptchaAPI.m
//  hoomxb
//
//  Created by HXB on 2017/5/31.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBCaptchaAPI.h"

@implementation HXBCaptchaAPI

- (NSString *)requestUrl {
    return @"/captcha";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodGet;
}
@end
