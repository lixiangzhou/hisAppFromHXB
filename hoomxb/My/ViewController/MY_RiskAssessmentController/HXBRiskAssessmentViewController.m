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

@property (nonatomic,copy) void(^popBlock)(NSString *type);
@end

@implementation HXBRiskAssessmentViewController

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
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kHXBH5_RiskEvaluationURL]]];
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"风险测评";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    [self setupRightBarBtn];
    
    /****** 加载桥梁对象 ******/
    [WebViewJavascriptBridge enableLogging];
    
    /****** 初始化 ******/
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
    }];
    kWeakSelf
    /****** OC端注册一个方法 (测试)******/
    [_bridge registerHandler:@"riskEvaluation" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        //如果外部实现了这个方法，那就直接执行这个block
        if (self.popBlock) {
            NSString *type = data[@"riskType"];
            self.popBlock(type);
            return;
        }
        __block UIViewController *vc = nil;
        [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:NSClassFromString(@"HxbAccountInfoViewController")]) {
                vc = obj;
                *stop = true;
            }
        }];
        [weakSelf.navigationController popToViewController:vc animated:true];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isColourGradientNavigationBar = YES;
    [HxbHUDProgress showLoadDataHUD:self.webView];
}

- (void)setupRightBarBtn
{
    UIButton *rightBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
    [rightBackBtn setTitle:@"跳过" forState:UIControlStateNormal];
    // 让按钮内部的所有内容左对齐
    rightBackBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [rightBackBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [rightBackBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    // 修改导航栏左边的item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBackBtn];
}

- (void)dismiss
{
    [_bridge callHandler:@"skipTest" data:nil];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlString = [[request URL]  absoluteString];
    NSLog(@"==> %@",urlString);
    
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    
    NSDictionary *requestHeaders = request.allHTTPHeaderFields;
    
    // 判断请求头是否已包含，如果不判断该字段会导致webview加载时死循环

    if (requestHeaders[@"X-Hxb-Auth-Token"] && requestHeaders[@"User-Agent"]) {

        return YES;
        
    } else {
        
        NSString *systemVision = [[UIDevice currentDevice] systemVersion];
        NSString *version = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
        NSString *userAgent = [NSString stringWithFormat:@"iphone/%@/%@" ,systemVision,version];
        NSLog(@"%@",[KeyChain token]);
        [mutableRequest setValue:[KeyChain token] forHTTPHeaderField:@"X-Hxb-Auth-Token"];
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
}
- (void)popWithBlock:(void (^)(NSString *type))popBlock {
    self.popBlock = popBlock;
}
@end
