
//
//  HxbSignInView.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbSignInView.h"


static NSString *const kPhoneText = @"手机号";
static NSString *const kPasswordText = @"密码";
static NSString *const kSignInText = @"同意用户协议并登陆";
static NSString *const kSignUPText = @"还没有账户，去注册";

static NSString *const kPhoneText_Error = @"请输入正确的手机号码";
static NSString *const kPhoneText_Nil = @"手机号码不能为空";
static NSString *const kPassword_Nil = @"密码不能为空";
static NSString *const kThePhoneNumberDoesNotMatchThePassword = @"手机号与密码不匹配";

///注册登录的View
@interface HxbSignInView ()
<
UITextFieldDelegate
>

///点击了登录按钮
@property (nonatomic,copy) void(^clickSignInButtonBlock)(NSString *pasword);
///点击了注册按钮
@property (nonatomic,copy) void(^clickSignUpButtonBlock)();

///电话号码
@property (nonatomic, strong) UITextField *phoneTextField;
///密码
@property (nonatomic, strong) UITextField *passwordTextField;
///登录按钮
@property (nonatomic, strong) UIButton *signInButton;
///注册按钮
@property (nonatomic, strong) UIButton *signUpbutton;
///手机号
@property (nonatomic, strong) UILabel *phoneNumberLabel;
///密码
@property (nonatomic, strong) UILabel *passwordLabel;
@end

@implementation HxbSignInView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        ///创建自控制器
        [self setUPSubViews_Creat];
        ///设置子控件
        [self setUPSubViews_SetUP];
    }
    return self;
}

///创建自控制器
- (void)setUPSubViews_Creat {
    self.phoneTextField = [[UITextField alloc]init];
    self.passwordTextField = [[UITextField alloc]init];
    self.signInButton = [[UIButton alloc]init];
    self.signUpbutton = [[UIButton alloc]init];
    
    self.phoneNumberLabel = [[UILabel alloc]init];///关于手机号的Label
    self.passwordLabel = [[UILabel alloc]init];///关于密码的label
    
    [self addSubview:self.phoneTextField];
    [self addSubview:self.passwordTextField];
    [self addSubview:self.signInButton];
    [self addSubview:self.signUpbutton];
    
    [self addSubview:self.phoneNumberLabel];
    [self addSubview:self.passwordLabel];
    
    
    kWeakSelf
    [self.phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(kScrAdaptationH(120));
        make.left.equalTo(weakSelf).offset(kScrAdaptationW(20));
        make.width.equalTo(@(kScrAdaptationW(80)));
        make.height.offset(kScrAdaptationH(40));
    }];
    [self.passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.phoneNumberLabel.mas_bottom).offset(kScrAdaptationH(20));
        make.width.equalTo(weakSelf.phoneNumberLabel.mas_width);
        make.left.equalTo(weakSelf.phoneNumberLabel);
        make.height.equalTo(weakSelf.phoneNumberLabel);
    }];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.phoneNumberLabel);
        make.left.equalTo(weakSelf.phoneNumberLabel.mas_right).offset(kScrAdaptationW(0));
        make.right.equalTo(weakSelf).offset(kScrAdaptationW(-20));
        make.height.equalTo(@(kScrAdaptationH(40)));
    }];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.passwordLabel);
        make.right.left.equalTo(weakSelf.phoneTextField);
        make.width.height.centerX.equalTo(weakSelf.phoneTextField);
    }];
    [self.signInButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.passwordTextField.mas_bottom).offset(kScrAdaptationH(120));
        make.right.equalTo(weakSelf).offset(-20);
        make.left.equalTo(weakSelf).offset(20);
    }];
    [self.signUpbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.signInButton.mas_bottom).offset(20);
        make.right.left.equalTo(weakSelf.signInButton);
    }];
    
    self.signInButton.backgroundColor = [UIColor hxb_randomColor];
    self.signUpbutton.backgroundColor = [UIColor hxb_randomColor];
    self.passwordTextField.backgroundColor = [UIColor hxb_randomColor];
    self.phoneTextField.backgroundColor = [UIColor hxb_randomColor];
}

///设置子控件
- (void)setUPSubViews_SetUP {
    //赋值
    self.phoneNumberLabel.text = kPhoneText;//手机号
    self.passwordLabel.text = kPasswordText;//密码
    self.phoneNumberLabel.textColor = [UIColor redColor];
    self.passwordLabel.textColor = [UIColor redColor];
    
    self.phoneTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;

    //button 的设置
    [self.signInButton setTitle:kSignInText forState:UIControlStateNormal];
    [self.signUpbutton setTitle:kSignUPText forState:UIControlStateNormal];
    
    self.signUpbutton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.signInButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //点击事件的添加
    [self.signInButton addTarget:self action:@selector(clickSignInButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.signUpbutton addTarget:self action:@selector(clickSignUPButton:) forControlEvents:UIControlEventTouchUpInside];
    
}
///点击了 登录按钮
- (void)clickSignInButton: (UIButton *)signInButton {
    ///有未填写的信息，或者有手机号不正确 就返回
    if ([self notFillInThoseInformation]) return;
    if (![NSString isMobileNumber:self.phoneTextField.text]) return;
    
    ///可以登录
    if (self.clickSignInButtonBlock) self.clickSignInButtonBlock(self.passwordTextField.text);
    
}
///点击了 注册按钮
- (void)clickSignUPButton: (UIButton *)signUPButton {
    
}
///判断 未填写那些资料 （密码、手机号）
- (BOOL) notFillInThoseInformation {
    //电话号码未填写
    if (!self.phoneTextField.text.length) {
        NSLog(@"%@",kPhoneText_Nil);
        return true;
    }
    if (!self.passwordTextField.text.length) {
        NSLog(@"%@",kPassword_Nil);
        return true;
    }
    return false;
}



#pragma mark - textField 的代理方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return true;
}
///当textField 的值将要改变的时候调用
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //1、textField 输入string后的值
    NSString *str = nil;
    if (string.length) {
        str = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }else {
        NSInteger length = self.phoneTextField.text.length;
        NSRange range = NSMakeRange(length - 1, 1);
        NSMutableString *strM = self.phoneTextField.text.mutableCopy;
        [strM deleteCharactersInRange:range];
        str = strM.copy;
    }
    
    //是否展示清除按钮
    UITextFieldViewMode model = str.length ? UITextFieldViewModeAlways : UITextFieldViewModeNever;
    textField.clearButtonMode = model;
    
    //如果是号码textField 那么就直接返回true
    if (textField == self.passwordTextField) return true;
    //是否为电话号码
    [self showISMobileNumberViewWithString: str];
    
    //点击了删除按钮
    if ([string isEqual: @""]) return true;
    
    //如果是号密码的textField 那么就判断，是否超多了11位，如果超过了，就直接取消第一相应，并调到密码的第一相应
    if ([self isPhoneTextFieldLenthOutdo11]) {
        [self.phoneTextField resignFirstResponder];
        [self.passwordTextField becomeFirstResponder];
    }
    return true;
}

///停止编辑的时候要判断有没有手势密码。（有 输入，没有就去设置）
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (textField == self.phoneTextField) {
     
    }
    return true;
}

///电话的number是否为超出了11位
- (BOOL) isPhoneTextFieldLenthOutdo11 {
    if (self.phoneTextField.text.length >= 11) {
        return true;
    }
    return false;
}

///展示是否为电话号码
- (void)showISMobileNumberViewWithString:(NSString *)str {
    BOOL isTrue = [NSString isMobileNumber:str];
    NSLog(@"电话号码-- %d",isTrue);
}



#pragma mark - 点击事件的传递
//登录
- (void)signIN_ClickButtonFunc:(void (^)(NSString *pasword))clickSignInButtonBlock {
    self.clickSignInButtonBlock = clickSignInButtonBlock;
}
//注册
- (void)signUP_clickButtonFunc:(void (^)())clickSignUPButtonBlock {
    self.clickSignUpButtonBlock = clickSignUPButtonBlock;
}





/*
- (UITextField *)phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [UITextField hxb_lineTextFieldWithFrame:CGRectMake(20, self.height/3 - 80, SCREEN_WIDTH - 40, 44)];
        RACSignal *signal = [self.phoneTextField.rac_textSignal map:^id(NSString *value) {
            return @(value.length);
        }];
        [signal subscribeNext:^(id x) {
           
            NSInteger X = [x integerValue];
            if (X >= 11) {
                [self.passwordTextField resignFirstResponder];
                [self.passwordTextField becomeFirstResponder];
            }
        }];
//        [_phoneTextField addTarget:self action:@selector(phoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        UILabel *leftLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,70, 44)];
        leftLable.text = @"手机号";
        leftLable.textColor = COR1;
        _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        _phoneTextField.delegate = self;
        _phoneTextField.leftView = leftLable;
        _phoneTextField.returnKeyType = UIReturnKeyNext;
    }
    return _phoneTextField;
}

- (UITextField *)passwordTextField{
    if (!_passwordTextField) {
        _passwordTextField = [UITextField hxb_lineTextFieldWithFrame:CGRectMake(20, CGRectGetMaxY(_phoneTextField.frame) + 60, SCREEN_WIDTH - 40, 44)];
//        [_passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        UILabel *leftLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,70, 44)];
        leftLable.text = @"密码";
        leftLable.textColor = COR1;
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        _passwordTextField.delegate = self;
        _passwordTextField.leftView = leftLable;
        _passwordTextField.returnKeyType = UIReturnKeyDone;
    }
    return _passwordTextField;
}

- (UIButton *)signInButton{
    if (!_signInButton) {
        _signInButton = [UIButton btnwithTitle:@"Sign In" andTarget:self andAction:@selector(signInButtonClick:) andFrameByCategory:CGRectMake(20,CGRectGetMaxY(_passwordTextField.frame) + 120, SCREEN_WIDTH - 40, 44)];
    }
    return _signInButton;
}

- (UIButton *)signUpbutton{
    if (!_signUpbutton) {
        _signUpbutton = [[UIButton alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_signInButton.frame) + 20, SCREEN_WIDTH , 20)];
        [_signUpbutton setTitle:@"Sign Up" forState:UIControlStateNormal];
        [_signUpbutton setTitleColor:COR1 forState:UIControlStateNormal];
        [_signUpbutton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_signUpbutton addTarget:self action:@selector(signUpButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //                         btnwithTitle:@"Sign In" andTarget:self andAction:@selector(signUpButtonClick:) andFrameByCategory:];
    }
    return _signUpbutton;
}
*/
 @end

