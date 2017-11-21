//
//  HXBAlertVC.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBAlertVC.h"
#import "SVGKit/SVGKImage.h"
#import "HXBVerificationCodeAlertView.h"
#import "HBAlertPasswordView.h"
@interface HXBAlertVC ()<HBAlertPasswordViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIButton *sureBtn;

@property (nonatomic, strong) UIButton *forgetBtn;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *message;

@property (nonatomic, strong) HBAlertPasswordView *pwdField;

//@property (nonatomic, strong) UIView *lineView;

//@property (nonatomic, strong) UIButton *eyeBtn;
//子标题设置
@property (nonatomic, strong) UILabel *subTitleLabel;

/**
 交易密码
 */
@property (nonatomic, copy) NSString *transactionPassword;

@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) HXBVerificationCodeAlertView *verificationCodeAlertView;

@property (nonatomic, strong) UILabel *mobileLabel;

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
    [self.view addSubview:self.mobileLabel];
    [self.contentView addSubview:self.sureBtn];
    [self.contentView addSubview:self.message];
}

-(void)setIsSpeechVerificationCode:(BOOL)isSpeechVerificationCode{
    _isSpeechVerificationCode = isSpeechVerificationCode;
    self.verificationCodeAlertView.isSpeechVerificationCode = isSpeechVerificationCode;
}
- (void)setIsCode:(BOOL)isCode
{
    _isCode = isCode;
    if (isCode) {
        [self.forgetBtn removeFromSuperview];
        [self.pwdField removeFromSuperview];
        [self.contentView addSubview:self.verificationCodeAlertView];
        [self.contentView addSubview:self.subTitleLabel];
    } else {
        [self.verificationCodeAlertView removeFromSuperview];
        [self.subTitleLabel removeFromSuperview];
        [self.contentView addSubview:self.forgetBtn];
        [self.contentView addSubview:self.pwdField];
    }
    [self setupSubViewFrame];
}

- (void)setSubTitle:(NSString *)subTitle
{
    _subTitle = subTitle;
    self.subTitleLabel.text = subTitle;
}

- (void)setIsMobile:(BOOL)isMobile {
    _isMobile = isMobile;
    if (isMobile) {
        _mobileLabel.hidden = NO;
        _sureBtn.backgroundColor = COR29;
        [_sureBtn setTitle:@"拨打" forState:(UIControlStateNormal)];
        _sureBtn.userInteractionEnabled = YES;
    } else {
        _mobileLabel.hidden = YES;
    }
    
}


- (void)setupSubViewFrame
{
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(kScrAdaptationH750(310));//385
        make.height.offset(kScrAdaptationH750(500));//440
        make.width.offset(kScrAdaptationW750(590));
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_top); 
        make.right.equalTo(self.contentView.mas_right);
        make.width.offset(kScrAdaptationW750(50));
        make.height.offset(kScrAdaptationH750(95));
    }];
    [self.message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kScrAdaptationH750(60));
        make.centerX.equalTo(self.contentView);
        make.height.offset(kScrAdaptationH750(34));
    }];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(kScrAdaptationH750(-60));
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

    [self.mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kScrAdaptationH(50));
        make.bottom.equalTo(self.sureBtn.mas_top);
        make.left.equalTo(self.contentView).offset(kScrAdaptationW750(50));
        make.right.equalTo(self.contentView).offset(kScrAdaptationW750(-50));
    }];
    [self.view bringSubviewToFront:self.mobileLabel];
    
    if (self.isCode) {
       
        [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.message.mas_bottom).offset(kScrAdaptationH750(20));
            make.left.right.equalTo(self.contentView);
        }];
        [self.verificationCodeAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.subTitleLabel.mas_bottom);
            make.bottom.equalTo(self.sureBtn.mas_top);
            make.left.equalTo(self.contentView).offset(kScrAdaptationW750(70));
            make.right.equalTo(self.contentView).offset(kScrAdaptationW750(-70));
        }];
        return;
    }
//    if (self.isMobile) {
    
//        return;
//    }
    
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

- (void)setMessageLabelText:(NSString *)messageLabelText {
    _messageLabelText = messageLabelText;
    self.mobileLabel.text = _messageLabelText;
    if (messageLabelText.length > 0) {
        _verificationCodeAlertView.hidden = YES;
    } else {
        _verificationCodeAlertView.hidden = NO;
    }
}

- (void)setMessageTitle:(NSString *)messageTitle {
    _messageTitle = messageTitle;
    self.message.text = messageTitle;
}

- (void)buttonClick:(UIButton *)btn
{
    if (!self.isCode) {
        //校验交易密码
        [self checkTransactionPasswordWithBtn:btn];
    }else{
        if (_isMobile) {
            self.sureBtnClick(@"打客服");
            return;
        }
        //校验验证码
        [self checkVerificationCode];
        
    }
}

- (void)setIsCleanPassword:(BOOL)isCleanPassword {
    _isCleanPassword = isCleanPassword;
    _pwdField.isCleanPassword = _isCleanPassword;
    _verificationCodeAlertView.isCleanSmsCode = _isCleanPassword;
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
    }else if ([btn.titleLabel.text isEqualToString:@"忘记密码?"]||[btn.titleLabel.text isEqualToString:@"忘记交易密码?"])
    {
        if (self.forgetBtnClick) {
            self.forgetBtnClick();
        }
    }
//    [self dismissViewControllerAnimated:NO completion:nil];
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
        [_sureBtn setBackgroundColor:kHXBColor_Font0_5];
        _sureBtn.userInteractionEnabled = NO;
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
        [_forgetBtn setTitle:@"忘记交易密码?" forState:UIControlStateNormal];
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

- (UILabel *)mobileLabel
{
    if (!_mobileLabel) {
        _mobileLabel = [[UILabel alloc] init];
        _mobileLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(32);
        _mobileLabel.numberOfLines = 0;
        _mobileLabel.hidden = YES;
        _mobileLabel.textAlignment = NSTextAlignmentCenter;
        _mobileLabel.textColor = COR8;
    }
    return _mobileLabel;
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
//        [_backBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (HXBVerificationCodeAlertView *)verificationCodeAlertView
{
    if (!_verificationCodeAlertView) {
        kWeakSelf
        _verificationCodeAlertView = [[HXBVerificationCodeAlertView alloc] init];
        _verificationCodeAlertView.delegate = self;
        _verificationCodeAlertView.backgroundColor = [UIColor whiteColor];
        _verificationCodeAlertView.getVerificationCodeBlock = ^{
            if (weakSelf.getVerificationCodeBlock) {
                weakSelf.getVerificationCodeBlock();
            }
        };
        _verificationCodeAlertView.getSpeechVerificationCodeBlock = ^{
            if (weakSelf.getSpeechVerificationCodeBlock) {
                weakSelf.getSpeechVerificationCodeBlock();
            }
        };
    }
    return _verificationCodeAlertView;
}

- (UILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.textColor = COR8;
        _subTitleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _subTitleLabel;
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}
#pragma mark - <HBAlertPasswordViewDelegate>
- (void)sureActionWithAlertPasswordView:(HBAlertPasswordView *)alertPasswordView password:(NSString *)password {
    
    self.transactionPassword = password;
    NSLog(@"%@",[NSString stringWithFormat:@"输入的密码为:%@", password]);
    if (password.length == 6) {
        [_sureBtn setBackgroundColor:COR29];
       
        _sureBtn.userInteractionEnabled = YES;
    } else {
        [_sureBtn setBackgroundColor:kHXBColor_Font0_5];
        
        _sureBtn.userInteractionEnabled = NO;;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.superview == _verificationCodeAlertView) {
        NSString *str = nil;
        if (string.length) {
            str = [NSString stringWithFormat:@"%@%@",textField.text,string];
        }
        if (range.location == 0 && [string isEqualToString:@""]) {
            [_sureBtn setBackgroundColor:kHXBColor_Font0_5];
            self.verificationCodeAlertView.lineColor = kHXBColor_Font0_5;
            _sureBtn.userInteractionEnabled = NO;;
        } else {
            [_sureBtn setBackgroundColor:COR29];
            self.verificationCodeAlertView.lineColor = COR29;
            _sureBtn.userInteractionEnabled = YES;
        }
        if (str.length > 6) return NO;
    } else {
        if (range.location == 0 && [string isEqualToString:@""]) {
            [_sureBtn setBackgroundColor:kHXBColor_Font0_5];
            self.verificationCodeAlertView.lineColor = kHXBColor_Font0_5;
            _sureBtn.userInteractionEnabled = NO;;
        } else {
            [_sureBtn setBackgroundColor:COR29];
            self.verificationCodeAlertView.lineColor = COR29;
            _sureBtn.userInteractionEnabled = YES;
        }
    }
    return YES;
}


@end
