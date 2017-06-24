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
        _homeView = [[HXBModifyPhoneView alloc] initWithFrame:self.view.bounds];
        
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
            } andFailureBlock:^(NSError *error) {
                NSLog(@"%@",error);
            }];
        };
        
    }
    return _homeView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.homeView];
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
    }];

}

/**
 图形验证成功

 @param phoneNumber 新手机号
 @param checkPaptcha 图形验证码
 */
- (void)graphicSuccessWithPhoneNumber:(NSString *)phoneNumber andWithCheckPaptcha:(NSString *)checkPaptcha
{
    kWeakSelf
    [HXBSignUPAndLoginRequest smscodeRequestWithMobile:phoneNumber andAction:HXBSignUPAndLoginRequest_sendSmscodeType_newmobile andCaptcha:checkPaptcha andSuccessBlock:^(BOOL isSuccessBlock) {
        NSLog(@"%d",isSuccessBlock);
    } andFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
        [weakSelf.homeView sendCodeFail];
    }];
}

@end
