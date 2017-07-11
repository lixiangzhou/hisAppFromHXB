//
//  HXBQuickRechargeView.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBQuickRechargeView.h"
#import "HXBMyTopUpHeaderView.h"
#import "HXBGetValidationCodeView.h"
@interface HXBQuickRechargeView()

/**
 头部视图
 */
@property (nonatomic, strong) HXBMyTopUpHeaderView *myTopUpHeaderView;
/**
 充值金额
 */
@property (nonatomic, strong) HXBBaseView_TwoLable_View *rechargeLabel;
/**
 持卡人
 */
@property (nonatomic, strong) HXBBaseView_TwoLable_View *cardholderLabel;

/**
 银行卡号
 */
@property (nonatomic, strong) HXBBaseView_TwoLable_View *bankCardNumberLabel;

/**
 预留手机号
 */
@property (nonatomic, strong) HXBBaseView_TwoLable_View *phoneNumberlabel;

/**
 获取验证码
 */
@property (nonatomic, strong) HXBGetValidationCodeView *getValidationCodeView;

/**
 充值按钮
 */
@property (nonatomic, strong) UIButton *rechargeBtn;
@end

@implementation HXBQuickRechargeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.myTopUpHeaderView];
        [self addSubview:self.rechargeLabel];
        [self addSubview:self.cardholderLabel];
        [self addSubview:self.bankCardNumberLabel];
        [self addSubview:self.phoneNumberlabel];
        [self addSubview:self.getValidationCodeView];
        [self addSubview:self.rechargeBtn];
        [self setCardViewFrame];
    }
    return self;
}

- (void)setCardViewFrame{
    
    [self.myTopUpHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top).offset(64);
        make.height.equalTo(@44);
    }];
    [self.rechargeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.myTopUpHeaderView.mas_bottom).offset(20);
    }];
    [self.cardholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.rechargeLabel.mas_bottom).offset(20);
    }];
    [self.bankCardNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.cardholderLabel.mas_bottom).offset(20);
    }];
    [self.phoneNumberlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.bankCardNumberLabel.mas_bottom).offset(20);
    }];
    [self.getValidationCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.top.equalTo(self.phoneNumberlabel.mas_bottom).offset(20);
        make.height.equalTo(@44);
    }];
    [self.rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.top.equalTo(self.getValidationCodeView.mas_bottom).offset(20);
        make.height.equalTo(@44);
    }];
}

- (void)rechargeBtnClick
{
    if (self.rechargeBtnClickBlock) {
        self.rechargeBtnClickBlock();
    }
}

#pragma mark - 懒加载

- (HXBMyTopUpHeaderView *)myTopUpHeaderView
{
    if (!_myTopUpHeaderView) {
        _myTopUpHeaderView = [[HXBMyTopUpHeaderView alloc] init];
    }
    return _myTopUpHeaderView;
}

- (HXBBaseView_TwoLable_View *)rechargeLabel
{
    if (!_rechargeLabel) {
        _rechargeLabel = [[HXBBaseView_TwoLable_View alloc] init];
        [_rechargeLabel setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
            viewModelVM.leftLabelStr = @"充值";
            viewModelVM.rightLabelStr = @"789456元";
            viewModelVM.isLeftRight = YES;
            viewModelVM.leftViewColor = COR12;
            viewModelVM.rightViewColor = COR12;
            return viewModelVM;
        }];
    }
    return _rechargeLabel;
}

- (HXBBaseView_TwoLable_View *)cardholderLabel
{
    if (!_cardholderLabel) {
        _cardholderLabel = [[HXBBaseView_TwoLable_View alloc] init];
        [_cardholderLabel setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
            viewModelVM.leftLabelStr = @"持卡人";
            viewModelVM.isLeftRight = YES;
            viewModelVM.leftViewColor = COR12;
            viewModelVM.rightViewColor = COR12;
            return viewModelVM;
        }];
    }
    return _cardholderLabel;
}

- (HXBBaseView_TwoLable_View *)bankCardNumberLabel
{
    if (!_bankCardNumberLabel) {
        _bankCardNumberLabel = [[HXBBaseView_TwoLable_View alloc] init];
        [_bankCardNumberLabel setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
            viewModelVM.leftLabelStr = @"银行卡号";
            viewModelVM.rightLabelStr = @"****6789";
            viewModelVM.isLeftRight = YES;
            viewModelVM.leftViewColor = COR12;
            viewModelVM.rightViewColor = COR12;
            return viewModelVM;
        }];
    }
    return _bankCardNumberLabel;
}

- (HXBBaseView_TwoLable_View *)phoneNumberlabel
{
    if (!_phoneNumberlabel) {
        _phoneNumberlabel = [[HXBBaseView_TwoLable_View alloc] init];
        [_phoneNumberlabel setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
            viewModelVM.leftLabelStr = @"预留手机号";
            viewModelVM.rightLabelStr = @"185****6789";
            viewModelVM.isLeftRight = YES;
            viewModelVM.leftViewColor = COR12;
            viewModelVM.rightViewColor = COR12;
            return viewModelVM;
        }];
    }
    return _phoneNumberlabel;
}

- (HXBGetValidationCodeView *)getValidationCodeView
{
    if (!_getValidationCodeView) {
        _getValidationCodeView = [[HXBGetValidationCodeView alloc] init];
    }
    return _getValidationCodeView;
}

- (UIButton *)rechargeBtn
{
    if (!_rechargeBtn) {
        _rechargeBtn = [[UIButton alloc] init];
        [_rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
        [_rechargeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rechargeBtn addTarget:self action:@selector(rechargeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _rechargeBtn.layer.borderWidth = 0.5;
        _rechargeBtn.layer.borderColor = COR5.CGColor;
        _rechargeBtn.layer.cornerRadius = 3;
        _rechargeBtn.layer.masksToBounds = YES;
    }
    return _rechargeBtn;
}

@end
