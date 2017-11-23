//
//  HXBWKWebviewViewModuel.m
//  hoomxb
//
//  Created by caihongji on 2017/11/23.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBWKWebviewViewModuel.h"
#import <WebKit/WebKit.h>

@interface HXBWKWebviewViewModuel ()<WKNavigationDelegate>

@end

@implementation HXBWKWebviewViewModuel

#pragma mark 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    if (self.loadStateBlock) {
        self.loadStateBlock(PageLoadStart);
    }
}

#pragma mark 页面加载完成时调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if (self.loadStateBlock) {
        self.loadStateBlock(PageLoadEnd);
    }
}

#pragma mark 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if (self.loadStateBlock) {
        self.loadStateBlock(PageLoadFaile);
    }
}

@end
