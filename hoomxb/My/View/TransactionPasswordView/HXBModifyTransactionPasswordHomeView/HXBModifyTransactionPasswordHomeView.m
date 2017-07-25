//
//  HXBModifyTransactionPasswordHomeView.m
//  修改交易密码
//
//  Created by HXB-C on 2017/6/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBModifyTransactionPasswordHomeView.h"
#import "HXBUserInfoModel.h"
@interface HXBModifyTransactionPasswordHomeView()

/**
 提示标签（认证姓名）
 */
@property (nonatomic, strong) UILabel *authenticatedNameTipLabel;
/**
 认证姓名Label
 */
@property (nonatomic, strong) UILabel *authenticatedNameLabel;
/**
 输入身份证号码TextField
 */
@property (nonatomic, strong) UITextField *idCardTextField;
/**
 提示标签
 */
@property (nonatomic, strong) UILabel *promptLabel;
/**
 手机号
 */
@property (nonatomic, strong) UILabel *phoneNumberLabel;
/**
 输入验证码TextField
 */
@property (nonatomic, strong) UITextField *verificationCodeTextField;
/**
 获取验证码的按钮
 */
@property (nonatomic, strong) UIButton *getValidationCodeButton;
/**
 下一步的按钮
 */
@property (nonatomic, strong) UIButton *nextButton;

@property (nonatomic, weak) NSTimer *timer;

@property (nonatomic, assign) int count;

@end

@implementation HXBModifyTransactionPasswordHomeView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setup];
    }
    return self;
}


- (void)setupSubViewFrame
{
    [self.authenticatedNameTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(self).offset(30);
    }];
    [self.authenticatedNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.authenticatedNameTipLabel.mas_right);
        make.centerY.equalTo(self.authenticatedNameTipLabel);
    }];
    [self.idCardTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.authenticatedNameTipLabel);
        make.top.equalTo(self.authenticatedNameTipLabel.mas_bottom).offset(15);
        make.right.equalTo(self).offset(-16);
    }];
    if ([self.userInfoModel.userInfo.isAllPassed isEqualToString:@"1"]) {
        [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.authenticatedNameTipLabel);
            make.top.equalTo(self.idCardTextField.mas_bottom).offset(30);
        }];
    }else
    {
        [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@16);
            make.top.equalTo(self).offset(30);
        }];
    }
    
    [self.phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.authenticatedNameTipLabel);
        make.top.equalTo(self.promptLabel.mas_bottom).offset(8);
        make.right.equalTo(self).offset(-16);
        make.height.equalTo(@20);
    }];
    [self.verificationCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.authenticatedNameTipLabel);
        make.top.equalTo(self.phoneNumberLabel.mas_bottom).offset(30);
        make.width.equalTo(@100);
    }];
    [self.getValidationCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-16);
        make.centerY.equalTo(self.verificationCodeTextField);
    }];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(self).offset(-16);
        make.top.equalTo(self.verificationCodeTextField.mas_bottom).offset(40);
        make.height.equalTo(@35);
    }];

}

/**
 设置子视图
 */
- (void)setup
{
    
    [self addSubview:self.authenticatedNameTipLabel];
    [self addSubview:self.authenticatedNameLabel];
    [self addSubview:self.idCardTextField];
    [self addSubview:self.promptLabel];
    [self addSubview:self.phoneNumberLabel];
    [self addSubview:self.verificationCodeTextField];
    [self addSubview:self.getValidationCodeButton];
    [self addSubview:self.nextButton];
    
}

/**
 点击获取验证码
 */
- (void)getValidationCodeButtonClick
{
    if (self.getValidationCodeButtonClickBlock) {
        self.getValidationCodeButtonClickBlock(self.idCardTextField.text);
    }
    
}

/**
 身份证验证成功
 */
- (void)idcardWasSuccessfully
{
    self.getValidationCodeButton.enabled = NO;
    self.count = 60;
    [self.getValidationCodeButton setTitle:[NSString stringWithFormat:@"%ds",self.count] forState:UIControlStateNormal];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeDown) userInfo:nil repeats:YES];
}

- (void)timeDown
{
    self.count--;
    [self.getValidationCodeButton setTitle:[NSString stringWithFormat:@"%ds",self.count] forState:UIControlStateNormal];
    if (self.count == -1) {
        self.getValidationCodeButton.enabled = YES;
        [self.timer invalidate];
        self.timer = nil;
        [self.getValidationCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

/**
 发送验证码失败
 */
- (void)sendCodeFail
{
    self.getValidationCodeButton.enabled = YES;
    [self.timer invalidate];
    self.timer = nil;
    [self.getValidationCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];

}

/**
 下一步点击方法
 */
- (void)nextButtonClick
{
    NSLog(@"需要判断验证码是否正确");
    
    if (self.nextButtonClickBlock) {
        self.nextButtonClickBlock(self.idCardTextField.text,self.verificationCodeTextField.text);
    }
}
#pragma mark - set方法
- (void)setUserInfoModel:(HXBUserInfoModel *)userInfoModel
{
    _userInfoModel = userInfoModel;
    self.phoneNumberLabel.text = [userInfoModel.userInfo.mobile hxb_hiddenPhonNumberWithMid];
    if ([userInfoModel.userInfo.isAllPassed isEqualToString:@"1"]) {
        self.authenticatedNameLabel.text = [userInfoModel.userInfo.realName hxb_hiddenUserNameWithleft];
    }else
    {
        self.authenticatedNameTipLabel.hidden = YES;
        self.authenticatedNameLabel.hidden = YES;
        self.idCardTextField.hidden = YES;
    }
    [self setupSubViewFrame];
}

#pragma mark - get方法
/**
 提示标签（认证姓名）
 */
- (UILabel *)authenticatedNameTipLabel
{
    if (!_authenticatedNameTipLabel) {
        _authenticatedNameTipLabel = [[UILabel alloc] init];
        _authenticatedNameTipLabel.text = @"认证姓名:";
        _authenticatedNameTipLabel.font = [UIFont systemFontOfSize:15];
    }
    return _authenticatedNameTipLabel;
}
/**
 认证姓名Label
 */
- (UILabel *)authenticatedNameLabel
{
    if (!_authenticatedNameLabel) {
        _authenticatedNameLabel = [[UILabel alloc] init];
        _authenticatedNameLabel.text = @"***";
        _authenticatedNameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _authenticatedNameLabel;
}
/**
 输入身份证号码TextField
 */
- (UITextField *)idCardTextField
{
    if (!_idCardTextField) {
        _idCardTextField = [[UITextField alloc] init];
        _idCardTextField.placeholder = @"认证姓名对应的身份证号码";
        _idCardTextField.font = [UIFont systemFontOfSize:15];
        _idCardTextField.keyboardType = UIKeyboardTypeDecimalPad;
    }
    return _idCardTextField;
}
/**
 提示标签
 */
- (UILabel *)promptLabel
{
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.text = @"点击获取验证码向一下手机号发送验证码";
        _promptLabel.font = [UIFont systemFontOfSize:15];
    }
    return _promptLabel;
}

/**
 手机号Label
 */
- (UILabel *)phoneNumberLabel
{
    if (!_phoneNumberLabel) {
        _phoneNumberLabel = [[UILabel alloc] init];
        _phoneNumberLabel.text = @"153****1111";
        _phoneNumberLabel.font = [UIFont systemFontOfSize:18];
    }
    return _phoneNumberLabel;
}

/**
 输入验证码TextField
 */
- (UITextField *)verificationCodeTextField
{
    if (!_verificationCodeTextField) {
        _verificationCodeTextField = [[UITextField alloc] init];
        _verificationCodeTextField.placeholder = @"短信验证码";
        _verificationCodeTextField.font = [UIFont systemFontOfSize:15];
        _verificationCodeTextField.keyboardType = UIKeyboardTypeDecimalPad;
    }
    return _verificationCodeTextField;
}
/**
 获取验证码的按钮
 */
- (UIButton *)getValidationCodeButton
{
    if (!_getValidationCodeButton) {
        _getValidationCodeButton = [[UIButton alloc] init];
        _getValidationCodeButton.backgroundColor = [UIColor whiteColor];
        _getValidationCodeButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_getValidationCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getValidationCodeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_getValidationCodeButton addTarget:self action:@selector(getValidationCodeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getValidationCodeButton;
}

/**
 下一步按钮
 */
- (UIButton *)nextButton
{
    if (!_nextButton) {
        _nextButton = [[UIButton alloc] init];
        _nextButton.backgroundColor = [UIColor blueColor];
        _nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _nextButton.layer.masksToBounds = YES;
        _nextButton.layer.cornerRadius = 5;
    }
    return _nextButton;
}

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}

@end
