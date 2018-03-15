//
//  HXBModifyPhoneView.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/24.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBModifyPhoneView.h"
#import "HXBCustomTextField.h"
#import "SVGKit/SVGKImage.h"
#import "HXBSignUPViewModel.h"

@interface HXBModifyPhoneView ()<UITextFieldDelegate>

/**
 新手机号输入框
 */
@property (nonatomic, strong) HXBCustomTextField *phoneTextField;

/**
 短信验证码输入框
 */
@property (nonatomic, strong) HXBCustomTextField *verificationCodeTextField;
//@property (nonatomic, strong) UIView *lineView;
/**
 获取验证码按钮
 */
@property (nonatomic, strong) UIButton *getCodeBtn;

/**
 确认修改按钮
 */
@property (nonatomic, strong) UIButton *sureChangeBtn;

@property (nonatomic, weak) NSTimer *timer;

@property (nonatomic, assign) int timeCount;
@end

@implementation HXBModifyPhoneView

#pragma mark - 懒加载
- (HXBCustomTextField *)phoneTextField
{
    if (!_phoneTextField) {
        _phoneTextField = [[HXBCustomTextField alloc] init];
        _phoneTextField.placeholder = @"新手机号";
        _phoneTextField.delegate = self;
        kWeakSelf
        _phoneTextField.limitStringLength = 11;
        _phoneTextField.block = ^(NSString *text) {
            if (text.length == 11) {
                if (weakSelf.timeCount == 0) {
                    weakSelf.getCodeBtn.backgroundColor = [UIColor whiteColor];
                    weakSelf.getCodeBtn.layer.borderWidth = kXYBorderWidth;
                    weakSelf.getCodeBtn.layer.borderColor = COR29.CGColor;
                    [weakSelf.getCodeBtn setTitleColor:COR29 forState:(UIControlStateNormal)];
                    weakSelf.getCodeBtn.userInteractionEnabled = YES;
                }
            } else if (text.length < 11) {
                weakSelf.getCodeBtn.backgroundColor = COR26;
                weakSelf.getCodeBtn.userInteractionEnabled = NO;
                weakSelf.getCodeBtn.layer.borderWidth = 0;
                [weakSelf.getCodeBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            }
            if (text.length > 0 && _verificationCodeTextField.text.length > 0) {
                [weakSelf.sureChangeBtn setBackgroundColor:COR29];
                weakSelf.sureChangeBtn.userInteractionEnabled = YES;
            } else {
                [weakSelf.sureChangeBtn setBackgroundColor:COR12];
                weakSelf.sureChangeBtn.userInteractionEnabled = NO;
            }

        };
        _phoneTextField.leftImage = [UIImage imageNamed:@"mobile_number"];
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneTextField;
}

- (HXBCustomTextField *)verificationCodeTextField
{
    if (!_verificationCodeTextField) {
        _verificationCodeTextField = [[HXBCustomTextField alloc] init];
        _verificationCodeTextField.placeholder = @"短信验证码";
        _verificationCodeTextField.isGetCode = YES;
        _verificationCodeTextField.delegate = self;
        _verificationCodeTextField.leftImage = [UIImage imageNamed:@"security_code"];
        _verificationCodeTextField.limitStringLength = 6;
        kWeakSelf
        _verificationCodeTextField.block = ^(NSString *text) {
            if (text.length > 0 && _phoneTextField.text.length > 0) {
                [weakSelf.sureChangeBtn setBackgroundColor:COR29];
                weakSelf.sureChangeBtn.userInteractionEnabled = YES;
            } else {
                [weakSelf.sureChangeBtn setBackgroundColor:COR12];
                weakSelf.sureChangeBtn.userInteractionEnabled = NO;
            }
        };
        _verificationCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _verificationCodeTextField;
}

- (UIButton *)getCodeBtn
{
    if (!_getCodeBtn) {
        _getCodeBtn = [UIButton btnwithTitle:@"获取验证码" andTarget:self andAction:@selector(getCodeBtnClick) andFrameByCategory:CGRectZero];
        _getCodeBtn.backgroundColor = COR26;
        _getCodeBtn.userInteractionEnabled = NO;
        _getCodeBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);

    }
    return _getCodeBtn;
}

- (UIButton *)sureChangeBtn{
    if (!_sureChangeBtn) {
        _sureChangeBtn = [UIButton btnwithTitle:@"下一步" andTarget:self andAction:@selector(sureChangeBtnClick) andFrameByCategory:CGRectZero];
        [_sureChangeBtn setBackgroundColor:COR12];
        _sureChangeBtn.userInteractionEnabled = NO;
    }
    return _sureChangeBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubViews];
        
        [self setupSubViewFrame];
    }
    return self;
}

#pragma mark - 处理子视图
/**
 添加子视图
 */
- (void)addSubViews
{
    [self addSubview:self.phoneTextField];
    [self addSubview:self.verificationCodeTextField];
    [self addSubview:self.getCodeBtn];
    [self addSubview:self.sureChangeBtn];
}
/**
 设置子视图frame
 */
- (void)setupSubViewFrame
{
    kWeakSelf
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.offset(kScrAdaptationH750(12));
        make.height.offset(kScrAdaptationH750(120));
    }];
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(kScrAdaptationW750(-40));
        make.centerY.equalTo(weakSelf.verificationCodeTextField);
        make.width.offset(kScrAdaptationW750(170));
        make.height.offset(kScrAdaptationH750(60));
    }];
    [self.verificationCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self.phoneTextField.mas_bottom);
        make.height.offset(kScrAdaptationH750(120));
    }];
    [self.sureChangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW750(40));
        make.right.equalTo(self).offset(kScrAdaptationW750(-40));
        make.top.equalTo(self.verificationCodeTextField.mas_bottom).offset(kScrAdaptationH750(92));
        make.height.offset(kScrAdaptationH750(82));
    }];
}

#pragma mark - 事件处理
- (void)getCodeBtnClick {
    kWeakSelf
    [[[HXBSignUPViewModel alloc] initWithBlock:^UIView *{
        return weakSelf;
    }] checkMobileRequestWithHud:NO mobile:self.phoneTextField.text resultBlock:^(BOOL isSuccess, NSString *message) {
        if (isSuccess) {
            if (weakSelf.getValidationCodeButtonClickBlock) {
                weakSelf.getValidationCodeButtonClickBlock(weakSelf.phoneTextField.text);
            }
        }
    }];

}


- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if (textField.superview == _phoneTextField) {
        _getCodeBtn.backgroundColor = COR26;
        _getCodeBtn.userInteractionEnabled = NO;
        _getCodeBtn.layer.borderWidth = 0;
        [_getCodeBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_sureChangeBtn setBackgroundColor:COR12];
        _sureChangeBtn.userInteractionEnabled = NO;
    } else {
        [_sureChangeBtn setBackgroundColor:COR12];
        _sureChangeBtn.userInteractionEnabled = NO;
    }
    
    return YES;
}

- (void)sureChangeBtnClick
{
    if (self.phoneTextField.text.length == 0) {
        [HxbHUDProgress showTextWithMessage:@"新手机号不能为空"];
    } else if (self.verificationCodeTextField.text.length == 0) {
        [HxbHUDProgress showTextWithMessage:@"请输入正确的验证码"];
    } else {
        if (self.sureChangeBtnClickBlock) {
            self.sureChangeBtnClickBlock(self.phoneTextField.text,self.verificationCodeTextField.text);
        }
    }
}

/**
 发送验证码失败
 */
- (void)sendCodeFail
{
    [self.timer invalidate];
    self.timer = nil;
    self.getCodeBtn.userInteractionEnabled = YES;
    self.getCodeBtn.backgroundColor = COR29;
    [self.getCodeBtn setTitleColor:COR29 forState:(UIControlStateNormal)];
    self.getCodeBtn.layer.borderWidth = kXYBorderWidth;
    [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    
}

/**
 获取验证码成功
 */
- (void)getCodeSuccessfully
{
    self.timeCount = 60;
    [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%ds",self.timeCount] forState:UIControlStateNormal];
    self.getCodeBtn.userInteractionEnabled = NO;
    self.getCodeBtn.backgroundColor = COR26;
    self.getCodeBtn.layer.borderWidth = 0;
    [self.getCodeBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeDown) userInfo:nil repeats:YES];

}

- (void)timeDown
{
    self.timeCount--;
    [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%ds",self.timeCount] forState:UIControlStateNormal];
    if (self.timeCount <= 0) {
        [self.timer invalidate];
        self.timer = nil;
        self.getCodeBtn.userInteractionEnabled = YES;
        self.getCodeBtn.backgroundColor = [UIColor whiteColor];
        self.getCodeBtn.layer.borderWidth = kXYBorderWidth;
        [self.getCodeBtn setTitleColor:COR29 forState:(UIControlStateNormal)];
        [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}
@end
