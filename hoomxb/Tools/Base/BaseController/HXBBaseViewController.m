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
@end
