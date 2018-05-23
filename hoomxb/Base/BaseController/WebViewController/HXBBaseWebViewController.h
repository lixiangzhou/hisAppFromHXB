//
//  HXBBaseWebViewController.h
//  hoomxb
//
//  Created by caihongji on 2018/5/3.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"

#define HXB_LOAD_LISTEN @"window.addEventListener('load',pageLoadComplete,false);\
function pageLoadComplete() {window.location='objc://pageLoadComplete';}\
"

@interface HXBBaseWebViewController : HXBBaseViewController<UIWebViewDelegate>

/**
 用于加载一个新的URLRequest。
 */
@property (nonatomic, strong,readonly) UIWebView *webView;

@property (nonatomic, copy) NSString* pageUrl;
/**
 页面title， 可以不传
 */
@property (nonatomic, copy) NSString* pageTitle;

//重新获取焦点时，是否需要重新加载, 默认值是YES
@property (nonatomic, assign) BOOL pageReload;

//返回按钮的隐藏控制
@property (nonatomic, assign) BOOL hiddenReturnButton;

/**
 注册js回调
 
 @param handlerName js 名称
 @param handler 回到方法
 */
- (void)registJavascriptBridge:(NSString *)handlerName handler:(WVJBHandler)handler;
/**
 调用js
 
 @param handlerName js 名称
 @param data 数据
 */
- (void)callHandler:(NSString *)handlerName data:(id)data;


/**
 重新加载页面
 */
- (void)reloadPage;

/**
 加载第三方H5页面需要重写此方法
 */
- (void)loadWebPage;
/**
 push 一个显示网页的控制器
 
 @param pageUrl 网页的URL
 @param controller 从该控制器push
 @return 返回当前控制器
 */
+ (instancetype)pushWithPageUrl:(NSString *)pageUrl fromController:(HXBBaseViewController *)controller;

@end
