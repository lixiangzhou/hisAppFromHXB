//
//  HxbWithdrawCardViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbWithdrawCardViewController.h"
#import "HxbWithdrawResultViewController.h"
#import "HXBBankCardModel.h"
#import "HXBWithdrawalsRequest.h"
#import "HXBModifyTransactionPasswordViewController.h"
#import "HXBBankCardListViewController.h"
#import "HXBWithdrawCardView.h"

#import "HxbMyTopUpViewController.h"
#import "HxbWithdrawViewController.h"
#import "HXBBankCardViewModel.h"
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

@property (nonatomic, strong) HXBBankCardViewModel *bindBankCardVM;


@end

@implementation HxbWithdrawCardViewController

- (HXBWithdrawCardView *)withdrawCardView
{
    if (!_withdrawCardView) {
        kWeakSelf
        _withdrawCardView = [[HXBWithdrawCardView alloc] initWithFrame:CGRectMake(0, HXBStatusBarAndNavigationBarHeight, kScreenWidth, kScreenHeight - HXBStatusBarAndNavigationBarHeight)];
        
        _withdrawCardView.bankNameBtnClickBlock = ^() {
            [weakSelf enterBankCardListVC];
        };
        
        _withdrawCardView.nextButtonClickBlock = ^(NSDictionary *dic){
            [weakSelf nextButtonClick:dic];
        };
        
        _withdrawCardView.checkCardBin = ^(NSString *bankNumber) {
            
            [weakSelf.bindBankCardVM checkCardBinResultRequestWithBankNumber:bankNumber andisToastTip:NO andCallBack:^(BOOL isSuccess) {
                if (isSuccess) {
                    [weakSelf checkCardBin:weakSelf.bindBankCardVM.cardBinModel];
                }
                else {
                    weakSelf.withdrawCardView.isCheckFailed = YES;
                }
            }];
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
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [self.view addSubview:self.withdrawCardView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 禁用全屏滑动手势
    ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = YES;
}

//卡bin校验
- (void)checkCardBin:(HXBCardBinModel *)cardBinModel
{
    self.withdrawCardView.cardBinModel = cardBinModel;
}

- (void)leftBackBtnClick {
    if (_className.length > 0 && _type == HXBRechargeAndWithdrawalsLogicalJudgment_Other) {
        if (self.block) {
            self.block(0);
        }
        [self popToViewControllerWithClassName:_className];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)enterBankCardListVC
{
    kWeakSelf
    HXBBankCardListViewController *bankCardListVC = [[HXBBankCardListViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:bankCardListVC];
//    bankCardListVC.bankCardListBlock = ^(NSString *bankCode, NSString *bankName){
//        weakSelf.withdrawCardView.bankCode = bankCode;
//        weakSelf.withdrawCardView.bankName = bankName;
//    };
    [weakSelf presentViewController:nav animated:YES completion:nil];
}



- (void)nextButtonClick:(NSDictionary *)dic{
    [self openStorageWithArgument:dic];
}

/**
 开通存管账户
 */
- (void)openStorageWithArgument:(NSDictionary *)dic{
    kWeakSelf
    [self.bindBankCardVM bindBankCardRequestWithArgument:dic andFinishBlock:^(BOOL isSuccess)  {
        if (isSuccess) {
            [weakSelf bindBankCardRequest];
        }
    }];
}

- (void)bindBankCardRequest {
    if (self.type == HXBRechargeAndWithdrawalsLogicalJudgment_Recharge) {
        
        HxbMyTopUpViewController *hxbMyTopUpViewController = [[HxbMyTopUpViewController alloc]init];
        [self.navigationController pushViewController:hxbMyTopUpViewController animated:YES];
        
    } else if (self.type == HXBRechargeAndWithdrawalsLogicalJudgment_Withdrawals) {
        
        HxbWithdrawViewController *withdrawViewController = [[HxbWithdrawViewController alloc]init];
        if (!KeyChain.isLogin)  return;
        [self.navigationController pushViewController:withdrawViewController animated:YES];
        
    } else if(self.type == HXBRechargeAndWithdrawalsLogicalJudgment_Other) {
        if (self.block) { // 绑卡成功，返回
            self.block(1);
        };
        [self leftBackBtnClick];
    }
}

#pragma mark 懒加载
- (HXBBankCardViewModel *)bindBankCardVM {
    if (!_bindBankCardVM) {
        kWeakSelf
        _bindBankCardVM = [[HXBBankCardViewModel alloc] initWithBlock:^UIView *{
            return weakSelf.view;
        }];
    }
    return _bindBankCardVM;
}


@end

