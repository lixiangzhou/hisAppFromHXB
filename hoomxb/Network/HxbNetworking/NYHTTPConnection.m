//
//  NYHTTPConnection.m
//  NYNetwork
//
//  Created by 牛严 on 16/6/28.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import "NYHTTPConnection.h"
#import "NYNetworkConfig.h"
#import "TokenAPI.h"
#import "tokenModel.h"
#import <objc/runtime.h>
#import "HxbHTTPSessionManager.h"
#define Config [NYNetworkConfig sharedInstance]

//@implementation NYBaseRequest (NYHTTPConnection)
//static const char kBaseRequestConnectionKey;
//- (NYHTTPConnection *)connection
//{
//    return objc_getAssociatedObject(self, &kBaseRequestConnectionKey);
//}
//
//- (void)setConnection:(NYHTTPConnection *)connection
//{
//    objc_setAssociatedObject(self, &kBaseRequestConnectionKey, connection, OBJC_ASSOCIATION_ASSIGN);
//}
//
//@end


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
    
    _manager = [HxbHTTPSessionManager manager];
//-------------------------------------------request----------------------------------------
    if (request.requestSerializerType == NYRequestSerializerTypeHTTP) {
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }else if (request.requestSerializerType == NYRequestSerializerTypeJson){
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    _manager.requestSerializer.timeoutInterval = request.timeoutInterval ?: Config.defaultTimeOutInterval ?: 30;
    
    NSDictionary *headers = [self headerFieldsValueWithRequest:request];
      [_manager.requestSerializer setHTTPShouldHandleCookies:NO];
    
    [headers enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
        [_manager.requestSerializer setValue:value forHTTPHeaderField:field];
    }];
    
//--------------------------------------------response----------------------------------------
    if (request.responseSerializerType == NYResponseSerializerTypeHTTP) {
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }else if (request.responseSerializerType == NYResponseSerializerTypeJson){
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    _manager.responseSerializer.acceptableStatusCodes = Config.defaultAcceptableStatusCodes;
    _manager.responseSerializer.acceptableContentTypes = Config.defaultAcceptableContentTypes;
    
    NSString *urlString = @"";
    if (request.baseUrl.length) {
        urlString = [NSURL URLWithString:request.requestUrl relativeToURL:[NSURL URLWithString:request.baseUrl]].absoluteString;
    }else{
        urlString = [NSURL URLWithString:request.requestUrl relativeToURL:[NSURL URLWithString:Config.baseUrl]].absoluteString;
    }
    NSDictionary *parameters = request.requestArgument;
    
//    NSMutableDictionary *signDict = [NSMutableDictionary dictionary];
//    [signDict addEntriesFromDictionary:parameters];
//    
//    NSString * signString = [NSString signStringBySortFromParamDict:signDict];
//    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
//    [postParameters setObject:signString forKey:@"sign"];
    
//------------------------------------------AFHTTPSessionManage---------------------------
    NSURLSessionDataTask *task = nil;
    switch (request.requestMethod) {
        case NYRequestMethodGet:
        {
    if ([KeyChain token].length == 0) {
         [self getToken];
    }
            task = [_manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [self requestHandleSuccess:request responseObject:responseObject];
                [self.dispatchTable removeObjectForKey:@(task.taskIdentifier)];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)task.response;
//                NSLog(@"ceode:>>>>>>>>%ld",(long)err);
                if([httpResponse statusCode] == 401){
                    [self getToken];
                    task = [_manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        
                        [self requestHandleSuccess:request responseObject:responseObject];
                        [self.dispatchTable removeObjectForKey:@(task.taskIdentifier)];
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   
                        [self requestHandleFailure:request error:error];
                        [self.dispatchTable removeObjectForKey:@(task.taskIdentifier)];
                    }];

                }
                [self requestHandleFailure:request error:error];
                [self.dispatchTable removeObjectForKey:@(task.taskIdentifier)];
            }];
    
        }
            break;
        case NYRequestMethodPost:
        {
            task = [_manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self requestHandleSuccess:request responseObject:responseObject];
                [self.dispatchTable removeObjectForKey:@(task.taskIdentifier)];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self requestHandleFailure:request error:error];
                [self.dispatchTable removeObjectForKey:@(task.taskIdentifier)];
            }];
        }
            break;
        case NYRequestMethodPut:
        {
            task = [_manager PUT:urlString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self requestHandleSuccess:request responseObject:responseObject];
                [self.dispatchTable removeObjectForKey:@(task.taskIdentifier)];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self requestHandleFailure:request error:error];
                [self.dispatchTable removeObjectForKey:@(task.taskIdentifier)];
            }];
        }
            break;
        case NYRequestMethodDelete:
        {
            task = [_manager DELETE:urlString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self requestHandleSuccess:request responseObject:responseObject];
                [self.dispatchTable removeObjectForKey:@(task.taskIdentifier)];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self requestHandleFailure:request error:error];
                [self.dispatchTable removeObjectForKey:@(task.taskIdentifier)];
            }];
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

- (void)getToken{
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
    NSString *tokenURL = [NSString stringWithFormat:@"%@%@",BASEURL,TOKENURL];
    
    [_manager GET:tokenURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"😝😝😝😝😝%@",responseObject);
        NSDictionary *dic = [responseObject objectForKey:@"data"];
        tokenModel *model = [tokenModel yy_modelWithJSON:dic];
        NSLog(@"😝😝😝😝😝%@",model.token);
        [KeyChain setToken:model.token];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"😱😱😱😱😱%@",error);
    }];
    });
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

@end
