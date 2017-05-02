//
//  HxbSignInViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbSignInViewController.h"
#import "HxbSignInViewModel.h"
#import "HxbSignUpViewController.h"
#import "HxbPhoneVerifyViewController.h"

@interface HxbSignInViewController ()
<
UITextFieldDelegate
>
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *lineSecondView;
@property (nonatomic, strong) UIButton *signInButton;
@property (nonatomic, strong) UIButton *signUpbutton;
@end

@implementation HxbSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Sign In";
    [self setLeftItemBar];
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.signInButton];
    [self.view addSubview:self.signUpbutton];
    _phoneTextField.text = @"13000000063";
    _passwordTextField.text = @"111111";
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [HXBNotificationCenter removeObserver:self name:ShowLoginVC object:nil];
}

- (void)textFieldDidChange:(UITextField *)textField{
    
}

- (void)signUpButtonClick:(UIButton *)sender{
    HxbPhoneVerifyViewController *phoneVerifyViewController =[[HxbPhoneVerifyViewController alloc]init];
    [self.navigationController pushViewController:phoneVerifyViewController animated:true];
}

- (void)signInButtonClick:(UIButton *)sender{
    NSLog(@"登录验证");
    [self calibratePassword];
    [self signInResponse];
    
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setLeftItemBar{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"login_close"] style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
    leftItem.tintColor = [UIColor colorWithRed:131/255.0f green:131/255.0f blue:131/255.0f alpha:1];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)signInResponse{
    if (_phoneTextField.text.length == 0) {
        [HxbHUDProgress showTextWithMessage:@"用户名不能为空"];
        return;
    }
    
    if (_passwordTextField.text.length == 0) {
        [HxbHUDProgress showTextWithMessage:@"密码不能为空"];
        return;
    }
    
    HxbSignInViewModel *signInViewModel =[[HxbSignInViewModel alloc]init];
  //  {"username":"13000000063","password":"111111"}
    [signInViewModel signInRequestWithUserName:_phoneTextField.text Password:_passwordTextField.text SuccessBlock:^(BOOL login, NSString *message) {
        if (login) {
            [HxbHUDProgress showTextWithMessage:message];
            [self dismissViewControllerAnimated:YES completion:nil];
            [KeyChain setPhone:_phoneTextField.text];
            [KeyChain setLoginPwd:_passwordTextField.text];
        }
    } FailureBlock:^(NYBaseRequest *request, NSError *error) {
       [HxbHUDProgress showTextWithMessage:error.description];
    }];
}

- (void) calibratePassword{
  
    [_passwordTextField resignFirstResponder];
//    if (![NSString isStringContainNumberWith:_passwordTextField.text]) {
//     
//        [HxbHUDProgress showTextWithMessage:@""];
//        return;
//    }
//    if ([NSString isChinese:_passwordTextField.text]) {
////        [self showWrongViewWithTitle:@"密码格式错误" detail:@"密码中不能出现中文字符"];
//        return;
//    }

}

- (UITextField *)phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT/3 - 80, SCREEN_WIDTH - 40, 44)];
        _phoneTextField.font = [UIFont systemFontOfSize:22];
        _phoneTextField.delegate = self;
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.tintColor = COR11;
        _phoneTextField.textColor = COR6;
//        _phoneTextField.rightView = self.textFieldRightImageView;
        _phoneTextField.rightViewMode = UITextFieldViewModeAlways;
        _phoneTextField.rightView.hidden = YES;
        [_phoneTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [_phoneTextField addSubview:self.lineView];
    }
    return _phoneTextField;
}

- (UITextField *)passwordTextField{
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_phoneTextField.frame) + 60, SCREEN_WIDTH - 40, 44)];
        _passwordTextField.font = [UIFont systemFontOfSize:22];
        _passwordTextField.delegate = self;
        //        _passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.tintColor = COR11;
        _passwordTextField.textColor = COR6;
//        _passwordTextField.rightView = self.textFieldRightImageView;
//        _passwordTextField.rightViewMode = UITextFieldViewModeAlways;
        _passwordTextField.rightView.hidden = YES;
        [_passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [_passwordTextField addSubview:self.lineSecondView];
    }
    return _passwordTextField;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _phoneTextField.height - 1, _phoneTextField.width, 0.5)];
        _lineView.backgroundColor = COR11;
    }
    return _lineView;
}

- (UIView *)lineSecondView{
    if (!_lineSecondView) {
        _lineSecondView = [[UIView alloc]initWithFrame:CGRectMake(0, _phoneTextField.height - 1, _phoneTextField.width, 0.5)];
        _lineSecondView.backgroundColor = COR11;
    }
    return _lineSecondView;
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
