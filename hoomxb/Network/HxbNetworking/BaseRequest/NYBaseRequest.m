//
//  NYBaseRequest.m
//  NYNetwork
//
//  Created by 牛严 on 16/6/28.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import "NYBaseRequest.h"
#import "NYHTTPConnection.h"
#import "NYNetworkManager.h"

@implementation NYBaseRequest

- (NSDictionary *)httpHeaderFields{
    if (!_httpHeaderFields) {
        _httpHeaderFields = @{};
    }
    return _httpHeaderFields;
}

//----------------------------------response------------------------------------

//- (NSInteger)responseStatusCode{
//    NSHTTPURLResponse *response = (NSHTTPURLResponse *)self.connection.task.response;
//    return response.statusCode;
//}

//- (NSDictionary *)responseHeaderFieldValueDictionary{
//    NSHTTPURLResponse *response = (NSHTTPURLResponse *)self.connection.task.response;
//    return response.allHeaderFields;
//}

//-----------------------------------funtion--------------------------------------
- (void)start{
    [self startWithHUD:nil];
}

- (void)startWithHUD:(NSString *)str
{
    [[NYNetworkManager sharedManager] addRequest:self withHUD:str];
 
}

- (void)startWithAnimation
{
    [[NYNetworkManager sharedManager] addRequestWithAnimation:self];
}

- (void)startWithSuccess:(HXBRequestSuccessBlock)success failure:(HXBRequestFailureBlock)failure{
    self.success = [success copy];
    self.failure = [failure copy];
    [self start];
}

- (void)startWithHUDStr:(NSString *)string Success:(HXBRequestSuccessBlock)success failure:(HXBRequestFailureBlock)failure{
    self.success = [success copy];
    self.failure = [failure copy];
    [self startWithHUD:string];
}

- (void)startAnimationWithSuccess:(HXBRequestSuccessBlock)success failure:(HXBRequestFailureBlock)failure{
    self.success = [success copy];
    self.failure = [failure copy];
    [self startWithAnimation];
}

- (NYBaseRequest *)copyRequest {
    NYBaseRequest *request = [NYBaseRequest new];
    
    request.requestMethod = self.requestMethod;
    request.requestUrl = self.requestUrl;
    request.baseUrl = self.baseUrl;
    request.requestArgument = self.requestArgument;
    request.httpHeaderFields = self.httpHeaderFields;
    request.timeoutInterval = self.timeoutInterval;
    request.success = [self.success copy];
    request.failure = [self.failure copy];
    request.customCodeSuccessBlock = [self.customCodeSuccessBlock copy];
    request.customCodeFailureBlock = [self.customCodeFailureBlock copy];
    
    return request;
}

@end
