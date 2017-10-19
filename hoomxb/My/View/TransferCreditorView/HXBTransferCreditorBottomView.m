//
//  HXBTransferCreditorBottomView.m
//  hoomxb
//
//  Created by HXB-C on 2017/9/21.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBTransferCreditorBottomView.h"
#import "HXBTransferConfirmModel.h"
@interface HXBTransferCreditorBottomView ()
//债权价值
@property (nonatomic, strong) UIButton *creditorValueBtn;
//等号
@property (nonatomic, strong) UILabel *signLabel;
//当前带收入本金
@property (nonatomic, strong) UILabel *principaLabel;
//加号
@property (nonatomic, strong) UILabel *plusLable;
//利息
@property (nonatomic, strong) UILabel *interestLabel;
//手续费
@property (nonatomic, strong) UILabel *serviceChargeLabel;
//回收金额
@property (nonatomic, strong) UILabel *recoveryAmountLabel;

@end



@implementation HXBTransferCreditorBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.creditorValueBtn];
        [self addSubview:self.signLabel];
        [self addSubview:self.principaLabel];
        [self addSubview:self.plusLable];
        [self addSubview:self.interestLabel];
        [self addSubview:self.serviceChargeLabel];
        [self addSubview:self.recoveryAmountLabel];
        [self setupFrame];
    }
    return self;
}


- (void)setupFrame
{
    [self.creditorValueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW750(40));
//        make.width.offset(kScrAdaptationW750(156));
        make.top.equalTo(self).offset(kScrAdaptationH750(63));
        make.height.offset(kScrAdaptationH750(44));
    }];
    [self.signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.creditorValueBtn.mas_right).offset(kScrAdaptationH750(10));
        make.width.offset(kScrAdaptationW750(15));
        make.centerY.equalTo(self.creditorValueBtn);
        make.height.offset(kScrAdaptationH750(44));
    }];
    [self.principaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.signLabel.mas_right).offset(kScrAdaptationH750(10));
        make.width.offset(kScrAdaptationW750(164));
        make.centerY.equalTo(self.creditorValueBtn);
        make.height.offset(kScrAdaptationH750(44));
    }];
    [self.plusLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.principaLabel.mas_right).offset(kScrAdaptationH750(10));
        make.width.offset(kScrAdaptationW750(15));
        make.centerY.equalTo(self.creditorValueBtn);
        make.height.offset(kScrAdaptationH750(44));
    }];
    [self.plusLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.plusLable.mas_right).offset(kScrAdaptationH750(10));
        make.width.offset(kScrAdaptationW750(15));
        make.centerY.equalTo(self.creditorValueBtn);
        make.height.offset(kScrAdaptationH750(44));
    }];
    [self.interestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.plusLable.mas_right).offset(kScrAdaptationH750(10));
        make.width.offset(kScrAdaptationW750(116));
        make.centerY.equalTo(self.creditorValueBtn);
        make.height.offset(kScrAdaptationH750(44));
    }];
    [self.serviceChargeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.creditorValueBtn.mas_left).offset(kScrAdaptationH750(10));
        make.top.equalTo(self.creditorValueBtn.mas_bottom).offset(kScrAdaptationH750(25));
        make.height.offset(kScrAdaptationH750(24));
    }];
    [self.recoveryAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.creditorValueBtn.mas_left).offset(kScrAdaptationH750(10));
        make.top.equalTo(self.serviceChargeLabel.mas_bottom).offset(kScrAdaptationH750(25));
        make.height.offset(kScrAdaptationH750(24));
    }];
}
#pragma mark - setter
- (void)setTransferConfirmModel:(HXBTransferConfirmModel *)transferConfirmModel
{
    _transferConfirmModel = transferConfirmModel;
    self.serviceChargeLabel.text = [NSString stringWithFormat:@"手续费按照债权价值的%@%%收取",transferConfirmModel.rate];
}


#pragma mark - getter(懒加载)
- (UIButton *)creditorValueBtn
{
    if (!_creditorValueBtn) {
        _creditorValueBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _creditorValueBtn.userInteractionEnabled = NO;
        _creditorValueBtn.layer.borderColor = COR10.CGColor;
        _creditorValueBtn.layer.borderWidth = kXYBorderWidth;
        [_creditorValueBtn setImage:[UIImage imageNamed:@"creditorValue"] forState:(UIControlStateNormal)];
        [_creditorValueBtn setTitle:@"债权价值" forState:(UIControlStateNormal)];
        [_creditorValueBtn setTitleColor:COR10 forState:UIControlStateNormal];
        _creditorValueBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        _creditorValueBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _creditorValueBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -kScrAdaptationW750(5), 0, 0);
        _creditorValueBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -kScrAdaptationW750(10), 0, kScrAdaptationW750(10));
    }
    return _creditorValueBtn;
}

- (UILabel *)signLabel
{
    if (!_signLabel) {
        _signLabel = [[UILabel alloc] init];
        _signLabel.text = @"=";
        _signLabel.textColor = COR10;
        _signLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
    }
    return _signLabel;
}
- (UILabel *)principaLabel
{
    if (!_principaLabel) {
        _principaLabel = [[UILabel alloc] init];
        _principaLabel.text = @"当前待收本金";
        _principaLabel.textAlignment = NSTextAlignmentCenter;
        _principaLabel.textColor = COR10;
        _principaLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        _principaLabel.layer.borderWidth = kXYBorderWidth;
        _principaLabel.layer.borderColor = COR10.CGColor;
    }
    return _principaLabel;
}
- (UILabel *)plusLable
{
    if (!_plusLable) {
        _plusLable = [[UILabel alloc] init];
        _plusLable.text = @"+";
        _plusLable.textColor = COR10;
        _plusLable.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
    }
    return _plusLable;
}

- (UILabel *)interestLabel
{
    if (!_interestLabel) {
        _interestLabel = [[UILabel alloc] init];
        _interestLabel.text = @"公允利息";
        _interestLabel.textAlignment = NSTextAlignmentCenter;
        _interestLabel.textColor = COR10;
        _interestLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        _interestLabel.layer.borderWidth = kXYBorderWidth;
        _interestLabel.layer.borderColor = COR10.CGColor;
    }
    return _interestLabel;
}
- (UILabel *)serviceChargeLabel
{
    if (!_serviceChargeLabel) {
        _serviceChargeLabel = [[UILabel alloc] init];
        _serviceChargeLabel.text = @"手续费按照债权价值的X%收取";
        _serviceChargeLabel.numberOfLines = 0;
        _serviceChargeLabel.textColor = COR10;
        _serviceChargeLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
    }
    return _serviceChargeLabel;
}
- (UILabel *)recoveryAmountLabel
{
    if (!_recoveryAmountLabel) {
        _recoveryAmountLabel = [[UILabel alloc] init];
        _recoveryAmountLabel.text = @"回收金额可能会根据转让时间有所波动，以实际回收金额为准";
        _recoveryAmountLabel.numberOfLines = 0;
        _recoveryAmountLabel.textColor = COR10;
        _recoveryAmountLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
    }
    return _recoveryAmountLabel;
}


@end
