//
//  HXBSetTransactionPasswordView.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBSetTransactionPasswordView.h"

@interface HXBSetTransactionPasswordView ()

@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *transactionTipLabel;
@property (nonatomic, strong) UITextField *transactionTextField;
@property (nonatomic, strong) UIButton *iconBtn;
@property (nonatomic, strong) UIButton *setTransactionBtn;

@end

@implementation HXBSetTransactionPasswordView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.tipLabel];
        [self addSubview:self.transactionTipLabel];
        [self addSubview:self.transactionTextField];
        [self addSubview:self.iconBtn];
        [self addSubview:self.setTransactionBtn];
        
        [self setCardViewFrame];
    }
    return self;
}
- (void)setCardViewFrame{
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(64 + kScrAdaptationH(20));
    }];
    [self.transactionTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.tipLabel.mas_bottom).offset(kScrAdaptationH(8));
    }];
    [self.transactionTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kScrAdaptationH(20));
        make.right.equalTo(self.mas_right).offset(kScrAdaptationH(-20));
        make.top.equalTo(self.transactionTipLabel.mas_bottom).offset(kScrAdaptationH(50));
        make.height.equalTo(@kScrAdaptationH(44));
    }];
    [self.iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.transactionTextField);
        make.right.equalTo(self.transactionTextField.mas_right);
        make.height.equalTo(@kScrAdaptationH(44));
        make.width.equalTo(@kScrAdaptationH(44));
    }];
    [self.setTransactionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kScrAdaptationH(20));
        make.right.equalTo(self.mas_right).offset(kScrAdaptationH(-20));
        make.top.equalTo(self.transactionTextField.mas_bottom).offset(kScrAdaptationH(30));
        make.height.equalTo(@kScrAdaptationH(44));
    }];
}

- (void)iconBtnClick
{
    self.transactionTextField.secureTextEntry = self.setTransactionBtn.selected;
    self.setTransactionBtn.selected = !self.setTransactionBtn.selected;
}
- (void)setTransactionBtnClick
{
    
}

#pragma mark - 懒加载

- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.text = @"恒丰银行存管账户已开通";
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.font = [UIFont systemFontOfSize:12];
    }
    return _tipLabel;
}

- (UILabel *)transactionTipLabel
{
    if (!_transactionTipLabel) {
        _transactionTipLabel = [[UILabel alloc] init];
        _transactionTipLabel.text = @"为账户安全再升级，请设置您的交易密码";
        _transactionTipLabel.textAlignment = NSTextAlignmentCenter;
        _transactionTipLabel.font = [UIFont systemFontOfSize:12];
    }
    return _transactionTipLabel;
}
- (UITextField *)transactionTextField
{
    if (!_transactionTextField) {
        _transactionTextField = [[UITextField alloc] init];
        _transactionTextField.placeholder = @"交易密码";
        _transactionTextField.font = [UIFont systemFontOfSize:12];
        _transactionTextField.secureTextEntry = YES;
    }
    return _transactionTextField;
}
- (UIButton *)iconBtn
{
    if (!_iconBtn) {
        _iconBtn = [[UIButton alloc] init];
        [_iconBtn setTitle:@"icon" forState:UIControlStateNormal];
        _iconBtn.backgroundColor = COR12;
        [_iconBtn addTarget:self action:@selector(iconBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _iconBtn;
}

- (UIButton *)setTransactionBtn
{
    if (!_setTransactionBtn) {
        _setTransactionBtn = [[UIButton alloc] init];
        _setTransactionBtn.layer.borderColor = COR12.CGColor;
        _setTransactionBtn.layer.borderWidth = kXYBorderWidth;
        _setTransactionBtn.layer.cornerRadius = 2.0;
        _setTransactionBtn.layer.masksToBounds = YES;
        [_setTransactionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_setTransactionBtn setTitle:@"设置交易密码" forState:UIControlStateNormal];
        [_setTransactionBtn addTarget:self action:@selector(setTransactionBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _setTransactionBtn;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

@end
