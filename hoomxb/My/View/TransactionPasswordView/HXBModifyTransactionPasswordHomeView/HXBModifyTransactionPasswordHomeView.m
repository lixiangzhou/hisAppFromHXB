//
//  HXBModifyTransactionPasswordHomeView.m
//  修改交易密码
//
//  Created by HXB-C on 2017/6/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBModifyTransactionPasswordHomeView.h"
#import "HXBUserInfoModel.h"
#import "HXBCustomTextField.h"
#import "SVGKImage.h"
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
@property (nonatomic, strong) HXBCustomTextField *idCardTextField;
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
@property (nonatomic, strong) HXBCustomTextField *verificationCodeTextField;
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
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self.authenticatedNameTipLabel.mas_bottom);
        make.height.offset(kScrAdaptationH750(110));
    }];
    if ([self.userInfoModel.userInfo.isIdPassed isEqualToString:@"1"]) {
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
        make.left.equalTo(self.promptLabel.mas_right);
        make.centerY.equalTo(self.promptLabel);
        make.right.equalTo(self).offset(-16);
        make.height.offset(kScrAdaptationH(30));
    }];
    [self.verificationCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self.phoneNumberLabel.mas_bottom);
        make.height.offset(kScrAdaptationH750(110));
    }];
    [self.getValidationCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(kScrAdaptationW750(-40));
        make.centerY.equalTo(self.verificationCodeTextField);
        make.width.offset(kScrAdaptationW750(170));
        make.height.offset(kScrAdaptationH750(60));
    }];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW750(40));
        make.right.equalTo(self).offset(kScrAdaptationW750(-40));
        make.top.equalTo(self.verificationCodeTextField.mas_bottom).offset(kScrAdaptationH750(100));
        make.height.offset(kScrAdaptationH750(82));
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
    self.getValidationCodeButton.backgroundColor = COR26;
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
        [self.getValidationCodeButton setBackgroundColor:COR29];
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
    [self.getValidationCodeButton setBackgroundColor:COR29];

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
    if ([userInfoModel.userInfo.isIdPassed isEqualToString:@"1"]) {
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
        _authenticatedNameTipLabel.text = @"认证姓名：";
        _authenticatedNameTipLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
        _authenticatedNameTipLabel.textColor = COR6;
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
        _authenticatedNameLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
        _authenticatedNameLabel.textColor = COR6;
        _authenticatedNameLabel.text = @"***";
        _authenticatedNameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _authenticatedNameLabel;
}
/**
 输入身份证号码TextField
 */
- (HXBCustomTextField *)idCardTextField
{
    if (!_idCardTextField) {
        _idCardTextField = [[HXBCustomTextField alloc] init];
        _idCardTextField.leftImage = [UIImage imageNamed:@"bankcard"];
        _idCardTextField.placeholder = @"请输入身份证号码";
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
        _promptLabel.text = @"短信会发送到";
        _promptLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
        _promptLabel.textColor = COR6;
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
        _phoneNumberLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
        _phoneNumberLabel.textColor = COR6;
        _phoneNumberLabel.font = [UIFont systemFontOfSize:18];
    }
    return _phoneNumberLabel;
}

/**
 输入验证码TextField
 */
- (HXBCustomTextField *)verificationCodeTextField
{
    if (!_verificationCodeTextField) {
        _verificationCodeTextField = [[HXBCustomTextField alloc] init];
        _verificationCodeTextField.placeholder = @"短信验证码";
        _verificationCodeTextField.leftImage = [UIImage imageNamed:@"security_code"];
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
        _getValidationCodeButton = [UIButton btnwithTitle:@"获取验证码" andTarget:self andAction:@selector(getValidationCodeButtonClick) andFrameByCategory:CGRectZero];
        _getValidationCodeButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(26);

    }
    return _getValidationCodeButton;
}

/**
 下一步按钮
 */
- (UIButton *)nextButton
{
    if (!_nextButton) {
        _nextButton = [UIButton btnwithTitle:@"下一步" andTarget:self andAction:@selector(nextButtonClick) andFrameByCategory:CGRectZero];
    }
    return _nextButton;
}

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}

@end
