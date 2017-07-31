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
        _myTopUpBaseView = [[HXBMyTopUpBaseView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
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
    kWeakSelf
    [KeyChain downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        weakSelf.myTopUpBaseView.viewModel = viewModel;
    } andFailure:^(NSError *error) {
        
    }];
}

/**
 快捷充值请求
 */
- (void)enterRecharge
{
    kWeakSelf
    HXBOpenDepositAccountRequest *accountRequest = [[HXBOpenDepositAccountRequest alloc] init];
    [accountRequest accountRechargeRequestWithRechargeAmount:self.myTopUpBaseView.amount andSuccessBlock:^(id responseObject) {
        [weakSelf requestRechargeResult:responseObject[@"data"][@"origin_order_no"]];
    } andFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

/**
 快捷充值确认
 */
- (void)requestRechargeResult:(NSString *)rechargeOrderNum
{
   
    kWeakSelf
    HXBAlertVC *alertVC = [[HXBAlertVC alloc] init];
    alertVC.isCode = YES;
    alertVC.messageTitle = @"请输入您的短信验证码";
    alertVC.sureBtnClick = ^(NSString *pwd){
        HXBOpenDepositAccountRequest *accountRequest = [[HXBOpenDepositAccountRequest alloc] init];
        [accountRequest accountRechargeResultRequestWithSmscode:pwd andWithRechargeOrderNum:rechargeOrderNum andSuccessBlock:^(id responseObject) {
            HXBRechargeCompletedViewController *rechargeCompletedVC = [[HXBRechargeCompletedViewController alloc] init];
            rechargeCompletedVC.responseObject = responseObject;
            rechargeCompletedVC.amount = weakSelf.myTopUpBaseView.amount;
            [self.navigationController pushViewController:rechargeCompletedVC animated:YES];
            
        } andFailureBlock:^(NSError *error) {
            
        }];
    };
    [self presentViewController:alertVC animated:NO completion:nil];
}

@end


