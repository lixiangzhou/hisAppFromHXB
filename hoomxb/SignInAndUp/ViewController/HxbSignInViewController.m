//
//  HxbSignInViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbSignInViewController.h"
#import "HxbSignUpViewController.h"
#import "HxbPhoneVerifyViewController.h"
#import "HxbSignInView.h"

@interface HxbSignInViewController ()<SignViewDelegate>

@end

@implementation HxbSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftItemBar];
    [self setSignView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [HXBNotificationCenter removeObserver:self name:ShowLoginVC object:nil];
}

- (void)setSignView{
    HxbSignInView *signView = [[HxbSignInView alloc]initWithFrame:self.view.frame];
    signView.delegate = self;
    [self.view addSubview:signView];
}

- (void)didClickSignInBtn{
    [self dismiss];
}

- (void)didClicksignUpBtn{
    HxbPhoneVerifyViewController *phoneVerifyViewController =[[HxbPhoneVerifyViewController alloc]init];
    [self.navigationController pushViewController:phoneVerifyViewController animated:true];
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setLeftItemBar{
    self.title = @"Sign In";
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"login_close"] style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
    leftItem.tintColor = [UIColor colorWithRed:131/255.0f green:131/255.0f blue:131/255.0f alpha:1];
    self.navigationItem.leftBarButtonItem = leftItem;
}

@end
