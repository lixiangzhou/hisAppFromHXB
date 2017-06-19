//
//  HXBSendSmscodeViewController.m
//  hoomxb
//
//  Created by HXB on 2017/6/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBSendSmscodeViewController.h"
#import "HXBSendSmscodeView.h"///发送短信的view

#import "HxbSignUpSucceedViewController.h"
///短信验证 VC
@interface HXBSendSmscodeViewController ()
@property (nonatomic,strong) HXBSendSmscodeView *smscodeView;
@end

@implementation HXBSendSmscodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUPView];//视图设置
    [self registerEvent];//事件注册
}

- (void)setUPView {
    self.smscodeView = [[HXBSendSmscodeView alloc] initWithFrame:self.view.frame];
    self.smscodeView.phonNumber = self.phonNumber;
    [self.view addSubview: self.smscodeView];
}

#pragma mark - 点击事件的注册
- (void) registerEvent {
    ///注册短信验证码
    [self registerSendSmscode];
    ///点击确认设置密码
    [self registerPassword];
}

///注册短信验证码
- (void)registerSendSmscode {
    __weak typeof(self)weakSelf = self;
    [self.smscodeView clickSendSmscodeButtonWithBlock:^{
       //请求网络数据
        [HXBSignUPAndLoginRequest smscodeRequestWithMobile:weakSelf.phonNumber andAction:weakSelf.type andCaptcha:weakSelf.captcha andSuccessBlock:^(BOOL isSuccessBlock) {
            NSLog(@"密码设置成功");
            switch (weakSelf.type) {
                case HXBSignUPAndLoginRequest_sendSmscodeType_forgot:
                    NSLog(@"重置登录密码");
                    break;
                case HXBSignUPAndLoginRequest_sendSmscodeType_signup:
                    NSLog(@"注册");
                    break;
            }
        } andFailureBlock:^(NSError *error) {
            kNetWorkError(@"短信发送失败");
        }];
    }];
}

- (void)registerPassword {
    __weak typeof(self)weakSelf = self;
    [self.smscodeView clickSetPassWordButtonFunc:^(NSString *password, NSString *smscode,NSString *inviteCode) {
        
        if (self.type == HXBSignUPAndLoginRequest_sendSmscodeType_forgot) {
            NSLog(@"忘记密码");
            [HXBSignUPAndLoginRequest forgotPasswordRequestWithMobile:weakSelf.phonNumber andSmscode:smscode andCaptcha:self.captcha andPassword:password andSuccessBlock:^(BOOL isExist) {
                HxbSignUpSucceedViewController *signUPSucceedVC = [[HxbSignUpSucceedViewController alloc]init];
                [weakSelf.navigationController pushViewController:signUPSucceedVC animated:true];
            } andFailureBlock:^(NSError *error) {
                
            }];
        }else {
            [HXBSignUPAndLoginRequest signUPRequetWithMobile:weakSelf.phonNumber andSmscode:smscode andPassword:password andInviteCode:inviteCode andSuccessBlock:^{
                HxbSignUpSucceedViewController *signUPSucceedVC = [[HxbSignUpSucceedViewController alloc]init];
                [weakSelf.navigationController pushViewController:signUPSucceedVC animated:true];
            } andFailureBlock:^(NSError *error) {
            }];
        }
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
