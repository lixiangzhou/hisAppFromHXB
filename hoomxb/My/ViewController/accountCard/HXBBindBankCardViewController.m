//
//  HXBBindBankCardViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBindBankCardViewController.h"
#import "HXBCardholderInformationView.h"
#import "HXBGetValidationCodeView.h"
#import "HXBRechargeCompletedViewController.h"
@interface HXBBindBankCardViewController ()

/**
 持卡人信息
 */
@property (nonatomic, strong) HXBCardholderInformationView *cardholderInformationView;

/**
 获取验证码
 */
@property (nonatomic, strong) HXBGetValidationCodeView *getValidationCodeView;

/**
 完成按钮
 */
@property (nonatomic, strong) UIButton *completeBtn;
@end

@implementation HXBBindBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.cardholderInformationView];
    [self.view addSubview:self.getValidationCodeView];
    [self.view addSubview:self.completeBtn];
    
    [self setSubViewFrame];
}

- (void)setSubViewFrame
{
    [self.cardholderInformationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(64);
        make.height.equalTo(@kScrAdaptationH(80));
    }];
    [self.getValidationCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(self.cardholderInformationView.mas_bottom).offset(20);
        make.height.equalTo(@44);
    }];
    [self.completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(self.getValidationCodeView.mas_bottom).offset(50);
        make.height.equalTo(@kScrAdaptationH(44));
    }];
}

- (void)completeBtnClick
{
    HXBRechargeCompletedViewController *rechargeCompletedVC = [[HXBRechargeCompletedViewController alloc] init];
    [self.navigationController pushViewController:rechargeCompletedVC animated:YES];
}

#pragma mark - 懒加载
- (HXBCardholderInformationView *)cardholderInformationView
{
    if (!_cardholderInformationView) {
        _cardholderInformationView = [[HXBCardholderInformationView alloc] init];
    }
    return _cardholderInformationView;
}
- (HXBGetValidationCodeView *)getValidationCodeView
{
    if (!_getValidationCodeView) {
        _getValidationCodeView = [[HXBGetValidationCodeView alloc] init];
    }
    return _getValidationCodeView;
}

- (UIButton *)completeBtn
{
    if (!_completeBtn) {
        _completeBtn = [[UIButton alloc] init];
        [_completeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_completeBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_completeBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _completeBtn;
}
@end
