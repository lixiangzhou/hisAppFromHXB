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
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self registerEvent];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isColourGradientNavigationBar = YES;
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
        if (self.type == HXBSignUPAndLoginRequest_sendSmscodeType_signup) {//注册
            if ([weakSelf.signUPView.checkMobileStr isEqualToString:kAlreadyRegistered])
            {
                [HxbHUDProgress showMessageCenter:kAlreadyRegistered inView:self.view];
                return;
            }
        }else if(self.type == HXBSignUPAndLoginRequest_sendSmscodeType_forgot)
        {
            if([weakSelf.signUPView.checkMobileStr isEqualToString:@"该手机号暂未注册"])
            {
                [HxbHUDProgress showMessageCenter:weakSelf.signUPView.checkMobileStr inView:self.view];
                return;
            }
        }
        NSLog(@"点击了下一步");
        switch (weakSelf.type) {
            case HXBSignUPAndLoginRequest_sendSmscodeType_signup://注册
                
                break;
            case HXBSignUPAndLoginRequest_sendSmscodeType_forgot://忘记密码重置登录密码
                
                break;
            case HXBSignUPAndLoginRequest_sendSmscodeType_tradpwd://重置交易密码
                
                break;
            case HXBSignUPAndLoginRequest_sendSmscodeType_newmobile://绑定手机号
                
                break;
            case HXBSignUPAndLoginRequest_sendSmscodeType_oldmobile://校验老的手机号)
                
                break;
            default:
                break;
        }
   
      
        //1. modal一个图验控制器
        ///1. 如果要是已经图验过了，那就不需要图验了
        HXBCheckCaptchaViewController *checkCaptchVC = [[HXBCheckCaptchaViewController alloc]init];
        [checkCaptchVC checkCaptchaSucceedFunc:^(NSString *checkPaptcha){
            weakSelf.checkPaptchaStr = checkPaptcha;
            NSLog(@"发送 验证码");
//            dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);
//                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [HXBSignUPAndLoginRequest smscodeRequestWithMobile:mobile andAction:self.type andCaptcha:checkPaptcha andSuccessBlock:^(BOOL isSuccessBlock) {
                        //发送短信vc
                        HXBSendSmscodeViewController *sendSmscodeVC = [[HXBSendSmscodeViewController alloc]init];
                        sendSmscodeVC.title = self.title;
                        sendSmscodeVC.phonNumber = mobile;
                        sendSmscodeVC.captcha = self.checkPaptchaStr;
                        sendSmscodeVC.type = self.type;
                        [weakSelf.navigationController pushViewController:sendSmscodeVC animated:true];
                    } andFailureBlock:^(NSError *error) {
                        [HxbHUDProgress showMessageCenter:@"短信发送失败" inView:self.view];
                    }];
//                });
//            });
        }];
        if (!weakSelf.isCheckCaptchaSucceed) {
            [weakSelf presentViewController:checkCaptchVC animated:true completion:nil];
            return;
        }
    
    }];
}
///校验手机号事件注册
- (void) registerEvent_checkMobile {
    kWeakSelf
    [self.signUPView checkMobileWithBlockFunc:^(NSString *mobile) {
        if (self.type == HXBSignUPAndLoginRequest_sendSmscodeType_signup) {
            [weakSelf registerCheckMobileWithMobile:mobile];
        }else
        {
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
    [HXBSignUPAndLoginRequest checkMobileRequestWithMobile:mobile andSuccessBlock:^(BOOL isExist) {
        NSLog(@"%d",isExist);
        if (isExist) {
            ///已有账号
            weakSelf.signUPView.checkMobileStr = @"该手机号暂未注册";
        }else
        {
            ///已有账号
            weakSelf.signUPView.checkMobileStr = kAlreadyRegistered;
        }
        ///已有账号
//        weakSelf.signUPView.checkMobileStr = @"该手机号暂未注册";
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
        if (isExist) {
            ///已有账号
            weakSelf.signUPView.checkMobileStr = kAlreadyRegistered;
        }else
        {
            ///已有账号
            weakSelf.signUPView.checkMobileStr = @"该手机号暂未注册";
        }

        ///已有账号
//        weakSelf.signUPView.checkMobileStr = @"该手机号暂未注册";
    } andFailureBlock:^(NSError *error,NYBaseRequest *request) {
        NSLog(@"%@",error);
        ///已有账号
        weakSelf.signUPView.checkMobileStr = kAlreadyRegistered;
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
