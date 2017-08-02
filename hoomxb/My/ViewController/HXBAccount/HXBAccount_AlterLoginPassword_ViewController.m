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
    self.title = @"修改登录密码";
    [self setUPView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isColourGradientNavigationBar = YES;
}

- (void)setUPView {
kWeakSelf
    self.alterLoginPasswordView = [[HXBAccount_AlterLoginPassword_View alloc]init];
    [self.view addSubview:self.alterLoginPasswordView];
    self.alterLoginPasswordView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64);
    
    [self.alterLoginPasswordView clickAlterButtonWithBlock:^(NSString *password_Original, NSString *password_New) {
        //验证密码
        if ([KeyChainManage sharedInstance].siginCount.integerValue == 4) {
            [self alertVC_4];
        }
        if ([KeyChainManage sharedInstance].siginCount.integerValue > 5) {
            [self alertVC_5];
        }
        NSString * message = [NSString isOrNoPasswordStyle:password_New];
        if (message.length > 0) {
            [HxbHUDProgress showTextWithMessage:message];
            return;
        }
        [HXBMobifyPassword_LoginRequest mobifyPassword_LoginRequest_requestWithOldPwd:password_Original andNewPwd:password_New andSuccessBlock:^{
            [KeyChainManage sharedInstance].siginCount = @(0).description;
            [HxbHUDProgress showTextWithMessage:@"密码修改成功"];
//            [HxbHUDProgress showTextWithMessage:@"密码修改成功" andView:view];
            [weakSelf.navigationController popToRootViewControllerAnimated:true];
        } andFailureBlock:^(NSError *error) {
            if (error) {
                NSLog(@"%@",error);
            }else {
                [KeyChainManage sharedInstance].siginCount = @([KeyChainManage sharedInstance].siginCount.integerValue + 1).description;
            }
        }];
    }];
    
}

- (void)alertVC_4 {
    //弹窗提示是否找回，点击找回退出登录到登录页面
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"是否找回密码" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    //            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    //
    //            }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ///退出登录
        [[KeyChainManage sharedInstance] signOut];
        //到登录界面
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
    }];
    
    UIAlertAction *cancalAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:okAction];
    [alertController addAction:cancalAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)alertVC_5 {
    //弹窗提示是否找回，点击找回退出登录到登录页面
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"错误超过5次，请24小时之后再试" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    //            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    //
    //            }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        ///退出登录
        [[KeyChainManage sharedInstance] signOut];
        //到登录界面
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
    }];
    
//    UIAlertAction *cancalAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:okAction];
//    [alertController addAction:cancalAction];
    [self presentViewController:alertController animated:YES completion:nil];
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
