//
//  NYBaseRequest.h
//  NYNetwork
//
//  Created by 牛严 on 16/6/28.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
/// 服务器返回未知异常
static  NSInteger const kResponseStatusError = 300000;
/// 服务器返回的常用字段
static NSString *const kResponseStatus = @"status";
/// 服务器返回的常用字段
static NSString *const kResponseData = @"data";
/// 服务器返回的常用字段
static NSString *const kResponseDataList = @"dataList";
/// 服务器返回的常用字段
static NSString *const kResponseMessage = @"message";

@class NYBaseRequest;
//@class NYHTTPConnection;

//================================== 定义方法序列化枚举，成功失败回调 ==================================
typedef NS_ENUM(NSInteger, NYRequestMethod){
    NYRequestMethodGet = 0,
    NYRequestMethodPost,
    NYRequestMethodPut,
    NYRequestMethodDelete,
};

//typedef NS_ENUM(NSInteger, NYRequestSerializerType){
//    NYRequestSerializerTypeHTTP = 0,
//    NYRequestSerializerTypeJson,
//};
//
//typedef NS_ENUM(NSInteger, NYResponseSerializerType){
//    NYResponseSerializerTypeHTTP = 0,
//    NYResponseSerializerTypeJson,
//};

typedef void (^HXBRequestSuccessBlock)(NYBaseRequest *request, NSDictionary *responseObject);
typedef void (^HXBRequestFailureBlock)(NYBaseRequest *request, NSError *error);

@interface NYBaseRequest : NSObject

// ================================== request ==================================
//@property (nonatomic, weak) NYHTTPConnection *connection;
//请求方法 Get/Post
@property (nonatomic, assign) NYRequestMethod requestMethod;
//baseUrl之后的请求Url
@property (nonatomic, copy) NSString *requestUrl;
//baseUrl，如http://api.hoomxb.com
@property (nonatomic, copy) NSString *baseUrl;
//请求参数字典
@property (nonatomic, strong) id requestArgument;
//向请求头中添加的附加信息，除token、version等公共信息
@property (nonatomic, copy) NSDictionary *httpHeaderFields;
//请求超时时间
@property (nonatomic, assign) NSTimeInterval timeoutInterval;


//================================== response ==================================
//响应序列化类型
//@property (nonatomic, assign) NYResponseSerializerType responseSerializerType;
//响应状态码，如403
@property (nonatomic, assign) NSInteger responseStatusCode;
//响应头
@property (nonatomic, copy) NSDictionary *responseHeaderFieldValueDictionary;
//回调成功内容
@property (nonatomic, strong) id responseObject;
//回调失败错误
@property (nonatomic, strong) NSError *error;
/// 请求对应的任务
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;






//================================== callback ==================================
//返回成功回调
@property (nonatomic, copy) HXBRequestSuccessBlock success;
/**
 自定义特殊状态拦截返回成功回调
 */
@property (nonatomic, copy) HXBRequestSuccessBlock customCodeSuccessBlock;
//返回失败回调
@property (nonatomic, copy) HXBRequestFailureBlock failure;
/**
 自定义特殊状态拦截返回失败回调
 */
@property (nonatomic, copy) HXBRequestFailureBlock customCodeFailureBlock;


//================================== function ==================================
- (void)start;

- (void)startWithSuccess:(HXBRequestSuccessBlock)success failure:(HXBRequestFailureBlock)failure;

- (void)startWithHUDStr:(NSString *)string Success:(HXBRequestSuccessBlock)success failure:(HXBRequestFailureBlock)failure;

- (void)startAnimationWithSuccess:(HXBRequestSuccessBlock)success failure:(HXBRequestFailureBlock)failure;


- (NYBaseRequest *)copyRequest;

@end
