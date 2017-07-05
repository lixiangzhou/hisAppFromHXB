//
//  HXBRiskAssessmentViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/4.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRiskAssessmentViewController.h"
#import "WebViewJavascriptBridge.h"
@interface HXBRiskAssessmentViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property WebViewJavascriptBridge* bridge;

@end

@implementation HXBRiskAssessmentViewController

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor redColor];
        _webView.scalesPageToFit = YES;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.bounces = NO;
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kHXBH5_RiskEvaluationURL]]];
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    
    /****** 加载桥梁对象 ******/
    [WebViewJavascriptBridge enableLogging];
    
    /****** 初始化 ******/
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
    }];
    kWeakSelf
    /****** OC端注册一个方法 (测试)******/
    [_bridge registerHandler:@"riskEvaluation" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlString = [[request URL]  absoluteString];
    NSLog(@"==> %@",urlString);
    
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    
    NSDictionary *requestHeaders = request.allHTTPHeaderFields;
    
    // 判断请求头是否已包含，如果不判断该字段会导致webview加载时死循环

    if (requestHeaders[@"X-HxbAuth-Token"] && requestHeaders[@"User-Agent"]) {
        
        return YES;
        
    } else {
        
        NSString *systemVision = [[UIDevice currentDevice] systemVersion];
        NSString *version = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
        NSString *userAgent = [NSString stringWithFormat:@"iphone/%@/%@" ,systemVision,version];
        NSLog(@"%@",[KeyChain token]);
        [mutableRequest setValue:[KeyChain token] forHTTPHeaderField:@"X-HxbAuth-Token"];
        [mutableRequest setValue:userAgent forHTTPHeaderField:@"User-Agent"];
        
        request = [mutableRequest copy];
        
        [webView loadRequest:request];
        
        return NO;
    }

    return YES;
}

@end
