//
//  HXBQuickRechargeViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBQuickRechargeViewController.h"
#import "HXBQuickRechargeView.h"

@interface HXBQuickRechargeViewController ()

@property (nonatomic, strong) HXBQuickRechargeView *quickRechargeView;

@end

@implementation HXBQuickRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.quickRechargeView];
}

- (HXBQuickRechargeView *)quickRechargeView
{
    if (!_quickRechargeView) {
        _quickRechargeView = [[HXBQuickRechargeView alloc] initWithFrame:self.view.bounds];
    }
    return _quickRechargeView;
}

@end
