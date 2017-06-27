//
//  HxbWithdrawResultViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbWithdrawResultViewController.h"

@interface HxbWithdrawResultViewController ()
@property (nonatomic, strong) UIImageView *icon;//图标
@property (nonatomic, strong) UILabel *tipLabel;//是否成功的处理提示
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *bankCardtipLabel;//银行卡提示标签
@property (nonatomic, strong) UILabel *bankCardNumberLabel;//银行卡尾号
@property (nonatomic, strong) UILabel *withdrawalsTipLabel;//提现金额标签
@property (nonatomic, strong) UILabel *withdrawalsNumberLabel;//提现金额
@property (nonatomic, strong) UILabel *withdrawalsTimeTipLabel;//提现到账时间标签
@property (nonatomic, strong) UILabel *withdrawalsTimeLabel;//提现到账时间

@property (nonatomic, strong) UIButton *backButton;
@end

@implementation HxbWithdrawResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    [self.view addSubview:self.icon];
    [self.view addSubview:self.tipLabel];
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.bankCardtipLabel];
    [self.backView addSubview:self.bankCardNumberLabel];
    [self.backView addSubview:self.withdrawalsTipLabel];
    [self.backView addSubview:self.withdrawalsNumberLabel];
    [self.backView addSubview:self.withdrawalsTimeTipLabel];
    [self.backView addSubview:self.withdrawalsTimeLabel];
    [self.view addSubview:self.backButton];
}

- (void)backBttonClick:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}




#pragma mark - 懒加载
- (UILabel *)bankCardtipLabel
{
    if (!_bankCardtipLabel) {
        _bankCardtipLabel = [[UILabel alloc] init];
        _bankCardtipLabel.text = @"银行卡";
    }
    return _bankCardtipLabel;
}
- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] init];
    }
    return _backView;
}
- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.text = @"提现申请已受理";
    }
    return _tipLabel;
}
- (UIImageView *)icon
{
    if (!_icon) {
        _icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zhaoshang"]];
    }
    return _icon;
}
- (UIButton *)backBtton{
    if (!_backButton) {
        _backButton = [UIButton btnwithTitle:@"返回我资产" andTarget:self andAction:@selector(backBttonClick:) andFrameByCategory:CGRectMake(20, SCREEN_HEIGHT/2, SCREEN_WIDTH - 40 , 44)];
    }
    return _backButton;
}

@end
