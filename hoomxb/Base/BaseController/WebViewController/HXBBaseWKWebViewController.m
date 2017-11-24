//
//  HXBBaseWKWebViewController.m
//  hoomxb
//
//  Created by caihongji on 2017/11/21.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseWKWebViewController.h"
#import <WebKit/WebKit.h>
#import "HXBWKWebviewViewModuel.h"
#import "HXBWKWebViewProgressView.h"

@interface HXBBaseWKWebViewController ()<WKNavigationDelegate> {
    //进度视图的高度
    NSInteger _progressViewHeight;
    //判断是否时首次加载页面
    BOOL _firstLoadPage;
}

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) HXBWKWebViewProgressView* progressView;

//js 代理
@property (nonatomic, strong) WKWebViewJavascriptBridge *jsBridge;

//webview viewModuel
@property (nonatomic, strong) HXBWKWebviewViewModuel *webViewModuel;

@end

@implementation HXBBaseWKWebViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _firstLoadPage = YES;
        _pageReload = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isRedColorWithNavigationBar = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    [self setupConstraints];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:(NSKeyValueObservingOptionNew) context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

- (void)viewDidAppear:(BOOL)animated {
    if (_firstLoadPage || self.pageReload) {
        _firstLoadPage = NO;
        
        [self loadWebPage];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];

    } else if ([keyPath isEqualToString:@"title"]) {
        self.title = [HXBMiddlekey H5Title:self.webView.title];
    }
    
}

#pragma mark 无网络重新加载H5
- (void)getNetworkAgain
{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.pageUrl]]];
}

#pragma mark 安装约束
- (void)setupConstraints {
    kWeakSelf
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(HXBStatusBarAndNavigationBarHeight);
        make.height.mas_equalTo(_progressViewHeight);
    }];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.progressView.mas_bottom);
    }];
}

#pragma mark 更新约束
- (void)updateConstraints {
    [self.progressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_progressViewHeight);
    }];
}

#pragma mark 显示加载进度
- (void)loadProgress:(BOOL)isShow {
    if (isShow) {
        _progressViewHeight = 3;
    }
    else {
        _progressViewHeight = 0;
    }
    
    [self updateConstraints];
}

#pragma mark 注册js回调
- (void)registJavascriptBridge:(NSString *)handlerName handler:(WVJBHandler)handler {
    [self.jsBridge registerHandler:handlerName handler:handler];
}

#pragma mark webView初始化
- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = [[WKUserContentController alloc] init];
        
        WKPreferences *preferences = [[WKPreferences alloc] init];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
//        preferences.minimumFontSize = 30.0;
        configuration.preferences = preferences;
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        _webView.navigationDelegate = self.webViewModuel;
    }
    return _webView;
}

#pragma mark progressView初始化
- (HXBWKWebViewProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[HXBWKWebViewProgressView alloc] init];
        kWeakSelf
        _progressView.HXBPageLoadStateSuccessBlock = ^{
            [weakSelf loadProgress:NO];
        };
    }
    return _progressView;
}

#pragma mark webViewModuel初始化
- (HXBWKWebviewViewModuel *)webViewModuel {
    if (!_webViewModuel) {
        _webViewModuel = [[HXBWKWebviewViewModuel alloc] init];
        
        kWeakSelf
        _webViewModuel.loadStateBlock = ^(HXBPageLoadState state) {
            switch (state) {
                case HXBPageLoadStateStart: {
                    [weakSelf loadProgress:YES];
                    break;
                }
//                case HXBPageLoadStateEnd: {
//                    [weakSelf loadProgress:NO];
//                    break;
//                }
                case HXBPageLoadStateFaile: {
                    [weakSelf loadProgress:NO];
                    break;
                }
                default:
                    break;
            }
        };
    }
    return _webViewModuel;
}

#pragma mark jsBridge初始化
- (WKWebViewJavascriptBridge *)jsBridge {
    if (!_jsBridge) {
        [WKWebViewJavascriptBridge enableLogging];
        
        _jsBridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:(NSObject<WKNavigationDelegate>*)self.webViewModuel handler:^(id data, WVJBResponseCallback responseCallback) {
        }];
    }
    
    return _jsBridge;
}

#pragma mark 加载页面
- (void)loadWebPage {
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init];
    [urlRequest setURL:[NSURL URLWithString:self.pageUrl]];
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    NSString *version = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    NSString *userAgent = [NSString stringWithFormat:@"%@/IOS %@/v%@ iphone" ,[HXBDeviceVersion deviceVersion],systemVersion,version];
    NSLog(@"%@",[KeyChain token]);
    [urlRequest setValue:[KeyChain token] forHTTPHeaderField:@"X-Hxb-Auth-Token"];
    [urlRequest setValue:userAgent forHTTPHeaderField:X_Hxb_User_Agent];
    [self.webView loadRequest:urlRequest];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
