//
//  HxbWithdrawResultViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//
#define marginal 20
#import "HxbWithdrawResultViewController.h"
#import "HXBBankCardModel.h"
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
    self.view.backgroundColor = COR12;
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
    [self setupSubViewFrame];
}

- (void)setupSubViewFrame
{
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@84);
        make.centerX.equalTo(self.view);
        make.height.with.equalTo(@50);
    }];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.icon.mas_bottom);
    }];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.tipLabel.mas_bottom).offset(50);
        make.height.equalTo(@132);
    }];
    [self.bankCardtipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(marginal);
        make.top.equalTo(self.backView.mas_top).offset(marginal);
    }];
    [self.bankCardNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right).offset(-marginal);
        make.centerY.equalTo(self.bankCardtipLabel);
    }];
    [self.withdrawalsTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(marginal);
        make.top.equalTo(self.bankCardtipLabel.mas_bottom).offset(marginal);
    }];
    [self.withdrawalsNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right).offset(-marginal);
        make.centerY.equalTo(self.withdrawalsTipLabel);
    }];
    [self.withdrawalsTimeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(marginal);
        make.top.equalTo(self.withdrawalsTipLabel.mas_bottom).offset(marginal);
    }];
    [self.withdrawalsTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right).offset(-marginal);
        make.centerY.equalTo(self.withdrawalsTimeTipLabel);
    }];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(marginal);
        make.right.equalTo(self.view.mas_right).offset(-marginal);
        make.bottom.equalTo(self.view.mas_bottom).offset(-100);
        make.height.equalTo(@35);
    }];
    
}

- (void)setBankCardModel:(HXBBankCardModel *)bankCardModel
{
    _bankCardModel = bankCardModel;
    self.bankCardNumberLabel.text = [NSString stringWithFormat:@"尾号 %@",[self.bankCardModel.cardId substringFromIndex:self.bankCardModel.cardId.length - 4]];
    self.withdrawalsNumberLabel.text = [NSString stringWithFormat:@"%@元",self.bankCardModel.amount];
    self.withdrawalsTimeLabel.text = [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:self.bankCardModel.arrivalTime andDateFormat:@"yyyy-MM-dd"];
}

- (void)backBttonClick:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}




#pragma mark - 懒加载
- (UILabel *)withdrawalsTimeLabel
{
    if (!_withdrawalsTimeLabel) {
        _withdrawalsTimeLabel = [[UILabel alloc] init];
    }
    return _withdrawalsTimeLabel;
}
- (UILabel *)withdrawalsTimeTipLabel
{
    if (!_withdrawalsTimeTipLabel) {
        _withdrawalsTimeTipLabel = [[UILabel alloc] init];
        _withdrawalsTimeTipLabel.text = @"预计到账时间";
        _withdrawalsTimeTipLabel.textColor = COR12;
    }
    return _withdrawalsTimeTipLabel;
}

- (UILabel *)withdrawalsNumberLabel
{
    if (!_withdrawalsNumberLabel) {
        _withdrawalsNumberLabel = [[UILabel alloc] init];
    }
    return _withdrawalsNumberLabel;
}

- (UILabel *)withdrawalsTipLabel
{
    if (!_withdrawalsTipLabel) {
        _withdrawalsTipLabel = [[UILabel alloc] init];
        _withdrawalsTipLabel.text = @"提现金额";
        _withdrawalsTipLabel.textColor = COR12;
    }
    return _withdrawalsTipLabel;
}

- (UILabel *)bankCardNumberLabel
{
    if (!_bankCardNumberLabel) {
        _bankCardNumberLabel = [[UILabel alloc] init];
    }
    return _bankCardNumberLabel;
}
- (UILabel *)bankCardtipLabel
{
    if (!_bankCardtipLabel) {
        _bankCardtipLabel = [[UILabel alloc] init];
        _bankCardtipLabel.text = @"银行卡";
        _bankCardtipLabel.textColor = COR12;
    }
    return _bankCardtipLabel;
}
- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
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
- (UIButton *)backButton{
    if (!_backButton) {
        _backButton = [[UIButton alloc] init];
        [_backButton setTitle:@"返回我的账户" forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_backButton setBackgroundColor:[UIColor blueColor]];
        [_backButton addTarget:self action:@selector(backBttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

@end
