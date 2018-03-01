//
//  HXBBaseRequestManager.h
//  hoomxb
//
//  Created by caihongji on 2017/12/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBBaseRequestManager : NSObject
//当前是否正在获取令牌
@property (nonatomic, assign, readonly) BOOL isGettingToken;
//是否有正在进行的请求
@property (nonatomic, assign, readonly) BOOL isHasSendingRequest;

+ (instancetype)sharedInstance;

/**
 添加请求

 @param request 请求对象
 */
- (void)addRequest:(NYBaseRequest*)request;

/**
 删除请求

 @param request 请求对象
 @return 这个请求对象是否存在
 */
- (BOOL)deleteRequest:(NYBaseRequest*)request;

/**
 当前是否存在相同的请求实例，如果存在，则请求不能发出

 @param request 请求对象
 @return 是否存在
 */
- (BOOL)sameRequestInstance:(NYBaseRequest*)request;

/**
 添加需要重新获取令牌的请求

 @param request 请求对象
 */
- (void)addTokenInvalidRequest:(NYBaseRequest*)request;

/**
 发送刷新令牌后的通知

 @param isSuccess 令牌是否成功刷新
 */
- (void)sendFreshTokenNotify:(BOOL)isSuccess;

/**
 取消发送者发出的所有请求

 @param sender 请求发送者
 */
- (void)cancelRequest:(id)sender;

/**
 sender是否正在发送请求
 
 @param sender 请求发送者
 */
- (BOOL)isSendingRequest:(id)sender;


@end
