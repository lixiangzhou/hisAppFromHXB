//
//  HXBBaseWebViewController.m
//  hoomxb
//
//  Created by HXB on 2017/5/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseWebViewController.h"
#import <WebKit/WebKit.h>

@interface HXBBaseWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@end

@implementation HXBBaseWebViewController{
    WKWebView * _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//MARK: --- setupWebView
- (void)setupWebView {
    
    //设置导航条
    //创建WkWebView & 解决webView不能播放视频的问题
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
    configuration.allowsInlineMediaPlayback = YES;
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) configuration:configuration];
    if (self.pushURL) {
        [_webView loadRequest:[NSURLRequest requestWithURL:self.pushURL]];
        
        //设置代理
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        
        //打开侧滑手势
        _webView.allowsBackForwardNavigationGestures = YES;

        //加入到self.view
        [self.view addSubview:_webView];
    }
}

#pragma mark - WKNavigationDelegate
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

//MARK: 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO ;
    
    NSLog(@"加载：失败");
}

//MAKR: - 新加的代理方法

//MARK: 这个方法是服务器重定向时调用，即 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
}
//MARK: 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
}
//MARK: 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //需执行decisionHandler的block。
        if (!navigationAction.targetFrame.isMainFrame) {
            [webView evaluateJavaScript:@"var a = document.getElementsByTagName('a');for(var i=0;i<a.length;i++){a[i].setAttribute('target','');}" completionHandler:nil];
        }
        decisionHandler(WKNavigationActionPolicyAllow);
}



#pragma mark - WKUIDelegate
/// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    NSLog(@"加载：打开内部链接");
    
    // 打开内部链接
    return _webView;
    // 不打开
    //    return nil;
}

/// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler
{
    NSLog(@"加载：输入框提示");
    
    completionHandler(@"Client Not handler");
}

/// 确认框]
/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param frame             主窗口
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
    NSLog(@"加载：确认框提示");
    
    //  js 里面的alert实现，如果不实现，网页的alert函数无效
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler(YES);
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action){
                                                          completionHandler(NO);
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:^{}];
}


/// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    NSLog(@"加载：警告框提示");
    
    // js 里面的alert实现，如果不实现，网页的alert函数无效
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler();
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:^{}];
}


#pragma mark - ---------------5、WKWebView疑难--------------
#pragma mark - WKNavigationDelegate
//追踪加载过程，有是否允许加载、开始加载、加载完成、加载失败
//MARK: WKWebView加载POST请求无法发送参数问题
- (void)WKWebViewLoadPOSTRequest{
    
    // 创建WKWebView
    WKWebView *webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 将WKWebView添加到当前View
    [self.view addSubview:webView];
    // 设置访问的URL
    NSURL *url = [NSURL URLWithString:@"http://www.example.com"];
    // 根据URL创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 设置请求方法为POST
    [request setHTTPMethod:@"POST"];
    // 设置请求参数
    [request setHTTPBody:[@"username=aaa&password=123" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 实例化网络会话
    NSURLSession *session = [NSURLSession sharedSession];
    // 创建请求Task
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // 将请求到的网页数据用loadHTMLString 的方法加载
        NSString *htmlStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [webView loadHTMLString:htmlStr baseURL:nil];
    }];
    // 开启网络任务
    [task resume];
}

#pragma mark -  开启加载
- (void)loadRequestWithURL: (NSString *)URL
{
    if ([_webView isLoading]){
        return;
    }
    
    NSURL *url = [NSURL URLWithString:@"http://www.hao123.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    NSLog(@"加载：启动");
}

- (void)stopClick{
    if ([_webView isLoading]){
        [_webView stopLoading];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"加载：停止");
    }
}

@end
