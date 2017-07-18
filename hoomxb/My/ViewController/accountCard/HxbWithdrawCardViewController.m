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

#import "HXBRechargeCompletedViewController.h"//ZCC需要修改
@interface HxbWithdrawCardViewController () <UITextFieldDelegate>

/**
 bankCode
 */
@property (nonatomic, copy) NSString *bankCode;
/**
 数据模型
 */
@property (nonatomic, strong) HXBBankCardModel *bankCardModel;

@property (nonatomic, strong) HXBWithdrawCardView *withdrawCardView;

/**
 bankName
 */
@property (nonatomic, strong) NSString *bankName;


@end

@implementation HxbWithdrawCardViewController

- (HXBWithdrawCardView *)withdrawCardView
{
    if (!_withdrawCardView) {
        kWeakSelf
        _withdrawCardView = [[HXBWithdrawCardView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
        
        _withdrawCardView.bankNameBtnClickBlock = ^(UIButton *bankNameBtn) {
            
            weakSelf.bankName = bankNameBtn.titleLabel.text;
            HXBBankCardListViewController *bankCardListVC = [[HXBBankCardListViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:bankCardListVC];
            bankCardListVC.bankCardListBlock = ^(NSString *bankCode, NSString *bankName){
                [bankNameBtn setTitle:bankName forState:UIControlStateNormal];
                [bankNameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                weakSelf.bankCode = bankCode;
            };
            [weakSelf presentViewController:nav animated:YES completion:nil];
        };
        
        
        _withdrawCardView.nextButtonClickBlock = ^(NSString *bankCard){
            [weakSelf nextButtonClick:bankCard];
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

- (void)nextButtonClick:(NSString *)bankCard{
    //充值结果

    HXBRechargeCompletedViewController *rechargeCompletedVC = [[HXBRechargeCompletedViewController alloc] init];
    [self.navigationController pushViewController:rechargeCompletedVC animated:YES];
    
    
//    kWeakSelf
//    HXBAlertVC *alertVC = [[HXBAlertVC alloc] init];
//    alertVC.sureBtnClick = ^(NSString *pwd){
//        if (pwd.length == 0) {
//            return [HxbHUDProgress showTextWithMessage:@"密码不能为空"];
//            return;
//        }
//        [weakSelf checkWithdrawals:pwd andWithBankCard:bankCard];
//    };
//    alertVC.forgetBtnClick = ^(){
//        HXBModifyTransactionPasswordViewController *modifyTransactionPasswordVC = [[HXBModifyTransactionPasswordViewController alloc] init];
//        modifyTransactionPasswordVC.title = @"修改交易密码";
//        modifyTransactionPasswordVC.userInfoModel = weakSelf.userInfoModel;
//        [weakSelf.navigationController pushViewController:modifyTransactionPasswordVC animated:YES];
//    };
//    [self presentViewController:alertVC animated:NO completion:^{
//        
//    }];
    
}


//- (void)checkWithdrawals:(NSString *)paypassword andWithBankCard:(NSString *)bankCard
//{
//    self.view.userInteractionEnabled = NO;
//    kWeakSelf
//    NSMutableDictionary *requestArgument  = [NSMutableDictionary dictionary];
//    requestArgument[@"bankno"] = weakSelf.bankCode;
////    requestArgument[@"city"] = self.bankCardModel.city; 
//    requestArgument[@"bank"] = bankCard;
//    requestArgument[@"paypassword"] = paypassword;
//    requestArgument[@"amount"] = self.amount;
//    HXBWithdrawalsRequest *withdrawals = [[HXBWithdrawalsRequest alloc] init];
//    [withdrawals withdrawalsRequestWithRequestArgument:requestArgument andSuccessBlock:^(id responseObject) {
//        NSLog(@"%@",responseObject);
//        weakSelf.view.userInteractionEnabled = YES;
//        HxbWithdrawResultViewController *withdrawResultVC = [[HxbWithdrawResultViewController alloc]init];
//        weakSelf.bankCardModel.arrivalTime = responseObject[@"data"][@"arrivalTime"];
//        weakSelf.bankCardModel.bankType = weakSelf.bankName;
//        weakSelf.bankCardModel.cardId = bankCard;
//        weakSelf.bankCardModel.amount = weakSelf.amount;
//        withdrawResultVC.bankCardModel = weakSelf.bankCardModel;
//        [weakSelf.navigationController pushViewController:withdrawResultVC animated:YES];
//    } andFailureBlock:^(NSError *error) {
//        self.view.userInteractionEnabled = YES;
//         NSLog(@"%@",error);
//    }];
//}





#pragma mark - --- delegate 视图委托 ---

@end

