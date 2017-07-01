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
    self.height = loanDetailViewModel.loanDetailModel.loanVo.description_loanVO_height + 60;
}

- (void)setupSubViewframe
{
    [self.loanInstructionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.left.equalTo(@20);
    }];
    [self.loanContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loanInstructionLabel.mas_bottom).offset(10);
        make.left.equalTo(@20);
        make.right.equalTo(self.mas_right).offset(-20);
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
        _loanInstructionLabel.font = [UIFont systemFontOfSize:15];
        _loanInstructionLabel.textColor = COR11;
        _loanInstructionLabel.text = @"借款说明";
    }
    return _loanInstructionLabel;
}

- (UILabel *)loanContentLabel
{
    if (!_loanContentLabel) {
        _loanContentLabel = [[UILabel alloc] init];
        _loanContentLabel.font = [UIFont systemFontOfSize:13];
        _loanContentLabel.numberOfLines = 0;
        _loanContentLabel.text = @"借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明借款说明";
    }
    return _loanContentLabel;
}

@end
