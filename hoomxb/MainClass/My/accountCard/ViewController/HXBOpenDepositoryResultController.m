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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"开通恒丰银行资金存管";
}

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
    self.contentModel.imageName = @"successful";
    
    self.contentModel.firstBtnTitle = @"去充值";
    kWeakSelf
    self.contentModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
        [weakSelf popToMine];
    };
    
    self.contentModel.secondBtnTitle = @"先逛逛";
    self.contentModel.secondBtnBlock = ^(HXBCommonResultController *resultController) {
        [weakSelf popToHomeVC];
    };
}

- (void)errorResult {
    self.contentModel.imageName = @"failure";
    
    self.contentModel.firstBtnTitle = @"重新开户";
    kWeakSelf
    self.contentModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
        [resultController.navigationController popToViewController:weakSelf.openDepositoryVC animated:YES];
    };
}

- (void)timeoutResult {
    self.contentModel.imageName = @"outOffTime";
    
    self.contentModel.firstBtnTitle = @"我的账户";
    kWeakSelf
    self.contentModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
        [weakSelf popToMine];
    };
}

- (void)popToHomeVC {
    if (self.openDepositoryTipVC) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    // 当前控制器 pop 到栈顶
    UINavigationController *currentNavVC = [HXBRootVCManager manager].mainTabbarVC.selectedViewController;
    [currentNavVC popToRootViewControllerAnimated:NO];
    
    // 跳转到首页
    [HXBRootVCManager manager].mainTabbarVC.selectedIndex = 0;
    [[HXBRootVCManager manager].mainTabbarVC.selectedViewController popToRootViewControllerAnimated:NO];
    
}

- (void)popToMine {
    if (self.openDepositoryTipVC) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    // 当前控制器 pop 到栈顶
    UINavigationController *currentNavVC = [HXBRootVCManager manager].mainTabbarVC.selectedViewController;
    [currentNavVC popToRootViewControllerAnimated:NO];
    
    // 跳转到我的
    [HXBRootVCManager manager].mainTabbarVC.selectedIndex = 2;
    [[HXBRootVCManager manager].mainTabbarVC.selectedViewController popToRootViewControllerAnimated:NO];
}

#pragma mark - Action

- (void)leftBackBtnClick {
    if ([self.result isEqualToString:@"success"]) {
        [self popToHomeVC];
    } else {
        [self.navigationController popToViewController:self.openDepositoryVC animated:YES];
    }
}

@end
