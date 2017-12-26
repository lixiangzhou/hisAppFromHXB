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

static NSString *const HXB_Toast = @"toast";
static NSString *const HXB_Dialog = @"dialog";

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
    /****** OC端注册一个方法 (h5 调app 展示信息框)******/
    [self registJavascriptBridge:@"showMessage" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"%@",data);
        [weakSelf showH5MessageWithData:data];
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
    NSString *path = data[@"path"];
    if ([path isEqualToString:kRegisterVC]) {
        //注册
        //跳转登录注册
        HxbSignUpViewController *signUPVC = [[HxbSignUpViewController alloc]init];
        signUPVC.title = @"注册";
        signUPVC.type = HXBSignUPAndLoginRequest_sendSmscodeType_H5;
        [self.navigationController pushViewController:signUPVC animated:YES];
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
            [KeyChain downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
                [weakSelf reloadPage];
            } andFailure:^(NSError *error) {
                
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
        
        HXBXYAlertViewController *alertVC = [[HXBXYAlertViewController alloc] initWithTitle:nil Massage:showMessage force:1 andLeftButtonMassage:@"" andRightButtonMassage:@"确定"];
        [alertVC setClickXYRightButtonBlock:^{
        }];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}


@end
