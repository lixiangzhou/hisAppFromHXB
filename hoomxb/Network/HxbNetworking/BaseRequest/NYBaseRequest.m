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
#import "HxbHUDProgress.h"
#import "SGInfoAlert.h"

@implementation NYBaseRequest

- (void)dealloc
{
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _requestMethod = NYRequestMethodGet;
        _timeoutInterval = 20;
    }
    return self;
}

- (instancetype)initWithDelegate:(id<HXBRequestHudDelegate>)delegate
{
    self = [self init];
    if (self) {
        self.hudDelegate = delegate;
    }
    return self;
}

- (NSDictionary *)httpHeaderFields{
    if (!_httpHeaderFields) {
        _httpHeaderFields = @{};
    }
    return _httpHeaderFields;
}

#pragma mark  以下为重构后需要使用的各种方法

- (NSString*)hudShowContent {
    if(!_hudShowContent) {
        _hudShowContent = [kLoadIngText copy];
    }
    return _hudShowContent;
}

/**
 比较是否是同一个请求
 
 @param request 比较对象
 @return YES：不同；反之。
 */
- (BOOL)defferRequest:(NYBaseRequest*)request
{
    if(self.hudDelegate && [self.requestUrl isEqualToString:request.requestUrl] && self.hudDelegate==request.hudDelegate && [self.requestArgument isEqual:request.requestArgument]) {
        return NO;
    }
    return YES;
}

/**
 显示加载框
 
 */
- (void)showLoading
{
    if([self.hudDelegate respondsToSelector:@selector(showProgress:)]){
        [self.hudDelegate showProgress:self.hudShowContent];
    }
}

/**
 隐藏加载框
 
 */
- (void)hideLoading
{
    if([self.hudDelegate respondsToSelector:@selector(hideProgress)]){
        [self.hudDelegate hideProgress];
    }
}
/**
 显示提示文本
 
 @param content 提示内容
 */
- (void)showToast:(NSString*)content
{
    if([self.hudDelegate respondsToSelector:@selector(showToast:)]){
        [self.hudDelegate showToast:content];
    }
}

/**
 请求数据
 
 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadData:(HXBRequestSuccessBlock)success failure:(HXBRequestFailureBlock)failure{
//#ifdef DEBUG
//    if([UIApplication sharedApplication].keyWindow) {
//        [SGInfoAlert showInfo:[NSString stringWithFormat:@"我是重构接口：%@", self.requestUrl] bgColor:[UIColor blackColor].CGColor inView:[UIApplication sharedApplication].keyWindow vertical:0.3];
//    }
//#endif
    self.success = success;
    self.failure = failure;
    [[NYNetworkManager sharedManager] addRequest:self];
}

/**
 取消请求
 */
- (void)cancelRequest
{
    [self.connection.task cancel];
}
@end
