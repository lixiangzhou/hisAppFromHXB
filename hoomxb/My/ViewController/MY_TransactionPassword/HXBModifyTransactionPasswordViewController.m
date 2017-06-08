//
//  HXBModifyTransactionPasswordViewController.m
//  修改交易密码
//
//  Created by HXB-C on 2017/6/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBModifyTransactionPasswordViewController.h"
#import "HXBModifyTransactionPasswordHomeView.h"
#import "HXBTransactionPasswordConfirmationViewController.h"
@interface HXBModifyTransactionPasswordViewController ()

@property (nonatomic, strong) HXBModifyTransactionPasswordHomeView *homeView;

@end

@implementation HXBModifyTransactionPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubView];
}

/**
 设置子View
 */
- (void)setupSubView
{
    self.title = @"修改交易密码";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.homeView];
}


#pragma mark - Get方法
- (HXBModifyTransactionPasswordHomeView *)homeView
{
    if (!_homeView) {
        _homeView = [[HXBModifyTransactionPasswordHomeView alloc] initWithFrame:self.view.bounds];
        __weak typeof(self) weakSelf = self;
        _homeView.nextButtonClickBlock = ^(NSString *idCardNo,NSString *verificationCode){
            HXBTransactionPasswordConfirmationViewController *transactionPasswordVC = [[HXBTransactionPasswordConfirmationViewController alloc] init];
            [weakSelf.navigationController pushViewController:transactionPasswordVC animated:YES];
        };
    }
    return _homeView;
}

#pragma mark - set方法
- (void)setUserInfoModel:(HXBUserInfoModel *)userInfoModel
{
    _userInfoModel = userInfoModel;
    self.homeView.userInfoModel = userInfoModel;
}


@end
