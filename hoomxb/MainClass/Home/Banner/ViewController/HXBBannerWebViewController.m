//
//  HXBBannerWebViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/8/23.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

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
#import "HxbSignUpViewController.h"//注册
#import "HXBDepositoryAlertViewController.h"//开户弹框
#import "HXBBannerViewModel.h"

static NSString *const HXB_Toast = @"toast";
static NSString *const HXB_Dialog = @"dialog";

@interface HXBBannerWebViewController ()
@property (nonatomic, strong) HXBBannerViewModel* viewModel;
@end

@implementation HXBBannerWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(!self.pageTitle) {
       self.title = @"";
    }
    self.isColourGradientNavigationBar = YES;
    self.pageReload = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupJavascriptBridge];
    [self setupShareBtn];
}

#pragma mark 初始化viewModel
- (HXBBannerViewModel *)viewModel {
    if(!_viewModel) {
        kWeakSelf
        _viewModel = [[HXBBannerViewModel alloc] initWithBlock:^UIView *{
            return weakSelf.view;
        }];
    }
    
    return _viewModel;
}

- (void)setupShareBtn {
    self.viewModel.model = self.model;
    if ([self.viewModel isNeedShare]) {
        UIButton *shareBtn = [[UIButton alloc] initWithFrame: CGRectMake(kScreenW - HXBNavigationBarHeight, 0, HXBNavigationBarHeight, HXBNavigationBarHeight)];
        shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, kScrAdaptationW(15));
        [shareBtn setImage:[UIImage imageNamed:@"share"] forState:(UIControlStateNormal)];
        [shareBtn addTarget:self action:@selector(shareClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self.navigationController.navigationBar addSubview:shareBtn];
    }
    
}

- (void)shareClick {
    [self.viewModel share];
}
/**
 初始化与H5交互
 */
- (void)setupJavascriptBridge {

    kWeakSelf
    /****** OC端注册一个方法 (测试)******/
    [self registJavascriptBridge:@"startPage" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"%@",data);
        [weakSelf logicalJumpWithData:data];
    }];
    /****** OC端注册一个方法 (h5 调app 展示信息框)******/
    [self registJavascriptBridge:@"showMessage" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"%@",data);
        [weakSelf showH5MessageWithData:data];
    }];
    [self registJavascriptBridge:@"startH5Page" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"%@",data);
        [weakSelf h5PageJumpWithData:data];
    }];
    [self registJavascriptBridge:@"share" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"%@",data);
        HXBUMShareViewModel *shareViewModel = [[HXBUMShareViewModel alloc] init];
        shareViewModel.shareModel = [HXBUMShareModel yy_modelWithDictionary:data];
        /// FIXME
        [HXBUMengShareManager showShareMenuViewInWindowWith:shareViewModel shareStatus:@"link"];
    }];
    
}

/**
 跳转H5页面的回调

 @param data 参数
 */
- (void)h5PageJumpWithData:(id)data
{
    NSDictionary* urlParamDic = data;
    NSString *path = [urlParamDic stringAtPath:@"path"];
    
    if([path isEqualToString:kH5LandingDeposit]){
        HXBBannerWebViewController* webviewVC = [[HXBBannerWebViewController alloc] init];
        webviewVC.pageTitle = [urlParamDic stringAtPath:@"title"];
        webviewVC.pageUrl = [NSString stringWithFormat:@"%@%@", [KeyChainManage sharedInstance].h5host, path];
        [self.navigationController pushViewController:webviewVC animated:YES];
    }
    else if([path isEqualToString:kH5LandingTrust]) {
        HXBBaseWKWebViewController* webviewVC = [[HXBBaseWKWebViewController alloc] init];
        webviewVC.pageTitle = [urlParamDic stringAtPath:@"title"];
        webviewVC.pageUrl = [NSString stringWithFormat:@"%@%@", [KeyChainManage sharedInstance].h5host, path];
        [self.navigationController pushViewController:webviewVC animated:YES];
    }
}
///**
// 再次获取网络数据
// */
//- (void)getNetworkAgain
//{
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.pageUrl]]];
//}

- (void)logicalJumpWithData:(id)data
{
    //跳转立即投资
    HXBBaseTabBarController *tabBarVC = (HXBBaseTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    NSString *path = data[@"path"];
    if ([path isEqualToString:kRegisterVC]) {
        //注册
        //跳转登录注册
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowSignUpVC object:nil];
    }else if ([path isEqualToString:kRechargeVC]){
        //充值页面
        HxbMyTopUpViewController *hxbMyTopUpViewController = [[HxbMyTopUpViewController alloc]init];
        [self.navigationController pushViewController:hxbMyTopUpViewController animated:YES];
    }else if ([path isEqualToString:kEscrowActivityVC]){
        //存管开户页面
        HXBOpenDepositAccountViewController *openDepositAccountVC = [[HXBOpenDepositAccountViewController alloc] init];
        openDepositAccountVC.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
        openDepositAccountVC.title = @"开通存管账户";
        [self.navigationController pushViewController:openDepositAccountVC animated:YES];
    }else if ([path isEqualToString:kPlanDetailVC]){
        //某个计划的详情页
        HXBFinancing_PlanDetailsViewController *planDetailsVC = [[HXBFinancing_PlanDetailsViewController alloc]init];
        NSString *productId = data[@"productId"];
        if (productId != nil) {
            planDetailsVC.planID = productId;
            planDetailsVC.isPlan = YES;
            planDetailsVC.isFlowChart = YES;
            [self.navigationController pushViewController:planDetailsVC animated:YES];
        }
    }else if ([path isEqualToString:kLoanDetailVC]){
        //某个散标的详情页
        HXBFinancing_LoanDetailsViewController *loanDetailsVC = [[HXBFinancing_LoanDetailsViewController alloc]init];
        NSString *productId = data[@"productId"];
        if (productId != nil) {
            
            loanDetailsVC.loanID = productId;
            
            [self.navigationController pushViewController:loanDetailsVC animated:YES];
        }
        
    }else if ([path isEqualToString:kLoginVC]){
        if(KeyChain.isLogin) {
            kWeakSelf
            [self.viewModel downLoadUserInfo:YES resultBlock:^(BOOL isSuccess) {
                if(isSuccess) {
                    [weakSelf reloadPage];
                }
            }];
        }
        else{
            //登录页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
        }
        
    }else if ([path isEqualToString:kHomeVC]){
        //主页
       [self.navigationController popViewControllerAnimated:NO];
        tabBarVC.selectedIndex = 0;
    }else if ([path isEqualToString:kPlan_fragment]){
        //红利计划列表页
        [self.navigationController popViewControllerAnimated:NO];
        tabBarVC.selectedIndex = 1;
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_PlanAndLoan_Fragment object:@{@"selectedIndex" : @0}];
    }else if ([path isEqualToString:kLoan_fragment]){
        //散标列表页
        [self.navigationController popViewControllerAnimated:NO];
        tabBarVC.selectedIndex = 1;
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_PlanAndLoan_Fragment object:@{@"selectedIndex" : @1}];
    }else if ([path isEqualToString:kLoantransferfragment]){
        //主页债权转让列表页
        [self.navigationController popViewControllerAnimated:NO];
        tabBarVC.selectedIndex = 1;
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_PlanAndLoan_Fragment object:@{@"selectedIndex" : @2}];
    }else if ([path isEqualToString:kAccountFriendsRecordActivity]){
        HXBInviteListViewController *inviteListVC = [[HXBInviteListViewController alloc] init];
        [self.navigationController pushViewController:inviteListVC animated:YES];
    }else if ([path isEqualToString:kEscrowdialogActivityVC]){
        [HXBDepositoryAlertViewController showEscrowDialogActivityWithVCTitle:@"开通存管账户" andType:(HXBRechargeAndWithdrawalsLogicalJudgment_Other) andWithFromController:self.navigationController];
    }
   
}

// H5回传弹出样式
- (void)showH5MessageWithData:(id)data {
    NSString *type = data[@"type"];
    NSString *showMessage = data[@"message"];
    if ([type isEqualToString:HXB_Toast]) {
        
        [HxbHUDProgress showTextWithMessage:showMessage];
    } else if ([type isEqualToString:HXB_Dialog]) {
        
        HXBXYAlertViewController *alertVC = [[HXBXYAlertViewController alloc] initWithTitle:nil Massage:showMessage force:2 andLeftButtonMassage:@"" andRightButtonMassage:@"确定"];
        [alertVC setClickXYRightButtonBlock:^{
        }];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}


@end
