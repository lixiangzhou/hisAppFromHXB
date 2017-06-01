//
//  HXBCheckMobile.m
//  hoomxb
//
//  Created by HXB on 2017/5/31.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBCheckMobileAPI.h"

@implementation HXBCheckMobileAPI
- (NSString *)requestUrl {
    return @"/checkMobile";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodPost;
}
@end
