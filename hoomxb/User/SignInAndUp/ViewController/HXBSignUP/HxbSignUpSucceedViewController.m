
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
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"红利计划##" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBarButtonItem:)];
    self.navigationItem.backBarButtonItem = leftBarButtonItem;

}

- (void)clickLeftBarButtonItem : (UIBarButtonItem *)button {
    [[NSNotificationCenter defaultCenter]postNotificationName:kHXBBotification_ShowHomeVC object:nil];
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
