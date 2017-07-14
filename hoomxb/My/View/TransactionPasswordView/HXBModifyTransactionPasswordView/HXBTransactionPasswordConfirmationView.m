//
//  HXBTransactionPasswordConfirmationView.m
//  修改交易密码
//
//  Created by HXB-C on 2017/6/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBTransactionPasswordConfirmationView.h"
@interface HXBTransactionPasswordConfirmationView ()
/**
 确认密码输入的TextField
 */
@property (nonatomic, strong) UITextField *passwordConfirmationTextField;
/**
 是否明文的按钮
 */
@property (nonatomic, strong) UIButton *expressButton;
/**
 确认修改按钮
 */
@property (nonatomic, strong) UIButton *confirmChangeButton;

@end

@implementation HXBTransactionPasswordConfirmationView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setup];
        [self setupSubViewFrame];
    }
    return self;
}

- (void)setupSubViewFrame
{
    [self.passwordConfirmationTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@30);
    }];
    [self.expressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordConfirmationTextField.mas_right);
        make.centerY.equalTo(self.passwordConfirmationTextField);
        make.width.height.equalTo(@15);
    }];
    [self.confirmChangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(self).offset(-16);
        make.top.equalTo(self.passwordConfirmationTextField.mas_bottom).offset(100);
        make.height.equalTo(@35);
    }];
}

/**
 设置子试图
 */
- (void)setup
{
    [self addSubview:self.passwordConfirmationTextField];
    [self addSubview:self.expressButton];
    [self addSubview:self.confirmChangeButton];
}

/**
 是非明文按钮的点击
 */
- (void)expressButtonClick
{
    self.passwordConfirmationTextField.secureTextEntry = self.expressButton.selected;
    self.expressButton.selected = !self.expressButton.selected;
}

/**
 确认密码按钮的点击
 */
- (void)confirmChangeButtonClick
{
    if (self.confirmChangeButtonClickBlock) {
        self.confirmChangeButtonClickBlock(self.passwordConfirmationTextField.text);
    }
}

#pragma mark - get方法（懒加载）
/**
 新交易密码输入框
 */
- (UITextField *)passwordConfirmationTextField
{
    if (!_passwordConfirmationTextField) {
        _passwordConfirmationTextField = [[UITextField alloc] init];
        _passwordConfirmationTextField.placeholder = @"新交易密码（8-20位数字大小写字母组合）";
        _passwordConfirmationTextField.font = [UIFont systemFontOfSize:15];
        _passwordConfirmationTextField.secureTextEntry = YES;
    }
    return _passwordConfirmationTextField;
}

/**
 是否明文的按钮
 */
- (UIButton *)expressButton
{
    if (!_expressButton) {
        _expressButton = [[UIButton alloc] init];
        _expressButton.backgroundColor = [UIColor redColor];
        [_expressButton addTarget:self action:@selector(expressButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _expressButton;
}

/**
 确认修改按钮
 */
- (UIButton *)confirmChangeButton
{
    if (!_confirmChangeButton) {
        _confirmChangeButton = [[UIButton alloc] init];
        _confirmChangeButton.backgroundColor = [UIColor blueColor];
        _confirmChangeButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_confirmChangeButton setTitle:@"确认修改" forState:UIControlStateNormal];
        [_confirmChangeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmChangeButton addTarget:self action:@selector(confirmChangeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _confirmChangeButton.layer.masksToBounds = YES;
        _confirmChangeButton.layer.cornerRadius = 5;
    }
    return _confirmChangeButton;
}


@end
