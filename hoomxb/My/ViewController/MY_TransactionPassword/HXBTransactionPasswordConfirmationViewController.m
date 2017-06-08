//
//  HXBTransactionPasswordConfirmationViewController.m
//  修改交易密码
//
//  Created by HXB-C on 2017/6/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBTransactionPasswordConfirmationViewController.h"
#import "HXBTransactionPasswordConfirmationView.h"
@interface HXBTransactionPasswordConfirmationViewController ()

@property (nonatomic, strong) HXBTransactionPasswordConfirmationView *homeView;

@end

@implementation HXBTransactionPasswordConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubView];
}

- (void)setupSubView
{
    self.title = @"确认交易密码";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.homeView];
}

- (HXBTransactionPasswordConfirmationView *)homeView
{
    if (!_homeView) {
        _homeView = [[HXBTransactionPasswordConfirmationView alloc] initWithFrame:self.view.bounds];
    }
    return _homeView;
}


@end
