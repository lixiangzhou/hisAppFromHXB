//
//  NYNetworkManager.m
//  NYNetwork
//
//  Created by 牛严 on 16/6/28.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import "NYNetworkManager.h"
#import "NYHTTPConnection.h"
#import "HxbHUDProgress.h"

@implementation NYNetworkManager

+ (instancetype)sharedManager
{
    static NYNetworkManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)addRequest:(NYBaseRequest *)request
{
    [self addRequest:request withHUD:nil];
}

- (void)addRequest:(NYBaseRequest *)request withHUD:(NSString *)content
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // 适配重构前的HUD
    HxbHUDProgress *hud = nil;
    if (request.hudDelegate == nil) {
        HxbHUDProgress *hud = (content.length) ? [HxbHUDProgress new] : nil;
        [hud showAnimationWithText:content];
    }
    NSLog(@"%@",request.httpHeaderFields);
    
  
    NYHTTPConnection *connection = [[NYHTTPConnection alloc]init];
    [connection connectWithRequest:request success:^(NYHTTPConnection *connection, id responseJsonObject) {
        // 适配重构前的HUD
        if (request.hudDelegate == nil) {
            [hud hide];
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self processConnection:connection withRequest:request responseJsonObject:responseJsonObject];
    } failure:^(NYHTTPConnection *connection, NSError *error) {
        // 适配重构前的HUD
        if (request.hudDelegate == nil) {
            [hud hide];
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self processConnection:connection withRequest:request error:error];
    }];
}

- (void)addRequestWithAnimation:(NYBaseRequest *)request
{
    // 适配重构前的HUD
    HxbHUDProgress *hud = nil;
    if (request.hudDelegate == nil) {
        hud = [HxbHUDProgress new];
        [hud showAnimation];
    }
    
    NYHTTPConnection *connection = [[NYHTTPConnection alloc]init];
    [connection connectWithRequest:request success:^(NYHTTPConnection *connection, id responseJsonObject) {
        // 适配重构前的HUD
        if (request.hudDelegate == nil) {
            [hud hide];
        }
        [self processConnection:connection withRequest:request responseJsonObject:responseJsonObject];
    } failure:^(NYHTTPConnection *connection, NSError *error) {
        // 适配重构前的HUD
        if (request.hudDelegate == nil) {
            [hud hide];
        }
        [self processConnection:connection withRequest:request error:error];
    }];
}

- (void)processConnection:(NYHTTPConnection *)connection withRequest:(NYBaseRequest *)request responseJsonObject:(id)responseJsonObject
{
    request.responseObject = responseJsonObject;
    [self callBackRequestSuccess:request];
}

- (void)processConnection:(NYHTTPConnection *)connection withRequest:(NYBaseRequest *)request error:(NSError *)error
{
    request.error = error;
    [self callBackRequestFailure:request];
}

//--------------------------------------------回调--------------------------------------------
/**
 *  成功回调
 */
- (void)callBackRequestSuccess:(NYBaseRequest *)request
{
    if (request.success) {
        if (request.customCodeSuccessBlock) {
            request.customCodeSuccessBlock(request,request.responseObject);
        } else {
            [self defaultMethodRequestSuccessWithRequest:request];
        }
        request.success(request,request.responseObject);
    }
    [self clearRequestBlock:request];
}

/**
 *  失败回调
 */
- (void)callBackRequestFailure:(NYBaseRequest *)request
{    
    if (request.failure) {
        if (request.customCodeFailureBlock) {
            request.customCodeFailureBlock(request,request.error);
        } else {
            [self defaultMethodRequestFaulureWithRequest:request];
        }
        request.failure(request,request.error);
    }

    [self clearRequestBlock:request];
}

- (void)clearRequestBlock:(NYBaseRequest *)request
{
    request.success = nil;
    request.failure = nil;
}

//---------------------------------在回调中默认执行方法，在扩展中重写--------------------------
- (void)defaultMethodRequestSuccessWithRequest:(NYBaseRequest *)request {
    
}

- (void)defaultMethodRequestFaulureWithRequest:(NYBaseRequest *)request {
}

@end
