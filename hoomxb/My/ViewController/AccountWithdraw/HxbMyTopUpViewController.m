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


#import "HXBQuickRechargeViewController.h"//ZCC需要修改逻辑
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
    }
    return _myTopUpBaseView;
}


- (void)enterRecharge
{
    HXBQuickRechargeViewController *quickRechargeVC = [[HXBQuickRechargeViewController alloc] init];
    [self.navigationController pushViewController:quickRechargeVC animated:YES];

}

@end


