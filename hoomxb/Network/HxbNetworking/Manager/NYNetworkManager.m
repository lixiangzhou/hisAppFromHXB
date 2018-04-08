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
#import "HXBBaseRequestManager.h"

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
    //防止同一个
    if([[HXBBaseRequestManager sharedInstance] sameRequestInstance:request]){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (request.failure) {
                NSError* erro = [NSError errorWithDomain:@"" code:kHXBCode_AlreadyPopWindow userInfo:nil];
                request.failure(request, erro);
            }
        });
        return;
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // 显示HUD
    if(request.showHud) {
        [request showLoading];
    }
    
    [[HXBBaseRequestManager sharedInstance] addRequest:request];
    NYHTTPConnection *connection = [[NYHTTPConnection alloc]init];
    
    __weak typeof (request) weakRequest = request;
    [connection connectWithRequest:request success:^(NYHTTPConnection *connection, id responseJsonObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self processConnection:connection withRequest:weakRequest responseJsonObject:responseJsonObject];
    } failure:^(NYHTTPConnection *connection, NSError *error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self processConnection:connection withRequest:weakRequest error:error];
    }];
}

- (void)processConnection:(NYHTTPConnection *)connection withRequest:(NYBaseRequest *)request responseJsonObject:(id)responseJsonObject
{
    if([[HXBBaseRequestManager sharedInstance] deleteRequest:request]) {
        // 适配重构前的HUD
        if(request.showHud) {
            [request hideLoading];
        }
        
        request.responseObject = responseJsonObject;
        [self callBackRequestSuccess:request];
    }
}

- (void)processConnection:(NYHTTPConnection *)connection withRequest:(NYBaseRequest *)request error:(NSError *)error
{
    if([[HXBBaseRequestManager sharedInstance] deleteRequest:request]) {
        // 适配重构前的HUD
        if(request.showHud) {
            [request hideLoading];
        }
        
        request.error = error;
        [self callBackRequestFailure:request];
    }
}

//--------------------------------------------回调--------------------------------------------
/**
 *  成功回调
 */
- (void)callBackRequestSuccess:(NYBaseRequest *)request
{
    if (request.success) {
        if([request.hudDelegate respondsToSelector:@selector(erroStateCodeDeal:)]) {
            if([request.hudDelegate erroStateCodeDeal:request]) {
                if(request.failure) {
                    request.responseObject = nil;
                    NSError* erro = [NSError errorWithDomain:@"" code:kHXBCode_AlreadyPopWindow userInfo:nil];
                    request.failure(request, erro);
                    return;
                }
            }
        }
        NSDictionary* responseDic = request.responseObject;
        NSString* codeValue = [responseDic stringAtPath:@"status"];
        if(![codeValue isEqualToString:@"0"]) {
            if(request.failure) {
                request.failure(request, [NSError errorWithDomain:@"" code:kHXBCode_CommonInterfaceErro userInfo:request.responseObject]);
                return;
            }
        }
        request.success(request,request.responseObject);
    }
}

/**
 *  失败回调
 */
- (void)callBackRequestFailure:(NYBaseRequest *)request
{    
    if (request.failure) {
        if([request.hudDelegate respondsToSelector:@selector(erroResponseCodeDeal:)]) {
            if([request.hudDelegate erroResponseCodeDeal:request]) {
                NSError* erro = [NSError errorWithDomain:@"" code:kHXBCode_AlreadyPopWindow userInfo:nil];
                request.failure(request, erro);
                return;
            }
        }
        
        if(!request.error) {
            request.error = [NSError errorWithDomain:@"" code:kHXBCode_AlreadyPopWindow userInfo:nil];
        }
        request.failure(request,request.error);
    }
}
@end
