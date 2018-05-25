//
//  HxbMyTopUpViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbMyTopUpViewController.h"
#import "HxbSecurityCertificationViewController.h"
#import "HXBMyTopUpBaseView.h"
#import "HXBVerificationCodeAlertVC.h"
#import "HXBBankCardModel.h"
#import "HXBMyTopUpBankView.h"
#import "HXBMyTopUpVCViewModel.h"
#import "HXBRootVCManager.h"
#import "HXBLazyCatAccountWebViewController.h"

@interface HxbMyTopUpViewController ()

@property (nonatomic, strong) HXBMyTopUpBaseView *myTopUpBaseView;

@property (nonatomic, strong) HXBMyTopUpVCViewModel *viewModel;
@end

@implementation HxbMyTopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isColourGradientNavigationBar = YES;
    self.title = @"充值";
    [self.view addSubview:self.myTopUpBaseView];
    
    [self getBankData];
//    kWeakSelf
//    [self.bankCardViewModel requestBankDataResultBlock:^(BOOL isSuccess) {
//        if (isSuccess) {
//            weakSelf.bankCardModel = weakSelf.bankCardViewModel.bankCardModel;
//            //设置绑卡信息
//            weakSelf.bankNameLabel.text = weakSelf.bankCardModel.bankType;
//            weakSelf.bankCardNumLabel.text = [NSString stringWithFormat:@"（尾号%@）",[weakSelf.bankCardModel.cardId substringFromIndex:weakSelf.bankCardModel.cardId.length - 4]];
//            weakSelf.amountLimitLabel.text = weakSelf.bankCardModel.quota;
//            weakSelf.bankLogoImageView.svgImageString = weakSelf.bankCardModel.bankCode;
//            if (weakSelf.bankLogoImageView.image == nil) {
//                weakSelf.bankLogoImageView.svgImageString = @"默认";
//            }
//        }
//    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 禁用全屏滑动手势
    NSInteger index = self.navigationController.viewControllers.count;
    UIViewController *VC = self.navigationController.viewControllers[index - 2];
    if ([VC isKindOfClass:NSClassFromString(@"HXBOpenDepositAccountViewController")] || [VC isKindOfClass:NSClassFromString(@"HxbWithdrawCardViewController")]) {
        ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = NO;
    }
    
    self.isColourGradientNavigationBar = YES;
    
    kWeakSelf
    [self.viewModel downLoadUserInfo:YES resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.myTopUpBaseView.viewModel = weakSelf.viewModel.userInfoModel;
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 恢复全屏滑动手势
    ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.myTopUpBaseView.amount = @"";
}

- (void)getBankData {
    kWeakSelf
    [self.viewModel requestBankData:^(BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.myTopUpBaseView.mybankView.bankCardModel = weakSelf.viewModel.bankCardModel;
        }
    }];
}

#pragma mark - Action
/**
 快捷充值请求
 */
- (void)enterRecharge
{
    [self.view endEditing:YES];
    kWeakSelf
    [self.viewModel accountQuickChargeWithAmount:self.myTopUpBaseView.amount resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            HXBLazyCatAccountWebViewController *webVC = [HXBLazyCatAccountWebViewController new];
            webVC.requestModel = weakSelf.viewModel.lazyCatReqModel;
            [weakSelf.navigationController pushViewController:webVC animated:YES];
        }
    }];
}

- (void)leftBackBtnClick
{
    NSInteger index = self.navigationController.viewControllers.count;
    UIViewController *VC = self.navigationController.viewControllers[index - 2];
    if ([VC isKindOfClass:NSClassFromString(@"HXBOpenDepositAccountViewController")] || [VC isKindOfClass:NSClassFromString(@"HxbWithdrawCardViewController")]) {
        [self.navigationController popToViewController:self.navigationController.viewControllers[index - 3] animated:YES];
    }else
    {
        [super leftBackBtnClick];
    }
}

#pragma mark Get Methods
- (HXBMyTopUpVCViewModel *)viewModel {
    if (!_viewModel) {
        kWeakSelf
        _viewModel = [[HXBMyTopUpVCViewModel alloc] initWithBlock:^UIView *{
            if (weakSelf.presentedViewController) {
                return weakSelf.presentedViewController.view;
            }
            else {
                return weakSelf.view;
            }
        }];
    }
    return _viewModel;
}

- (HXBMyTopUpBaseView *)myTopUpBaseView
{
    if (!_myTopUpBaseView) {
        kWeakSelf
        _myTopUpBaseView = [[HXBMyTopUpBaseView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _myTopUpBaseView.rechargeBlock = ^{
            //第一次短验
            [weakSelf enterRecharge];
        };
        if (self.amount.floatValue) {
            _myTopUpBaseView.amount = _amount;
        }
    }
    return _myTopUpBaseView;
}
@end


