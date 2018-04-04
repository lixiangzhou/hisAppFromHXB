//
//  HXBWKWebviewViewModuel.m
//  hoomxb
//
//  Created by caihongji on 2017/11/23.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBWKWebviewViewModel.h"

@interface HXBWKWebviewViewModuel ()

@end

@implementation HXBWKWebviewViewModuel

#pragma mark 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    if (self.loadStateBlock) {
        self.loadStateBlock(HXBPageLoadStateStart);
    }
}

#pragma mark 页面加载完成时调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    //将链接的target指向_self
    [webView evaluateJavaScript:@"{\
     var a = document.getElementsByTagName('a'); \
     for (var i=0; i<a.length; i++) \
     if (a[i].getAttribute('target') == '_blank'){\
     a[i].target=\"_self\";\
     }\
     }" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
         
     }];
    
    if (self.loadStateBlock) {
        self.loadStateBlock(HXBPageLoadStateEnd);
    }
}

#pragma mark 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if (self.loadStateBlock) {
        self.loadStateBlock(HXBPageLoadStateFaile);
    }
}

@end
