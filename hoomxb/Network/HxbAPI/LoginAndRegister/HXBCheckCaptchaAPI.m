//
//  HXBCheckCaptcha.m
//  hoomxb
//
//  Created by HXB on 2017/5/31.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBCheckCaptchaAPI.h"

@implementation HXBCheckCaptchaAPI
- (NSString *)requestUrl {
    return @"/checkCaptcha";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodPost;
}
@end
