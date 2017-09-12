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
@property (nonatomic,copy) void(^clickEventBlock)(HXBFinPlanContract_ContractWebView *webView);
@end

@implementation HXBFinPlanContract_ContractWebView
- (void)loadURL: (NSString *)URL {
    if (![KeyChain ishaveNet]) return;
    if (!_isHiddenHUD) {
        [HxbHUDProgress showLoadDataHUD:self];
    }
    if (![URL containsString:[KeyChain h5host]]) {
        URL = [NSString stringWithFormat:@"%@%@",[KeyChain h5host],URL];
    }
    
    NSURL *url = [NSURL URLWithString:URL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    NSString *systemVision = [[UIDevice currentDevice] systemVersion];
    NSString *version = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    NSString *userAgent = [NSString stringWithFormat:@"Iphone/IOS %@/v%@ iphone" ,systemVision,version];
    NSLog(@"%@",[KeyChain token]);
    [request setValue:[KeyChain token] forHTTPHeaderField:@"X-Hxb-Auth-Token"];
    [request setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    
    request = [request copy];
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
- (void)clickEvent {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [tap addTarget:self action:@selector(clickAddTrustView:)];
    [self.scrollView addGestureRecognizer:tap];
}
- (void)clickAddTrustView: (UITapGestureRecognizer *) tap {
    if (self.clickEventBlock) {
        self.clickEventBlock(self);
    }
}
- (void)clickEventWithBlock:(void (^)(HXBFinPlanContract_ContractWebView *))clickEventBlock {
    [self clickEvent];
    self.clickEventBlock = clickEventBlock;
}
//HTTPS 没有证书的话（自建证书）不能加载，所以来开启权限。  注意：对ios8 无效，
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler {
//    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
//        if ([challenge previousFailureCount] == 0) {
//            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
//            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
//        } else {
//            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
//        }
//    } else {
//        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
//    }
//}
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
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [HxbHUDProgress hidenHUD:self];
    NSLog(@"加载：完成");
}
@end
