//
//  HXBVerificationCodeAlertVC
//  hoomxb
//
//  Created by HXB-C on 2017/6/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBVerificationCodeAlertVC.h"
#import "HXBVerificationCodeAlertView.h"

@interface HXBVerificationCodeAlertVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *messageLab;
@property (nonatomic, strong) UILabel *subTitleLabel;

@end

@implementation HXBVerificationCodeAlertVC

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
    [self.contentView addSubview:self.cancelBtn];
    [self.contentView addSubview:self.sureBtn];
    [self.contentView addSubview:self.messageLab];
    [self.contentView addSubview:self.verificationCodeAlertView];
    [self.contentView addSubview:self.subTitleLabel];
    
    [self setupSubViewFrame];
}

-(void)setIsSpeechVerificationCode:(BOOL)isSpeechVerificationCode{
    _isSpeechVerificationCode = isSpeechVerificationCode;
    self.verificationCodeAlertView.isSpeechVerificationCode = isSpeechVerificationCode;
}

- (void)setSubTitle:(NSString *)subTitle
{
    _subTitle = subTitle;
    self.subTitleLabel.text = subTitle;
}

- (void)setupSubViewFrame
{
    kWeakSelf
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(kScrAdaptationH750(400));//385 310
        make.height.offset(kScrAdaptationH750(400));//440 500
        make.width.offset(kScrAdaptationW750(560));//590
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView.mas_bottom);
        make.left.equalTo(weakSelf.contentView.mas_left);
        make.width.mas_equalTo(kScrAdaptationW750(280));
        make.height.offset(kScrAdaptationH750(80));
    }];
    [self.messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView.mas_top).offset(kScrAdaptationH750(60));
        make.centerX.equalTo(weakSelf.contentView);
        make.height.offset(kScrAdaptationH750(34));
    }];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView.mas_bottom);
        make.right.equalTo(weakSelf.contentView.mas_right);
        make.width.mas_equalTo(kScrAdaptationW750(280));
        make.height.offset(kScrAdaptationH750(80));
    }];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.bottom.equalTo(weakSelf.view.mas_bottom);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.messageLab.mas_bottom).offset(kScrAdaptationH750(20));
        make.left.right.equalTo(weakSelf.contentView);
    }];
    [self.verificationCodeAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.subTitleLabel.mas_bottom);//.offset(kScrAdaptationH750(50));
        make.bottom.equalTo(weakSelf.sureBtn.mas_top).offset(kScrAdaptationH750(-60));
        make.left.equalTo(weakSelf.contentView).offset(kScrAdaptationW750(30));
        make.right.equalTo(weakSelf.contentView).offset(kScrAdaptationW750(-30));
    }];
}

- (void)setMessageTitle:(NSString *)messageTitle {
    _messageTitle = messageTitle;
    self.messageLab.text = messageTitle;
}

- (void)buttonClick:(UIButton *)btn
{
    //校验验证码
    [self checkVerificationCode];
}

- (void)setIsCleanPassword:(BOOL)isCleanPassword {
    _isCleanPassword = isCleanPassword;
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
    if (self.sureBtnClick) {
        self.sureBtnClick(self.verificationCodeAlertView.verificationCode);
    }
}

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
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
//        [_cancelBtn setImage:[SVGKImage imageNamed:@"close.svg"].UIImage forState:UIControlStateNormal];
        _cancelBtn.backgroundColor = RGB(232, 232, 238);
        _cancelBtn.userInteractionEnabled = YES;
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
        [_sureBtn setBackgroundColor:COR29];
        _sureBtn.userInteractionEnabled = NO;
        _sureBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
    }
    return _sureBtn;
}

- (UILabel *)messageLab
{
    if (!_messageLab) {
        _messageLab = [[UILabel alloc] init];
        _messageLab.font = kHXBFont_PINGFANGSC_REGULAR_750(34);
    }
    return _messageLab;
}

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
    if (self.cancelBtnClickBlock) {
        self.cancelBtnClickBlock();
    }
    [self dismissViewControllerAnimated:NO completion:^{
    }];
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
