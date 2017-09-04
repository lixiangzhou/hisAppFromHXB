//
//  HXBModifyPhoneView.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/24.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBModifyPhoneView.h"
#import "HXBSignUPAndLoginRequest.h"
#import "HXBCustomTextField.h"
#import "SVGKImage.h"
@interface HXBModifyPhoneView ()<UITextFieldDelegate>

/**
 新手机号输入框
 */
@property (nonatomic, strong) HXBCustomTextField *phoneTextField;

/**
 短信验证码输入框
 */
@property (nonatomic, strong) HXBCustomTextField *verificationCodeTextField;
@property (nonatomic, strong) UIView *lineView;
/**
 获取验证码按钮
 */
@property (nonatomic, strong) UIButton *getCodeBtn;

/**
 确认修改按钮
 */
@property (nonatomic, strong) UIButton *sureChangeBtn;

@property (nonatomic, weak) NSTimer *timer;
@end

@implementation HXBModifyPhoneView

#pragma mark - 懒加载
- (HXBCustomTextField *)phoneTextField
{
    if (!_phoneTextField) {
        _phoneTextField = [[HXBCustomTextField alloc] init];
        _phoneTextField.placeholder = @"新手机号";
        _phoneTextField.delegate = self;
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
        _verificationCodeTextField.delegate = self;
        _verificationCodeTextField.isHidenLine = YES;
        _verificationCodeTextField.leftImage = [UIImage imageNamed:@"security_code"];
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
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(kScrAdaptationW750(40), kScrAdaptationH750(250.4), kScreenWidth - kScrAdaptationW750(80), kScrAdaptationH750(1.6))];
    self.lineView.backgroundColor = COR12;
    [self addSubview:self.lineView];
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
        make.right.equalTo(self).offset(-kScrAdaptationW750(210));
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
- (void)getCodeBtnClick
{
    
    if (![NSString isMobileNumber:self.phoneTextField.text]) {
        [HxbHUDProgress showTextWithMessage:@"请输入正确的手机号"];
        return;
    }
    [HXBSignUPAndLoginRequest checkExistMobileRequestWithMobile:self.phoneTextField.text andSuccessBlock:^(BOOL isExist) {
        if (isExist) {
            [HxbHUDProgress showTextWithMessage:@"手机号已经被绑定"];
        }else
        {
            if (self.getValidationCodeButtonClickBlock) {
                self.getValidationCodeButtonClickBlock(self.phoneTextField.text);
            }
        }
    } andFailureBlock:^(NSError *error, NYBaseRequest *request) {
        
        if (request) {
            UIView *view = nil;
            if([self isKindOfClass:[UIViewController class]]) {
                UIViewController *vc = (UIViewController *)self;
                view = vc.view;
            }
            if ([self isKindOfClass:[UIView class]]) {
                view = self;
            }
            if (view){
                [HxbHUDProgress showMessage:request.responseObject[kResponseMessage] inView:view];
            }else
                [HxbHUDProgress showMessage:request.responseObject[kResponseMessage]];
        }
    }];

}
//参数一：range,要被替换的字符串的range，如果是新键入的那么就没有字符串被替换，range.lenth=0,第二个参数：替换的字符串，即键盘即将键入或者即将粘贴到textfield的string
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.superview == _phoneTextField) {
        NSString *str = nil;
        if (string.length) {
            str = [NSString stringWithFormat:@"%@%@",textField.text,string];
        } else if(!string.length) {
            NSInteger length = self.phoneTextField.text.length;
            NSRange range = NSMakeRange(length - 1, 1);
            NSMutableString *strM = self.phoneTextField.text.mutableCopy;
            [strM deleteCharactersInRange:range];
            str = strM.copy;
        }
        if (str.length == 11) {
            [_phoneTextField resignFirstResponder];
            if (![NSString isMobileNumber:str]) {
                [HxbHUDProgress showTextWithMessage:@"请输入正确的手机号"];
            } else {
                _getCodeBtn.backgroundColor = COR29;
                _getCodeBtn.userInteractionEnabled = YES;
            }
        } else if (str.length > 11) {
            return NO;
        } else {
            _getCodeBtn.backgroundColor = COR26;
            _getCodeBtn.userInteractionEnabled = NO;
        }
    } else {
        NSString *str = nil;
        if (string.length) {
            str = [NSString stringWithFormat:@"%@%@",textField.text,string];
        } else if(!string.length) {
            NSInteger length = self.verificationCodeTextField.text.length;
            NSRange range = NSMakeRange(length - 1, 1);
            NSMutableString *strM = self.verificationCodeTextField.text.mutableCopy;
            [strM deleteCharactersInRange:range];
            str = strM.copy;
        }
        if (str.length > 6) {
            return NO;
        }
    }
    
    return YES;
    
}


- (void)sureChangeBtnClick
{
    if (self.phoneTextField.text.length == 0) {
        [HxbHUDProgress showTextWithMessage:@"新手机号不能为空"];
    } else if (![NSString isMobileNumber:self.phoneTextField.text]) {
        [HxbHUDProgress showTextWithMessage:@"请输入正确的手机号"];
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
    self.getCodeBtn.enabled = YES;
    [self.timer invalidate];
    self.timer = nil;
    [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    
}

/**
 获取验证码成功
 */
- (void)getCodeSuccessfully
{
    self.getCodeBtn.enabled = NO;
    __block int count = 60;
    [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%d秒",count] forState:UIControlStateNormal];
    self.getCodeBtn.backgroundColor = COR26;
    kWeakSelf
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        count--;
        [weakSelf.getCodeBtn setTitle:[NSString stringWithFormat:@"%d秒",count] forState:UIControlStateNormal];
        if (count == -1) {
            weakSelf.getCodeBtn.enabled = YES;
            [weakSelf.timer invalidate];
            weakSelf.timer = nil;
            [weakSelf.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            weakSelf.getCodeBtn.backgroundColor = COR29;
        }
    }];
}
- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}
@end
