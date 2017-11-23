//
//  HXBBannerWebViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/8/23.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
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
#define kAccountFriendsRecordActivity @"/account/invite_friends_record_activity"//好友邀请记录


#import "HXBBannerWebViewController.h"
#import "WebViewJavascriptBridge.h"
#import "HxbMyTopUpViewController.h"//充值
#import "HXBOpenDepositAccountViewController.h"//开通存管用户
#import "HXBFinancing_PlanDetailsViewController.h"//红利计划详情
#import "HXBFinancing_LoanDetailsViewController.h"//散标详情页
#import "HXBBaseTabBarController.h"//红利计划
#import "HXBUMengShareManager.h"
#import "HXBUMShareViewModel.h"
#import "HXBUMShareModel.h"
#import "HXBInviteListViewController.h"

@interface HXBBannerWebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) WebViewJavascriptBridge* bridge;
@end

@implementation HXBBannerWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    self.isColourGradientNavigationBar = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    
    [self setupJavascriptBridge];
    
    [self setupSubViewFrame];
    
    
}

- (void)setupSubViewFrame {
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(HXBStatusBarAndNavigationBarHeight);
        make.left.right.bottom.equalTo(self.view);
    }];
}


/**
 初始化与H5交互
 */
- (void)setupJavascriptBridge {
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
    [self.bridge registerHandler:@"share" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"%@",data);
        
        HXBUMShareViewModel *shareViewModel = [[HXBUMShareViewModel alloc] init];
        shareViewModel.shareModel = [HXBUMShareModel yy_modelWithDictionary:data];
        [HXBUMengShareManager showShareMenuViewInWindowWith:shareViewModel];
    }];


}

/**
 再次获取网络数据
 */
- (void)getNetworkAgain
{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
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
        [baseVC.navigationController pushViewController:openDepositAccountVC animated:NO];
    }else if ([data[@"path"] isEqualToString:kPlanDetailVC]){
        //某个计划的详情页
        HXBFinancing_PlanDetailsViewController *planDetailsVC = [[HXBFinancing_PlanDetailsViewController alloc]init];
        NSString *productId = data[@"productId"];
        if (productId != nil) {
            planDetailsVC.planID = productId;
            planDetailsVC.isPlan = true;
            planDetailsVC.isFlowChart = true;
            [baseVC.navigationController pushViewController:planDetailsVC animated:NO];
        }
    }else if ([data[@"path"] isEqualToString:kLoanDetailVC]){
        //某个散标的详情页
        HXBFinancing_LoanDetailsViewController *loanDetailsVC = [[HXBFinancing_LoanDetailsViewController alloc]init];
        NSString *productId = data[@"productId"];
        if (productId != nil) {
            
            loanDetailsVC.loanID = productId;
            
            [baseVC.navigationController pushViewController:loanDetailsVC animated:NO];
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
    }else if ([data[@"path"] isEqualToString:kAccountFriendsRecordActivity]){
        HXBInviteListViewController *inviteListVC = [[HXBInviteListViewController alloc] init];
        [baseVC.navigationController pushViewController:inviteListVC animated:NO];
    }
   
}
#pragma mark - Event
- (void)shareBtnClick {
    [HXBUMengShareManager showShareMenuViewInWindowWith:nil];
}


#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        return NO;
    }
    
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [HxbHUDProgress hidenHUD:self.webView];
    self.title = [HXBMiddlekey H5Title:[webView stringByEvaluatingJavaScriptFromString:@"document.title"]];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark - 懒加载
- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, HxbNavigationBarY, kScreenWidth, kScreenHeight - HxbNavigationBarY)];
        _webView.delegate = self;
        _webView.scalesPageToFit = YES;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.bounces = NO;
        // UIWebView 滚动的比较慢，这里设置为正常速度
        _webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
        NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init];
        [urlRequest setURL:[NSURL URLWithString:self.url]];
        NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
        NSString *version = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
        NSString *userAgent = [NSString stringWithFormat:@"%@/IOS %@/v%@ iphone" ,[HXBDeviceVersion deviceVersion],systemVersion,version];
        NSLog(@"测试token：%@结束",[KeyChain token]);
        [urlRequest setValue:[KeyChain token] forHTTPHeaderField:@"X-Hxb-Auth-Token"];
        [urlRequest setValue:userAgent forHTTPHeaderField:X_Hxb_User_Agent];
        [_webView loadRequest:urlRequest];
        [HxbHUDProgress showLoadDataHUD:_webView];
    }
    return _webView;
}


@end
