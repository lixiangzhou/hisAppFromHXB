//
//  HXBCallPhone_BottomView.m
//  hoomxb
//
//  Created by HXB-C on 2017/8/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBCallPhone_BottomView.h"

@interface HXBCallPhone_BottomView ()
/**
 左边提示label
 */
@property (nonatomic, strong) UILabel *leftTipLabel;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) UILabel *bottomTipLabel;

@end

@implementation HXBCallPhone_BottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.leftTipLabel];
        [self addSubview:self.phoneBtn];
        [self addSubview:self.bottomTipLabel];
        [self setupSubViewFrame];
    }
    return self;
}

- (void)setupSubViewFrame
{
    [self.leftTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.height.offset(kScrAdaptationH750(34));
    }];
    [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTipLabel.mas_right);
        make.centerY.equalTo(self.leftTipLabel);
        make.height.offset(kScrAdaptationH750(34));
    }];
    [self.bottomTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftTipLabel.mas_bottom);
        make.centerX.equalTo(self);
    }];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTipLabel.mas_left);
        make.right.equalTo(self.phoneBtn.mas_right);
        make.bottom.equalTo(self.bottomTipLabel.mas_bottom);
        make.top.equalTo(self.leftTipLabel.mas_top);
    }];
}

- (void)callPhone
{
    [HXBAlertManager callupWithphoneNumber:self.phoneBtn.titleLabel.text andWithMessage:@"请联系客服"];
}

#pragma mark - set方法

- (void)setLeftTitle:(NSString *)leftTitle
{
    _leftTitle = leftTitle;
    self.leftTipLabel.text = leftTitle;
}

- (void)setPhoneNumber:(NSString *)phoneNumber
{
    _phoneNumber = phoneNumber;
    [self.phoneBtn setTitle:phoneNumber forState:UIControlStateNormal];
}

- (void)setSupplementText:(NSString *)supplementText
{
    _supplementText = supplementText;
    self.bottomTipLabel.text = supplementText;
}

#pragma mark - 懒加载

- (UILabel *)leftTipLabel
{
    if (!_leftTipLabel) {
        _leftTipLabel = [[UILabel alloc] init];
        _leftTipLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        _leftTipLabel.textColor = COR8;
    }
    return _leftTipLabel;
}

- (UIButton *)phoneBtn
{
    if (!_phoneBtn) {
        _phoneBtn = [[UIButton alloc] init];
        [_phoneBtn setTitleColor:COR30 forState:UIControlStateNormal];
        _phoneBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        [_phoneBtn addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneBtn;
}

- (UILabel *)bottomTipLabel
{
    if (!_bottomTipLabel) {
        _bottomTipLabel = [[UILabel alloc] init];
        _bottomTipLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        _bottomTipLabel.textColor = COR8;
    }
    return _bottomTipLabel;
}

@end
