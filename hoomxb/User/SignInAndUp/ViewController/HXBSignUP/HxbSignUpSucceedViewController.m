
//
//  HxbSignUpSucceedViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbSignUpSucceedViewController.h"
#import "HxbSecurityCertificationViewController.h"

@interface HxbSignUpSucceedViewController ()
@property (nonatomic, strong) UIButton *securityCertificationButton;
@end

@implementation HxbSignUpSucceedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.securityCertificationButton];
    UIButton *leftBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
    //    [leftBackBtn setTitle:@"返回" forState:UIControlStateNormal];
    [leftBackBtn setImage:[UIImage imageNamed:@"login_close"] forState:UIControlStateNormal];
    // 让按钮内部的所有内容左对齐
    leftBackBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBackBtn addTarget:self action:@selector(clickLeftBarButtonItem:) forControlEvents:UIControlEventTouchUpInside];
    [leftBackBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    // 修改导航栏左边的item
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBackBtn];
}

- (void)clickLeftBarButtonItem : (UIBarButtonItem *)button {
//    [[NSNotificationCenter defaultCenter]postNotificationName:kHXBBotification_ShowHomeVC object:nil];
    [self dismissViewControllerAnimated:false completion:nil];
    
}

- (void)securityCertificationButtonClick:(UIButton *)sender{
    HxbSecurityCertificationViewController *securityCertificationViewController = [[HxbSecurityCertificationViewController alloc]init];
    [self.navigationController pushViewController:securityCertificationViewController animated:true];

}
- (UIButton *)securityCertificationButton{
    if (!_securityCertificationButton) {
        _securityCertificationButton = [UIButton btnwithTitle:@"去认证" andTarget:self andAction:@selector(securityCertificationButtonClick:) andFrameByCategory:CGRectMake(20, SCREEN_HEIGHT/2 + 100, SCREEN_WIDTH- 40, 44)];
    }
    return _securityCertificationButton;
}

@end
