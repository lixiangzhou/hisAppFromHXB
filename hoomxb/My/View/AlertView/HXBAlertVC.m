//
//  HXBAlertVC.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBAlertVC.h"
#import "SVGKImage.h"
#import "HXBVerificationCodeAlertView.h"
#import "HBAlertPasswordView.h"
@interface HXBAlertVC ()<HBAlertPasswordViewDelegate>
@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIButton *sureBtn;

@property (nonatomic, strong) UIButton *forgetBtn;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *message;

@property (nonatomic, strong) HBAlertPasswordView *pwdField;

//@property (nonatomic, strong) UIView *lineView;

//@property (nonatomic, strong) UIButton *eyeBtn;

/**
 交易密码
 */
@property (nonatomic, copy) NSString *transactionPassword;

@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) HXBVerificationCodeAlertView *verificationCodeAlertView;

@end

@implementation HXBAlertVC

- (instancetype)init
{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.cancelBtn];
    [self.contentView addSubview:self.sureBtn];
    [self.contentView addSubview:self.message];
    
    
    
   
}

- (void)setIsCode:(BOOL)isCode
{
    _isCode = isCode;
    if (isCode) {
        [self.contentView addSubview:self.verificationCodeAlertView];
    }else
    {
        [self.contentView addSubview:self.forgetBtn];
        [self.contentView addSubview:self.pwdField];
//        [self.contentView addSubview:self.lineView];
//        [self.contentView addSubview:self.eyeBtn];
    }
    [self setupSubViewFrame];
}

- (void)setupSubViewFrame
{
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(kScrAdaptationH750(385));
        make.height.offset(kScrAdaptationH750(440));
        make.width.offset(kScrAdaptationW750(590));
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.width.offset(kScrAdaptationW750(50));
        make.height.offset(kScrAdaptationH750(95));
    }];
    [self.message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kScrAdaptationH750(80));
        make.centerX.equalTo(self.contentView);
        make.height.offset(kScrAdaptationH750(34));
    }];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(kScrAdaptationH750(-73));
        make.left.equalTo(self.contentView.mas_left).offset(kScrAdaptationW750(40));
        make.right.equalTo(self.contentView.mas_right).offset(-kScrAdaptationW750(40));
        make.height.offset(kScrAdaptationH750(70));
    }];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];

    if (self.isCode) {
        [self.verificationCodeAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.message.mas_bottom);
            make.bottom.equalTo(self.sureBtn.mas_top);
            make.left.equalTo(self.contentView).offset(kScrAdaptationW750(90));
            make.right.equalTo(self.contentView).offset(kScrAdaptationW750(-90));
        }];
        return;
    }
    
    [self.pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.message.mas_bottom).offset(kScrAdaptationH750(40));
        make.left.equalTo(self.contentView.mas_left).offset(kScrAdaptationW750(45));
        make.right.equalTo(self.contentView.mas_right).offset(-kScrAdaptationW750(45));
        make.height.offset(kScrAdaptationH750(80));
    }];
//    [self.eyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.pwdField);
//        make.right.equalTo(self.pwdField.mas_right);
//        make.height.offset(kScrAdaptationH750(23.9));
//        make.width.offset(kScrAdaptationW750(40));
//    }];
    
//    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.pwdField.mas_bottom).offset(kScrAdaptationH750(20));
//        make.left.equalTo(self.contentView.mas_left).offset(kScrAdaptationW750(40));
//        make.right.equalTo(self.contentView.mas_right).offset(-kScrAdaptationW750(40));
//        make.height.offset(0.5);
//    }];
    
    [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdField.mas_bottom).offset(kScrAdaptationH750(20));
        make.right.equalTo(self.contentView.mas_right).offset(kScrAdaptationW750(-27));
        make.height.offset(kScrAdaptationH750(24));
    }];
    
}

- (void)setMessageTitle:(NSString *)messageTitle
{
    _messageTitle = messageTitle;
    self.message.text = messageTitle;
}

- (void)buttonClick:(UIButton *)btn
{
    if (!self.isCode) {
        //校验交易密码
        [self checkTransactionPasswordWithBtn:btn];
    }else
    {
        //校验验证码
        [self checkVerificationCode];
    }
    
}
/**
 校验验证码
 */
- (void)checkVerificationCode
{
    if (self.verificationCodeAlertView.verificationCode.length <= 0) {
        [HxbHUDProgress showMessage:@"验证码不能为空" inView:self.contentView];
        return;
    }
    self.sureBtnClick(self.verificationCodeAlertView.verificationCode);
//    [self dismissViewControllerAnimated:NO completion:nil];
}

/**
 校验交易密码
 */
- (void)checkTransactionPasswordWithBtn:(UIButton *)btn
{
    if ([btn.titleLabel.text isEqualToString:@"确定"]) {
        if (self.transactionPassword.length != 6) {
            [HxbHUDProgress showMessage:@"交易密码为6位数字" inView:self.contentView];
            return;
        }else
        {
            self.sureBtnClick(self.transactionPassword);
        }
    }else if ([btn.titleLabel.text isEqualToString:@"忘记密码?"])
    {
        if (self.forgetBtnClick) {
            self.forgetBtnClick();
        }
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

//- (UIView *)lineView
//{
//    if (!_lineView) {
//        _lineView = [[UIView alloc] init];
//        _lineView.backgroundColor = RGB(221, 221, 221);
//    }
//    return _lineView;
//}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = kScrAdaptationW750(10);
        _contentView.layer.masksToBounds = YES;
        
    }
    return _contentView;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] init];
//        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setImage:[SVGKImage imageNamed:@"close.svg"].UIImage forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancelBtn.backgroundColor = [UIColor clearColor];
        [_cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc] init];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_sureBtn setBackgroundColor:RGB(245, 81, 81)];
        _sureBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
        _sureBtn.layer.cornerRadius = kScrAdaptationW750(10);
        _sureBtn.layer.masksToBounds = YES;
    }
    return _sureBtn;
}

//- (void)eyeBtnClick
//{
//    self.pwdField.secureTextEntry = self.eyeBtn.selected;
//    self.eyeBtn.selected = !self.eyeBtn.selected;
//}
- (UIButton *)forgetBtn
{
    if (!_forgetBtn) {
        _forgetBtn = [[UIButton alloc] init];
        [_forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        _forgetBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        [_forgetBtn setTitleColor:RGB(115, 173, 255) forState:UIControlStateNormal];
        [_forgetBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetBtn;
}
- (UILabel *)message
{
    if (!_message) {
        _message = [[UILabel alloc] init];
        _message.font = kHXBFont_PINGFANGSC_REGULAR_750(34);
    }
    return _message;
}

- (HBAlertPasswordView *)pwdField
{
    if (!_pwdField) {
        _pwdField = [[HBAlertPasswordView alloc] initWithFrame:CGRectMake(100, 100, kScrAdaptationW750(500), kScrAdaptationH750(80))];
        _pwdField.delegate = self;
//        _pwdField = [[HBAlertPasswordView alloc] init];
//        _pwdField.placeholder = @"请输入交易密码";
//        _pwdField.secureTextEntry = YES;
//        _pwdField.keyboardType = UIKeyboardTypeNumberPad;
//        _pwdField.layer.borderWidth = 0.5;
//        _pwdField.layer.borderColor = COR12.CGColor;
    }
    return _pwdField;
}

//- (UIButton *)eyeBtn
//{
//    if (!_eyeBtn) {
//        _eyeBtn = [[UIButton alloc] init];
//        [_eyeBtn setImage:[SVGKImage imageNamed:@"password_eye_close.svg"].UIImage forState:UIControlStateNormal];
//        [_eyeBtn setImage:[SVGKImage imageNamed:@"password_eye_open.svg"].UIImage forState:UIControlStateSelected];
//        [_eyeBtn addTarget:self action:@selector(eyeBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _eyeBtn;
//}

- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] init];
        _backBtn.backgroundColor = [UIColor clearColor];
        [_backBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (HXBVerificationCodeAlertView *)verificationCodeAlertView
{
    if (!_verificationCodeAlertView) {
        kWeakSelf
        _verificationCodeAlertView = [[HXBVerificationCodeAlertView alloc] init];
        _verificationCodeAlertView.backgroundColor = [UIColor whiteColor];
        _verificationCodeAlertView.getVerificationCodeBlock = ^{
            if (weakSelf.getVerificationCodeBlock) {
                weakSelf.getVerificationCodeBlock();
            }
        };
    }
    return _verificationCodeAlertView;
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}
#pragma mark - <HBAlertPasswordViewDelegate>
- (void)sureActionWithAlertPasswordView:(HBAlertPasswordView *)alertPasswordView password:(NSString *)password {
    
//    [alertPasswordView removeFromSuperview];
    self.transactionPassword = password;
    NSLog(@"%@",[NSString stringWithFormat:@"输入的密码为:%@", password]);
}


@end
