//
//  HXBLoanInformation.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/30.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#define spacing 20

#import "HXBLoanInformation.h"
#import "HXBFinDetailViewModel_LoanDetail.h"
@interface HXBLoanInformation ()
//标的信息
@property (nonatomic, strong) UILabel *titleLabel;
//还款方式
@property (nonatomic, strong) UILabel *repaymentMethodsTipLabel;
//还款方式的值
@property (nonatomic, strong) UILabel *repaymentMethodsLabel;
//提前还款费率
@property (nonatomic, strong) UILabel *repaymentRateTipLabel;
//提前还款费率的值
@property (nonatomic, strong) UILabel *repaymentRateLabel;
//安全保证
@property (nonatomic, strong) UILabel *safetyAssuranceTipLabel;
//安全保证的值
@property (nonatomic, strong) UILabel *safetyAssuranceLabel;

@end

@implementation HXBLoanInformation

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.repaymentMethodsTipLabel];
        [self addSubview:self.repaymentMethodsLabel];
        
        [self addSubview:self.repaymentRateTipLabel];
        [self addSubview:self.repaymentRateLabel];
        
        [self addSubview:self.safetyAssuranceTipLabel];
        [self addSubview:self.safetyAssuranceLabel];
        [self setupSubViewframe];
    }
    return self;
}

- (void)setLoanDetailViewModel:(HXBFinDetailViewModel_LoanDetail *)loanDetailViewModel
{
    _loanDetailViewModel = loanDetailViewModel;
    self.repaymentMethodsLabel.text = loanDetailViewModel.loanDetailModel.loanVo.repaymentType;
    
    self.repaymentRateLabel.text = loanDetailViewModel.loanDetailModel.loanVo.interest;
    
    self.safetyAssuranceLabel.text = loanDetailViewModel.loanDetailModel.loanVo.allProtected;
}

- (void)setupSubViewframe
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@spacing);
        make.left.equalTo(@spacing);
    }];
    [self.repaymentMethodsTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(25);
        make.left.equalTo(@spacing);
    }];
    [self.repaymentMethodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.repaymentMethodsTipLabel);
        make.right.equalTo(self.mas_right).offset(-spacing);
    }];
    [self.repaymentRateTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.repaymentMethodsTipLabel.mas_bottom).offset(spacing);
        make.left.equalTo(@spacing);
    }];
    [self.repaymentRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.repaymentRateTipLabel);
        make.right.equalTo(self.mas_right).offset(-spacing);
    }];
    
    [self.safetyAssuranceTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.repaymentRateTipLabel.mas_bottom).offset(spacing);
        make.left.equalTo(@spacing);
    }];
    
    [self.safetyAssuranceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.safetyAssuranceTipLabel);
        make.right.equalTo(self.mas_right).offset(-spacing);
    }];
    
//    [self mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(self.safetyAssuranceTipLabel.mas_bottom).offset(spacing);
//    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    self.height = self.safetyAssuranceTipLabel.bottom + spacing;
}

#pragma mark - 懒加载
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = COR11;
        _titleLabel.text = @"标的信息";
    }
    return _titleLabel;
}

- (UILabel *)repaymentMethodsTipLabel
{
    if (!_repaymentMethodsTipLabel) {
        _repaymentMethodsTipLabel = [[UILabel alloc] init];
        _repaymentMethodsTipLabel.font = [UIFont systemFontOfSize:12];
        _repaymentMethodsTipLabel.textColor = COR11;
        _repaymentMethodsTipLabel.text = @"还款方式";
    }
    return _repaymentMethodsTipLabel;
}

- (UILabel *)repaymentMethodsLabel
{
    if (!_repaymentMethodsLabel) {
        _repaymentMethodsLabel = [[UILabel alloc] init];
        _repaymentMethodsLabel.font = [UIFont systemFontOfSize:12];
    }
    return _repaymentMethodsLabel;
}

- (UILabel *)repaymentRateTipLabel
{
    if (!_repaymentRateTipLabel) {
        _repaymentRateTipLabel = [[UILabel alloc] init];
        _repaymentRateTipLabel.font = [UIFont systemFontOfSize:12];
        _repaymentRateTipLabel.textColor = COR11;
        _repaymentRateTipLabel.text = @"提前还款费率";
    }
    return _repaymentRateTipLabel;
}

- (UILabel *)repaymentRateLabel
{
    if (!_repaymentRateLabel) {
        _repaymentRateLabel = [[UILabel alloc] init];
        _repaymentRateLabel.font = [UIFont systemFontOfSize:12];
    }
    return _repaymentRateLabel;
}

- (UILabel *)safetyAssuranceTipLabel
{
    if (!_safetyAssuranceTipLabel) {
        _safetyAssuranceTipLabel = [[UILabel alloc] init];
        _safetyAssuranceTipLabel.font = [UIFont systemFontOfSize:12];
        _safetyAssuranceTipLabel.textColor = COR11;
        _safetyAssuranceTipLabel.text = @"安全保障";
    }
    return _safetyAssuranceTipLabel;
}

- (UILabel *)safetyAssuranceLabel
{
    if (!_safetyAssuranceLabel) {
        _safetyAssuranceLabel = [[UILabel alloc] init];
        _safetyAssuranceLabel.font = [UIFont systemFontOfSize:12];
    }
    return _safetyAssuranceLabel;
}

@end
