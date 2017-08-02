//
//  HXBMiddlekey.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/24.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMiddlekey.h"

#import "HXBOpenDepositAccountViewController.h"
#import "HXBBaseTabBarController.h"
#import "HxbWithdrawCardViewController.h"
@implementation HXBMiddlekey

+ (void)depositoryJumpLogicWithNAV:(UINavigationController *)nav
{
    if (![KeyChain isLogin]) {
        //跳转登录注册
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
    }else
    {
        
        [KeyChain downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
            
            if (viewModel.userInfoModel.userInfo.isUnbundling) {
                [HXBAlertManager callupWithphoneNumber:@"4001551888" andWithMessage:@"您已经在后台解绑身份证请联系客服"];
                return;
            }
            
            HXBOpenDepositAccountViewController *openDepositAccountVC = [[HXBOpenDepositAccountViewController alloc] init];
            if (!viewModel.userInfoModel.userInfo.isCreateEscrowAcc) {
                //开通存管银行账户
                openDepositAccountVC.title = @"开通存管账户";
                openDepositAccountVC.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
                [nav pushViewController:openDepositAccountVC animated:YES];
                
            } else if ([viewModel.userInfoModel.userInfo.isCashPasswordPassed isEqualToString:@"1"] && [viewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"0"])
            {
                //进入绑卡界面
                HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc]init];
                withdrawCardViewController.title = @"绑卡";
                withdrawCardViewController.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
                [nav pushViewController:withdrawCardViewController animated:YES];
            }else if (!([viewModel.userInfoModel.userInfo.isCashPasswordPassed isEqualToString:@"1"] && [viewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"]))
            {
                //完善信息
                openDepositAccountVC.title = @"完善信息";
                openDepositAccountVC.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
                [nav pushViewController:openDepositAccountVC animated:YES];
            }else if (![viewModel.userInfoModel.userInfo.hasEverInvest isEqualToString:@"1"]){
                //跳转立即投资
                HXBBaseTabBarController *tabBarVC = (HXBBaseTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                tabBarVC.selectedIndex = 1;
            }
            
        } andFailure:^(NSError *error) {
            
        }];
    }
}

+ (void)rechargePurchaseJumpLogicWithNAV:(UINavigationController *)nav
{
    if (![KeyChain isLogin]) {
        //跳转登录注册
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
    }else
    {
        
        [KeyChain downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
            
            if (viewModel.userInfoModel.userInfo.isUnbundling) {
                [HXBAlertManager callupWithphoneNumber:@"4001551888" andWithMessage:@"您已经在后台解绑身份证请联系客服"];
                return;
            }
            
            HXBOpenDepositAccountViewController *openDepositAccountVC = [[HXBOpenDepositAccountViewController alloc] init];
            
            if (!viewModel.userInfoModel.userInfo.isCreateEscrowAcc) {
                //开通存管银行账户
                openDepositAccountVC.title = @"开通存管账户";
                [nav pushViewController:openDepositAccountVC animated:YES];
                
            } else if ([viewModel.userInfoModel.userInfo.isCashPasswordPassed isEqualToString:@"1"] && [viewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"0"])
            {
                
                //进入绑卡界面
                HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc]init];
                withdrawCardViewController.title = @"绑卡";
                [nav pushViewController:withdrawCardViewController animated:YES];
            }else if (!([viewModel.userInfoModel.userInfo.isCashPasswordPassed isEqualToString:@"1"] && [viewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"]))
            {
                //完善信息
                openDepositAccountVC.title = @"完善信息";
                [nav pushViewController:openDepositAccountVC animated:YES];
            }
        } andFailure:^(NSError *error) {
            
        }];
    }
}
@end
