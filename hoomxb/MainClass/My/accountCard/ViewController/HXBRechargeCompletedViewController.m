//
//  HXBRechargeCompletedViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRechargeCompletedViewController.h"
#import "HXBRechargesuccessView.h"
#import "HXBRechargeFailView.h"
#import "HXBLazyCatResponseDelegate.h"
#import "HXBLazyCatResponseModel.h"
#import "HXBRootVCManager.h"

@interface HXBRechargeCompletedViewController () <HXBLazyCatResponseDelegate>

//@property (nonatomic, strong) HXBRechargesuccessView *rechargesuccessView;

@property (nonatomic, weak) UIViewController *popVC;

@property (nonatomic, strong) HXBLazyCatResponseModel *responseModel;

@end

@implementation HXBRechargeCompletedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"充值";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 禁用全屏滑动手势
    ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = NO;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = YES;
}

#pragma mark - HXBLazyCatResponseDelegate
- (void)setResultPageProperty:(HXBLazyCatResponseModel *)model {
    self.contentModel = [HXBCommonResultContentModel new];
    self.contentModel.titleString = model.data.title;
    self.contentModel.descString = model.data.content;
    
    if ([model.result isEqualToString:@"success"]) {
        [self successResult];
    } else if ([model.result isEqualToString:@"error"]) {
        [self errorResult];
    } else if ([model.result isEqualToString:@"timeout"]) {
        [self timeoutResult];
    }
}

- (void)setResultPageWithPopViewControllers:(NSArray *)vcArray {
    self.popVC = vcArray.lastObject;
}

#pragma mark - Helper

- (void)successResult {
    self.contentModel.imageName = @"successful";
    
    self.contentModel.firstBtnTitle = @"立即出借";
    kWeakSelf
    self.contentModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
        [HXBRootVCManager manager].mainTabbarVC.selectedIndex = 0;
        [[HXBRootVCManager manager].mainTabbarVC.selectedViewController popToRootViewControllerAnimated:NO];
        
        [weakSelf.navigationController popToRootViewControllerAnimated:NO];
    };
    
    self.contentModel.secondBtnTitle = @"继续充值";
    self.contentModel.secondBtnBlock = ^(HXBCommonResultController *resultController) {
        [weakSelf toMine];
    };
}

- (void)errorResult {
    self.contentModel.imageName = @"failure";
    
    self.contentModel.firstBtnTitle = @"重新充值";
    kWeakSelf
    self.contentModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
        [weakSelf toMine];
    };
}

- (void)timeoutResult {
    self.contentModel.imageName = @"outOffTime";
    
    self.contentModel.firstBtnTitle = @"我的账户";
    kWeakSelf
    self.contentModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
        [weakSelf toMine];
    };
}

/// 到我的页面
- (void)toMine {
    [HXBRootVCManager manager].mainTabbarVC.selectedIndex = 2;
    [[HXBRootVCManager manager].mainTabbarVC.selectedViewController popToRootViewControllerAnimated:NO];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

#pragma mark - Action

- (void)leftBackBtnClick {
    [self toMine];
}

/*
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"充值成功";
    
    [self.view addSubview:self.rechargesuccessView];
    self.rechargesuccessView.amount = self.amount;
    [self.rechargesuccessView setTitle:self.responseModel.data.title descString:self.responseModel.data.content];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 禁用全屏滑动手势
    ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 恢复全屏滑动手势
    ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = YES;
}

#pragma mark - HXBLazyCatResponseDelegate
- (void)setResultPageWithPopViewControllers:(NSArray *)vcArray {
    self.popVC = vcArray.lastObject;
}

- (void)setResultPageProperty:(HXBLazyCatResponseModel *)model {
    self.responseModel = model;
}

#pragma mark - Lazy
- (HXBRechargesuccessView *)rechargesuccessView
{
    if (!_rechargesuccessView) {
        kWeakSelf
        _rechargesuccessView = [[HXBRechargesuccessView alloc] initWithFrame:CGRectMake(0, HXBStatusBarAndNavigationBarHeight, kScreenWidth, kScreenHeight - HXBStatusBarAndNavigationBarHeight)];
        //继续充值Block
        _rechargesuccessView.continueRechargeBlock = ^{
            [weakSelf.navigationController popToViewController:weakSelf.popVC animated:YES];
        };
        //立即投资
        _rechargesuccessView.immediateInvestmentBlock = ^{
            weakSelf.tabBarController.selectedIndex = 1;
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        };
    }
    return _rechargesuccessView;
}

#pragma mark - Action
- (void)leftBackBtnClick
{
    [self.navigationController popToViewController:self.popVC animated:YES];
}

*/
@end
