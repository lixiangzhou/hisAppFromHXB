//
//  HXBOpenDepositoryResultController.m
//  hoomxb
//
//  Created by lxz on 2018/5/2.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBOpenDepositoryResultController.h"
#import "HXBLazyCatResponseDelegate.h"
#import "HXBLazyCatResponseModel.h"
#import "HxbMyTopUpViewController.h"
#import "HXBRootVCManager.h"
#import "HxbAccountInfoViewController.h"

@interface HXBOpenDepositoryResultController () <HXBLazyCatResponseDelegate>
@property (nonatomic, weak) UIViewController *openDepositoryVC;
@property (nonatomic, weak) UIViewController *openDepositoryTipVC;

@property (nonatomic, copy) NSString *result;
@end

@implementation HXBOpenDepositoryResultController

#pragma mark - HXBLazyCatResponseDelegate
- (void)setResultPageProperty:(HXBLazyCatResponseModel *)model {
    self.contentModel = [HXBCommonResultContentModel new];
    self.contentModel.titleString = model.data.title;
    self.contentModel.descString = model.data.content;
    
    self.result = model.result;
    if ([model.result isEqualToString:@"success"]) {
        [self successResult];
    } else if ([model.result isEqualToString:@"error"]) {
        [self errorResult];
    } else if ([model.result isEqualToString:@"timeout"]) {
        [self timeoutResult];
    }
}

- (void)setResultPageWithPopViewControllers:(NSArray *)vcArray {
    for (UIViewController *VC in vcArray) {
        if ([VC isKindOfClass:NSClassFromString(@"HXBOpenDepositAccountViewController")]) {
            self.openDepositoryVC = VC;
        } else if ([VC isKindOfClass:NSClassFromString(@"HXBBindBankCardViewController")]) {
            self.openDepositoryTipVC = VC;
        }
    }
}

#pragma mark - Helper

- (void)successResult {
    self.contentModel.imageName = @"";
    
    self.contentModel.firstBtnTitle = @"去充值";
    kWeakSelf
    self.contentModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
        [HXBRootVCManager manager].mainTabbarVC.selectedIndex = 2;
        [[HXBRootVCManager manager].mainTabbarVC.selectedViewController.navigationController popToRootViewControllerAnimated:NO];
        // 以防万一
        [resultController.navigationController popToRootViewControllerAnimated:NO];
        if (weakSelf.openDepositoryTipVC) {
            [resultController dismissViewControllerAnimated:NO completion:nil];
        }
    };
    
    self.contentModel.secondBtnTitle = @"先逛逛";
    self.contentModel.secondBtnBlock = ^(HXBCommonResultController *resultController) {
        [weakSelf popToHomeVC];
    };
}

- (void)errorResult {
    self.contentModel.imageName = @"";
    
    self.contentModel.firstBtnTitle = @"返回";
    kWeakSelf
    self.contentModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
        [resultController.navigationController popToViewController:weakSelf.openDepositoryVC animated:YES];
    };
}

- (void)timeoutResult {
    self.contentModel.imageName = @"";
    
    self.contentModel.firstBtnTitle = @"我的账户";
    self.contentModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
        [KeyChain downLoadUserInfoWithRequestBlock:^(NYBaseRequest *request) {
            request.showHud = YES;
        } resultBlock:^(HXBRequestUserInfoViewModel *viewModel, NSError *error) {
            if (error == nil) {
                [HXBRootVCManager manager].mainTabbarVC.selectedIndex = 2;
                [[HXBRootVCManager manager].mainTabbarVC.selectedViewController.navigationController popToRootViewControllerAnimated:NO];
                [resultController.navigationController popToRootViewControllerAnimated:NO];
                
                HxbAccountInfoViewController *accountInfoVC = [[HxbAccountInfoViewController alloc]init];
                accountInfoVC.userInfoViewModel = viewModel;
                accountInfoVC.isDisplayAdvisor = viewModel.userInfoModel.userInfo.isDisplayAdvisor;
                [resultController.navigationController pushViewController:accountInfoVC animated:YES];
            }
        }];
    };
}

- (void)popToHomeVC {
    [HXBRootVCManager manager].mainTabbarVC.selectedIndex = 0;
    [[HXBRootVCManager manager].mainTabbarVC.selectedViewController.navigationController popToRootViewControllerAnimated:NO];
    // 以防万一
    [self.navigationController popToRootViewControllerAnimated:NO];
    if (self.openDepositoryTipVC) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

#pragma mark - Action

- (void)leftBackBtnClick {
    if ([self.result isEqualToString:@""]) {
        [self popToHomeVC];
    } else {
        [self.navigationController popToViewController:self.openDepositoryVC animated:YES];
    }
}

@end
