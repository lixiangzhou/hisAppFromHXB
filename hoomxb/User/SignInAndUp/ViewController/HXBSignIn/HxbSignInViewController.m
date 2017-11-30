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

///手机号存在
static NSString *const kMobile_IsExist = @"手机号已存在";
static NSString *const kMobile_NotExis = @"手机号尚未注册";

@interface HxbSignInViewController ()
@property (nonatomic,strong) HxbSignInView *signView;

@property (nonatomic,copy) NSString *checkCaptcha;
@end

@implementation HxbSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
        //用户登录请求
        [HXBSignUPAndLoginRequest loginRequetWithfMobile:mobile andPassword:pasword andCaptcha:self.checkCaptcha andSuccessBlock:^(BOOL isSuccess) {
            NSLog(@"登录成功");
            [KeyChainManage sharedInstance].siginCount = @"0";
            //调到我的界面
            [KeyChainManage sharedInstance].isLogin = YES;
            KeyChain.ciphertext = @"0";
            [[KeyChainManage sharedInstance] isVerifyWithBlock:^(NSString *isVerify) {
                
                [weakSelf dismissViewControllerAnimated:YES completion:^{
                    [self update];
                }];
            }];
        } andFailureBlock:^(NSError *error, id responseObject) {
            if ([responseObject[kResponseStatus] integerValue]) {
                if ([responseObject[kResponseStatus] integerValue] == kHXBCode_Enum_Captcha) {//谈图验
                    HXBCheckCaptchaViewController *checkCaptchaViewController = [[HXBCheckCaptchaViewController alloc]init];
                    [checkCaptchaViewController checkCaptchaSucceedFunc:^(NSString *checkPaptcha) {
                        //                    self.checkCaptcha = checkPaptcha;
                        self.signView.isDeletePassword = YES;
                        [self signIn_downLoadDataWithCaptcha:checkPaptcha andPassword:pasword andMobile:mobile];
                    }];
                    [self presentViewController:checkCaptchaViewController animated:YES completion:nil];
                }
                
            }
            ///清空
            self.checkCaptcha = nil;
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
    [self.signView signUP_clickButtonFunc:^{
        [HXBUmengManagar HXB_clickEventWithEnevtId:kHXBUmeng_loginToRegist];
        HxbSignUpViewController *signUPVC = [[HxbSignUpViewController alloc]init];
        signUPVC.title = @"注册";
        signUPVC.type = HXBSignUPAndLoginRequest_sendSmscodeType_signup;
        [weakSelf.navigationController pushViewController:signUPVC animated:YES];
    }];
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
    [HXBSignUPAndLoginRequest loginRequetWithfMobile:mobile andPassword:password andCaptcha:captcha andSuccessBlock:^(BOOL isSuccess) {
        NSLog(@"登录成功");
        [KeyChainManage sharedInstance].siginCount = @"0";
        //调到我的界面
        [KeyChainManage sharedInstance].isLogin = YES;
        [[KeyChainManage sharedInstance] isVerifyWithBlock:^(NSString *isVerify) {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }];
    } andFailureBlock:^(NSError *error, id responseObject) {
        if ([responseObject[kResponseStatus] integerValue]) {
            [HxbHUDProgress showTextWithMessage:responseObject[kResponseMessage]];
            if ([responseObject[kResponseStatus] integerValue] == kHXBCode_Enum_Captcha) {//谈图验
                HXBCheckCaptchaViewController *checkCaptchaViewController = [[HXBCheckCaptchaViewController alloc]init];
                [checkCaptchaViewController checkCaptchaSucceedFunc:^(NSString *checkPaptcha) {
                    //                    self.checkCaptcha = checkPaptcha;
                    [self signIn_downLoadDataWithCaptcha:checkPaptcha andPassword:password andMobile:mobile];
                }];
                [self presentViewController:checkCaptchaViewController animated:YES completion:nil];
            }
        }
        
    }];
}

#pragma mark - Helper
- (void)dismiss{
    if (self.selectedIndexVC != nil) {
        [HXBRootVCManager manager].mainTabbarVC.selectedIndex = [self.selectedIndexVC integerValue];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        [self update];
    }];
}

- (void)update{
    if (self.isUpdate) {
        self.isUpdate = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_update object:nil];
    }
}

- (void)leftBackBtnClick{
    [self dismiss];
}

@end
