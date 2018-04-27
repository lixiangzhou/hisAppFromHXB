//
//  HXBRequestHudDelegate.h
//  hoomxb
//
//  Created by lxz on 2017/12/5.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NYBaseRequest;

@protocol HXBRequestHudDelegate <NSObject>

#pragma mark 弹框显示
- (void)showProgress:(NYBaseRequest *)request showHudCongtent:(NSString*)hudContent;
- (void)showToast:(NSString *)toast;
- (void)hideProgress:(NYBaseRequest *)request;

#pragma mark 错误码处理
/**
 错误的状态码处理

 @param request 请求对象
 @return 是否已经做了处理
 */
- (BOOL)erroStateCodeDeal:(NYBaseRequest *)request;

/**
 错误的响应码处理
 
 @param request 请求对象
 @return 是否已经做了处理
 */
- (BOOL)erroResponseCodeDeal:(NYBaseRequest *)request;

#pragma mark在委托者中操作请求对象
/**
 添加请求到委托者

 @param request 请求对象
 */
- (void)addRequestObject:(NYBaseRequest *)request;

/**
 移除请求从委托者

 @param request 请求对象
 */
- (void)removeRequestObject:(NYBaseRequest *)request;

/**
 从委托者获取其中的请求列表

 @return 请求列表
 */
- (NSArray*)getRequestObjectList;
@end
