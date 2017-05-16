
//
//  HxbSignInView.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbSignInView.h"
#import "HxbSignInViewModel.h"

@interface HxbSignInView ()
<
UITextFieldDelegate
>
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *signInButton;
@property (nonatomic, strong) UIButton *signUpbutton;
@end

@implementation HxbSignInView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.phoneTextField];
        [self addSubview:self.passwordTextField];
        [self addSubview:self.signInButton];
        [self addSubview:self.signUpbutton];
        _phoneTextField.text = @"13000000063";
        _passwordTextField.text = @"111111";
    }
    return self;
}
- (void)signInResponse{
    
//    HxbSignInViewModel *signInViewModel =[[HxbSignInViewModel alloc]init];
//    //  {"username":"13000000063","password":"111111"}
//    [signInViewModel signInRequestWithUserName:_phoneTextField.text Password:_passwordTextField.text SuccessBlock:^(BOOL login, NSString *message) {
//        if (login) {
//            [HxbHUDProgress showTextWithMessage:message];
//            if ([self.delegate respondsToSelector:@selector(didClickSignInBtn)]) {
//                [self.delegate didClickSignInBtn];
//        }
    
            [KeyChain setPhone:_phoneTextField.text];
            [KeyChain setLoginPwd:_passwordTextField.text];
//        }
//    } FailureBlock:^(NYBaseRequest *request, NSError *error) {
//        [HxbHUDProgress showTextWithMessage:error.description];
//    }];
}

- (BOOL) calibratePassword{
    
    [_passwordTextField resignFirstResponder];
    if (_phoneTextField.text.length == 0) {
        [HxbHUDProgress showTextWithMessage:@"手机号码不能为空"];
        return NO;
    }else if(_phoneTextField.text.length < 11){
        [HxbHUDProgress showTextWithMessage:@"请输入正确的手机号码"];
        return NO;
    }
    
    if (_passwordTextField.text.length == 0) {
        [HxbHUDProgress showTextWithMessage:@"密码不能为空"];
        return NO;
    }
    return YES;
}

//- (void)phoneTextFieldDidChange:(UITextField *)textField{
//    
//    
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _phoneTextField) {
        [_passwordTextField becomeFirstResponder];
    }else{
        [_passwordTextField resignFirstResponder];
    }
    return YES;
}

- (void)signUpButtonClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(didClicksignUpBtn)]){
        [self.delegate didClicksignUpBtn];
    }
}

- (void)signInButtonClick:(UIButton *)sender{
    NSLog(@"登录验证");
    if ([self calibratePassword]) {
         [self signInResponse];
    }
}

- (UITextField *)phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [UITextField hxb_lineTextFieldWithFrame:CGRectMake(20, self.height/3 - 80, SCREEN_WIDTH - 40, 44)];
        RACSignal *signal = [self.phoneTextField.rac_textSignal map:^id(NSString *value) {
            return @(value.length);
        }];
        [signal subscribeNext:^(id x) {
          
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
@end

