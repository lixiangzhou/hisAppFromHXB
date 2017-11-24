//
//  HXBSendSmscodeViewController.m
//  hoomxb
//
//  Created by HXB on 2017/6/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBSendSmscodeViewController.h"
#import "HXBSendSmscodeView.h"///发送短信的view

//#import "HxbSignUpSucceedViewController.h"
#import "HxbAccountInfoViewController.h"
#import "HXBBindBankCardViewController.h"
#import "HXBSignUPAgreementWebViewVC.h"
#import "HXBSignInWaterView.h"
#import "HXBRegisterAlertVC.h"
#import "HXBCheckCaptchaViewController.h"///modal 出来的校验码
#import "HXBSignUPAndLoginRequest.h"///数据请求

///短信验证 VC
@interface HXBSendSmscodeViewController ()
@property (nonatomic,strong) HXBSendSmscodeView *smscodeView;
///波浪视图
@property (nonatomic, strong) HXBSignInWaterView *waterView;
@property (nonatomic,strong) UITableView *hxbBaseVCScrollView;
@property (nonatomic,copy) void(^trackingScrollViewBlock)(UIScrollView *scrollView);
@property (nonatomic, strong) HXBCheckCaptchaViewController *checkCaptchVC;
@end

@implementation HXBSendSmscodeViewController
- (void)setType:(HXBSignUPAndLoginRequest_sendSmscodeType)type {
    _type = type;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [self setUPView];//视图设置
    [self registerEvent];//事件注册
//    [self sendSmscode];//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC);
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        });
//    });
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)setUPView {
    self.hxbBaseVCScrollView.bounces = NO;
    self.smscodeView = [[HXBSendSmscodeView alloc] initWithFrame:self.view.frame];
    
    self.smscodeView.type = self.type;
    self.smscodeView.startsCountdown = YES;
    
    kWeakSelf
    self.trackingScrollViewBlock = ^(UIScrollView *scrollView) {
        [weakSelf.smscodeView endEditing:true];
    };
    self.smscodeView.phonNumber = self.phonNumber;
    self.smscodeView.isSendSpeechCode = NO;
    [self.hxbBaseVCScrollView addSubview: self.smscodeView];
    [self.view addSubview:self.waterView];
    
}

#pragma mark - 点击事件的注册
- (void) registerEvent {
    ///注册短信验证码
    [self registerSendSmscode];
    ///点击确认设置密码
    [self registerPassword];
    ///服务协议
    [self registerAgreementSignUP];
}

///注册短信验证码
- (void)registerSendSmscode {
    kWeakSelf
        [self.smscodeView clickSendSmscodeButtonWithBlock:^{
            if (_type == HXBSignUPAndLoginRequest_sendSmscodeType_forgot) {
                [weakSelf sendSmscode:@"sms"];
                weakSelf.smscodeView.startsCountdown = YES;
            } else {
                HXBRegisterAlertVC *registerAlertVC = [[HXBRegisterAlertVC alloc] init];
                [self presentViewController:registerAlertVC animated:NO completion:nil];
                
                registerAlertVC.messageTitle = @"获取语音验证码";
                registerAlertVC.subTitle = @"使用语音验证码，您将收到告知验证码的电话，您可放心接听";
                
                [registerAlertVC verificationCodeBtnWithBlock:^{
                    weakSelf.smscodeView.isSendSpeechCode = NO;
                    [weakSelf sendSmscode:@"sms"];
                    [weakSelf.smscodeView clickSendButton:nil];
                }];
                [registerAlertVC speechVerificationCodeBtnWithBlock:^{
                    weakSelf.smscodeView.isSendSpeechCode = YES;
                    [weakSelf sendSmscode:@"voice"];//获取语音验证码 注意参数
                    [weakSelf.smscodeView clickSendButton:nil];
                }];
                [registerAlertVC cancelBtnWithBlock:^{
                    //
                    weakSelf.smscodeView.startsCountdown = NO;
                    NSLog(@"点击取消按钮");
                }];
            }
            
        }];

}

- (void)sendSmscode:(NSString *)typeStr {
    kWeakSelf
    //请求网络数据
    if (typeStr) {
        [HXBSignUPAndLoginRequest smscodeRequestWithMobile:self.phonNumber andAction:self.type andCaptcha:self.captcha andType:typeStr andSuccessBlock:^(BOOL isSuccessBlock) {
            switch (weakSelf.type) {
                case HXBSignUPAndLoginRequest_sendSmscodeType_forgot:{
                    NSLog(@"发送 验证码");
                }
                    break;
                case HXBSignUPAndLoginRequest_sendSmscodeType_signup:
                {
                    NSLog(@"注册");
                    weakSelf.smscodeView.startsCountdown = YES;
                }
                    break;
            }
        } andFailureBlock:^(NSError *error) {
            kNetWorkError(@"短信发送失败");
            weakSelf.smscodeView.startsCountdown = NO;
            
            NSDictionary *dic = (NSDictionary *)error;
            NSString *status = [NSString stringWithFormat:@"%@",dic[@"status"]];
            if ([status isEqualToString:@"411"]) {
                self.checkCaptchVC = [[HXBCheckCaptchaViewController alloc] init];
                [self.checkCaptchVC checkCaptchaSucceedFunc:^(NSString *checkPaptcha){
                    weakSelf.captcha = checkPaptcha;
                    NSLog(@"发送 验证码");
                    
                    [HXBSignUPAndLoginRequest smscodeRequestWithMobile:self.phonNumber andAction:self.type andCaptcha:checkPaptcha andSuccessBlock:^(BOOL isSuccessBlock) {
                        
                        HXBRegisterAlertVC *registerAlertVC = nil;
                        if (self.presentedViewController)
                        {
                            registerAlertVC = (HXBRegisterAlertVC *)self.presentedViewController;
                        }else
                        {
                            registerAlertVC = [[HXBRegisterAlertVC alloc] init];
                            [self presentViewController:registerAlertVC animated:NO completion:nil];
                        }
                        registerAlertVC.messageTitle = @"获取语音验证码";
                        registerAlertVC.subTitle = @"使用语音验证码，您将收到告知验证码的电话，您可放心接听";
                        
                        [registerAlertVC verificationCodeBtnWithBlock:^{
                            
                            [weakSelf sendSmscode:@"sms"];
                            [weakSelf.smscodeView clickSendButton:nil];
                        }];
                        [registerAlertVC speechVerificationCodeBtnWithBlock:^{
                            
                            [weakSelf sendSmscode:@"voice"];//获取语音验证码 注意参数
                            
                            [weakSelf.smscodeView clickSendButton:nil];
                        }];
                        [registerAlertVC cancelBtnWithBlock:^{
                            //
                            weakSelf.smscodeView.startsCountdown = NO;
                            NSLog(@"点击取消按钮");
                        }];
                        
                    } andFailureBlock:^(NSError *error) {
                        
                    }];
                }];
                [weakSelf presentViewController:self.checkCaptchVC animated:true completion:nil];
            }
            
        }];
        
    }else{
        [HXBSignUPAndLoginRequest smscodeRequestWithMobile:self.phonNumber andAction:self.type andCaptcha:self.captcha andSuccessBlock:^(BOOL isSuccessBlock) {
            switch (weakSelf.type) {
                case HXBSignUPAndLoginRequest_sendSmscodeType_forgot:{
                    NSLog(@"发送 验证码");
                }
                    break;
                case HXBSignUPAndLoginRequest_sendSmscodeType_signup:
                {
                    NSLog(@"注册");
                    //                weakSelf.smscodeView.isSpeechVerificationCode = YES;
                    weakSelf.smscodeView.startsCountdown = YES;
                }
                    break;
            }
        } andFailureBlock:^(NSError *error) {
            kNetWorkError(@"短信发送失败");
            //        weakSelf.smscodeView.isSpeechVerificationCode = NO;
            weakSelf.smscodeView.startsCountdown = NO;
        }];
    }
    
}
- (void)registerPassword {
    __weak typeof(self)weakSelf = self;
    [self.smscodeView clickSetPassWordButtonFunc:^(NSString *password, NSString *smscode,NSString *inviteCode) {
        NSString * message = [NSString isOrNoPasswordStyle:password];
        if (message.length > 0) {
            [HxbHUDProgress showTextWithMessage:message];
            return;
        }
        if (self.type == HXBSignUPAndLoginRequest_sendSmscodeType_forgot) {
            NSLog(@"忘记密码");
            [HXBSignUPAndLoginRequest forgotPasswordRequestWithMobile:weakSelf.phonNumber andSmscode:smscode andCaptcha:self.captcha andPassword:password andSuccessBlock:^(BOOL isExist) {
                [self.navigationController popToRootViewControllerAnimated:false];
            } andFailureBlock:^(NSError *error) {
                
            }];
        }else {
            [HXBSignUPAndLoginRequest signUPRequetWithMobile:weakSelf.phonNumber andSmscode:smscode andPassword:password andInviteCode:inviteCode andSuccessBlock:^{
                 NSLog(@"注册设置成功");
                [[KeyChainManage sharedInstance] setMobile:self.phonNumber];
                [KeyChainManage sharedInstance].isLogin = true;
                KeyChain.ciphertext = @"0";
//                HxbSignUpSucceedViewController *signUPSucceedVC = [[HxbSignUpSucceedViewController alloc]init];
//                [weakSelf.navigationController pushViewController:signUPSucceedVC animated:true];
                HXBBindBankCardViewController *bindBankCardVC = [[HXBBindBankCardViewController alloc] init];
                bindBankCardVC.type = HXBRechargeAndWithdrawalsLogicalJudgment_signup;
                [self.navigationController pushViewController:bindBankCardVC animated:YES];
            } andFailureBlock:^(NSError *error) {
                
            }];
        }
        
    }];
}

- (void)registerAgreementSignUP {
    kWeakSelf
    [self.smscodeView clickAgreementSignUPWithBlock:^{
        HXBSignUPAgreementWebViewVC *signUPAgreementWebViewVC = [[HXBSignUPAgreementWebViewVC alloc]init];
        signUPAgreementWebViewVC.URL = kHXB_Negotiate_SginUPURL;
        [weakSelf.navigationController pushViewController:signUPAgreementWebViewVC animated:true];
    }];
}

- (void)dealloc {
    [self.hxbBaseVCScrollView.panGestureRecognizer removeObserver: self forKeyPath:@"state"];
    NSLog(@"✅被销毁 %@",self);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"state"]) {
        NSNumber *tracking = change[NSKeyValueChangeNewKey];
        if (tracking.integerValue == UIGestureRecognizerStateBegan && self.trackingScrollViewBlock) {
            self.trackingScrollViewBlock(self.hxbBaseVCScrollView);
        }
        return;
    }
    
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:nil];
}

#pragma mark - Lazy
- (HXBSignInWaterView *)waterView
{
    if (!_waterView) {
        _waterView = [[HXBSignInWaterView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH(111))];
    }
    return _waterView;
}

- (UITableView *)hxbBaseVCScrollView {
    if (!_hxbBaseVCScrollView) {
        
        _hxbBaseVCScrollView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        
        [self.view insertSubview:_hxbBaseVCScrollView atIndex:0];
        [_hxbBaseVCScrollView.panGestureRecognizer addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
        _hxbBaseVCScrollView.tableFooterView = [[UIView alloc]init];
        _hxbBaseVCScrollView.backgroundColor = kHXBColor_BackGround;
        [HXBMiddlekey AdaptationiOS11WithTableView:_hxbBaseVCScrollView];
    }
    return _hxbBaseVCScrollView;
}

@end
