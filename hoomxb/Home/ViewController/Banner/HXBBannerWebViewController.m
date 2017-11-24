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

@interface HXBBannerWebViewController ()

@end

@implementation HXBBannerWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    self.isColourGradientNavigationBar = YES;
    self.pageReload = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupJavascriptBridge];
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
    
    [self registJavascriptBridge:@"share" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"%@",data);
        HXBUMShareViewModel *shareViewModel = [[HXBUMShareViewModel alloc] init];
        shareViewModel.shareModel = [HXBUMShareModel yy_modelWithDictionary:data];
        [HXBUMengShareManager showShareMenuViewInWindowWith:shareViewModel];
    }];
    
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


@end
