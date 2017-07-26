//
//  HxbWithdrawCardViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbWithdrawCardViewController.h"
#import "HxbPickerArea.h"
#import "HxbWithdrawResultViewController.h"
#import "HXBBankCardModel.h"
#import "HXBWithdrawalsRequest.h"
#import "HXBAlertVC.h"
#import "HXBModifyTransactionPasswordViewController.h"
#import "HXBBankCardListViewController.h"
#import "HXBWithdrawCardView.h"

#import "HxbMyTopUpViewController.h"
#import "HXBOpenDepositAccountRequest.h"
@interface HxbWithdrawCardViewController () <UITextFieldDelegate>

/**
 bankCode
 */
//@property (nonatomic, copy) NSString *bankCode;
/**
 数据模型
 */
@property (nonatomic, strong) HXBBankCardModel *bankCardModel;

@property (nonatomic, strong) HXBWithdrawCardView *withdrawCardView;

/**
 bankName
 */
//@property (nonatomic, strong) NSString *bankName;


@end

@implementation HxbWithdrawCardViewController

- (HXBWithdrawCardView *)withdrawCardView
{
    if (!_withdrawCardView) {
        kWeakSelf
        _withdrawCardView = [[HXBWithdrawCardView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
        
        _withdrawCardView.bankNameBtnClickBlock = ^() {
            [weakSelf enterBankCardListVC];
        };
        
        
        _withdrawCardView.nextButtonClickBlock = ^(NSDictionary *dic){
            [weakSelf nextButtonClick:dic];
        };
        
    }
    return _withdrawCardView;
}

- (HXBBankCardModel *)bankCardModel
{
    if (!_bankCardModel) {
        _bankCardModel = [[HXBBankCardModel alloc] init];
    }
    return _bankCardModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isColourGradientNavigationBar = YES;
    [self.view addSubview:self.withdrawCardView];

}

- (void)enterBankCardListVC
{
    kWeakSelf
    HXBBankCardListViewController *bankCardListVC = [[HXBBankCardListViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:bankCardListVC];
    bankCardListVC.bankCardListBlock = ^(NSString *bankCode, NSString *bankName){
        weakSelf.withdrawCardView.bankCode = bankCode;
        weakSelf.withdrawCardView.bankName = bankName;
    };
    [weakSelf presentViewController:nav animated:YES completion:nil];
}

- (void)setUserInfoModel:(HXBUserInfoModel *)userInfoModel
{
    
}

- (void)nextButtonClick:(NSDictionary *)dic{
    //充值界面
    HxbMyTopUpViewController *hxbMyTopUpViewController = [[HxbMyTopUpViewController alloc]init];
    [self.navigationController pushViewController:hxbMyTopUpViewController animated:YES];
    
    
    HXBOpenDepositAccountRequest *openDepositAccountRequest = [[HXBOpenDepositAccountRequest alloc] init];
    [openDepositAccountRequest openDepositAccountRequestWithArgument:dic andSuccessBlock:^(id responseObject) {
        HxbMyTopUpViewController *hxbMyTopUpViewController = [[HxbMyTopUpViewController alloc]init];
        [self.navigationController pushViewController:hxbMyTopUpViewController animated:YES];
    } andFailureBlock:^(NSError *error) {
        
    }];
    
}




#pragma mark - --- delegate 视图委托 ---

@end

