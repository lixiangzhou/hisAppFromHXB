//
//  HXBOpenDepositAccountViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBOpenDepositAccountViewController.h"
#import "HXBBankCardListViewController.h"
#import "HxbMyTopUpViewController.h"
#import "HXBOpenDepositAccountView.h"
#import "HXBOpenDepositAccountRequest.h"
#import "HXBFinLoanTruansfer_ContraceWebViewVC.h"///存管的服务协议
#import "HxbWithdrawViewController.h"
@interface HXBOpenDepositAccountViewController ()

@property (nonatomic, strong) HXBOpenDepositAccountView *mainView;

@end

@implementation HXBOpenDepositAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isBlueGradientNavigationBar = YES;
}

//进入银行卡列表
- (void)enterBankCardListVC
{
    kWeakSelf
    HXBBankCardListViewController *bankCardListVC = [[HXBBankCardListViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:bankCardListVC];
    bankCardListVC.bankCardListBlock = ^(NSString *bankCode, NSString *bankName){
        weakSelf.mainView.bankCode = bankCode;
        weakSelf.mainView.bankName = bankName;
    };
    [weakSelf presentViewController:nav animated:YES completion:nil];
}
//开通账户
- (void)bottomBtnClick:(NSDictionary *)dic
{
    kWeakSelf
    [HXBUmengManagar HXB_clickEventWithEnevtId:kHXBUmeng_commitBtn];
    HXBOpenDepositAccountRequest *openDepositAccountRequest = [[HXBOpenDepositAccountRequest alloc] init];
    [openDepositAccountRequest openDepositAccountRequestWithArgument:dic andSuccessBlock:^(id responseObject) {
        
        if (weakSelf.type == HXBRechargeAndWithdrawalsLogicalJudgment_Recharge) {
            HxbMyTopUpViewController *hxbMyTopUpViewController = [[HxbMyTopUpViewController alloc]init];
            [self.navigationController pushViewController:hxbMyTopUpViewController animated:YES];
        }else if (weakSelf.type == HXBRechargeAndWithdrawalsLogicalJudgment_Withdrawals){
            HxbWithdrawViewController *withdrawViewController = [[HxbWithdrawViewController alloc]init];
            if (!KeyChain.isLogin)  return;
            [self.navigationController pushViewController:withdrawViewController animated:YES];
        }else if(weakSelf.type == HXBRechargeAndWithdrawalsLogicalJudgment_Other)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }else if(weakSelf.type == HXBRechargeAndWithdrawalsLogicalJudgment_signup)
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } andFailureBlock:^(NSError *error) {
        
    }];
    
}

#pragma mark - 懒加载
- (HXBOpenDepositAccountView *)mainView
{
    if (!_mainView) {
        kWeakSelf
        _mainView = [[HXBOpenDepositAccountView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
        _mainView.bankNameBlock = ^{
            [weakSelf enterBankCardListVC];
        };
        _mainView.openAccountBlock = ^(NSDictionary *dic) {
            [weakSelf bottomBtnClick:dic];
        };
        [_mainView clickTrustAgreementWithBlock:^(BOOL isThirdpart) {
            NSLog(@"《存管开户协议》");
            HXBFinLoanTruansfer_ContraceWebViewVC *webViewVC = [[HXBFinLoanTruansfer_ContraceWebViewVC alloc] init];
            if (isThirdpart) {
                webViewVC.URL = kHXB_Negotiate_thirdpart;
                webViewVC.title = @"恒丰银行股份有限公司杭州分行网络交易资金账户三方协议";
            }else
            {
                webViewVC.URL = kHXB_Negotiate_authorize;
                webViewVC.title = @"红小宝平台授权协议";
            }
            [weakSelf.navigationController pushViewController:webViewVC animated:true];
        }];
        
    }
    return _mainView;
}
- (void)leftBackBtnClick
{
    if (self.type == HXBRechargeAndWithdrawalsLogicalJudgment_signup) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
    {
        [super leftBackBtnClick];
    }
}
@end
