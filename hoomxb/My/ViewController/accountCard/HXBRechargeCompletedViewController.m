//
//  HXBRechargeCompletedViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRechargeCompletedViewController.h"
#import "HXBRechargesuccessView.h"
#import "HXBRechargeFailView.h"


#import "HXBSetTransactionPasswordViewController.h"//ZCC需要修改逻辑;
@interface HXBRechargeCompletedViewController ()

@property (nonatomic, strong) HXBRechargesuccessView *rechargesuccessView;

@property (nonatomic, strong) HXBRechargeFailView *rechargeFailView;
@end

@implementation HXBRechargeCompletedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值结果";
    [self.view addSubview:self.rechargesuccessView];
    
    [self.view addSubview:self.rechargeFailView];
    
}

- (HXBRechargesuccessView *)rechargesuccessView
{
    if (!_rechargesuccessView) {
        _rechargesuccessView = [[HXBRechargesuccessView alloc] initWithFrame:self.view.bounds];
    }
    return _rechargesuccessView;
}

- (HXBRechargeFailView *)rechargeFailView
{
    if (!_rechargeFailView) {
        kWeakSelf
        _rechargeFailView = [[HXBRechargeFailView alloc] initWithFrame:self.view.bounds];
        _rechargeFailView.investmentBtnClickBlock = ^{
            HXBSetTransactionPasswordViewController *setTransactionPasswordVC = [[HXBSetTransactionPasswordViewController alloc] init];
            [weakSelf.navigationController pushViewController:setTransactionPasswordVC animated:YES];
        };
    }
    return _rechargeFailView;
}


@end
