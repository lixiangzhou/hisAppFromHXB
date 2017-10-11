//
//  HXBLoanInstructionView.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/30.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBLoanInstructionView.h"
#import "HXBFinDetailViewModel_LoanDetail.h"
@interface HXBLoanInstructionView()

@property (nonatomic, strong) UILabel *loanInstructionLabel;

@property (nonatomic, strong) UILabel *loanContentLabel;

@property (nonatomic, strong) UILabel       *safetyLevelInstructionLabel;//安全等级
@property (nonatomic, strong) UIImageView   *safetyLevelIconImageView;
@property (nonatomic, strong) UILabel       *safetyLevelLabel;
@property (nonatomic, strong) UILabel       *safetyLevelContentContentLabel;

@end

@implementation HXBLoanInstructionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.loanInstructionLabel];
        [self addSubview:self.loanContentLabel];
        [self addSubview:self.safetyLevelInstructionLabel];
        [self addSubview:self.safetyLevelIconImageView];
        [self addSubview:self.safetyLevelLabel];
        [self addSubview:self.safetyLevelContentContentLabel];
        [self setupSubViewframe];
    }
    return self;
}
- (void)setLoanDetailViewModel:(HXBFinDetailViewModel_LoanDetail *)loanDetailViewModel
{
    _loanDetailViewModel = loanDetailViewModel;
    self.loanContentLabel.text = loanDetailViewModel.loanDetailModel.loanVo.description_loanVO;
//    _loanContentLabel.text = @"借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明";
//    self.height = loanDetailViewModel.loanDetailModel.loanVo.description_loanVO_height + 60;
}
- (void)setLoanInstruction:(NSString *)loanInstruction {
    _loanInstruction = loanInstruction;
    self.loanContentLabel.text = loanInstruction;
}
- (void)setupSubViewframe
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loanInstructionLabel.mas_top).offset(kScrAdaptationH(-15));
//        make.bottom.equalTo(self.loanContentLabel.mas_bottom).offset(kScrAdaptationH(15));
        make.bottom.equalTo(self.safetyLevelContentContentLabel.mas_bottom).offset(kScrAdaptationH(15));
    }];
    [self.loanInstructionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kScrAdaptationH(15)));
        make.left.equalTo(@(kScrAdaptationW(15)));
    }];
    [self.loanContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loanInstructionLabel.mas_bottom).offset(kScrAdaptationH(15));
        make.left.equalTo(@(kScrAdaptationW(15)));
        make.right.equalTo(self.mas_right).offset(kScrAdaptationW(-15));
    }];
    
    [self.safetyLevelInstructionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loanContentLabel.mas_bottom).offset(kScrAdaptationH(15));
        make.left.equalTo(@(kScrAdaptationW(15)));
    }];
    [self.safetyLevelIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kScrAdaptationW(15)));
        make.top.equalTo(self.safetyLevelLabel).offset(kScrAdaptationH(3.5));
        make.height.equalTo(@(kScrAdaptationH(10.3)));
        make.width.equalTo(@(kScrAdaptationW(8.5)));
    }];
    [self.safetyLevelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.safetyLevelInstructionLabel.mas_bottom).offset(kScrAdaptationH(15));
        make.left.equalTo(self.safetyLevelIconImageView.mas_right).offset(kScrAdaptationH(4));
        make.height.equalTo(@(kScrAdaptationW(17)));
        make.width.equalTo(@(kScrAdaptationW(20)));
    }];
    [self.safetyLevelContentContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.safetyLevelInstructionLabel.mas_bottom).offset(kScrAdaptationH(15));
        make.left.equalTo(self.safetyLevelLabel.mas_right);
        make.right.equalTo(self.mas_right).offset(kScrAdaptationW(-70));
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    self.height = self.loanContentLabel.bottom + 10;
}

#pragma mark - 懒加载

- (UILabel *)loanInstructionLabel
{
    if (!_loanInstructionLabel) {
        _loanInstructionLabel = [[UILabel alloc] init];
        _loanInstructionLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
        _loanInstructionLabel.textColor = kHXBColor_Grey_Font0_2;
        _loanInstructionLabel.text = @"借款说明";
    }
    return _loanInstructionLabel;
}

- (UILabel *)loanContentLabel
{
    if (!_loanContentLabel) {
        _loanContentLabel = [[UILabel alloc] init];
        _loanContentLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        _loanContentLabel.textColor = kHXBColor_Font0_6;
        _loanContentLabel.numberOfLines = 0;
        _loanContentLabel.text = @"借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明";
    }
    return _loanContentLabel;
}

- (UILabel *)safetyLevelInstructionLabel
{
    if (!_safetyLevelInstructionLabel) {
        _safetyLevelInstructionLabel = [[UILabel alloc] init];
        _safetyLevelInstructionLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
        _safetyLevelInstructionLabel.textColor = kHXBColor_Grey_Font0_2;
        _safetyLevelInstructionLabel.text = @"安全等级";
    }
    return _safetyLevelInstructionLabel;
}

- (UILabel *)safetyLevelContentContentLabel
{
    if (!_safetyLevelContentContentLabel) {
        _safetyLevelContentContentLabel = [[UILabel alloc] init];
        _safetyLevelContentContentLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        _safetyLevelContentContentLabel.textColor = kHXBColor_Font0_6;
        _safetyLevelContentContentLabel.numberOfLines = 0;
        _safetyLevelContentContentLabel.text = @"风险等级说明风险等级说明风险等级说明风险等级说明风险等级说明风险等级说明风险等级说明风险等级说明风险等级说明风险等级说明风险等级说明风险等级说明风险等级说明风险等级说明风险等级说明风险等级说明风险等级说明风险等级说明";
    }
    return _safetyLevelContentContentLabel;
}

- (UILabel *)safetyLevelLabel{
    if (!_safetyLevelLabel) {
        _safetyLevelLabel = [[UILabel alloc] init];
        _safetyLevelLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        _safetyLevelLabel.textColor = RGB(255, 163, 56);
        _safetyLevelLabel.numberOfLines = 1;
        _safetyLevelLabel.text = @"AA";
    }
    return _safetyLevelLabel;
}

- (UIImageView *)safetyLevelIconImageView{
    if (!_safetyLevelIconImageView) {
        _safetyLevelIconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _safetyLevelIconImageView.image = [UIImage imageNamed:@"security_ level"];
    }
    return _safetyLevelIconImageView;
}

@end
