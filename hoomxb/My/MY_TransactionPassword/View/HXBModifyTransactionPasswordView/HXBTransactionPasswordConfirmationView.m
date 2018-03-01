//
//  HXBTransactionPasswordConfirmationView.m
//  修改交易密码
//
//  Created by HXB-C on 2017/6/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBTransactionPasswordConfirmationView.h"
#import "HBAlertPasswordView.h"
@interface HXBTransactionPasswordConfirmationView ()<HBAlertPasswordViewDelegate>

@property (nonatomic, strong) UILabel *tipLabel;
/**
 输入密码框
 */
@property (nonatomic, strong) HBAlertPasswordView *passwordView;


@end

@implementation HXBTransactionPasswordConfirmationView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setup];
        [self setupSubViewFrame];
    }
    return self;
}

- (void)setupSubViewFrame
{
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(kScrAdaptationH750(260));
        make.height.offset(kScrAdaptationH750(34));
    }];
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.tipLabel.mas_bottom).offset(kScrAdaptationH750(60));
        make.height.offset(kScrAdaptationH750(90));
        make.width.offset(kScrAdaptationW750(570));
    }];
}

/**
 设置子试图
 */
- (void)setup
{
    [self addSubview:self.tipLabel];
    [self addSubview:self.passwordView];
}

#pragma mark - HBAlertPasswordViewDelegate
- (void)sureActionWithAlertPasswordView:(HBAlertPasswordView *)alertPasswordView password:(NSString *)password
{
    if (password.length == 6) {
        if (self.confirmChangeButtonClickBlock) {
            self.confirmChangeButtonClickBlock(password);
        }
    }
}

#pragma mark - get方法（懒加载）
- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.text = @"请设置新的交易密码";
        _tipLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(34);
        _tipLabel.textColor = COR6;
    }
    return _tipLabel;
}

- (HBAlertPasswordView *)passwordView
{
    if (!_passwordView) {
        _passwordView = [[HBAlertPasswordView alloc] initWithFrame:CGRectMake(0, 0, kScrAdaptationW750(570), kScrAdaptationH750(90))];
        _passwordView.delegate = self;
    }
    return _passwordView;
}



@end
