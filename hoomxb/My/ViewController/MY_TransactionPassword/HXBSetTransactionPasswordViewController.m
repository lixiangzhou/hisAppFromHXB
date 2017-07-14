//
//  HXBSetTransactionPasswordViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBSetTransactionPasswordViewController.h"
#import "HXBSetTransactionPasswordView.h"
@interface HXBSetTransactionPasswordViewController ()

@property (nonatomic, strong) HXBSetTransactionPasswordView *setTransactionPasswordView;

@end

@implementation HXBSetTransactionPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置交易密码";
    [self.view addSubview:self.setTransactionPasswordView];
}

#pragma mark - 懒加载
- (HXBSetTransactionPasswordView *)setTransactionPasswordView
{
    if (!_setTransactionPasswordView) {
        _setTransactionPasswordView = [[HXBSetTransactionPasswordView alloc] initWithFrame:self.view.bounds];
    }
    return _setTransactionPasswordView;
}

@end
