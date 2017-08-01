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

@end

@implementation HXBLoanInstructionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.loanInstructionLabel];
        [self addSubview:self.loanContentLabel];
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
        make.bottom.equalTo(self.loanContentLabel.mas_bottom).offset(kScrAdaptationH(15));
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
        _loanInstructionLabel.font = kHXBFont_PINGFANGSC_REGULAR(21);
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

@end
