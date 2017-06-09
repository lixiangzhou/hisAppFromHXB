//
//  HXBAccount_AlterLoginPassword_ViewController.m
//  hoomxb
//
//  Created by HXB on 2017/6/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBAccount_AlterLoginPassword_ViewController.h"
#import "HXBAccount_AlterLoginPassword_View.h"///修改登录密码的view
#import "HXBMobifyPassword_LoginRequest.h"///修改密码接口
@interface HXBAccount_AlterLoginPassword_ViewController ()
@property (nonatomic,strong) HXBAccount_AlterLoginPassword_View *alterLoginPasswordView;
@end

@implementation HXBAccount_AlterLoginPassword_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUPView];
}

- (void)setUPView {
    self.alterLoginPasswordView = [[HXBAccount_AlterLoginPassword_View alloc]init];
    [self.view addSubview:self.alterLoginPasswordView];
    self.alterLoginPasswordView.frame = self.view.frame;
    self.edgesForExtendedLayout = false;
    [self.alterLoginPasswordView clickAlterButtonWithBlock:^(NSString *password_Original, NSString *password_New) {
        //验证密码
        [HXBMobifyPassword_LoginRequest mobifyPassword_LoginRequest_requestWithOldPwd:password_Original andNewPwd:password_New andSuccessBlock:^{
        } andFailureBlock:^(NSError *error) {
            if (error) {
                
            }
        }];
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
