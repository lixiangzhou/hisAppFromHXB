//
//  HXBBaseWebViewController.m
//  hoomxb
//
//  Created by caihongji on 2018/5/3.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseWebViewController.h"
#import "SVGKit/SVGKImage.h"
#import "HXBWKWebViewProgressView.h"
#import <WebViewJavascriptBridge.h>
#import "HXBWebViewProgress.h"

@interface HXBBaseWebViewController ()<HXBWebViewProgressDelegate> {
    //进度视图的高度
    NSInteger _progressViewHeight;
    //判断是否时首次加载页面
    BOOL _firstLoadPage;
}

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) HXBWKWebViewProgressView* progressView;
@property (nonatomic, strong) HXBWebViewProgress* webViewProgress;

//js 代理
@property (nonatomic, strong) WebViewJavascriptBridge *jsBridge;

@property (nonatomic, assign) BOOL loadResult;

@property (nonatomic, strong) UIButton *closeBtn;

//是否需要显示关闭按钮
@property (nonatomic, assign) BOOL showCloseButton;


@end

@implementation HXBBaseWebViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pageReload = YES;
        _firstLoadPage = YES;
        _showCloseButton = NO;
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
    
    if(self.pageTitle) {
        self.title = self.pageTitle;
    }
    
    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
    [self loadWebPage];
}

- (void)setupLeftBackBtn {
    UIButton *leftBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 35)];
    [leftBackBtn setImage:[SVGKImage imageNamed:@"back.svg"].UIImage forState:UIControlStateNormal];
    [leftBackBtn setImage:[SVGKImage imageNamed:@"back.svg"].UIImage forState:UIControlStateHighlighted];
    
    [leftBackBtn addTarget:self action:@selector(leftBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.leftBackBtn = leftBackBtn;
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    [closeBtn setImage:[UIImage imageNamed:@"webView_close"] forState:(UIControlStateNormal)];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.closeBtn = closeBtn;
    self.closeBtn.hidden = YES;
    
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    if (@available(iOS 11.0, *)) {
        leftBackBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        closeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    } else {
        spaceItem.width = -15;
    }
    self.navigationItem.leftBarButtonItems = @[spaceItem,[[UIBarButtonItem alloc] initWithCustomView:leftBackBtn], [[UIBarButtonItem alloc] initWithCustomView:closeBtn]];
}

- (void)setHiddenReturnButton:(BOOL)hiddenReturnButton {
    _hiddenReturnButton = hiddenReturnButton;
    
    if(hiddenReturnButton) {
        self.leftBackBtn.hidden = YES;
        self.closeBtn.hidden = YES;
    }
    else{
        self.leftBackBtn.hidden = NO;
        self.closeBtn.hidden = NO;
    }
}

- (void)leftBackBtnClick {
    if(self.showCloseButton) {
        if(self.webView.canGoBack) {
            [self.webView goBack];
        }
        else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)closeBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    [_webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)reLoadWhenViewAppear {
    [super reLoadWhenViewAppear];
    
    if (![self loadNoNetworkView]) {
        if (!_firstLoadPage && self.pageReload) {
            [self reloadPage];
        }
    }
    
    _firstLoadPage = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        if(!self.hiddenReturnButton){
            self.showCloseButton = self.webView.canGoBack;
        }
    }
}

- (void)setShowCloseButton:(BOOL)showCloseButton {
    _showCloseButton = showCloseButton;
    self.closeBtn.hidden = !showCloseButton;
    if(showCloseButton) {
        self.leftBackBtn.width = 25;
    }
    else {
        self.leftBackBtn.width = 50;
    }
}

#pragma mark 无网络重新加载H5
- (void)getNetworkAgain
{
    [self loadWebPage];
}

#pragma mark 安装约束
- (void)setupConstraints {
    kWeakSelf
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
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
    
    if(self.loadResult) {
        self.webView.hidden = NO;
    }
    [self updateConstraints];
}

#pragma mark 注册js回调
- (void)registJavascriptBridge:(NSString *)handlerName handler:(WVJBHandler)handler {
    [self.jsBridge registerHandler:handlerName handler:handler];
}

#pragma mark 调用js
- (void)callHandler:(NSString *)handlerName data:(id)data {
    [self.jsBridge callHandler:handlerName data:data];
}

+ (instancetype)pushWithPageUrl:(NSString *)pageUrl fromController:(HXBBaseViewController *)controller
{
    HXBBaseWebViewController *VC = [HXBBaseWebViewController new];
    VC.pageUrl = pageUrl;
    [controller.navigationController pushViewController:VC animated:YES];
    return VC;
}

#pragma mark webView初始化
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.scalesPageToFit = YES;
        
        if (@available(iOS 11.0, *)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _webView;
}

#pragma mark progressView初始化
- (HXBWKWebViewProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[HXBWKWebViewProgressView alloc] init];
        kWeakSelf
        _progressView.webViewLoadSuccessBlock = ^{
            [weakSelf loadProgress:NO];
        };
    }
    return _progressView;
}

#pragma mark webview协议

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self loadProgress:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.loadResult = YES;
    self.title = [NSString H5Title:[webView stringByEvaluatingJavaScriptFromString:@"document.title"]];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self loadProgress:NO];
}

#pragma mark 进度委托协议
- (void)webViewProgress:(HXBWebViewProgress *)webViewProgress updateProgress:(float)progress {
    if(progress == 0) {
        [self.progressView setProgress:progress animated:NO];
    }
    else{
        [self.progressView setProgress:progress animated:YES];
    }
}

#pragma mark jsBridge初始化
- (WebViewJavascriptBridge *)jsBridge {
    if (!_jsBridge) {
        [WebViewJavascriptBridge enableLogging];
        
        _webViewProgress = [[HXBWebViewProgress alloc] init];
        _webViewProgress.progressDelegate = self;
        _webViewProgress.webViewProxyDelegate = self;
        
        _jsBridge = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:_webViewProgress handler:^(id data, WVJBResponseCallback responseCallback) {
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

#pragma mark 重新加载页面
- (void)reloadPage {
    self.webView.hidden = YES;
    self.loadResult = NO;
    [self.webView reload];
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
