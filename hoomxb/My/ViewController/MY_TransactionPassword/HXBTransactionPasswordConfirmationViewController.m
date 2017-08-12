//
//  HXBTransactionPasswordConfirmationViewController.m
//  修改交易密码
//
//  Created by HXB-C on 2017/6/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBTransactionPasswordConfirmationViewController.h"
#import "HXBTransactionPasswordConfirmationView.h"
#import "HXBModifyTransactionPasswordRequest.h"
#import "HxbAccountInfoViewController.h"
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
    self.title = @"设置新交易密码";
    [self.view addSubview:self.homeView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isColourGradientNavigationBar = YES;
}
/**
 确认修改交易密码

 @param surePassword 设置的新密码
 */
- (void)confirmTransactionWithPassword:(NSString *)surePassword
{
    kWeakSelf
    HXBModifyTransactionPasswordRequest *modifyTransactionPasswordRequest = [[HXBModifyTransactionPasswordRequest alloc] init];
    [modifyTransactionPasswordRequest myTransactionPasswordWithIDcard:self.idcard andWithCode:self.code andWithPassword:surePassword andSuccessBlock:^(id responseObject) {
        [HxbHUDProgress showTextWithMessage:@"修改成功"];
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        
    } andFailureBlock:^(NSError *error) {
        
    }];
    
}

#pragma mark - get方法
- (HXBTransactionPasswordConfirmationView *)homeView
{
    if (!_homeView) {
        _homeView = [[HXBTransactionPasswordConfirmationView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
        kWeakSelf
        _homeView.confirmChangeButtonClickBlock = ^(NSString *surePassword){
            [weakSelf confirmTransactionWithPassword:surePassword];
        };
    }
    return _homeView;
}


@end
