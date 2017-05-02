//
//  HxbSignUpViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/2.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbSignUpViewController.h"
#import "HxbSignUpViewModel.h"

@interface HxbSignUpViewController ()
<
UITextFieldDelegate
>
@property (nonatomic, strong) UIButton *signUpButton;
@end

@implementation HxbSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.signUpButton];
}

- (void)signUpButtonClick:(UIButton *)sender{
    HxbSignUpViewModel *signUpViewModel =[[HxbSignUpViewModel alloc]init];
    //  {"username":"13000000063","password":"111111"}
    [signUpViewModel signUpRequestSuccessBlock:^(BOOL signupSuccess, NSString *message) {
        if (signupSuccess) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注册成功" message:message preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
                NSLog(@"%@",action.title);
                
            }];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self dismissViewControllerAnimated:true completion:nil];
                NSLog(@"%@",action.title);
                
            }];
            
            [alertController addAction:cancelAction];
            
            [alertController addAction:okAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
    } FailureBlock:^(NYBaseRequest *request, NSError *error) {
        
    }];
}
- (UIButton *)signUpButton{
    if (!_signUpButton) {
        _signUpButton = [UIButton btnwithTitle:@"注册" andTarget:self andAction:@selector(signUpButtonClick:) andFrameByCategory:CGRectMake(20, SCREEN_HEIGHT - SCREEN_HEIGHT/3 , SCREEN_WIDTH - 40, 44)];
    }
    return _signUpButton;
}
@end
