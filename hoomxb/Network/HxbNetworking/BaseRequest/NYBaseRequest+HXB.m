//
//  NYBaseRequest+HXB.m
//  hoomxb
//
//  Created by lxz on 2017/11/29.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "NYBaseRequest+HXB.h"

@implementation NYBaseRequest (HXB)

+ (NYBaseRequest *)requestWithRequestUrl:(NSString *)requestUrl param:(NSDictionary *)param method:(NYRequestMethod)method success:(HXBRequestSuccessBlock)success failure:(HXBRequestFailureBlock)failure;
{
    return [self requestWithRequestUrl:requestUrl param:param method:method success:success failure:failure configRequestBlock:nil];
}

+ (NYBaseRequest *)requestWithRequestUrl:(NSString *)requestUrl param:(NSDictionary *)param method:(NYRequestMethod)method success:(HXBRequestSuccessBlock)success failure:(HXBRequestFailureBlock)failure configRequestBlock:(void (^)(NYBaseRequest *))configRequestBlock
{
    NYBaseRequest *request = [NYBaseRequest new];
    request.requestUrl = requestUrl;
    request.requestArgument = param;
    request.requestMethod = method;
    
    if (configRequestBlock) {
        configRequestBlock(request);
    }
    
    [request loadData:success failure:failure];
    
    return request;
}

@end
