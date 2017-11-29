//
//  NYBaseRequest+HXB.h
//  hoomxb
//
//  Created by lxz on 2017/11/29.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "NYBaseRequest.h"

@interface NSDictionary (HXB)
@property (nonatomic, strong, readonly) id data;
@property (nonatomic, copy, readonly) NSString *message;
@property (nonatomic, assign, readonly) NSInteger statusCode;
// status == kHXBCode_Success
@property (nonatomic, assign, readonly, getter=isSuccess) BOOL success;
@end

@interface NYBaseRequest (HXB)
+ (NYBaseRequest *)requestWithRequestUrl:(NSString *)requestUrl param:(NSDictionary *)param method:(NYRequestMethod)method success:(SuccessBlock)success failure:(FailureBlock)failure;
@end
