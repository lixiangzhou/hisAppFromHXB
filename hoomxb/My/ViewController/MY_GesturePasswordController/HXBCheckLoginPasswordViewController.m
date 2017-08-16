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
#import "HXBCustomTextField.h"
#import "SVGKImageView.h"
@interface HXBCheckLoginPasswordViewController ()

@property (nonatomic, strong) HXBCustomTextField *loginPasswordTextField;

@property (nonatomic, strong) UIButton *checkLoginBtn;

@end

@implementation HXBCheckLoginPasswordViewController

- (UIButton *)checkLoginBtn
{
    if (!_checkLoginBtn) {
        _checkLoginBtn = [UIButton btnwithTitle:@"下一步" andTarget:self andAction:@selector(checkLoginPassword) andFrameByCategory:CGRectZero];
    }
    return _checkLoginBtn;
}

- (HXBCustomTextField *)loginPasswordTextField
{
    if (!_loginPasswordTextField) {
        _loginPasswordTextField = [[HXBCustomTextField alloc] init];
        _loginPasswordTextField.secureTextEntry = YES;
        _loginPasswordTextField.placeholder = @"登录密码";
        _loginPasswordTextField.leftImage = [SVGKImage imageNamed:@"password"].UIImage;
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isColourGradientNavigationBar = YES;
}

- (void)setupSubViewFrame
{
    [self.loginPasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kScrAdaptationH750(12)+ 64);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.offset(kScrAdaptationH750(120));
    }];
    [self.checkLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kScrAdaptationW750(40));
        make.right.equalTo(self.view).offset(-kScrAdaptationW750(40));
        make.top.equalTo(self.loginPasswordTextField.mas_bottom).offset(kScrAdaptationH750(92));
        make.height.offset(kScrAdaptationH750(82));
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
