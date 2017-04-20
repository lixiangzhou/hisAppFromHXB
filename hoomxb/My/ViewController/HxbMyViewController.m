//
//  HxbMyViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbMyViewController.h"

@interface HxbMyViewController ()
@property (nonatomic,strong) UIButton *signOutButton;
@end

@implementation HxbMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.signOutButton];
}

- (void)signOutButtonButtonClick:(UIButton *)sender{
    [KeyChain removeAllInfo];
}

- (UIButton *)signOutButton{
    if (!_signOutButton) {
        _signOutButton = [UIButton btnwithTitle:@"Sign Out" andTarget:self andAction:@selector(signOutButtonButtonClick:) andFrameByCategory:CGRectMake(20, SCREEN_HEIGHT /2 + 100, SCREEN_WIDTH - 40, 44)];
    }
    return _signOutButton;
}

@end
