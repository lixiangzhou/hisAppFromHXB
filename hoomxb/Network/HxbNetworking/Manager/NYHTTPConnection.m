    //
//  NYHTTPConnection.m
//  NYNetwork
//
//  Created by 牛严 on 16/6/28.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import "NYHTTPConnection.h"
#import "NYNetworkConfig.h"

#import "HXBTokenModel.h"
#import <objc/runtime.h>
#import "HXBRootVCManager.h"
#import "HXBBaseRequestManager.h"

#define Config [NYNetworkConfig sharedInstance]

@interface NYHTTPConnection ()

@property (atomic, strong, readwrite) NSURLSessionDataTask *task;

@property (nonatomic, copy) HXBConnectionSuccessBlock success;

@property (nonatomic, copy) HXBConnectionFailureBlock failure;

@property (nonatomic, copy) NSString* requestToken;

@end

@implementation NYHTTPConnection

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/// 配置及处理 sessionManager
- (void)connectWithRequest:(NYBaseRequest *)request success:(HXBConnectionSuccessBlock)success failure:(HXBConnectionFailureBlock)failure
{
    self.success = success;
    self.failure = failure;
    
    //现在的初始化代码
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];

    //-------------------------------------------request----------------------------------------
    // 超时
    manager.requestSerializer.timeoutInterval = request.timeoutInterval > 0 ? request.timeoutInterval : [NYNetworkConfig sharedInstance].defaultTimeOutInterval;
    
    // cookie
    [manager.requestSerializer setHTTPShouldHandleCookies:NO];
    
    // 请求头
    NSDictionary *headers = [self headerFieldsValueWithRequest:request];
    [headers enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
        [manager.requestSerializer setValue:value forHTTPHeaderField:field];
    }];
    
    // statusCode contentType
    manager.responseSerializer.acceptableStatusCodes = Config.defaultAcceptableStatusCodes;
    manager.responseSerializer.acceptableContentTypes = Config.defaultAcceptableContentTypes;
    
    // URL
    NSString *urlString = @"";
    if (request.baseUrl.length) {
        urlString = [NSURL URLWithString:request.requestUrl relativeToURL:[NSURL URLWithString:request.baseUrl]].absoluteString;
    } else {
        urlString = [NSURL URLWithString:request.requestUrl relativeToURL:[NSURL URLWithString:Config.baseUrl]].absoluteString;
    }
    // 参数
    NSDictionary *parameters = request.requestArgument;
    // 设置回调
    void (^successBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self setResponseWithRequest:request task:task responseObj:responseObject error:nil];
        [self requestHandleSuccess:request responseObject:responseObject];
    };
    
    void (^failureBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self setResponseWithRequest:request task:task responseObj:nil error:error];
        [self requestHandleFailure:request error:error];
    };
    
    NSURLSessionDataTask *task = nil;
    switch (request.requestMethod) {
        case NYRequestMethodGet: { task = [manager GET:urlString parameters:parameters progress:nil success:successBlock failure:failureBlock]; break; }
        case NYRequestMethodPost: { task = [manager POST:urlString parameters:parameters progress:nil success:successBlock failure:failureBlock]; break; }
        case NYRequestMethodPut: { task = [manager PUT:urlString parameters:parameters success:successBlock failure:failureBlock]; break; }
        case NYRequestMethodDelete: { task = [manager DELETE:urlString parameters:parameters success:successBlock failure:failureBlock]; break; }
    }
    self.requestToken = KeyChain.token;
    self.task = task;
    request.connection = self;
}

- (void)requestHandleSuccess:(NYBaseRequest *)request responseObject:(id)object
{
    //判断是否需要延时处理
    NSTimeInterval interval = [request leftDelayInterval];
    if (interval > 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.success) {
                self.success(self, object);
            }
        });
    }
    else{
        if (self.success) {
            self.success(self, object);
        }
    }
}

- (void)requestHandleFailure:(NYBaseRequest *)request error:(NSError *)error
{
    NSInteger responseCode = [self responseCode:self.task];
    if ([self checkSingleLogin:responseCode]) {
        [self processSingleLoginWithRequest:request];
    } else {
        if (self.failure) {
            self.failure(self, error);
        }
    }
    
}

#pragma mark - Helper
/// 请求头字段配置
- (NSDictionary *)headerFieldsValueWithRequest:(NYBaseRequest *)request
{
    NSMutableDictionary *headers = [Config.additionalHeaderFields mutableCopy];
    
    [request.httpHeaderFields enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [headers setObject:obj forKey:key];
    }];
    return headers;
}

/// 设置请求的 Response 信息
- (void)setResponseWithRequest:(NYBaseRequest *)request task:(NSURLSessionDataTask *)task responseObj:(NSDictionary *)responseObj error:(NSError *)error {
    request.responseStatusCode = [self responseCode:task];
    request.responseAllHeaderFields = [self allHeaderFields:task];
    request.responseObject = responseObj;
    request.error = error;
}


- (NSInteger)responseCode:(NSURLSessionDataTask *)task {
    return ((NSHTTPURLResponse *)task.response).statusCode;
}

- (NSDictionary *)allHeaderFields:(NSURLSessionDataTask *)task {
    return ((NSHTTPURLResponse *)task.response).allHeaderFields;
}

#pragma mark - Single Login
/// 检查是否进行单点处理
- (BOOL)checkSingleLogin:(NSInteger)responseCode {
    return responseCode == kHXBCode_Enum_TokenNotJurisdiction;
}

/// 单点登录处理
- (void)processSingleLoginWithRequest:(NYBaseRequest *)request {
    if(![self.requestToken isEqualToString:KeyChain.token]) {
        //令牌已经被更新过, 重发请求
        dispatch_async(dispatch_get_main_queue(), ^{
            [self connectWithRequest:request success:self.success failure:self.failure];
        });
    }
    else{
        if(![HXBBaseRequestManager sharedInstance].isGettingToken) {
            //当前没有正在获取令牌的请求
            
            [KeyChain removeToken];
            [self refreshAccessToken:^(NSString *token) {
                BOOL result = NO;
                if (token) {
                    KeyChain.token = token;
                    result = YES;
                    
                }
                [[HXBBaseRequestManager sharedInstance] sendFreshTokenNotify:result];
            }];
        }
        
        [[HXBBaseRequestManager sharedInstance] addTokenInvalidRequest:request];
    }
    
}

- (void)tokenUpdateNotify:(NYBaseRequest *)request updateState:(BOOL)isSuccess
{
    if (isSuccess) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self processTokenInvidate];
            
            if ([HXBRootVCManager manager].mainTabbarVC.selectedViewController.childViewControllers.count > 1) {
                if (self.failure) {
                    request.error = [NSError errorWithDomain:request.error.domain code:kHXBCode_Enum_ConnectionTimeOut userInfo:@{@"message":@"连接超时"}];
                    self.failure(request.connection, nil);
                }
            } else {
                [self connectWithRequest:request success:self.success failure:self.failure];
            }
        });
    } else {
        if (self.failure) {
            request.error = [NSError errorWithDomain:request.error.domain code:kHXBCode_Enum_ConnectionTimeOut userInfo:@{@"message":@"连接超时"}];
            
            self.failure(request.connection, request.error);
        }
    }
}

/// 重新请求token
- (void)refreshAccessToken:(void(^)(NSString *token))refresh{
    NSString *tokenURLString = [NSString stringWithFormat:@"%@%@",[NYNetworkConfig sharedInstance].baseUrl,TOKENURL];
    NSURL *tokenURL =[NSURL URLWithString:tokenURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:tokenURL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      if (!data) {
                                          refresh(nil);
                                          return ;
                                      }
                                      NSDictionary *dict = [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil] objectForKey:@"data"];
                                      HXBTokenModel *model = [HXBTokenModel yy_modelWithJSON:dict];
                                      refresh(model.token);
                                  }];
    [task resume];
}

/// token 失效回到首页
- (void)processTokenInvidate {
    // token 失效，静态登出并回到首页
    if (KeyChain.isLogin) {
        /// 退出登录，清空登录信息，回到首页
        KeyChain.isLogin = NO;
        
        //单点登出之后dismiss最上层可能会有的控制器
        [[HXBRootVCManager manager].mainTabbarVC.presentedViewController dismissViewControllerAnimated:NO completion:nil];
        // 静态显示主TabVC的HomeVC
        // 当前有tabVC的时候，会在tabVC中得到处理，显示HomeVC
        // 如果没有创建tabVC的时候，不处理该通知，因为只有在tabVC中监听了该通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBBotification_ShowHomeVC object:nil];
    }
}

@end
