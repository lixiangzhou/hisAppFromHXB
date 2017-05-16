//
//  HXBFinPlanContract_ContractWebView.m
//  hoomxb
//
//  Created by HXB on 2017/5/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinPlanContract_ContractWebView.h"
@interface HXBFinPlanContract_ContractWebView ()
<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic,strong) NSURL *webViewLoadURL;
@end
@implementation HXBFinPlanContract_ContractWebView
- (void)loadURL: (NSString *)URL {
    NSURL *url = [NSURL URLWithString:URL];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [self loadRequest:request];
    self.webViewLoadURL = url;
}



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUP];
    }
    return self;
}


- (void)setUP {
    //设置代理
    self.UIDelegate = self;
    self.navigationDelegate = self;
}

//HTTPS 没有证书的话（自建证书）不能加载，所以来开启权限。  注意：对ios8 无效，
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([challenge previousFailureCount] == 0) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        } else {
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
    } else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    }
}
//MARK: 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
}
//MARK: 内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}
//MARK: 页面加载完成时调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO ;
    NSLog(@"加载：完成");
}
@end
