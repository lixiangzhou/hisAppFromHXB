//
//  HXBModifyPhoneViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/24.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBModifyPhoneViewController.h"
#import "HXBModifyPhoneView.h"
#import "HXBSignUPAndLoginRequest.h"
#import "HXBCheckCaptchaViewController.h"
#import "HXBModifyPhoneRequest.h"
#import "HXBSignUPAndLoginRequest.h"
#import "HxbAccountInfoViewController.h"
@interface HXBModifyPhoneViewController ()
@property (nonatomic, strong) HXBModifyPhoneView *homeView;

/**
 图验证码
 */
@property (nonatomic, copy) NSString *checkPaptcha;

@end

@implementation HXBModifyPhoneViewController


- (HXBModifyPhoneView *)homeView
{
    if (!_homeView) {
        kWeakSelf
        _homeView = [[HXBModifyPhoneView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
        
        //获取图形验证码
        _homeView.getValidationCodeButtonClickBlock = ^(NSString *phoneNumber){
            [weakSelf enterGraphicsCodeViewWithPhoneNumber:phoneNumber];
        };
        
        //点击确认修改
        _homeView.sureChangeBtnClickBlock = ^(NSString *phoneNumber,NSString *verificationCode){
            HXBModifyPhoneRequest *modifyPhoneRequest = [[HXBModifyPhoneRequest alloc] init];
            [modifyPhoneRequest mobifyPhoneNumberWithNewPhoneNumber:phoneNumber andWithNewsmscode:verificationCode andWithCaptcha:weakSelf.checkPaptcha andSuccessBlock:^(id responseObject) {
                NSLog(@"%@",responseObject);
                [KeyChain setMobile:phoneNumber];
                [KeyChain removeGesture];
                [KeyChain signOut];
                weakSelf.tabBarController.selectedIndex = 0;
                [HxbHUDProgress showTextWithMessage:@"修改成功，请用用新手机号登录"];
                [weakSelf.navigationController popToRootViewControllerAnimated:NO];
                [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
                
            } andFailureBlock:^(NSError *error) {
                NSLog(@"%@",error);
             
            }];
        };
        
    }
    return _homeView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认修改绑定手机号";
    [self.view addSubview:self.homeView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isColourGradientNavigationBar = YES;
}

/**
 进入图形验证码界面
 */
- (void)enterGraphicsCodeViewWithPhoneNumber:(NSString *)phoneNumber{
    kWeakSelf
    ///1. 如果要是已经图验过了，那就不需要图验了
    HXBCheckCaptchaViewController *checkCaptchVC = [[HXBCheckCaptchaViewController alloc]init];
    [self presentViewController:checkCaptchVC animated:true completion:nil];
    [checkCaptchVC checkCaptchaSucceedFunc:^(NSString *checkPaptcha){
        weakSelf.checkPaptcha = checkPaptcha;
        [weakSelf.homeView getCodeSuccessfully];
        [weakSelf graphicSuccessWithPhoneNumber:phoneNumber andWithCheckPaptcha:checkPaptcha];
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        });
    }];

}

/**
 图形验证成功

 @param phoneNumber 新手机号
 @param checkPaptcha 图形验证码
 */
- (void)graphicSuccessWithPhoneNumber:(NSString *)phoneNumber andWithCheckPaptcha:(NSString *)checkPaptcha
{
    [HXBSignUPAndLoginRequest smscodeRequestWithMobile:phoneNumber andAction:HXBSignUPAndLoginRequest_sendSmscodeType_newmobile andCaptcha:checkPaptcha andSuccessBlock:^(BOOL isSuccessBlock) {
        NSLog(@"%d",isSuccessBlock);
    } andFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        //请求失败不会将按钮状态改变
//        [weakSelf.homeView sendCodeFail];
    }];
}

@end
