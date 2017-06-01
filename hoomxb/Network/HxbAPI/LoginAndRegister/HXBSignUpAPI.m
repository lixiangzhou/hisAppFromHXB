//
//  SignUpAPI.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/2.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBSignUpAPI.h"

@implementation HXBSignUpAPI

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/user/signup";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodPost;
}
/**
mobile	是	string	手机号
smscode	是	string	短信验证码
password	是	string	密码
inviteCode	否	string	邀请码
*/
@end
