//
//  HxbSignUpViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/2.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbSignUpViewController.h"
#import "HXBSignUPView.h"///关于 注册的view
#import "HxbSignUpSucceedViewController.h"
#import "HXBCheckCaptchaViewController.h"///modal 出来的校验码
#import "HXBSendSmscodeViewController.h"///短信验证的Vc
#import "HxbSignInViewController.h"
#import "HXBSignUPViewModel.h"
#import "HXBRootVCManager.h"

///注册按钮的title
static NSString *const kSignUPButtonString = @"注册";
///已有账号
static NSString *const kAlreadyRegistered = @"该手机号已注册";

@interface HxbSignUpViewController ()

@property (nonatomic, strong) HXBSignUPView *signUPView;

@property (nonatomic, strong) HXBSignUPViewModel *viewModel;
@end

@implementation HxbSignUpViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isTransparentNavigationBar = YES;
    [self.view addSubview:self.signUPView];
    self.signUPView.type = self.type;
    [self registerEvent];
    if (self.type == HXBSignUPAndLoginRequest_sendSmscodeType_forgot) {
        _signUPView.isHiddenLoginBtn = YES;
    }
}

#pragma mark - Action
- (void)registerEvent {
    [self registerEvent_ClickNextButton];///点击了下一步按钮
    [self registerEvent_checkMobile];///校验手机号事件注册
    [self registerEvent_clickHaveAccount];///点击了已有账户，去登录按钮
}

///点击了下一步按钮
- (void)registerEvent_ClickNextButton {
    kWeakSelf
    [self.signUPView signUPClickNextButtonFunc:^(NSString *mobile) {
        [HXBUmengManagar HXB_clickEventWithEnevtId:kHXBUmeng_registFirst];
        if (!KeyChain.ishaveNet) {
            [HxbHUDProgress showMessageCenter:kNoNetworkText inView:nil];
            return;
        }
        
        //1. modal一个图验控制器
        HXBCheckCaptchaViewController *checkCaptchVC = [[HXBCheckCaptchaViewController alloc] init];
        [checkCaptchVC checkCaptchaSucceedFunc:^(NSString *checkPaptcha){
            NSLog(@"发送 验证码");
            
            [weakSelf.viewModel getVerifyCodeRequesWithMobile:mobile andAction:weakSelf.type andCaptcha:checkPaptcha andType:@"" andCallbackBlock:^(BOOL isSuccess, NSError *error) {
                if (isSuccess) {
                    //发送短信vc
                    HXBSendSmscodeViewController *sendSmscodeVC = [[HXBSendSmscodeViewController alloc]init];
                    sendSmscodeVC.title = weakSelf.title;
                    sendSmscodeVC.phonNumber = mobile;
                    sendSmscodeVC.captcha = checkPaptcha;
                    sendSmscodeVC.type = weakSelf.type;
                    [weakSelf.navigationController pushViewController:sendSmscodeVC animated:YES];
                }
                else {
                    
                }
            }];
        }];
        
        if (weakSelf.type == HXBSignUPAndLoginRequest_sendSmscodeType_forgot) {
            [weakSelf.viewModel checkExistMobile:mobile resultBlock:^(BOOL isSuccess) {
                if (isSuccess) {
                    [weakSelf presentViewController:checkCaptchVC animated:YES completion:nil];
                }
            }];
        }else
        {
            [weakSelf.viewModel checkMobileRequestWithHud:YES mobile:mobile resultBlock:^(BOOL isSuccess, NSString *message) {
                if (isSuccess) {
                    [weakSelf presentViewController:checkCaptchVC animated:YES completion:nil];
                }
            }];
        }
    }];
}
///校验手机号事件注册
- (void)registerEvent_checkMobile {
    kWeakSelf
    [self.signUPView checkMobileWithBlockFunc:^(NSString *mobile) {
        if (self.type == HXBSignUPAndLoginRequest_sendSmscodeType_signup) {
            [weakSelf registerCheckMobileWithMobile:mobile];
        } else {
            [weakSelf forgotPasswordCheckMobileWithMobile:mobile];
        }
    }];
}

/**
 注册验证手机号
 
 @param mobile 手机号
 */
- (void)registerCheckMobileWithMobile:(NSString *)mobile
{
    kWeakSelf
    [self.viewModel checkMobileRequestWithHud:NO mobile:mobile resultBlock:^(BOOL isSuccess, NSString *message) {
        if (isSuccess == NO) {
            weakSelf.signUPView.checkMobileStr = message ? message : kAlreadyRegistered;
        }
    }];
}

/**
 忘记密码验证手机号
 
 @param mobile 手机号
 */
- (void)forgotPasswordCheckMobileWithMobile:(NSString *)mobile
{
    kWeakSelf
    [self.viewModel checkExistMobile:mobile resultBlock:^(BOOL isSuccess) {
        weakSelf.signUPView.checkMobileStr = isSuccess ? kAlreadyRegistered : @"该手机号暂未注册";
    }];
}

///点击了已有账号按钮
- (void)registerEvent_clickHaveAccount{
    kWeakSelf
    if (self.navigationController.viewControllers.count > 1) {
        [self.signUPView clickHaveAccountButtonFunc:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
    else {
        [self.signUPView clickHaveAccountButtonFunc:^{
            HxbSignInViewController *vc = [[HxbSignInViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    }
}

//返回按钮
- (void)leftBackBtnClick{
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - Lazy
- (HXBSignUPView *)signUPView {
    if (!_signUPView) {
        _signUPView = [[HXBSignUPView alloc]init];
        _signUPView.frame = self.view.frame;
    }
    return _signUPView;
}

- (HXBSignUPViewModel *)viewModel {
    if (!_viewModel) {
        kWeakSelf
        _viewModel = [[HXBSignUPViewModel alloc] initWithBlock:^UIView *{
            if (weakSelf.presentedViewController) {
                return weakSelf.presentedViewController.view;
            }
            else {
                return weakSelf.view;
            }
        }];
    }
    return _viewModel;
}
@end
