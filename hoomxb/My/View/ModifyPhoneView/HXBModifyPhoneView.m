//
//  HXBModifyPhoneView.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/24.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBModifyPhoneView.h"
#import "HXBSignUPAndLoginRequest.h"

@interface HXBModifyPhoneView ()

/**
 新手机号输入框
 */
@property (nonatomic, strong) UITextField *phoneTextField;

/**
 短信验证码输入框
 */
@property (nonatomic, strong) UITextField *verificationCodeTextField;

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
- (UITextField *)phoneTextField
{
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.placeholder = @"新手机号";
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneTextField;
}

- (UITextField *)verificationCodeTextField
{
    if (!_verificationCodeTextField) {
        _verificationCodeTextField = [[UITextField alloc] init];
        _verificationCodeTextField.placeholder = @"短信验证码";
    }
    return _verificationCodeTextField;
}

- (UIButton *)getCodeBtn
{
    if (!_getCodeBtn) {
        _getCodeBtn = [[UIButton alloc] init];
        _getCodeBtn.backgroundColor = [UIColor whiteColor];
        _getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_getCodeBtn addTarget:self action:@selector(getCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getCodeBtn;
}

- (UIButton *)sureChangeBtn{
    if (!_sureChangeBtn) {
        _sureChangeBtn = [[UIButton alloc] init];
        _sureChangeBtn.backgroundColor = [UIColor blueColor];
        _sureChangeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sureChangeBtn setTitle:@"确认修改" forState:UIControlStateNormal];
        [_sureChangeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureChangeBtn addTarget:self action:@selector(sureChangeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _sureChangeBtn.layer.masksToBounds = YES;
        _sureChangeBtn.layer.cornerRadius = 5;
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
        make.left.equalTo(@16);
        make.right.equalTo(self).offset(-16);
        make.top.equalTo(@20);
//        make.height.equalTo(@35);
    }];
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-16);
        make.top.equalTo(weakSelf.phoneTextField.mas_bottom).offset(16);
    }];
    [self.verificationCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(weakSelf.getCodeBtn.mas_left);
        make.centerY.equalTo(weakSelf.getCodeBtn);
        //        make.height.equalTo(@35);
    }];
    [self.sureChangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(self).offset(-16);
        make.top.equalTo(self.verificationCodeTextField.mas_bottom).offset(40);
        make.height.equalTo(@35);
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
    } andFailureBlock:^(NSError *error) {
        
    }];
}

- (void)sureChangeBtnClick
{
    if (self.sureChangeBtnClickBlock) {
        self.sureChangeBtnClickBlock(self.phoneTextField.text,self.verificationCodeTextField.text);
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
    kWeakSelf
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        count--;
        [weakSelf.getCodeBtn setTitle:[NSString stringWithFormat:@"%d秒",count] forState:UIControlStateNormal];
        if (count == -1) {
            weakSelf.getCodeBtn.enabled = YES;
            [weakSelf.timer invalidate];
            weakSelf.timer = nil;
            [weakSelf.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        }
    }];
}
- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}
@end
