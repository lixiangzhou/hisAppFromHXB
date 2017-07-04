//
//  HXBRiskAssessmentViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/4.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRiskAssessmentViewController.h"

@interface HXBRiskAssessmentViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

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
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.188:3000/riskvail"]]];
    }
    return _webView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.webView];
    self.title = @"风险评测";
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
        
        [mutableRequest setValue:[KeyChain token] forHTTPHeaderField:@"X-HxbAuth-Token"];
        [mutableRequest setValue:userAgent forHTTPHeaderField:@"User-Agent"];
        
        request = [mutableRequest copy];
        
        [webView loadRequest:request];
        
        return NO;
    }

    return YES;
}



@end
