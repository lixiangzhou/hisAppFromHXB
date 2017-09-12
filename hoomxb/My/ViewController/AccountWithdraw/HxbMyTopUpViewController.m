//
//  HxbMyTopUpViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbMyTopUpViewController.h"
#import "HxbSecurityCertificationViewController.h"
#import "HxbBindCardViewController.h"
#import "HXBMyTopUpBaseView.h"


#import "HXBRechargeCompletedViewController.h"
#import "HXBAlertVC.h"
#import "HXBOpenDepositAccountRequest.h"
#import "HXBFBase_BuyResult_VC.h"
@interface HxbMyTopUpViewController ()

@property (nonatomic, strong) HXBMyTopUpBaseView *myTopUpBaseView;

@end

@implementation HxbMyTopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isColourGradientNavigationBar = YES;
    self.title = @"充值";
    [self.view addSubview:self.myTopUpBaseView];
}


- (HXBMyTopUpBaseView *)myTopUpBaseView
{
    if (!_myTopUpBaseView) {
        kWeakSelf
        _myTopUpBaseView = [[HXBMyTopUpBaseView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _myTopUpBaseView.rechargeBlock = ^{
            [weakSelf enterRecharge];
        };
        if (self.amount.floatValue) {
            _myTopUpBaseView.amount = _amount;
        }
    }
    return _myTopUpBaseView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isColourGradientNavigationBar = YES;
    kWeakSelf
    [KeyChain downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        weakSelf.myTopUpBaseView.viewModel = viewModel;
    } andFailure:^(NSError *error) {
        
    }];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.myTopUpBaseView.amount = @"";
}

/**
 快捷充值请求
 */
- (void)enterRecharge
{
    kWeakSelf
    HXBOpenDepositAccountRequest *accountRequest = [[HXBOpenDepositAccountRequest alloc] init];
    [accountRequest accountRechargeRequestWithRechargeAmount:self.myTopUpBaseView.amount andSuccessBlock:^(id responseObject) {
        [weakSelf requestRechargeResult];
    } andFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

/**
 快捷充值确认
 */
- (void)requestRechargeResult
{
    HXBAlertVC *alertVC = nil;
   if (self.presentedViewController)
   {
       alertVC = (HXBAlertVC *)self.presentedViewController;
   }else
   {
       alertVC = [[HXBAlertVC alloc] init];
       [self presentViewController:alertVC animated:NO completion:nil];
   }
    kWeakSelf
    alertVC.isCode = YES;
    alertVC.messageTitle = @"请输入您的短信验证码";
    __weak typeof(alertVC) weakAlertVC = alertVC;
    alertVC.sureBtnClick = ^(NSString *pwd){
        HXBOpenDepositAccountRequest *accountRequest = [[HXBOpenDepositAccountRequest alloc] init];
        [accountRequest accountRechargeResultRequestWithSmscode:pwd andWithQuickpayAmount:self.myTopUpBaseView.amount andSuccessBlock:^(id responseObject) {
            
            NSInteger status =  [responseObject[@"status"] integerValue];
            if (status == 104) return ;

            if (status != 0) {
                [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
//                kWeakSelf
//                HXBFBase_BuyResult_VC *result = [[HXBFBase_BuyResult_VC alloc] init];
//                result.title = @"充值失败";
//                result.imageName = @"failure";
//                result.buy_title = @"充值失败";
//                result.buy_description = responseObject[@"message"];
//                result.buy_ButtonTitle = @"重新充值";
//                [result clickButtonWithBlock:^{
//                    [weakSelf.navigationController popViewControllerAnimated:YES];
//                }];
//                [weakAlertVC dismissViewControllerAnimated:NO completion:nil];
//                [self.navigationController pushViewController:result animated:YES];
                
            }else
            {
                [weakAlertVC dismissViewControllerAnimated:NO completion:nil];
                HXBRechargeCompletedViewController *rechargeCompletedVC = [[HXBRechargeCompletedViewController alloc] init];
                rechargeCompletedVC.responseObject = responseObject;
                rechargeCompletedVC.amount = weakSelf.myTopUpBaseView.amount;
                [self.navigationController pushViewController:rechargeCompletedVC animated:YES];
            }
            
        } andFailureBlock:^(NSError *error) {
            
        }];
    };
    alertVC.getVerificationCodeBlock = ^{
        [weakSelf enterRecharge];
    };
    
}
- (void)leftBackBtnClick
{
    NSInteger index = self.navigationController.viewControllers.count;
    UIViewController *VC = self.navigationController.viewControllers[index - 2];
    if ([VC isKindOfClass:NSClassFromString(@"HXBOpenDepositAccountViewController")] || [VC isKindOfClass:NSClassFromString(@"HxbWithdrawCardViewController")] || [VC isKindOfClass:NSClassFromString(@"HXBFin_Plan_BuyViewController")]) {
        [self.navigationController popToViewController:self.navigationController.viewControllers[index - 3] animated:YES];
    }else
    {
        [super leftBackBtnClick];
    }
}
@end


