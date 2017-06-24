//
//  HxbSignUpViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/2.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbSignUpViewController.h"
#import "HXBSignUPView.h"///关于 注册的view
#import "HxbSignUpSucceedViewController.h"
#import "HXBSignUPAndLoginRequest.h"///数据请求
#import "HXBCheckCaptchaViewController.h"///modal 出来的校验码
#import "HXBSendSmscodeViewController.h"///短信验证的Vc

///注册按钮的title
static NSString *const kSignUPButtonString = @"注册";
///已有账号
static NSString *const kAlreadyRegistered = @"该手机号已注册";

@interface HxbSignUpViewController ()

@property (nonatomic, strong) HXBSignUPView *signUPView;
@property (nonatomic, assign) BOOL isCheckCaptchaSucceed;
@property (nonatomic, copy) NSString *checkPaptchaStr;
@end

@implementation HxbSignUpViewController

- (HXBSignUPView *)signUPView {
    if (!_signUPView) {
        _signUPView = [[HXBSignUPView alloc]init];
        _signUPView.frame = self.view.frame;
    }
    return _signUPView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.hxbBaseVCScrollView addSubview:self.signUPView];
    [self trackingScrollViewBlock:^(UIScrollView *scrollView) {
        [self.hxbBaseVCScrollView endEditing:true];
    }];
    [self registerEvent];
}

- (void)registerEvent {
    [self registerEvent_ClickNextButton];///点击了下一步按钮
    [self registerEvent_checkMobile];///校验手机号事件注册
    [self registerEvent_clickHaveAccount];///点击了已有账户，去登录按钮
}

///点击了下一步按钮
- (void) registerEvent_ClickNextButton {
    kWeakSelf
    [self.signUPView signUPClickNextButtonFunc:^(NSString *mobile) {
        NSLog(@"点击了下一步");
        //1. modal一个控制器
        ///1. 如果要是已经图验过了，那就不需要图验了
        HXBCheckCaptchaViewController *checkCaptchVC = [[HXBCheckCaptchaViewController alloc]init];
        [checkCaptchVC checkCaptchaSucceedFunc:^(NSString *checkPaptcha){
            weakSelf.isCheckCaptchaSucceed = true;
            self.checkPaptchaStr = checkPaptcha;
        }];
        if (!weakSelf.isCheckCaptchaSucceed) {
            [weakSelf presentViewController:checkCaptchVC animated:true completion:nil];
            return;
        }
        //发送短信vc
        HXBSendSmscodeViewController *sendSmscodeVC = [[HXBSendSmscodeViewController alloc]init];
        sendSmscodeVC.phonNumber = mobile;
        sendSmscodeVC.captcha = self.checkPaptchaStr;
        sendSmscodeVC.type = self.type;
        [weakSelf.navigationController pushViewController:sendSmscodeVC animated:true];
    }];
}
///校验手机号事件注册
- (void) registerEvent_checkMobile {
    kWeakSelf
    [self.signUPView checkMobileWithBlockFunc:^(NSString *mobile) {
        [HXBSignUPAndLoginRequest checkMobileRequestWithMobile:mobile andSuccessBlock:^(BOOL isExist) {
            ///已有账号
            weakSelf.signUPView.checkMobileStr = @"该手机后暂未注册";
        } andFailureBlock:^(NSError *error) {
            ///已有账号
            weakSelf.signUPView.checkMobileStr = kAlreadyRegistered;
        }];
    }];
}
///点击了已有账号按钮
- (void) registerEvent_clickHaveAccount{
    kWeakSelf
    [self.signUPView clickHaveAccountButtonFunc:^{
        [weakSelf.navigationController popViewControllerAnimated:true];
    }];
}
@end
