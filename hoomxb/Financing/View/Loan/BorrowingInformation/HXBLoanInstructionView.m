//
//  HXBLoanInstructionView.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/30.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBLoanInstructionView.h"
#import "HXBFinDetailViewModel_LoanDetail.h"
@interface HXBLoanInstructionView()

@property (nonatomic, strong) UILabel *loanInstructionLabel;
@property (nonatomic, strong) UILabel *loanContentLabel;
@property (nonatomic, strong) UILabel *securityLevelStrLabel;//”风险等级“标题
@property (nonatomic, strong) UIImageView *securityLevelImgV;
@property (nonatomic, strong) UILabel *securityLevelLabel;//风险等级
@property (nonatomic, strong) UILabel *securityLevelInstructionLabel;//风险等级说明
@property (nonatomic,copy) NSString *riskLevel;///标的风险等级
@property (nonatomic,copy) NSString *riskLevelDesc;///标的风险等级描述
@end

@implementation HXBLoanInstructionView

- (instancetype)initWithFrame:(CGRect)frame withRiskLevel:(NSString *)riskLevel andRiskLevelDesc:(NSString *)riskLevelDesc{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.riskLevel = riskLevel;
        self.riskLevelDesc = riskLevelDesc;
        [self addSubview:self.loanInstructionLabel];
        [self addSubview:self.loanContentLabel];
        [self addSubview:self.securityLevelStrLabel];
        [self addSubview:self.securityLevelImgV];
        [self addSubview:self.securityLevelLabel];
        [self addSubview:self.securityLevelInstructionLabel];
        
        [self setupSubViewframe];
        [self updateFrame];
    }
    return self;
}

- (void)setLoanDetailViewModel:(HXBFinDetailViewModel_LoanDetail *)loanDetailViewModel
{
    _loanDetailViewModel = loanDetailViewModel;
    self.loanContentLabel.text = loanDetailViewModel.loanDetailModel.loanVo.description_loanVO;
    
    self.securityLevelLabel.text = self.riskLevel?self.riskLevel:@"";
    self.securityLevelInstructionLabel.text = self.riskLevelDesc?self.riskLevelDesc:@"";
    [self updateFrame];
}

- (void)setLoanInstruction:(NSString *)loanInstruction {
    _loanInstruction = loanInstruction;
    self.loanContentLabel.text = loanInstruction;
}

- (void)updateFrame{
    if (!self.riskLevel&&!self.riskLevelDesc) {
        
        [self.securityLevelStrLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@kScrAdaptationH(0.01));
        }];
        [self.securityLevelImgV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@kScrAdaptationH(0.01));
        }];
        [self.securityLevelLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@kScrAdaptationH(0.01));
        }];
        [self.securityLevelInstructionLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@kScrAdaptationH(0.01));
        }];
    }
}

- (void)setupSubViewframe
{
    kWeakSelf
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.loanInstructionLabel.mas_top).offset(kScrAdaptationH(-15));
        make.bottom.equalTo(weakSelf.securityLevelInstructionLabel.mas_bottom).offset(kScrAdaptationH(15));
    }];
    [self.loanInstructionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kScrAdaptationH(15)));
        make.left.equalTo(@(kScrAdaptationW(15)));
    }];
    [self.loanContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.loanInstructionLabel.mas_bottom).offset(kScrAdaptationH(15));
        make.left.equalTo(@(kScrAdaptationW(15)));
        make.right.equalTo(weakSelf.mas_right).offset(kScrAdaptationW(-15));
    }];
    [self.securityLevelStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.loanContentLabel.mas_bottom).offset(kScrAdaptationH(15));
        make.left.equalTo(@(kScrAdaptationW(15)));
        make.right.equalTo(weakSelf.mas_right).offset(kScrAdaptationW(-15));
    }];
    [self.securityLevelImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.securityLevelStrLabel.mas_bottom).offset(kScrAdaptationH(13));
        make.left.equalTo(@(kScrAdaptationW(16)));
        make.width.equalTo(@kScrAdaptationW(10));
        make.height.equalTo(@kScrAdaptationH(12));
    }];
    [self.securityLevelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.securityLevelStrLabel.mas_bottom).offset(kScrAdaptationH(12));
        make.left.equalTo(weakSelf.securityLevelImgV.mas_right).offset(kScrAdaptationH(1));
        make.width.equalTo(@kScrAdaptationW(16));
    }];
    [self.securityLevelInstructionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.securityLevelStrLabel.mas_bottom).offset(kScrAdaptationH(11));
        make.left.equalTo(weakSelf.securityLevelLabel.mas_right).offset(kScrAdaptationH(10));
        make.right.equalTo(weakSelf.mas_right).offset(kScrAdaptationW(-15));
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
- (UILabel *)securityLevelStrLabel
{
    if (!_securityLevelStrLabel) {
        _securityLevelStrLabel = [[UILabel alloc] init];
        _securityLevelStrLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
        _securityLevelStrLabel.textColor = kHXBColor_Grey_Font0_2;
        _securityLevelStrLabel.text = @"安全等级";
    }
    return _securityLevelStrLabel;
}
-(UIImageView *)securityLevelImgV{
    if (!_securityLevelImgV) {
        _securityLevelImgV = [[UIImageView alloc] init];
        _securityLevelImgV.image = [UIImage imageNamed:@"security_level"];
    }
    return _securityLevelImgV;
}
- (UILabel *)securityLevelLabel
{
    if (!_securityLevelLabel) {
        _securityLevelLabel = [[UILabel alloc] init];
        _securityLevelLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _securityLevelLabel.textColor = rgba(255, 163, 56, 1);
        _securityLevelLabel.textAlignment = NSTextAlignmentCenter;
//        _securityLevelLabel.text = @"-";
    }
    return _securityLevelLabel;
}
- (UILabel *)securityLevelInstructionLabel
{
    if (!_securityLevelInstructionLabel) {
        _securityLevelInstructionLabel = [[UILabel alloc] init];
        _securityLevelInstructionLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        _securityLevelInstructionLabel.textColor = kHXBColor_Font0_6;
        _securityLevelInstructionLabel.numberOfLines = 0;
        _securityLevelInstructionLabel.textAlignment = NSTextAlignmentLeft;
//        _securityLevelInstructionLabel.text = @"风险等级说明";
    }
    return _securityLevelInstructionLabel;
}
@end
