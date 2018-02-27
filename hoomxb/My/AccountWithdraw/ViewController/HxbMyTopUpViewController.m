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
#import "HXBRechargeCompletedViewController.h"
#import "HXBVerificationCodeAlertVC.h"
#import "HXBBankCardModel.h"
#import "HXBMyTopUpBankView.h"
#import "HXBMyTopUpVCViewModel.h"
#import "HXBRootVCManager.h"
@interface HxbMyTopUpViewController ()

@property (nonatomic, strong) HXBMyTopUpBaseView *myTopUpBaseView;
@property (nonatomic, strong) HXBVerificationCodeAlertVC *alertVC;

@property (nonatomic, strong) HXBMyTopUpVCViewModel *viewModel;


@end

@implementation HxbMyTopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isColourGradientNavigationBar = YES;
    self.title = @"充值";
    [self.view addSubview:self.myTopUpBaseView];
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

/**
 快捷充值请求
 */
- (void)enterRecharge
{
    kWeakSelf
    [self.accountVM getVerifyCodeRequesWithRechargeAmount:self.myTopUpBaseView.amount andWithType:@"sms" andWithAction:@"recharge" andCallbackBlock:^(BOOL isSuccess,NSError *error) {
        if (isSuccess) {
            weakSelf.alertVC.subTitle = [NSString stringWithFormat:@"已发送到%@上，请查收", [weakSelf.myTopUpBaseView.mybankView.bankCardModel.mobile replaceStringWithStartLocation:3 lenght:4]];
            [weakSelf requestRechargeResult];
            [weakSelf.alertVC.verificationCodeAlertView disEnabledBtns];
        }
        else {
            NSInteger errorCode = 0;
            if ([error isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic = (NSDictionary *)error;
                errorCode = [dic[@"status"] integerValue];
            }else{
                errorCode = error.code;
            }
            if (errorCode != kHXBCode_Success) {
                [weakSelf.alertVC.verificationCodeAlertView enabledBtns];
            }
        }
    }];
}

/**
 快捷充值确认
 */
- (void)requestRechargeResult {
    if (!self.presentedViewController) {
        self.alertVC = [[HXBVerificationCodeAlertVC alloc] init];
        self.alertVC.messageTitle = @"请输入短信验证码";
        self.alertVC.subTitle = [NSString stringWithFormat:@"已发送到%@上，请查收", [self.myTopUpBaseView.mybankView.bankCardModel.mobile replaceStringWithStartLocation:3 lenght:4]];
        kWeakSelf
        self.alertVC.sureBtnClick = ^(NSString *pwd) {
            [weakSelf.viewModel accountRechargeResultRequestWithSmscode:pwd andWithQuickpayAmount:weakSelf.myTopUpBaseView.amount andCallBackBlock:^(BOOL isSuccess) {
                if (isSuccess) {
                    [weakSelf.alertVC dismissViewControllerAnimated:NO completion:nil];
                    HXBRechargeCompletedViewController *rechargeCompletedVC = [[HXBRechargeCompletedViewController alloc] init];
                    rechargeCompletedVC.amount = weakSelf.myTopUpBaseView.amount;
                    [weakSelf.navigationController pushViewController:rechargeCompletedVC animated:YES];
                }
            }];
        };
        self.alertVC.getVerificationCodeBlock = ^{
            [weakSelf.alertVC.verificationCodeAlertView enabledBtns];
            [weakSelf enterRecharge];
        };
        self.alertVC.getSpeechVerificationCodeBlock = ^{
            [weakSelf.alertVC.verificationCodeAlertView enabledBtns];
            [weakSelf enterRecharge];
        };
        
        [self presentViewController:self.alertVC animated:NO completion:nil];
    }
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
- (HXBMyTopUpVCViewModel *)accountVM {
    if (!_accountVM) {
        _accountVM = [[HXBMyTopUpVCViewModel alloc] initWithBlock:^UIView *{
            return [HXBRootVCManager manager].topVC.view;
        }];
    }
    return _viewModel;
}

@end


