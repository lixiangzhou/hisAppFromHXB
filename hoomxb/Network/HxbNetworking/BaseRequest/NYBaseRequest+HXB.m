//
//  NYBaseRequest+HXB.m
//  hoomxb
//
//  Created by lxz on 2017/11/29.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "NYBaseRequest+HXB.h"

@implementation NSDictionary (HXB)
- (id)data {
    return self[kResponseData];
}

- (NSString *)message {
    return self[kResponseMessage];
}

- (NSInteger)statusCode {
    return [self[kResponseStatus] integerValue];
}

- (BOOL)isSuccess {
    return self.statusCode == kHXBCode_Success;
}
@end

@implementation NYBaseRequest (HXB)

+ (NYBaseRequest *)requestWithRequestUrl:(NSString *)requestUrl param:(NSDictionary *)param method:(NYRequestMethod)method success:(SuccessBlock)success failure:(FailureBlock)failure;
{
    NYBaseRequest *request = [NYBaseRequest new];
    request.requestUrl = requestUrl;
    request.requestArgument = param;
    request.requestMethod = method;
    [request startWithSuccess:success failure:failure];
    return request;
}

@end
