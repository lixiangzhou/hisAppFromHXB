//
//  HXBCheckLoginPasswordViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/29.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBCheckLoginPasswordViewController.h"
#import "HXBGesturePasswordViewController.h"//手势密码
#import "HXBCustomTextField.h"
#import "SVGKit/SVGKImageView.h"
#import "HXBMyGestureViewModel.h"

@interface HXBCheckLoginPasswordViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) HXBCustomTextField *loginPasswordTextField;

@property (nonatomic, strong) UIButton *checkLoginBtn;

@property (nonatomic, strong) HXBMyGestureViewModel *viewModel;
@end

@implementation HXBCheckLoginPasswordViewController

- (UIButton *)checkLoginBtn
{
    if (!_checkLoginBtn) {
        _checkLoginBtn = [UIButton btnwithTitle:@"下一步" andTarget:self andAction:@selector(checkLoginPassword) andFrameByCategory:CGRectZero];
    }
    _checkLoginBtn.backgroundColor = COR26;
    _checkLoginBtn.userInteractionEnabled = NO;
    return _checkLoginBtn;
}

- (HXBCustomTextField *)loginPasswordTextField
{
    if (!_loginPasswordTextField) {
        _loginPasswordTextField = [[HXBCustomTextField alloc] init];
        _loginPasswordTextField.secureTextEntry = YES;
        _loginPasswordTextField.delegate = self;
        _loginPasswordTextField.placeholder = @"登录密码";
        _loginPasswordTextField.leftImage = [UIImage imageNamed:@"password"];
        kWeakSelf
        _loginPasswordTextField.block = ^(NSString *text) {
            if (text.length > 0) {
                weakSelf.checkLoginBtn.backgroundColor = COR29;
                weakSelf.checkLoginBtn.userInteractionEnabled = YES;
            } else {
                weakSelf.checkLoginBtn.backgroundColor = COR26;
                weakSelf.checkLoginBtn.userInteractionEnabled = NO;
            }
        };
    }
    return _loginPasswordTextField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置手势密码";
    kWeakSelf
    _viewModel = [[HXBMyGestureViewModel alloc] initWithBlock:^UIView *{
        return weakSelf.view;
    }];
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
        make.top.equalTo(self.view).offset(kScrAdaptationH750(12)+ HXBStatusBarAndNavigationBarHeight);
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
    } else {
        [_viewModel accountSetGesturePasswordWithPassword:self.loginPasswordTextField.text resultBlock:^(BOOL isSuccess) {
            if (isSuccess) {
                if (weakSelf.switchType == HXBAccountSecureSwitchTypeOff) {
                    KeyChain.skipGesture = kHXBGesturePwdSkipeYES;
                    [KeyChain removeGesture];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                } else {
                    HXBGesturePasswordViewController *gesturePasswordVC = [[HXBGesturePasswordViewController alloc] init];
                    gesturePasswordVC.type = GestureViewControllerTypeSetting;
                    gesturePasswordVC.switchType = weakSelf.switchType;
                    [weakSelf.navigationController pushViewController:gesturePasswordVC animated:YES];
                }
            }
        }];
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    _checkLoginBtn.backgroundColor = COR26;
    _checkLoginBtn.userInteractionEnabled = NO;
    return YES;
}


@end
