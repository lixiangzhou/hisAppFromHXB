//
//  HXBBannerWebViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/8/23.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#define kRegisterVC @"/account/register"//注册页面
#define kRechargeVC @"/cash/recharge"//充值页面
#define kEscrowActivityVC @"/escrow/EscrowActivity"//存管开户页面
#define kPlanDetailVC @"/plan/detail"//某个计划的详情页
#define kLoanDetailVC @"/loan/detail"//某个散标的详情页
#define kLoginVC @"/account/login"//登录页面
#define kHomeVC @"/home/main"//主页


#import "HXBBannerWebViewController.h"
#import "WebViewJavascriptBridge.h"
@interface HXBBannerWebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property WebViewJavascriptBridge* bridge;
@end

@implementation HXBBannerWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isColourGradientNavigationBar = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    
    /****** 加载桥梁对象 ******/
    [WebViewJavascriptBridge enableLogging];
    
    /****** 初始化 ******/
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
    }];
    kWeakSelf
    /****** OC端注册一个方法 (测试)******/
    [self.bridge registerHandler:@"startPage" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"%@",data);
        [weakSelf logicalJumpWithData:data];
    }];
}

- (void)logicalJumpWithData:(id)data
{
    if ([data[@"path"] isEqualToString:kRegisterVC]) {
        //注册
        //跳转登录注册
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
    }else if ([data[@"path"] isEqualToString:kRechargeVC]){
        //充值页面
        
    }else if ([data[@"path"] isEqualToString:kEscrowActivityVC]){
        //存管开户页面
        
    }else if ([data[@"path"] isEqualToString:kPlanDetailVC]){
        //某个计划的详情页
        
    }else if ([data[@"path"] isEqualToString:kLoanDetailVC]){
        //某个散标的详情页
        
    }else if ([data[@"path"] isEqualToString:kLoginVC]){
        //登录页面
        
    }else if ([data[@"path"] isEqualToString:kHomeVC]){
        //主页
       
    }
    [self popoverPresentationController];
}


#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"%@",request);
    
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


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [HxbHUDProgress hidenHUD:self.webView];
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

#pragma mark - 懒加载
- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
        _webView.delegate = self;
        _webView.scalesPageToFit = YES;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.bounces = NO;
        // UIWebView 滚动的比较慢，这里设置为正常速度
        _webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
        [HxbHUDProgress showLoadDataHUD:self.webView];
    }
    return _webView;
}

@end
