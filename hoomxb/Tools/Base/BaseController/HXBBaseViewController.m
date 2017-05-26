//
//  HXBBaseViewController.m
//  hoomxb
//
//  Created by HXB on 2017/4/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//


///注意ios8不能用

#import "HXBBaseViewController.h"
#import <WebKit/WebKit.h>

@interface HXBBaseViewController () <WKUIDelegate,WKNavigationDelegate>


@end

@implementation HXBBaseViewController{
    WKWebView * _webView;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self setupWebView];
}
//MARK: 销毁
kDealloc
#pragma mark - gtter 方法
///隐藏导航条
- (void)setIsHiddenNavigationBar:(BOOL)isHiddenNavigationBar {
    _isHiddenNavigationBar = isHiddenNavigationBar;
    self.navigationController.navigationBarHidden = isHiddenNavigationBar;
}
///是否禁止scrollView自动向下平移64
- (void)setHxb_automaticallyAdjustsScrollViewInsets:(BOOL)hxb_automaticallyAdjustsScrollViewInsets {
    _hxb_automaticallyAdjustsScrollViewInsets = hxb_automaticallyAdjustsScrollViewInsets;
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = hxb_automaticallyAdjustsScrollViewInsets;
    };
}
#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = self.isHiddenNavigationBar;
}
@end
