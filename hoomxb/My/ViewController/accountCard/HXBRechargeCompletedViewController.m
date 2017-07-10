//
//  HXBRechargeCompletedViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRechargeCompletedViewController.h"
#import "HXBRechargesuccessView.h"
#import "HXBRechargeFailView.h"
@interface HXBRechargeCompletedViewController ()

@property (nonatomic, strong) HXBRechargesuccessView *rechargesuccessView;

@property (nonatomic, strong) HXBRechargeFailView *rechargeFailView;
@end

@implementation HXBRechargeCompletedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值结果";
    [self.view addSubview:self.rechargesuccessView];
    
    [self.view addSubview:self.rechargeFailView];
    
}

- (HXBRechargesuccessView *)rechargesuccessView
{
    if (!_rechargesuccessView) {
        _rechargesuccessView = [[HXBRechargesuccessView alloc] initWithFrame:self.view.bounds];
    }
    return _rechargesuccessView;
}

- (HXBRechargeFailView *)rechargeFailView
{
    if (!_rechargeFailView) {
        _rechargeFailView = [[HXBRechargeFailView alloc] initWithFrame:self.view.bounds];
    }
    return _rechargeFailView;
}


@end
