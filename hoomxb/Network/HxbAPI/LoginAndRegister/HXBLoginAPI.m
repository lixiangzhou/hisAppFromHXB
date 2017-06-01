//
//  LoginAPI.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBLoginAPI.h"

@implementation HXBLoginAPI
{
    NSString *_userName;
    NSString *_loginPwd;
}

- (id)initWithUserName:(NSString *)userName loginPwd:(NSString *)loginPwd
{
    self = [super init];
    if (self) {
        _userName = userName;
        _loginPwd = (loginPwd.length)?loginPwd:@"";
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/user/login";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodPost;
}
@end
