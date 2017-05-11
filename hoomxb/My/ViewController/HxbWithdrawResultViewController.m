//
//  HxbWithdrawResultViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbWithdrawResultViewController.h"

@interface HxbWithdrawResultViewController ()
@property (nonatomic, strong) UIButton *backButton;
@end

@implementation HxbWithdrawResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.backButton];
    
}

- (void)backBttonClick:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (UIButton *)backBtton{
    if (!_backButton) {
        _backButton = [UIButton btnwithTitle:@"返回我资产" andTarget:self andAction:@selector(backBttonClick:) andFrameByCategory:CGRectMake(20, SCREEN_HEIGHT/2, SCREEN_WIDTH - 40 , 44)];
    }
    return _backButton;
}

@end
