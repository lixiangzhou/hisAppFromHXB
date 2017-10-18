//
//  HXBBindBankCardViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBindBankCardViewController.h"
#import "HXBCardholderInformationView.h"
#import "HXBGetValidationCodeView.h"
#import "HXBOpenDepositAccountViewController.h"
@interface HXBBindBankCardViewController ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *promptLabel;
/**
 完成按钮
 */
@property (nonatomic, strong) UIButton *openAccountBtn;
@end

@implementation HXBBindBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"开通恒丰银行存管账户";
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view addSubview:self.iconView];
    [self.view addSubview:self.promptLabel];
    [self.view addSubview:self.openAccountBtn];
    [self setSubViewFrame];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isBlueGradientNavigationBar = YES;
}

- (void)setSubViewFrame
{
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(kScrAdaptationH(46) + 64);
        make.height.offset(kScrAdaptationH(216));
        make.width.offset(kScrAdaptationW(250));
    }];
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.iconView.mas_bottom).offset(kScrAdaptationH(40));
        make.width.equalTo(self.iconView.mas_width);
    }];
    [self.openAccountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kScrAdaptationW(20));
        make.right.equalTo(self.view).offset(kScrAdaptationW(-20));
        make.top.equalTo(self.promptLabel.mas_bottom).offset(kScrAdaptationH(40));
        make.height.offset(kScrAdaptationH(41));
    }];
}

- (void)openAccountBtnClick
{
    [HXBUmengManagar HXB_clickEventWithEnevtId:kHXBUmeng_registSuccess_lead];
    HXBOpenDepositAccountViewController *openDepositAccountViewController = [[HXBOpenDepositAccountViewController alloc] init];
    openDepositAccountViewController.title = @"开通存管账户";
    openDepositAccountViewController.type = self.type;
    [self.navigationController pushViewController:openDepositAccountViewController animated:YES];
    
//    HxbMyTopUpViewController *hxbMyTopUpViewController = [[HxbMyTopUpViewController alloc]init];
//    [self.navigationController pushViewController:hxbMyTopUpViewController animated:YES];
    //充值结果
//    #import "HXBRechargeCompletedViewController.h"
//    HXBRechargeCompletedViewController *rechargeCompletedVC = [[HXBRechargeCompletedViewController alloc] init];
//    [self.navigationController pushViewController:rechargeCompletedVC animated:YES];
}

#pragma mark - 懒加载

- (UILabel *)promptLabel
{
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.numberOfLines = 0;
        _promptLabel.font = kHXBFont_PINGFANGSC_REGULAR(16);
        _promptLabel.textColor = COR8;
        _promptLabel.text = @"红小宝与恒丰银行完成存管对接\n用户资金安全隔离";
        _promptLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _promptLabel;
}

- (UIImageView *)iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bank"]];
    }
    return _iconView;
}

- (UIButton *)openAccountBtn
{
    if (!_openAccountBtn) {
        _openAccountBtn = [UIButton btnwithTitle:@"立即开通恒丰银行存管账户" andTarget:self andAction:@selector(openAccountBtnClick) andFrameByCategory:CGRectZero];
        [_openAccountBtn setBackgroundColor:COR24];
    }
    return _openAccountBtn;
}
- (void)leftBackBtnClick
{
    [HXBUmengManagar HXB_clickEventWithEnevtId:kHXBUmeng_registSuccess_return];
    if (self.type == HXBRechargeAndWithdrawalsLogicalJudgment_signup) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
    {
        [super leftBackBtnClick];
    }
}
@end
