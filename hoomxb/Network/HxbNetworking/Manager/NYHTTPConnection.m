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
#import "HxbHTTPSessionManager.h"
#define Config [NYNetworkConfig sharedInstance]



@interface NYHTTPConnection ()

@property (nonatomic, strong, readwrite) NYBaseRequest *request;

@property (nonatomic, strong, readwrite) NSURLSessionDataTask *task;

@property (nonatomic, copy) ConnectionSuccessBlock success;

@property (nonatomic, copy) ConnectionFailureBlock failture;

@property (strong, nonatomic) NSMutableDictionary<NSNumber *, NSURLSessionTask *> *dispatchTable;

@property (nonatomic, strong) HxbHTTPSessionManager *manager;
@end

@implementation NYHTTPConnection

+ (instancetype)init
{
    return [[self alloc]init];
}

/**
 *  生成headerFieldValueDic
 *
 *  @param request 处理的请求
 *
 */
- (NSDictionary *)headerFieldsValueWithRequest:(NYBaseRequest *)request
{
    NSMutableDictionary *headers = [Config.additionalHeaderFields mutableCopy];

    [request.requestHeaderFieldValueDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [headers setObject:obj forKey:key];
    }];
    return headers;
}

//配置及处理sessionManager
- (void)connectWithRequest:(NYBaseRequest *)request success:(ConnectionSuccessBlock)success failure:(ConnectionFailureBlock)failure
{
    self.success = success;
    self.failture = failure;
    //现在的初始化代码
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    HxbHTTPSessionManager *manager = [[HxbHTTPSessionManager alloc] initWithSessionConfiguration:config];
    //    HxbHTTPSessionManager *manager = [HxbHTTPSessionManager manager]; //以前初始化代码

//-------------------------------------------request----------------------------------------
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSLog(@"manager = %@",manager);
    manager.requestSerializer.timeoutInterval = 20;
    
    NSDictionary *headers = [self headerFieldsValueWithRequest:request];
      [manager.requestSerializer setHTTPShouldHandleCookies:NO];
    
    [headers enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
        [manager.requestSerializer setValue:value forHTTPHeaderField:field];
    }];
    
//--------------------------------------------response----------------------------------------
    if (request.responseSerializerType == NYResponseSerializerTypeHTTP) {
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }else if (request.responseSerializerType == NYResponseSerializerTypeJson){
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    manager.responseSerializer.acceptableStatusCodes = Config.defaultAcceptableStatusCodes;
    manager.responseSerializer.acceptableContentTypes = Config.defaultAcceptableContentTypes;
    
    NSString *urlString = @"";
    if (request.baseUrl.length) {
        urlString = [NSURL URLWithString:request.requestUrl relativeToURL:[NSURL URLWithString:request.baseUrl]].absoluteString;
    }else{
        urlString = [NSURL URLWithString:request.requestUrl relativeToURL:[NSURL URLWithString:Config.baseUrl]].absoluteString;
    }
    NSDictionary *parameters = request.requestArgument;
    
//------------------------------------------AFHTTPSessionManage---------------------------
    
    void (^successBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self requestHandleSuccess:request responseObject:responseObject];
        [self.dispatchTable removeObjectForKey:@(task.taskIdentifier)];
    };
    
    void (^failureBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self requestHandleFailure:request error:error];
        [self.dispatchTable removeObjectForKey:@(task.taskIdentifier)];
    };
    
    
    NSURLSessionDataTask *task = nil;
    switch (request.requestMethod) {
        case NYRequestMethodGet:
        {
            task = [manager GET:urlString parameters:parameters progress:nil success:successBlock failure:failureBlock];
        }
            break;
        case NYRequestMethodPost:
        {
            task = [manager POST:urlString parameters:parameters progress:nil success:successBlock failure:failureBlock];
        }
            break;
        case NYRequestMethodPut:
        {
            task = [manager PUT:urlString parameters:parameters success:successBlock failure:failureBlock];
        }
            break;
        case NYRequestMethodDelete:
        {
            task = [manager DELETE:urlString parameters:parameters success:successBlock failure:failureBlock];
        }
            break;
        default:{
            NSLog(@"unsupported request method");
        }
            break;
    }
    [self.dispatchTable setObject:task forKey:@(task.taskIdentifier)];
    self.task = task;
    request.connection = self;
}

- (void)requestHandleSuccess:(NYBaseRequest *)request responseObject:(id)object
{
    if (self.success) {
        self.success(self,object);
    }
}

- (void)requestHandleFailure:(NYBaseRequest *)request error:(NSError *)error
{
    if (self.failture) {
        self.failture(self,error);
    }
}

#pragma mark Get/Set Method
- (NSDictionary *)dispatchTable
{
    if (!_dispatchTable) {
        _dispatchTable = [NSMutableDictionary dictionary];
    }
    return _dispatchTable;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
