//
//  HxbMyTopUpViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbMyTopUpViewController.h"
#import "HxbSecurityCertificationViewController.h"
#import "HxbBindCardViewController.h"
#import "HXBMyTopUpBaseView.h"


#import "HXBRechargeCompletedViewController.h"
#import "HXBAlertVC.h"
#import "HXBOpenDepositAccountRequest.h"
#import "HXBFBase_BuyResult_VC.h"
#import "HXBBankCardModel.h"
#import "HXBMyTopUpBankView.h"
@interface HxbMyTopUpViewController ()

@property (nonatomic, strong) HXBMyTopUpBaseView *myTopUpBaseView;
//是否有语音验证码
@property (nonatomic, assign) BOOL isSpeechVerificationCode;
//是否点击的语音
@property (nonatomic, assign) BOOL isClickSpeechVerificationCode;
@property (nonatomic, strong) HXBAlertVC *alertVC;
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
            //第一次短验
            _isSpeechVerificationCode = NO;
            _isClickSpeechVerificationCode = NO;
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
    
    // 禁用全屏滑动手势
    ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = NO;
    self.isColourGradientNavigationBar = YES;
    
    kWeakSelf
    [KeyChain downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        weakSelf.myTopUpBaseView.viewModel = viewModel;
    } andFailure:^(NSError *error) {
        
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

/**
 快捷充值请求
 */
- (void)enterRecharge
{
    kWeakSelf
    NSString *type = _isClickSpeechVerificationCode ? @"voice" : @"sms";
    HXBOpenDepositAccountRequest *accountRequest = [[HXBOpenDepositAccountRequest alloc] init];
    [accountRequest accountRechargeRequestWithRechargeAmount:self.myTopUpBaseView.amount andWithType:type andWithAction:@"recharge" andSuccessBlock:^(id responseObject) {
        [weakSelf requestRechargeResult];
    } andFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

/**
 快捷充值确认
 */
- (void)requestRechargeResult {
    if (!self.presentedViewController) {
        self.alertVC = [[HXBAlertVC alloc] init];
        self.alertVC.isCode = YES;
        self.alertVC.isSpeechVerificationCode = _isSpeechVerificationCode;
        self.alertVC.messageTitle = @"请输入验证码";
        self.alertVC.subTitle = [NSString stringWithFormat:@"已发送到%@上，请查收", [self.myTopUpBaseView.mybankView.bankCardModel.mobile replaceStringWithStartLocation:3 lenght:4]];
        kWeakSelf
        self.alertVC.sureBtnClick = ^(NSString *pwd) {
            HXBOpenDepositAccountRequest *accountRequest = [[HXBOpenDepositAccountRequest alloc] init];
            [accountRequest accountRechargeResultRequestWithSmscode:pwd andWithQuickpayAmount:weakSelf.myTopUpBaseView.amount andSuccessBlock:^(id responseObject) {
                NSInteger status =  [responseObject[@"status"] integerValue];
                if (status == kHXBCode_Enum_ProcessingField) return ;
                
                if (status != 0) {
                    [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
                } else {
                    [weakSelf.alertVC dismissViewControllerAnimated:NO completion:nil];
                    HXBRechargeCompletedViewController *rechargeCompletedVC = [[HXBRechargeCompletedViewController alloc] init];
                    rechargeCompletedVC.responseObject = responseObject;
                    rechargeCompletedVC.amount = weakSelf.myTopUpBaseView.amount;
                    [weakSelf.navigationController pushViewController:rechargeCompletedVC animated:YES];
                }
            } andFailureBlock:^(NSError *error) {
            }];
        };
        self.alertVC.getVerificationCodeBlock = ^{
            _isClickSpeechVerificationCode = NO;
            _isSpeechVerificationCode = NO;
            weakSelf.alertVC.subTitle = [NSString stringWithFormat:@"已发送到%@上，请查收", [weakSelf.myTopUpBaseView.mybankView.bankCardModel.mobile replaceStringWithStartLocation:3 lenght:4]];
            [weakSelf enterRecharge];
        };
        self.alertVC.getSpeechVerificationCodeBlock = ^{
            _isClickSpeechVerificationCode = YES;
            _isSpeechVerificationCode = YES;
            weakSelf.alertVC.subTitle = [NSString stringWithFormat:@"请留意接听%@上的来电", [weakSelf.myTopUpBaseView.mybankView.bankCardModel.mobile replaceStringWithStartLocation:3 lenght:4]];
            [weakSelf enterRecharge];
        };
        
        [self presentViewController:self.alertVC animated:NO completion:nil];
    }
    
//   HXBAlertVC *alertVC = nil;
//   if (self.presentedViewController) {
//       alertVC = (HXBAlertVC *)self.presentedViewController;
//   } else {
//       alertVC = [[HXBAlertVC alloc] init];
//       [self presentViewController:alertVC animated:NO completion:nil];
//   }
//    
//    kWeakSelf
//    alertVC.isCode = YES;
//    alertVC.isSpeechVerificationCode = _isSpeechVerificationCode;
//    _isSpeechVerificationCode = YES;
//    alertVC.messageTitle = @"请输入验证码";
//    alertVC.subTitle = [NSString stringWithFormat:@"已发送到%@上，请查收", [self.myTopUpBaseView.mybankView.bankCardModel.mobile replaceStringWithStartLocation:3 lenght:4]];
//    __weak typeof(alertVC) weakAlertVC = alertVC;
//    alertVC.sureBtnClick = ^(NSString *pwd){
//        HXBOpenDepositAccountRequest *accountRequest = [[HXBOpenDepositAccountRequest alloc] init];
//        
//        [accountRequest accountRechargeResultRequestWithSmscode:pwd andWithQuickpayAmount:self.myTopUpBaseView.amount andSuccessBlock:^(id responseObject) {
//            
//            NSInteger status =  [responseObject[@"status"] integerValue];
//            if (status == kHXBCode_Enum_ProcessingField) return ;
//
//            if (status != 0) {
//                [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
//            } else {
//                [weakAlertVC dismissViewControllerAnimated:NO completion:nil];
//                HXBRechargeCompletedViewController *rechargeCompletedVC = [[HXBRechargeCompletedViewController alloc] init];
//                rechargeCompletedVC.responseObject = responseObject;
//                rechargeCompletedVC.amount = weakSelf.myTopUpBaseView.amount;
//                [self.navigationController pushViewController:rechargeCompletedVC animated:YES];
//            }
//        } andFailureBlock:^(NSError *error) {
//        }];
//    };
//    alertVC.getVerificationCodeBlock = ^{
//        _isClickSpeechVerificationCode = NO;
//        weakAlertVC.subTitle = [NSString stringWithFormat:@"已发送到%@上，请查收", [weakSelf.myTopUpBaseView.mybankView.bankCardModel.mobile replaceStringWithStartLocation:3 lenght:4]];
//        [weakSelf enterRecharge];
//    };
//    alertVC.getSpeechVerificationCodeBlock = ^{
//        _isClickSpeechVerificationCode = YES;
//        weakAlertVC.subTitle = [NSString stringWithFormat:@"请留意接听%@上的来电", [weakSelf.myTopUpBaseView.mybankView.bankCardModel.mobile replaceStringWithStartLocation:3 lenght:4]];
//        //获取语音验证码 注意参数
//        [weakSelf enterRecharge];
//    };
    
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
@end


