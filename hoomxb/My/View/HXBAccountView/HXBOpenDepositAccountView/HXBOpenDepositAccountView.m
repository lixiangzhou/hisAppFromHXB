//
//  HXBOpenDepositAccountView.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBOpenDepositAccountView.h"
#import "HXBDepositoryHeaderView.h"
#import "HXBCustomTextField.h"
#import "HXBFinBaseNegotiateView.h"
#import "SVGKImage.h"

@interface HXBOpenDepositAccountView ()
@property (nonatomic, strong) HXBDepositoryHeaderView *headerTipView;
@property (nonatomic, strong) HXBCustomTextField *nameTextField;
@property (nonatomic, strong) HXBCustomTextField *idCardTextField;
@property (nonatomic, strong) HXBCustomTextField *pwdTextField;
@property (nonatomic, strong) HXBDepositoryHeaderView *bottomTipView;
@property (nonatomic, strong) HXBCustomTextField *bankNameTextField;
@property (nonatomic, strong) HXBCustomTextField *bankNumberTextField;
@property (nonatomic, strong) HXBCustomTextField *phoneTextField;
@property (nonatomic, strong) HXBFinBaseNegotiateView *negotiateView;
@property (nonatomic, strong) UIButton *bottomBtn;
@end

@implementation HXBOpenDepositAccountView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.headerTipView];
        [self addSubview:self.nameTextField];
        [self addSubview:self.idCardTextField];
        [self addSubview:self.pwdTextField];
        [self addSubview:self.bottomTipView];
        [self addSubview:self.bankNameTextField];
        [self addSubview:self.bankNumberTextField];
        [self addSubview:self.phoneTextField];
        [self addSubview:self.negotiateView];
        [self addSubview:self.bottomBtn];
        [self setupSubViewFrame];
    }
    return self;
}
- (void)setupSubViewFrame
{
    [self.headerTipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kScrAdaptationH(20));
        make.left.right.equalTo(self);
        make.height.offset(kScrAdaptationH(37));
    }];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerTipView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.offset(kScrAdaptationH(50));
    }];
    [self.idCardTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameTextField.mas_bottom);
        make.left.right.equalTo(self);
        make.height.offset(kScrAdaptationH(50));
    }];
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.idCardTextField.mas_bottom);
        make.left.right.equalTo(self);
        make.height.offset(kScrAdaptationH(50));
    }];
    [self.bottomTipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdTextField.mas_bottom).offset(kScrAdaptationH(50));
        make.left.right.equalTo(self);
        make.height.offset(kScrAdaptationH(37));
    }];
    [self.bankNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomTipView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.offset(kScrAdaptationH(50));
    }];
    [self.bankNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bankNameTextField.mas_bottom);
        make.left.right.equalTo(self);
        make.height.offset(kScrAdaptationH(50));
    }];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bankNumberTextField.mas_bottom);
        make.left.right.equalTo(self);
        make.height.offset(kScrAdaptationH(50));
    }];
    
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.offset(kScrAdaptationH(49));
    }];
    [self.negotiateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomBtn.mas_top).offset(kScrAdaptationH(-20));
        make.centerX.equalTo(self);
        make.height.offset(kScrAdaptationH(14));
        make.width.offset(kScrAdaptationW(217));
    }];
}

- (void)setBankName:(NSString *)bankName
{
    _bankName = bankName;
    self.bankNameTextField.text = bankName;
}

- (void)bottomBtnClick
{
    if (self.openAccountBlock) {
        self.openAccountBlock();
    }
}

#pragma mark - 懒加载
- (HXBDepositoryHeaderView *)headerTipView
{
    if (!_headerTipView) {
        _headerTipView = [[HXBDepositoryHeaderView alloc] init];
        _headerTipView.titel = @"安全认证";
        _headerTipView.describe = @"按国家规定投资用户需满18岁";
    }
    return _headerTipView;
}
- (HXBCustomTextField *)nameTextField
{
    if (!_nameTextField) {
        _nameTextField = [[HXBCustomTextField alloc] init];
        _nameTextField.leftImage = [SVGKImage imageNamed:@"name.svg"].UIImage;
        _nameTextField.placeholder = @"真实姓名";
    }
    return _nameTextField;
}

- (HXBCustomTextField *)idCardTextField
{
    if (!_idCardTextField) {
        _idCardTextField = [[HXBCustomTextField alloc] init];
        _idCardTextField.leftImage = [SVGKImage imageNamed:@"id_number.svg"].UIImage;
        _idCardTextField.placeholder = @"身份证号";
    }
    return _idCardTextField;
}
- (HXBCustomTextField *)pwdTextField
{
    if (!_pwdTextField) {
        _pwdTextField = [[HXBCustomTextField alloc] init];
        _pwdTextField.leftImage = [SVGKImage imageNamed:@"transaction_password.svg"].UIImage;
        _pwdTextField.placeholder = @"交易密码";
    }
    return _pwdTextField;
}
- (HXBDepositoryHeaderView *)bottomTipView
{
    if (!_bottomTipView) {
        _bottomTipView = [[HXBDepositoryHeaderView alloc] init];
        _bottomTipView.titel = @"银行卡";
        _bottomTipView.describe = @"实名认证与银行卡需为同一人";
    }
    return _bottomTipView;
}
- (HXBCustomTextField *)bankNameTextField
{
    if (!_bankNameTextField) {
        kWeakSelf
        _bankNameTextField = [[HXBCustomTextField alloc] init];
        _bankNameTextField.leftImage = [SVGKImage imageNamed:@"bank_name.svg"].UIImage;
        _bankNameTextField.placeholder = @"银行名称";
        _bankNameTextField.rightImage = [SVGKImage imageNamed:@"more.svg"].UIImage;
        _bankNameTextField.btnClick = ^{
            if (weakSelf.bankNameBlock) {
                weakSelf.bankNameBlock();
            }
        };
    }
    return _bankNameTextField;
}
- (HXBCustomTextField *)bankNumberTextField
{
    if (!_bankNumberTextField) {
        _bankNumberTextField = [[HXBCustomTextField alloc] init];
        _bankNumberTextField.leftImage = [SVGKImage imageNamed:@"card.svg"].UIImage;
        _bankNumberTextField.placeholder = @"银行卡号";
    }
    return _bankNumberTextField;
}

- (HXBCustomTextField *)phoneTextField
{
    if (!_phoneTextField) {
        _phoneTextField = [[HXBCustomTextField alloc] init];
        _phoneTextField.leftImage = [SVGKImage imageNamed:@"mobile.svg"].UIImage;
        _phoneTextField.placeholder = @"预留手机号码";
    }
    return _phoneTextField;
}

- (HXBFinBaseNegotiateView *)negotiateView
{
    if (!_negotiateView) {
        _negotiateView = [[HXBFinBaseNegotiateView alloc] init];
        [_negotiateView clickNegotiateWithBlock:^{
            NSLog(@"点击了协议");
        }];
        kWeakSelf
        [_negotiateView clickCheckMarkWithBlock:^(BOOL isSelected) {
            if (isSelected) {
                weakSelf.bottomBtn.backgroundColor = COR24;
            }else
            {
                weakSelf.bottomBtn.backgroundColor = COR26;
            }
            weakSelf.bottomBtn.enabled = isSelected;
        }];
        _negotiateView.negotiateStr = @"存管服务协议";
    }
    return _negotiateView;
}
- (UIButton *)bottomBtn
{
    if (!_bottomBtn) {
        _bottomBtn = [[UIButton alloc] init];
        _bottomBtn.backgroundColor = COR24;
        [_bottomBtn setTitle:@"开通恒丰银行存管账户" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _bottomBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(16);
        [_bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}

@end
