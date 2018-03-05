//
//  HXBRechargesuccessView.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRechargesuccessView.h"

@interface HXBRechargesuccessView ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *rechargesuccessLabel;

@property (nonatomic, strong) UILabel *rechargeNumLabel;

@property (nonatomic, strong) UILabel *rechargePromptLabel;

@property (nonatomic, strong) UIButton *investmentBtn;

@property (nonatomic, strong) UIButton *rechargeBtn;

@end

@implementation HXBRechargesuccessView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.iconView];
        [self addSubview:self.rechargesuccessLabel];
        [self addSubview:self.rechargeNumLabel];
        [self addSubview:self.rechargePromptLabel];
        [self addSubview:self.investmentBtn];
        [self addSubview:self.rechargeBtn];
        
        [self setupSubViewFrame];
    }
    return self;
}

- (void)setAmount:(NSString *)amount
{
    _amount = amount;
    NSString *amountStr = [NSString hxb_getPerMilWithDouble:[amount doubleValue]];
    self.rechargeNumLabel.text = [NSString stringWithFormat:@"成功充值 %@",amountStr];
}

- (void)setupSubViewFrame {
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(kScrAdaptationH750(130));
        make.height.offset(kScrAdaptationH750(182));
        make.width.offset(kScrAdaptationW750(295));
    }];
    [self.rechargesuccessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.iconView.mas_bottom).offset(kScrAdaptationH750(70));
        make.height.offset(kScrAdaptationH750(38));
    }];
    [self.rechargeNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.rechargesuccessLabel.mas_bottom).offset(kScrAdaptationH750(14));
    }];
    [self.rechargePromptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.left.equalTo(self.mas_left).offset(kScrAdaptationH(20));
        make.right.equalTo(self.mas_right).offset(-kScrAdaptationH(20));
        make.top.equalTo(self.rechargeNumLabel.mas_bottom);
    }];
    [self.investmentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kScrAdaptationW(20));
        make.right.equalTo(self.mas_right).offset(-kScrAdaptationW(20));
        make.top.equalTo(self.rechargePromptLabel.mas_bottom).offset(kScrAdaptationH750(103));
        make.height.offset(kScrAdaptationH750(82));
    }];
    [self.rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.investmentBtn.mas_bottom).offset(kScrAdaptationH750(40));
        make.height.offset(kScrAdaptationH750(82));
        make.right.equalTo(self.investmentBtn.mas_right);
    }];
}

- (void)rechargeBtnClick
{
    //继续充值
    if (self.continueRechargeBlock) {
        self.continueRechargeBlock();
    }
}

- (void)investmentBtnClick
{
    //立即投资
    if (self.immediateInvestmentBlock) {
        self.immediateInvestmentBlock();
    }
}


#pragma mark - 懒加载

- (UIImageView *)iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.svgImageString = @"successful";
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconView;
}

- (UILabel *)rechargesuccessLabel
{
    if (!_rechargesuccessLabel) {
        _rechargesuccessLabel = [[UILabel alloc] init];
        _rechargesuccessLabel.text = @"充值成功";
        _rechargesuccessLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(38);
        _rechargesuccessLabel.textColor = COR6;
    }
    return _rechargesuccessLabel;
}

- (UILabel *)rechargeNumLabel
{
    if (!_rechargeNumLabel) {
        _rechargeNumLabel = [[UILabel alloc] init];
        _rechargeNumLabel.text = @"成功充值 xx元";
        _rechargeNumLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
        _rechargeNumLabel.textColor = COR10;
    }
    return _rechargeNumLabel;
}
- (UILabel *)rechargePromptLabel
{
    if (!_rechargePromptLabel) {
        _rechargePromptLabel = [[UILabel alloc] init];
        _rechargePromptLabel.textAlignment = NSTextAlignmentCenter;
//        _rechargePromptLabel.text = @"您的充值金额已到账至恒丰银行存管账户";
        _rechargePromptLabel.numberOfLines = 0;
        _rechargePromptLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
        _rechargePromptLabel.textColor = COR10;
    }
    return _rechargePromptLabel;
}
- (UIButton *)investmentBtn
{
    if (!_investmentBtn) {
        _investmentBtn = [UIButton btnwithTitle:@"立即出借" andTarget:self andAction:@selector(investmentBtnClick) andFrameByCategory:CGRectZero];
    }
    return _investmentBtn;
}

- (UIButton *)rechargeBtn
{
    if (!_rechargeBtn) {
        _rechargeBtn = [[UIButton alloc] init];
        [_rechargeBtn setTitle:@"继续充值" forState:UIControlStateNormal];
        [_rechargeBtn setTitleColor:COR29 forState:UIControlStateNormal];
        [_rechargeBtn addTarget:self action:@selector(rechargeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rechargeBtn;
}
@end
