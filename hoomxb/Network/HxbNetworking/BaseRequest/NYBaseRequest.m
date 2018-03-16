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
    request.showHud = self.showHud;
    request.success = [self.success copy];
    request.failure = [self.failure copy];
    
    return request;
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
 
 @param hudContent 显示的文本内容
 */
- (void)showLoading:(NSString*)hudContent
{
    if([self.hudDelegate respondsToSelector:@selector(showProgress:)]){
        [self.hudDelegate showProgress:hudContent];
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
#ifdef DEBUG
    if([UIApplication sharedApplication].keyWindow) {
        [SGInfoAlert showInfo:[NSString stringWithFormat:@"我是重构接口：%@", self.requestUrl] bgColor:[UIColor blackColor].CGColor inView:[UIApplication sharedApplication].keyWindow vertical:0.3];
    }
#endif
    self.isNewRequestWay = YES;
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
