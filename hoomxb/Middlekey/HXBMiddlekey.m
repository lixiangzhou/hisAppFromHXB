//
//  HXBMiddlekey.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/24.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMiddlekey.h"

#import "HXBOpenDepositAccountViewController.h"
#import "HXBBaseTabBarController.h"
#import "HxbWithdrawCardViewController.h"
@implementation HXBMiddlekey

+ (void)depositoryJumpLogicWithNAV:(UINavigationController *)nav withOldUserInfo:(HXBRequestUserInfoViewModel *)viewModel
{
    if (![KeyChain isLogin]) {
        //跳转登录注册
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
    }else
    {
        if (viewModel.userInfoModel.userInfo.isUnbundling) {
            [HXBAlertManager callupWithphoneNumber:kServiceMobile andWithTitle:@"温馨提示" Message:[NSString stringWithFormat:@"您的身份信息不完善，请联系客服 %@", kServiceMobile]];
            return;
        }
        
        if (!viewModel.userInfoModel.userInfo.isCreateEscrowAcc) {
            //开通存管银行账户
            HXBOpenDepositAccountViewController *openDepositAccountVC = [[HXBOpenDepositAccountViewController alloc] init];
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
            HXBOpenDepositAccountViewController *openDepositAccountVC = [[HXBOpenDepositAccountViewController alloc] init];
            openDepositAccountVC.title = @"完善信息";
            openDepositAccountVC.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
            [nav pushViewController:openDepositAccountVC animated:YES];
        }else if (![viewModel.userInfoModel.userInfo.hasEverInvest isEqualToString:@"1"]){
            //跳转立即投资
            HXBBaseTabBarController *tabBarVC = (HXBBaseTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            tabBarVC.selectedIndex = 1;
        }

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
                [HXBAlertManager callupWithphoneNumber:kServiceMobile andWithTitle:@"温馨提示" Message:[NSString stringWithFormat:@"您的身份信息不完善，请联系客服 %@", kServiceMobile]];
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

/**
 tableView适配iOS11
 */
+ (void)AdaptationiOS11WithTableView:(UITableView *)tableView
{
    //如果iOS的系统是11.0，会有这样一个宏定义“#define __IPHONE_11_0  110000”；如果系统版本低于11.0则没有这个宏定义
#ifdef __IPHONE_11_0
    if ([tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        if (@available(iOS 11.0, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            tableView.estimatedRowHeight = 0;
            tableView.estimatedSectionHeaderHeight = 0;
            tableView.estimatedSectionFooterHeight = 0;
        } else {
            // Fallback on earlier versions
        }
    }
#endif
}


@end
