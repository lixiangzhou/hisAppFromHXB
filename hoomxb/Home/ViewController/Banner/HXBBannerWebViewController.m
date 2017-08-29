//
//  HXBBannerWebViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/8/23.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#define kRegisterVC @"/account/register"//注册页面
#define kRechargeVC @"/cash/recharge"//充值页面
#define kEscrowActivityVC @"/home/EscrowActivity"//存管开户页面
#define kPlanDetailVC @"/plan/detail"//某个计划的详情页
#define kLoanDetailVC @"/loan/detail"//某个散标的详情页
#define kLoginVC @"/account/login"//登录页面
#define kHomeVC @"/home/main"//主页
#define kPlan_fragment @"/home/plan_fragment"//红利计划列表页
#define kLoan_fragment @"/home/loan_fragment"//散标列表页
#define kLoantransferfragment @"/home/loan_transfer_fragment"//债权转让列表页

#import "HXBBannerWebViewController.h"
#import "WebViewJavascriptBridge.h"
#import "HxbMyTopUpViewController.h"//充值
#import "HXBOpenDepositAccountViewController.h"//开通存管用户
#import "HXBFinancing_PlanDetailsViewController.h"//红利计划详情
#import "HXBFinancing_LoanDetailsViewController.h"//散标详情页
#import "HXBBaseTabBarController.h"//红利计划
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
    //跳转立即投资
    HXBBaseTabBarController *tabBarVC = (HXBBaseTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *baseVC = [self.navigationController.viewControllers firstObject];
    [self.navigationController popViewControllerAnimated:NO];
    if ([data[@"path"] isEqualToString:kRegisterVC]) {
        //注册
        //跳转登录注册
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
    }else if ([data[@"path"] isEqualToString:kRechargeVC]){
        //充值页面
        HxbMyTopUpViewController *hxbMyTopUpViewController = [[HxbMyTopUpViewController alloc]init];
        [baseVC.navigationController pushViewController:hxbMyTopUpViewController animated:YES];
    }else if ([data[@"path"] isEqualToString:kEscrowActivityVC]){
        //存管开户页面
        HXBOpenDepositAccountViewController *openDepositAccountVC = [[HXBOpenDepositAccountViewController alloc] init];
        openDepositAccountVC.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
        openDepositAccountVC.title = @"开通存管账户";
        [baseVC.navigationController pushViewController:openDepositAccountVC animated:YES];
    }else if ([data[@"path"] isEqualToString:kPlanDetailVC]){
        //某个计划的详情页
        HXBFinancing_PlanDetailsViewController *planDetailsVC = [[HXBFinancing_PlanDetailsViewController alloc]init];
        NSString *productId = data[@"productId"];
        if (productId != nil) {
            planDetailsVC.planID = productId;
            planDetailsVC.isPlan = true;
            planDetailsVC.isFlowChart = true;
            planDetailsVC.hidesBottomBarWhenPushed = true;
            [baseVC.navigationController pushViewController:planDetailsVC animated:true];
        }
    }else if ([data[@"path"] isEqualToString:kLoanDetailVC]){
        //某个散标的详情页
        HXBFinancing_LoanDetailsViewController *loanDetailsVC = [[HXBFinancing_LoanDetailsViewController alloc]init];
        NSString *productId = data[@"productId"];
        if (productId != nil) {
            
            loanDetailsVC.loanID = productId;
            
            loanDetailsVC.hidesBottomBarWhenPushed = true;
            [baseVC.navigationController pushViewController:loanDetailsVC animated:true];
        }
        
    }else if ([data[@"path"] isEqualToString:kLoginVC]){
        //登录页面
        //跳转登录注册
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
    }else if ([data[@"path"] isEqualToString:kHomeVC]){
        //主页
       
    }else if ([data[@"path"] isEqualToString:kPlan_fragment]){
        //红利计划列表页
        tabBarVC.selectedIndex = 1;
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_PlanAndLoan_Fragment object:@{@"selectedIndex" : @0}];
    }else if ([data[@"path"] isEqualToString:kLoan_fragment]){
        //散标列表页
        tabBarVC.selectedIndex = 1;
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_PlanAndLoan_Fragment object:@{@"selectedIndex" : @1}];
    }else if ([data[@"path"] isEqualToString:kLoantransferfragment]){
        //主页债权转让列表页
        tabBarVC.selectedIndex = 1;
    }
   
}


#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"%@",request);
    
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
        NSString *userAgent = [NSString stringWithFormat:@"Iphone/IOS %@/v%@" ,systemVision,version];
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
