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
    self.presentInformationView.bankCardModel = self.bankCardModel;
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
    self.bankCardModel = [HXBBankCardModel new];
//    self.bankCardNumberLabel.text = [NSString stringWithFormat:@"%@ 尾号 %@",self.bankCardModel.bankType,[self.bankCardModel.cardId substringFromIndex:self.bankCardModel.cardId.length - 4]];
//    //    self.bankCardModel.amount doubleValue
//
//    self.withdrawalsNumberLabel.text = [NSString stringWithFormat:@"%@",[NSString hxb_getPerMilWithDouble:[self.bankCardModel.amount doubleValue]]];
//    self.withdrawalsTimeLabel.text = self.bankCardModel.bankArriveTimeText;
    
//    self.bankCardModel.bankType =
//    self.bankCardModel
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
