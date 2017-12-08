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
#import "HXBSignUPAndLoginRequest.h"///数据请求
#import "HXBCheckCaptchaViewController.h"///modal 出来的校验码
#import "HXBSendSmscodeViewController.h"///短信验证的Vc

///注册按钮的title
static NSString *const kSignUPButtonString = @"注册";
///已有账号
static NSString *const kAlreadyRegistered = @"该手机号已注册";

@interface HxbSignUpViewController ()

@property (nonatomic, strong) HXBSignUPView *signUPView;

@end

@implementation HxbSignUpViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.signUPView];
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
            [HxbHUDProgress showMessageCenter:@"暂无网络，请稍后再试" inView:nil];
            return;
        }
        
        //1. modal一个图验控制器
        HXBCheckCaptchaViewController *checkCaptchVC = [[HXBCheckCaptchaViewController alloc] init];
        [checkCaptchVC checkCaptchaSucceedFunc:^(NSString *checkPaptcha){
            NSLog(@"发送 验证码");
            
            [HXBSignUPAndLoginRequest smscodeRequestWithMobile:mobile andAction:self.type andCaptcha:checkPaptcha andSuccessBlock:^(BOOL isSuccessBlock) {
                //发送短信vc
                HXBSendSmscodeViewController *sendSmscodeVC = [[HXBSendSmscodeViewController alloc]init];
                sendSmscodeVC.title = self.title;
                sendSmscodeVC.phonNumber = mobile;
                sendSmscodeVC.captcha = checkPaptcha;
                sendSmscodeVC.type = self.type;
                [weakSelf.navigationController pushViewController:sendSmscodeVC animated:YES];
            } andFailureBlock:^(NSError *error) {
//                [HxbHUDProgress showMessageCenter:@"短信发送失败" inView:self.view];
            }];
        }];
        
        if (weakSelf.type == HXBSignUPAndLoginRequest_sendSmscodeType_forgot) {
            [HXBSignUPAndLoginRequest checkExistMobileRequestWithMobile:mobile andSuccessBlock:^(BOOL isExist) {
                if (isExist) {
                    [weakSelf presentViewController:checkCaptchVC animated:YES completion:nil];
                    return;
                }
            } andFailureBlock:^(NSError *error, NYBaseRequest *request) {
            }];
        }else
        {
            [HXBSignUPAndLoginRequest checkMobileRequestHUDWithMobile:mobile andSuccessBlock:^(BOOL isExist, NSString *message) {
                if (isExist) {
                    [weakSelf presentViewController:checkCaptchVC animated:YES completion:nil];
                    return;
                }
            } andFailureBlock:^(NSError *error) {
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
    [HXBSignUPAndLoginRequest checkMobileRequestWithMobile:mobile andSuccessBlock:^(BOOL isExist, NSString *message) {
        NSLog(@"%d",isExist);
        if (!isExist) {
            ///已有账号
            weakSelf.signUPView.checkMobileStr = message;
        }
    } andFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        ///已有账号
        weakSelf.signUPView.checkMobileStr = kAlreadyRegistered;
    }];
    
}

/**
 忘记密码验证手机号
 
 @param mobile 手机号
 */
- (void)forgotPasswordCheckMobileWithMobile:(NSString *)mobile
{
    kWeakSelf
    [HXBSignUPAndLoginRequest checkExistMobileRequestWithMobile:mobile andSuccessBlock:^(BOOL isExist) {
        weakSelf.signUPView.checkMobileStr = isExist ? kAlreadyRegistered : @"该手机号暂未注册";
    } andFailureBlock:^(NSError *error,NYBaseRequest *request) {
        NSLog(@"%@",error);
        ///已有账号
        weakSelf.signUPView.checkMobileStr = kAlreadyRegistered;
    }];
}

///点击了已有账号按钮
- (void)registerEvent_clickHaveAccount{
    kWeakSelf
    if (self.type == HXBSignUPAndLoginRequest_sendSmscodeType_H5) {
        [self.signUPView clickHaveAccountButtonFunc:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    } else {
        [self.signUPView clickHaveAccountButtonFunc:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
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

@end
