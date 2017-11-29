//
//  NYBaseRequest+HXB.h
//  hoomxb
//
//  Created by lxz on 2017/11/29.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "NYBaseRequest.h"

@interface NSDictionary (HXBResponse)
@property (nonatomic, strong, readonly) id data;
@property (nonatomic, copy, readonly) NSString *message;
@property (nonatomic, assign, readonly) NSInteger statusCode;
// status == kHXBCode_Success
@property (nonatomic, assign, readonly, getter=isSuccess) BOOL success;
@end

@interface NYBaseRequest (HXB)

/*
 快速发送请求
 内部调用的是 requestWithRequestUrl:(NSString *)requestUrl param:(NSDictionary *)param method:(NYRequestMethod)method configRequestBlock:(void (^)(NYBaseRequest *request))configRequestBlock success:(SuccessBlock)success failure:(FailureBlock)failure
 */
+ (NYBaseRequest *)requestWithRequestUrl:(NSString *)requestUrl param:(NSDictionary *)param method:(NYRequestMethod)method success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 快速发送请求，可在 configRequestBlock 中配置request，添加其他的请求设置
 */
+ (NYBaseRequest *)requestWithRequestUrl:(NSString *)requestUrl param:(NSDictionary *)param method:(NYRequestMethod)method success:(SuccessBlock)success failure:(FailureBlock)failure configRequestBlock:(void (^)(NYBaseRequest *request))configRequestBlock;
@end
