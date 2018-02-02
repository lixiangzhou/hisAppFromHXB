//
//  HXBTransferCreditorTopView.m
//  hoomxb
//
//  Created by HXB-C on 2017/9/21.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBTransferCreditorTopView.h"
#import "HXBTransferConfirmModel.h"
@interface HXBTransferCreditorTopView ()
//回收金额
@property (nonatomic, strong) UILabel *recoveryAmountLabel;
//回收金额数值
@property (nonatomic, strong) UILabel *recoveryAmountNumberLabel;
//债权价值
@property (nonatomic, strong) UILabel *creditorValueLabel;
//债权价值金额
@property (nonatomic, strong) UILabel *creditorValueNumberLabel;
//手续费
@property (nonatomic, strong) UILabel *serviceChargeLabel;
//手续费金额
@property (nonatomic, strong) UILabel *serviceChargeNumberLabel;

@property (nonatomic, strong) UIView *line;

@end

@implementation HXBTransferCreditorTopView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.recoveryAmountLabel];
        [self addSubview:self.recoveryAmountNumberLabel];
        [self addSubview:self.creditorValueLabel];
        [self addSubview:self.creditorValueNumberLabel];
        [self addSubview:self.serviceChargeLabel];
        [self addSubview:self.serviceChargeNumberLabel];
        [self addSubview:self.line];
        [self setupFrame];
    }
    return self;
}

- (void)setupFrame
{
    [self.recoveryAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW750(40));
        make.top.equalTo(self).offset(kScrAdaptationH750(60));
        make.height.offset(kScrAdaptationH750(30));
    }];
    [self.creditorValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.recoveryAmountLabel.mas_left);
        make.top.equalTo(self.recoveryAmountLabel.mas_bottom).offset(kScrAdaptationH750(30));
        make.height.offset(kScrAdaptationH750(30));
    }];
    [self.serviceChargeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.recoveryAmountLabel.mas_left);
        make.top.equalTo(self.creditorValueLabel.mas_bottom).offset(kScrAdaptationH750(30));
        make.height.offset(kScrAdaptationH750(30));
    }];
    [self.recoveryAmountNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-kScrAdaptationW750(40));
        make.centerY.equalTo(self.recoveryAmountLabel);
        make.height.offset(kScrAdaptationH750(30));
    }];
    [self.creditorValueNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.recoveryAmountNumberLabel.mas_right);
        make.centerY.equalTo(self.creditorValueLabel);
        make.height.offset(kScrAdaptationH750(30));
    }];
    [self.serviceChargeNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.recoveryAmountNumberLabel.mas_right);
        make.centerY.equalTo(self.serviceChargeLabel);
        make.height.offset(kScrAdaptationH750(30));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(self);
        make.height.offset(kHXBDivisionLineHeight);
    }];
}

#pragma mark - setter
- (void)setTransferConfirmModel:(HXBTransferConfirmModel *)transferConfirmModel
{
    _transferConfirmModel = transferConfirmModel;
    self.recoveryAmountNumberLabel.text = [NSString hxb_getPerMilWithDouble:[transferConfirmModel.expectRecoveryAmount doubleValue]];
    self.creditorValueNumberLabel.text = [NSString hxb_getPerMilWithDouble:[transferConfirmModel.currentTransValue doubleValue]];
    self.serviceChargeNumberLabel.text = [NSString hxb_getPerMilWithDouble:[transferConfirmModel.transFee doubleValue]];
}

#pragma mark - getter(懒加载)
- (UILabel *)recoveryAmountLabel
{
    if (!_recoveryAmountLabel) {
        _recoveryAmountLabel = [[UILabel alloc] init];
        _recoveryAmountLabel.text = @"预计回收金额";
        _recoveryAmountLabel.textColor = COR6;
        _recoveryAmountLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
    }
    return _recoveryAmountLabel;
}

- (UILabel *)recoveryAmountNumberLabel
{
    if (!_recoveryAmountNumberLabel) {
        _recoveryAmountNumberLabel = [[UILabel alloc] init];
        _recoveryAmountNumberLabel.text = @"0.00元";
        _recoveryAmountNumberLabel.textColor = COR8;
        _recoveryAmountNumberLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
    }
    return _recoveryAmountNumberLabel;
}

- (UILabel *)creditorValueLabel
{
    if (!_creditorValueLabel) {
        _creditorValueLabel = [[UILabel alloc] init];
        _creditorValueLabel.text = @"债权价值";
        _creditorValueLabel.textColor = COR6;
        _creditorValueLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
    }
    return _creditorValueLabel;
}

- (UILabel *)creditorValueNumberLabel
{
    if (!_creditorValueNumberLabel) {
        _creditorValueNumberLabel = [[UILabel alloc] init];
        _creditorValueNumberLabel.text = @"0.00元";
        _creditorValueNumberLabel.textColor = COR8;
        _creditorValueNumberLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
    }
    return _creditorValueNumberLabel;
}

- (UILabel *)serviceChargeLabel
{
    if (!_serviceChargeLabel) {
        _serviceChargeLabel = [[UILabel alloc] init];
        _serviceChargeLabel.text = @"手续费";
        _serviceChargeLabel.textColor = COR6;
        _serviceChargeLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
    }
    return _serviceChargeLabel;
}

- (UILabel *)serviceChargeNumberLabel
{
    if (!_serviceChargeNumberLabel) {
        _serviceChargeNumberLabel = [[UILabel alloc] init];
        _serviceChargeNumberLabel.text = @"0.00元";
        _serviceChargeNumberLabel.textColor = COR8;
        _serviceChargeNumberLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
    }
    return _serviceChargeNumberLabel;
}

- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = COR12;
    }
    return _line;
}
@end
