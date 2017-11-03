//
//  HXBVerificationCodeAlertView.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/14.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBVerificationCodeAlertView.h"

@interface HXBVerificationCodeAlertView ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UIButton *codeBtn;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, assign) int count;

@property (nonatomic, strong) NSTimer *timer;
@end


@implementation HXBVerificationCodeAlertView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.textField];
        [self addSubview:self.codeBtn];
        [self addSubview:self.line];
        [self setupSubViewFrame];
        self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self getVerificationCode];
    }
    return self;
}

- (void)setIsCleanSmsCode:(BOOL)isCleanSmsCode {
    _isCleanSmsCode = isCleanSmsCode;
    if (_isCleanSmsCode) {
        _textField.text = @"";
    } else {
        
    }
}

- (void)setupSubViewFrame
{
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right);
        make.width.offset(kScrAdaptationW750(160));
        make.height.offset(kScrAdaptationH750(60));
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.codeBtn);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.codeBtn.mas_left).offset(kScrAdaptationW750(-50));
        make.height.offset(kScrAdaptationH(32));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textField.mas_left);
        make.right.equalTo(self.textField.mas_right);
        make.bottom.equalTo(self.codeBtn.mas_bottom);
        make.height.offset(kHXBDivisionLineHeight);
    }];
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    self.line.backgroundColor = lineColor;
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate
{
    _delegate = delegate;
    self.textField.delegate = delegate;
}
- (void)getVerificationCode
{
    self.codeBtn.enabled = NO;
    self.count = 60;
    [self.codeBtn setBackgroundColor:COR12];
    self.codeBtn.layer.borderWidth = 0;
    [self.codeBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.codeBtn setTitle:[NSString stringWithFormat:@"%ds",self.count] forState:UIControlStateNormal];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeDown) userInfo:nil repeats:YES];
    if (self.getVerificationCodeBlock) {
        self.getVerificationCodeBlock();
    }
}

- (void)timeDown
{
    self.count--;
    [self.codeBtn setTitle:[NSString stringWithFormat:@"%ds",self.count] forState:UIControlStateNormal];
    if (self.count == -1) {
        self.codeBtn.enabled = YES;
        [self.timer invalidate];
        self.timer = nil;
        [self.codeBtn setBackgroundColor:[UIColor whiteColor]];
        self.codeBtn.layer.borderWidth = kXYBorderWidth;
        self.codeBtn.layer.borderColor = COR29.CGColor;
        [self.codeBtn setTitleColor:COR29 forState:(UIControlStateNormal)];
        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

- (NSString *)verificationCode
{
    return self.textField.text;
}

#pragma mark - 懒加载
- (UIButton *)codeBtn
{
    if (!_codeBtn) {
        _codeBtn = [[UIButton alloc] init];
        _codeBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_codeBtn addTarget:self action:@selector(getVerificationCode) forControlEvents:UIControlEventTouchUpInside];
        [_codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_codeBtn setBackgroundColor:RGB(245, 81, 81)];
        _codeBtn.layer.cornerRadius = kScrAdaptationW750(8);
        _codeBtn.layer.masksToBounds = YES;
        
    }
    return _codeBtn;
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = kHXBFont_PINGFANGSC_REGULAR_750(32);
        _textField.textColor = RGB(51, 51, 51);
        _textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _textField;
}
- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = RGB(221, 221, 221);
    }
    return _line;
}
- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}


@end
