//
//  HXBBaseRequestManager.m
//  hoomxb
//
//  Created by caihongji on 2017/12/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseRequestManager.h"
#import "NYBaseRequest.h"

@interface HXBBaseRequestManager()
// 线程锁
@property (nonatomic, strong) NSConditionLock* conditionLock;
// request列表
@property (nonatomic, strong) NSMutableArray* requestList;
//等待token获取结果的列表
@property (nonatomic, strong) NSMutableArray* waitTokenResultList;

@end

@implementation HXBBaseRequestManager

+ (instancetype)sharedInstance
{
    static HXBBaseRequestManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _conditionLock = [[NSConditionLock alloc] init];
        _requestList = [NSMutableArray array];
        _waitTokenResultList = [NSMutableArray array];
    }
    return self;
}

- (BOOL)isGettingToken
{
    BOOL result = NO;
    
    [self.conditionLock lock];
    
    if(self.waitTokenResultList.count > 0) {
        result = YES;
    }
    
    [self.conditionLock unlock];
    
    return result;
}

- (BOOL)isHasSendingRequest
{
    BOOL result = NO;
    
    [self.conditionLock lock];
    
    if(self.requestList.count > 0) {
        result = YES;
    }
    
    [self.conditionLock unlock];
    
    return result;
}

/**
 添加请求
 
 @param request 请求对象
 */
- (void)addRequest:(NYBaseRequest*)request
{
    [self.conditionLock lock];
    
    if(request.hudDelegate) {
        for(NYBaseRequest* base in self.requestList) {
            if([base defferRequest:request]) {
                [base cancelRequest];
                [self.requestList removeObject:base];
                [self.waitTokenResultList removeObject:base];
                break;
            }
        }
    }
    [self.requestList addObject:request];
    
    [self.conditionLock unlock];
}

/**
 删除请求
 
 @param request 请求对象
 @return 这个请求对象是否存在
 */
- (BOOL)deleteRequest:(NYBaseRequest*)request
{
    BOOL isFind = NO;
    
    [self.conditionLock lock];
    
    if([self.requestList containsObject:request]) {
        isFind = YES;
        [self.requestList removeObject:request];
    }
    
    [self.conditionLock unlock];
    
    return isFind;
}

/**
 添加需要重新获取令牌的请求
 
 @param request 请求对象
 */
- (void)addTokenInvalidRequest:(NYBaseRequest*)request
{
    [self.conditionLock lock];
    
    [self.waitTokenResultList addObject:request];
    
    [self.conditionLock unlock];
}

/**
 发送刷新令牌后的通知
 
 @param isSuccess 令牌是否成功刷新
 */
- (void)sendFreshTokenNotify:(BOOL)isSuccess
{
    [self.conditionLock lock];
    
    for(NYBaseRequest *base in self.waitTokenResultList) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_AfterFreshToken object:base.connection userInfo:@{@"result":@(isSuccess)}];
    }
    [self.waitTokenResultList removeAllObjects];
    
    [self.conditionLock unlock];
}

/**
 取消发送者发出的所有请求
 
 @param sender 请求发送者
 */
- (void)cancelRequest:(id)sender
{
    [self.conditionLock lock];
    
    for(NYBaseRequest* base in self.requestList) {
        if(base.hudDelegate && base.hudDelegate == sender) {
            [base cancelRequest];
        }
    }
    
    [self.conditionLock unlock];
}

/**
 sender是否正在发送请求
 
 @param sender 请求发送者
 */
- (BOOL)isSendingRequest:(id)sender
{
    BOOL result = NO;
    
    [self.conditionLock lock];
    
    for(NYBaseRequest* base in self.requestList) {
        if(base.hudDelegate && base.hudDelegate == sender) {
            result = YES;
            break;
        }
    }
    
    [self.conditionLock unlock];
    
    return result;
}
@end
