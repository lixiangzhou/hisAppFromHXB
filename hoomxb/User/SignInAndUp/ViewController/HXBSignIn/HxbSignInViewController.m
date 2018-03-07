//
//  HxbSignInViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbSignInViewController.h"
#import "HxbSignUpViewController.h"
#import "HxbPhoneVerifyViewController.h"
#import "HxbSignInView.h"
#import "HXBSignUPAndLoginRequest.h"///用于请求注册登录的接口
#import "HXBRequestUserInfo.h"///用户数据的请求
#import "HXBCheckCaptchaViewController.h"
#import "HXBRootVCManager.h"
#import "HXBSignInViewModel.h"

///手机号存在
static NSString *const kMobile_IsExist = @"手机号已存在";
static NSString *const kMobile_NotExis = @"手机号尚未注册";

@interface HxbSignInViewController ()
@property (nonatomic,strong) HxbSignInView *signView;

@property (nonatomic,copy) NSString *checkCaptcha;

@property (nonatomic, strong) HXBSignInViewModel *viewModel;
@end

@implementation HxbSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kWeakSelf
    self.viewModel = [[HXBSignInViewModel alloc] initWithBlock:^UIView *{
        return weakSelf.view;
    }];
    
    self.title = @"登录";
    
    [self setSignView];/// 设置登录界面
    [self registerSignViewEvent];///signView事件注册
    [self registerCheckMobileEvent];///请求手机号是否存在
    [self registerSignUPEvent];///注册 点击signUP事件
    [self registerClickforgetPasswordButton];///忘记密码
    [self registerClickUserAgreementBtn];///用户协议
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [HXBNotificationCenter removeObserver:self name:kHXBNotification_ShowLoginVC object:nil];
}

/// 设置 登录界面
- (void)setSignView{
    self.isTransparentNavigationBar = YES;
    self.signView = [[HxbSignInView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:self.signView];
}

#pragma mark - signView事件注册
///点击了登录按钮
- (void)registerSignViewEvent {
    kWeakSelf
    [self.signView signIN_ClickButtonFunc:^(NSString *pasword, NSString *mobile) {
        [weakSelf.viewModel loginRequetWithMobile:mobile password:pasword captcha:self.checkCaptcha resultBlock:^(BOOL isSuccess, BOOL needPopCaptcha) {
            if (isSuccess) {
                KeyChain.siginCount = @"0";
                //调到我的界面
                KeyChain.isLogin = YES;
                KeyChain.ciphertext = @"0";
                [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_checkLoginSuccess object:nil];
                
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            } else {
                if (needPopCaptcha) {
                    HXBCheckCaptchaViewController *checkCaptchaViewController = [[HXBCheckCaptchaViewController alloc]init];
                    [checkCaptchaViewController checkCaptchaSucceedFunc:^(NSString *checkPaptcha) {
                        weakSelf.signView.isDeletePassword = YES;
                        [weakSelf signIn_downLoadDataWithCaptcha:checkPaptcha andPassword:pasword andMobile:mobile];
                    }];
                    [weakSelf presentViewController:checkCaptchaViewController animated:YES completion:nil];
                }
                weakSelf.checkCaptcha = nil;
            }
        }];
    }];
}

///注册 校验手机号事件
- (void) registerCheckMobileEvent {
    [self.signView checkMobileRequestBlockFunc:^(NSString *mobile) {
        [HXBSignUPAndLoginRequest checkExistMobileRequestWithMobile:mobile andSuccessBlock:^(BOOL isExist) {
        } andFailureBlock:^(NSError *error, NYBaseRequest *request) {
            kHXBRespons_ShowHUDWithError(self.signView)
        }];
    }];
}

#pragma mark - 注册 点击注册事件
- (void)registerSignUPEvent {
    kWeakSelf
    if (self.navigationController.viewControllers.count > 1) {
        [self.signView signUP_clickButtonFunc:^{
            [HXBUmengManagar HXB_clickEventWithEnevtId:kHXBUmeng_loginToRegist];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
    else {
        [self.signView signUP_clickButtonFunc:^{
            [HXBUmengManagar HXB_clickEventWithEnevtId:kHXBUmeng_loginToRegist];
            HxbSignUpViewController *signUPVC = [[HxbSignUpViewController alloc]init];
            signUPVC.title = @"注册";
            signUPVC.type = HXBSignUPAndLoginRequest_sendSmscodeType_signup;
            [weakSelf.navigationController pushViewController:signUPVC animated:YES];
        }];
    }
    
    
}

///点击了忘记密码按钮
- (void)registerClickforgetPasswordButton {
    kWeakSelf
    [self.signView clickforgetPasswordButtonFunc:^{
        HxbSignUpViewController *signUPVC = [[HxbSignUpViewController alloc] init];
        signUPVC.title = @"重置登录密码";
        signUPVC.type = HXBSignUPAndLoginRequest_sendSmscodeType_forgot;
        [weakSelf.navigationController pushViewController:signUPVC animated:YES];
    }];
}

- (void)registerClickUserAgreementBtn
{
    kWeakSelf
    [self.signView clickUserAgreementBtnFunc:^{
        [HXBBaseWKWebViewController pushWithPageUrl:[NSString splicingH5hostWithURL:kHXB_Negotiate_SginUPURL] fromController:weakSelf];
    }];
}

#pragma mark - 数据的请求

///登录 数据的请求
- (void)signIn_downLoadDataWithCaptcha: (NSString *)captcha andPassword: (NSString *)password andMobile: (NSString *)mobile{
    kWeakSelf
    [self.viewModel loginRequetWithMobile:mobile password:password captcha:captcha resultBlock:^(BOOL isSuccess, BOOL needPopCaptcha) {
        if (isSuccess) {
            KeyChain.siginCount = @"0";
            //调到我的界面
            KeyChain.isLogin = YES;
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        } else {
            if (needPopCaptcha) {
                HXBCheckCaptchaViewController *checkCaptchaViewController = [[HXBCheckCaptchaViewController alloc]init];
                [checkCaptchaViewController checkCaptchaSucceedFunc:^(NSString *checkPaptcha) {
                    [weakSelf signIn_downLoadDataWithCaptcha:checkPaptcha andPassword:password andMobile:mobile];
                }];
                [weakSelf presentViewController:checkCaptchaViewController animated:YES completion:nil];
            }
        }
    }];
}

#pragma mark - Helper
- (void)dismiss{
    if (self.selectedIndexVC != nil) {
        [HXBRootVCManager manager].mainTabbarVC.selectedIndex = [self.selectedIndexVC integerValue];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)leftBackBtnClick{
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self dismiss];
    }
}

@end
