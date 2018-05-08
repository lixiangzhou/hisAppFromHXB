//
//  NYBaseRequest.h
//  NYNetwork
//
//  Created by 牛严 on 16/6/28.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "HXBRequestHudDelegate.h"
#import "NSDictionary+HXBResponse.h"

#define RequestDelayInterval 2

@class NYBaseRequest;
@class NYHTTPConnection;

/// 服务器返回未知异常
static  NSInteger const kResponseStatusError = 300000;
/// 服务器返回的常用字段
static NSString *const kResponseStatus = @"status";
/// 服务器返回的常用字段
static NSString *const kResponseData = @"data";
///服务器错误返回的常用字段
static NSString *const kResponseErrorData = @"errorData";
///服务器返回的常用字段
static NSString *const kResponseDataList = @"dataList";
/// 服务器返回的常用字段
static NSString *const kResponseMessage = @"message";

//================================== 定义方法序列化枚举，成功失败回调 ==================================
typedef NS_ENUM(NSInteger, NYRequestMethod){
    NYRequestMethodGet = 0,
    NYRequestMethodPost,
    NYRequestMethodPut,
    NYRequestMethodDelete,
};

typedef void (^HXBRequestSuccessBlock)(NYBaseRequest *request, NSDictionary *responseObject);
typedef void (^HXBRequestFailureBlock)(NYBaseRequest *request, NSError *error);

@interface NYBaseRequest : NSObject

// ================================== request ==================================
@property (nonatomic, strong) NYHTTPConnection *connection;
/// 请求方法 Get/Post， 默认是Get
@property (nonatomic, assign) NYRequestMethod requestMethod;
/// baseUrl之后的请求Url
@property (nonatomic, copy) NSString *requestUrl;
/// baseUrl，如http://api.hoomxb.com
@property (nonatomic, copy) NSString *baseUrl;
/// 请求参数字典
@property (nonatomic, strong) id requestArgument;
/// 向请求头中添加的附加信息，除token、version等公共信息
@property (nonatomic, copy) NSDictionary *httpHeaderFields;
/// 请求超时时间， 默认是20秒
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
/// 是否显示加载框
@property (nonatomic, assign) BOOL showHud;
/// 加载框上显示的文本
@property (nonatomic, copy) NSString* hudShowContent;
/// 网络延时时间(s), 如果不需要延时处理, 则不需要传递该参数
@property (nonatomic, assign) NSTimeInterval delayInterval;

//================================== 发送者代理 ==================================
/// 委托
@property (nonatomic, weak) id<HXBRequestHudDelegate> hudDelegate;

//================================== response ==================================

/// 响应状态码，如403
@property (nonatomic, assign) NSInteger responseStatusCode;
/// 响应头
@property (nonatomic, copy) NSDictionary *responseAllHeaderFields;
/// 回调成功内容
@property (nonatomic, strong) id responseObject;
/// 回调失败错误
@property (nonatomic, strong) NSError *error;

//================================== callback ==================================
/// 返回成功回调
@property (nonatomic, copy) HXBRequestSuccessBlock success;
/// 返回失败回调
@property (nonatomic, copy) HXBRequestFailureBlock failure;

#pragma mark  以下为重构后需要使用的各种方法

- (instancetype)initWithDelegate:(id<HXBRequestHudDelegate>)delegate;

/**
 比较是否是同一个请求

 @param request 比较对象
 @return YES：不同；反之。
 */
- (BOOL)defferRequest:(NYBaseRequest*)request;
/**
 显示加载框
 
 */
- (void)showLoading;

/**
 隐藏加载框
 
 */
- (void)hideLoading;

/**
 显示提示文本

 @param content 提示内容
 */
- (void)showToast:(NSString*)content;

/**
 请求数据

 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadData:(HXBRequestSuccessBlock)success failure:(HXBRequestFailureBlock)failure;

/**
 取消请求
 */
- (void)cancelRequest;

/**
 当网络结果需要延时回调时,使用该方法计算剩余秒数

 @return 剩余秒数
 */
- (NSTimeInterval)leftDelayInterval;
@end
