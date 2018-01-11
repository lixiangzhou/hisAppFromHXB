//
//  NYHTTPConnection.h
//  NYNetwork
//
//  Created by 牛严 on 16/6/28.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NYBaseRequest.h"

@class NYHTTPConnection;

typedef void (^HXBConnectionSuccessBlock)(NYHTTPConnection *connection, id responseJsonObject);
typedef void (^HXBConnectionFailureBlock)(NYHTTPConnection *connection, NSError *error);


///网络数据的请求
@interface NYHTTPConnection : NSObject

@property (atomic, strong, readonly) NSURLSessionDataTask *task;

- (void)connectWithRequest:(NYBaseRequest *)request success:(HXBConnectionSuccessBlock)success failure:(HXBConnectionFailureBlock)failure;
- (void)tokenUpdateNotify:(NYBaseRequest *)request updateState:(BOOL)isSuccess;
@end
