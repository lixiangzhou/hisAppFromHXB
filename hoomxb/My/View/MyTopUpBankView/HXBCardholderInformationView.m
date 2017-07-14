//
//  HXBCardholderInformationView.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBCardholderInformationView.h"

@interface HXBCardholderInformationView ()

/**
 持卡信息
 */
@property (nonatomic, strong) UILabel *cardholderInformationLabel;

/**
 真实姓名
 */
@property (nonatomic, strong) UILabel *reallyNameLabel;

/**
 身份证号
 */
@property (nonatomic, strong) UILabel *idCardNumLabel;

/**
 卡号标签
 */
@property (nonatomic, strong) UILabel *cardNumberTipLabel;

/**
 银行卡号码
 */
@property (nonatomic, strong) UILabel *bankCardNumberLabel;
@end

@implementation HXBCardholderInformationView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.cardholderInformationLabel];
        [self addSubview:self.reallyNameLabel];
        [self addSubview:self.idCardNumLabel];
        [self addSubview:self.cardNumberTipLabel];
        [self addSubview:self.bankCardNumberLabel];
        self.backgroundColor = COR14;
        [self setSubViewFrame];
    }
    return self;
}

- (void)setSubViewFrame
{
    [self.cardholderInformationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kScrAdaptationH(20));
        make.top.equalTo(self.mas_top).offset(kScrAdaptationH(20));
    }];
    [self.reallyNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cardholderInformationLabel.mas_right).offset(kScrAdaptationH(5));
        make.top.equalTo(self.cardholderInformationLabel.mas_top);
    }];
    [self.idCardNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.reallyNameLabel.mas_right).offset(kScrAdaptationH(5));
        make.top.equalTo(self.cardholderInformationLabel.mas_top);
    }];
    [self.cardNumberTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cardholderInformationLabel.mas_left);
        make.top.equalTo(self.cardholderInformationLabel.mas_bottom).offset(kScrAdaptationH(20));
    }];
    [self.bankCardNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cardNumberTipLabel.mas_right).offset(kScrAdaptationH(5));
        make.top.equalTo(self.cardNumberTipLabel.mas_top);
    }];
}

#pragma mark - 懒加载

- (UILabel *)cardholderInformationLabel
{
    if (!_cardholderInformationLabel) {
        _cardholderInformationLabel = [[UILabel alloc] init];
        _cardholderInformationLabel.text = @"持卡人信息：";
        _cardholderInformationLabel.textColor = COR8;
        _cardholderInformationLabel.font = [UIFont systemFontOfSize:12];
    }
    return _cardholderInformationLabel;
}

- (UILabel *)reallyNameLabel
{
    if (!_reallyNameLabel) {
        _reallyNameLabel = [[UILabel alloc] init];
        _reallyNameLabel.text = @"姓名";
        _reallyNameLabel.textColor = COR8;
        _reallyNameLabel.font = [UIFont systemFontOfSize:12];
    }
    return _reallyNameLabel;
}

- (UILabel *)idCardNumLabel
{
    if (!_idCardNumLabel) {
        _idCardNumLabel = [[UILabel alloc] init];
        _idCardNumLabel.text = @"身份证号";
        _idCardNumLabel.textColor = COR8;
        _idCardNumLabel.font = [UIFont systemFontOfSize:12];
    }
    return _idCardNumLabel;
}

- (UILabel *)cardNumberTipLabel
{
    if(!_cardNumberTipLabel){
        _cardNumberTipLabel = [[UILabel alloc] init];
        _cardNumberTipLabel.text = @"卡号";
        _cardNumberTipLabel.font = [UIFont systemFontOfSize:12];
    }
    return _cardNumberTipLabel;
}

- (UILabel *)bankCardNumberLabel
{
    if (!_bankCardNumberLabel) {
        _bankCardNumberLabel = [[UILabel alloc] init];
        _bankCardNumberLabel.text = @"银行卡号";
        _bankCardNumberLabel.textColor = COR8;
        _bankCardNumberLabel.font = [UIFont systemFontOfSize:12];
    }
    return _bankCardNumberLabel;
}

@end
