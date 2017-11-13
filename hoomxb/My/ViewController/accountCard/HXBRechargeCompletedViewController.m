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



@interface HXBRechargeCompletedViewController ()

@property (nonatomic, strong) HXBRechargesuccessView *rechargesuccessView;

@property (nonatomic, strong) HXBRechargeFailView *rechargeFailView;
@end

@implementation HXBRechargeCompletedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //充值成功
    self.isColourGradientNavigationBar = YES;
    self.title = @"充值成功";
    [self.view addSubview:self.rechargesuccessView];
    self.rechargesuccessView.amount = self.amount;

}



- (HXBRechargesuccessView *)rechargesuccessView
{
    if (!_rechargesuccessView) {
        kWeakSelf
        _rechargesuccessView = [[HXBRechargesuccessView alloc] initWithFrame:CGRectMake(0, HxbNavigationBarY, kScreenWidth, kScreenHeight - HxbNavigationBarY)];
        //继续充值Block
        _rechargesuccessView.continueRechargeBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        //立即投资
        _rechargesuccessView.immediateInvestmentBlock = ^{
            weakSelf.tabBarController.selectedIndex = 1;
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        };
    }
    return _rechargesuccessView;
}

- (HXBRechargeFailView *)rechargeFailView
{
    if (!_rechargeFailView) {
        kWeakSelf
        _rechargeFailView = [[HXBRechargeFailView alloc] initWithFrame:self.view.bounds];
        _rechargeFailView.investmentBtnClickBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _rechargeFailView;
}

- (void)leftBackBtnClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
