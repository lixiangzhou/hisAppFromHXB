//
//  HXBQuickRechargeViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBQuickRechargeViewController.h"
#import "HXBQuickRechargeView.h"
#import "HxbWithdrawCardViewController.h"//ZCC需要修改逻辑
@interface HXBQuickRechargeViewController ()

@property (nonatomic, strong) HXBQuickRechargeView *quickRechargeView;

@end

@implementation HXBQuickRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"快捷充值";
    [self.view addSubview:self.quickRechargeView];
}

- (HXBQuickRechargeView *)quickRechargeView
{
    if (!_quickRechargeView) {
        kWeakSelf
        _quickRechargeView = [[HXBQuickRechargeView alloc] initWithFrame:self.view.bounds];
        _quickRechargeView.rechargeBtnClickBlock = ^{
            HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc]init];
            withdrawCardViewController.title = @"绑卡";
            [weakSelf.navigationController pushViewController:withdrawCardViewController animated:YES];
        };
    }
    return _quickRechargeView;
}

@end
