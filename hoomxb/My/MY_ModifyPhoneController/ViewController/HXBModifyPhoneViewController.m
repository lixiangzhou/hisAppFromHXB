//
//  HXBModifyPhoneViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/24.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBModifyPhoneViewController.h"
#import "HXBModifyPhoneView.h"
#import "HXBCheckCaptchaViewController.h"
#import "HxbAccountInfoViewController.h"
#import "HXBModifyPhoneViewModel.h"
#import "HXBRootVCManager.h"

@interface HXBModifyPhoneViewController ()
@property (nonatomic, strong) HXBModifyPhoneView *homeView;
@property (nonatomic,strong)HXBModifyPhoneViewModel *viewModel;
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
        _homeView = [[HXBModifyPhoneView alloc] initWithFrame:CGRectMake(0, HXBStatusBarAndNavigationBarHeight, kScreenWidth, kScreenHeight - HXBStatusBarAndNavigationBarHeight)];
        //获取图形验证码
        weakSelf.homeView.getValidationCodeButtonClickBlock = ^(NSString *phoneNumber){
            [weakSelf enterGraphicsCodeViewWithPhoneNumber:phoneNumber];
        };
        
        //点击确认修改
        _homeView.sureChangeBtnClickBlock = ^(NSString *phoneNumber,NSString *verificationCode){
            if (weakSelf.checkPaptcha.length == 0) {
                [HxbHUDProgress showTextWithMessage:@"请输入正确的短信验证码"];
            } else {
                
                weakSelf.viewModel = [[HXBModifyPhoneViewModel alloc] initWithBlock:^UIView *{
                    if (weakSelf.presentedViewController) {
                        return weakSelf.presentedViewController.view;
                    }
                    else {
                        return weakSelf.view;
                    }
                }];
                [weakSelf.viewModel mobifyPhoneNumberWithNewPhoneNumber:phoneNumber andWithNewsmscode:verificationCode andWithCaptcha:weakSelf.checkPaptcha resultBlock:^(BOOL isSuccess) {
                    if (isSuccess) {
                        KeyChain.mobile = weakSelf.viewModel.modifyPhoneModel.mobile;//phoneNumber;
                        [KeyChain removeGesture];
                        KeyChain.skipGesture = kHXBGesturePwdSkipeYES;
                        [KeyChain signOut];
                        weakSelf.tabBarController.selectedIndex = 0;
                        [HxbHUDProgress showTextWithMessage:@"修改成功，请用新手机号登录"];
                        [weakSelf.navigationController popToRootViewControllerAnimated:NO];
                        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
                    }
                }];
            }
        };
    
    }
    return _homeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定新手机号";
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
    [self presentViewController:checkCaptchVC animated:YES completion:nil];
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
    [self.viewModel getVerifyCodeRequesWithMobile:phoneNumber andAction:HXBSignUPAndLoginRequest_sendSmscodeType_newmobile andCaptcha:checkPaptcha andType:@"" andCallbackBlock:^(BOOL isSuccess, NSError *error) {
        if (isSuccess) {
            NSLog(@"%d",isSuccess);
        }
        else {
            NSLog(@"%@",error);
        }
    }];
}

@end
