//
//  HXBCheckLoginPasswordViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/29.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBCheckLoginPasswordViewController.h"
#import "HXBGesturePasswordViewController.h"//手势密码
#import "HXBSetGesturePasswordRequest.h"
@interface HXBCheckLoginPasswordViewController ()

@property (nonatomic, strong) UITextField *loginPasswordTextField;

@property (nonatomic, strong) UIButton *checkLoginBtn;

@end

@implementation HXBCheckLoginPasswordViewController

- (UIButton *)checkLoginBtn
{
    if (!_checkLoginBtn) {
        _checkLoginBtn = [[UIButton alloc] init];
        [_checkLoginBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_checkLoginBtn addTarget:self action:@selector(checkLoginPassword) forControlEvents:UIControlEventTouchUpInside];
        _checkLoginBtn.backgroundColor = [UIColor blueColor];
        [_checkLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _checkLoginBtn;
}

- (UITextField *)loginPasswordTextField
{
    if (!_loginPasswordTextField) {
        _loginPasswordTextField = [[UITextField alloc] init];
        _loginPasswordTextField.secureTextEntry = YES;
        _loginPasswordTextField.placeholder = @"登录密码";
        _loginPasswordTextField.layer.borderWidth = 0.5;
        _loginPasswordTextField.layer.borderColor = COR12.CGColor;
    }
    return _loginPasswordTextField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置手势密码";
    [self.view addSubview:self.loginPasswordTextField];
    [self.view addSubview:self.checkLoginBtn];
    [self setupSubViewFrame];
}

- (void)setupSubViewFrame
{
    [self.loginPasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@84);
        make.left.equalTo(@20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(@44);
    }];
    [self.checkLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(self.loginPasswordTextField.mas_bottom).offset(20);
        make.height.equalTo(@35);
    }];
}

- (void)checkLoginPassword
{
    kWeakSelf
    NSString * message = [NSString isOrNoPasswordStyle:self.loginPasswordTextField.text];
    if (message.length > 0) {
        [HxbHUDProgress showTextWithMessage:message];
        return;
    }else{
        HXBSetGesturePasswordRequest *setGesturePasswordAPI =[[HXBSetGesturePasswordRequest alloc] init];
        [setGesturePasswordAPI setGesturePasswordRequestWithPassword:self.loginPasswordTextField.text andSuccessBlock:^(id responseObject) {
            HXBGesturePasswordViewController *gesturePasswordVC = [[HXBGesturePasswordViewController alloc] init];
            gesturePasswordVC.type = GestureViewControllerTypeSetting;
            [weakSelf.navigationController pushViewController:gesturePasswordVC animated:YES];
        } andFailureBlock:^(NSError *error) {
            
        }];
        
    }
}

@end
