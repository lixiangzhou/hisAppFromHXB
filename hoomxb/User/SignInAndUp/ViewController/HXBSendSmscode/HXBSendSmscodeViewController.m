//
//  HXBSendSmscodeViewController.m
//  hoomxb
//
//  Created by HXB on 2017/6/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBSendSmscodeViewController.h"
#import "HXBSendSmscodeView.h"///发送短信的view

//#import "HxbSignUpSucceedViewController.h"
#import "HxbAccountInfoViewController.h"
#import "HXBBindBankCardViewController.h"
#import "HXBSignUPAgreementWebViewVC.h"
///短信验证 VC
@interface HXBSendSmscodeViewController ()
@property (nonatomic,strong) HXBSendSmscodeView *smscodeView;
@end

@implementation HXBSendSmscodeViewController
- (void)setType:(HXBSignUPAndLoginRequest_sendSmscodeType)type {
    _type = type;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUPView];//视图设置
    [self registerEvent];//事件注册
//    [self sendSmscode];//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC);
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        });
//    });
}

- (void)viewDidAppear:(BOOL)animated {
//    [self sendSmscode];
    [super viewDidAppear:animated];
}

- (void)setUPView {
    self.smscodeView = [[HXBSendSmscodeView alloc] initWithFrame:self.view.frame];
    self.smscodeView.type = self.type;
    kWeakSelf
    [self trackingScrollViewBlock:^(UIScrollView *scrollView) {
        [weakSelf.smscodeView endEditing:true];
    }];
    self.smscodeView.phonNumber = self.phonNumber;
    [self.hxbBaseVCScrollView addSubview: self.smscodeView];
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
    __weak typeof(self)weakSelf = self;
    [self.smscodeView clickSendSmscodeButtonWithBlock:^{
        [weakSelf sendSmscode];
    }];
}
- (void)sendSmscode {
    kWeakSelf
    //请求网络数据
    [HXBSignUPAndLoginRequest smscodeRequestWithMobile:self.phonNumber andAction:self.type andCaptcha:self.captcha andSuccessBlock:^(BOOL isSuccessBlock) {
        switch (weakSelf.type) {
            case HXBSignUPAndLoginRequest_sendSmscodeType_forgot:{
                NSLog(@"发送 验证码");
//                [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
//                                    [self.navigationController.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                                        if ([obj isKindOfClass:[HxbAccountInfoViewController class]]) {
//                                            [self.navigationController popToViewController:obj animated:true];
//                                            *stop = true;
//                                        }
                //                    }];
            }
                break;
            case HXBSignUPAndLoginRequest_sendSmscodeType_signup:
                NSLog(@"注册");
//                [[KeyChainManage sharedInstance] isVerifyWithBlock:^(NSString *isVerify) {
//                }];
                break;
        }
    } andFailureBlock:^(NSError *error) {
        kNetWorkError(@"短信发送失败");
    }];

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

kDealloc
@end
