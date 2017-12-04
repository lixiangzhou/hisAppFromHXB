//
//  HXBHTTPSessionManager.h
//  hoomxb
//
//  Created by lxz on 2017/12/4.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface NSDictionary (HXBResponse)
@property (nonatomic, strong, readonly) id data;
@property (nonatomic, copy, readonly) NSString *message;
@property (nonatomic, assign, readonly) NSInteger statusCode;
// status == kHXBCode_Success
@property (nonatomic, assign, readonly, getter=isSuccess) BOOL success;
@end

@interface HXBHTTPSessionManager : AFHTTPSessionManager

@end
