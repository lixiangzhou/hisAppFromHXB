//
//  HxbSecurityCertificationViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbSecurityCertificationViewController.h"
#import "HxbSecurityCertificationView.h"

@interface HxbSecurityCertificationViewController ()
<
securityCertificationViewDelegate
>
@end

@implementation HxbSecurityCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"安全认证";
    HxbSecurityCertificationView *securityCertificationView = [[HxbSecurityCertificationView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:securityCertificationView];
    securityCertificationView.delegate = self;
}

- (void)didClickSecurityCertificationButton{
    [HxbHUDProgress showTextWithMessage:@"点了"];
}

@end
