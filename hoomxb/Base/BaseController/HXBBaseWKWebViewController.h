//
//  HXBBaseWKWebViewController.h
//  hoomxb
//
//  Created by HXB on 2017/5/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface HXBBaseWKWebViewController : UIViewController
//活动或者官方类型通知 被点击后，串来的url 跳转webView
@property (nonatomic,strong) NSURL *pushURL;
@property (nonatomic,copy) NSString *typeTitle;

//MARK: - 关于加载
///内容开始加载的时候调用
@property (nonatomic,copy) void(^didStartLoadURLBlock)(WKNavigation *navigation);
///内容开始返回时调用
@property (nonatomic,copy) void(^didCommitLoadURLBlock)(WKNavigation *navigation);
///加载完成的时候调用
@property (nonatomic,copy) void(^didFinishLoadURLBlock)(WKNavigation *navigation);
///加载失败的时候调用
@property (nonatomic,copy) void(^didFailLoadURLBlock)(WKNavigation *navigation);



///这个方法是服务器重定向时调用，即 接收到服务器跳转请求之后调用
@property (nonatomic,copy) void(^didReceiveServerRedirectBlock)(WKNavigation *navigation);

@end
