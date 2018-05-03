//
//  HxbWithdrawResultViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbWithdrawResultViewController.h"
#import "HXBBankCardModel.h"
#import "HXBPresentInformationView.h"
#import "HXBLazyCatResponseDelegate.h"
#import "HXBLazyCatResultWithdrawalModel.h"
#import "HXBLazyCatResponseModel.h"
#import "HXBAccountWithdrawViewModel.h"
#import "HXBWithdrawModel.h"

@interface HxbWithdrawResultViewController () <HXBLazyCatResponseDelegate>

@property (nonatomic, strong) HXBPresentInformationView *presentInformationView;

@property (nonatomic, weak) UIViewController *popVC;

@end

@implementation HxbWithdrawResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现结果";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.presentInformationView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 禁用全屏滑动手势
    ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = NO;
    self.isColourGradientNavigationBar = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 恢复全屏滑动手势
    ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = YES;
}

#pragma mark - HXBLazyCatResponseDelegate
- (void)setResultPageProperty:(HXBLazyCatResponseModel *)model {
    HXBAccountWithdrawViewModel *viewModel = [HXBAccountWithdrawViewModel new];
    kWeakSelf
    [viewModel accountWithdrawaWithParameter:nil andRequestMethod:NYRequestMethodGet resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.bankCardModel = viewModel.withdrawModel.bankCard;
            weakSelf.bankCardModel.amount = ((HXBLazyCatResultWithdrawalModel *)model.data).amount;
            
            weakSelf.presentInformationView.bankCardModel = weakSelf.bankCardModel;
        }
    }];
}

- (void)setResultPageWithPopViewControllers:(NSArray *)vcArray {
    self.popVC = vcArray.lastObject;
}

#pragma mark - Action
- (void)leftBackBtnClick {
    [self.navigationController popToViewController:self.popVC animated:YES];
}

#pragma mark - Lazy
- (HXBPresentInformationView *)presentInformationView
{
    if (!_presentInformationView) {
        kWeakSelf
        _presentInformationView = [[HXBPresentInformationView alloc] initWithFrame:self.view.bounds];
        _presentInformationView.completeBlock = ^{
            //            [[NSNotificationCenter defaultCenter] postNotificationName:@"提现充值" object:weakSelf];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        };
    }
    return _presentInformationView;
}

@end
