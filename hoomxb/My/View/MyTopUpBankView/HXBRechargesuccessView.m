//
//  HXBRechargesuccessView.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRechargesuccessView.h"

@interface HXBRechargesuccessView ()

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
    self.rechargeNumLabel.text = [NSString stringWithFormat:@"成功充值 %@元",amount];
}

- (void)setupSubViewFrame
{
    [self.rechargesuccessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(@130);
    }];
    [self.rechargeNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.rechargesuccessLabel.mas_bottom).offset(kScrAdaptationH(8));
    }];
    [self.rechargePromptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.left.equalTo(self.mas_left).offset(kScrAdaptationH(20));
        make.right.equalTo(self.mas_right).offset(-kScrAdaptationH(20));
        make.top.equalTo(self.rechargeNumLabel.mas_bottom).offset(30);
    }];
    [self.investmentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kScrAdaptationH(20));
        make.right.equalTo(self.mas_right).offset(-kScrAdaptationH(20));
        make.top.equalTo(self.rechargePromptLabel.mas_bottom).offset(50);
        make.height.equalTo(@kScrAdaptationH(44));
    }];
    [self.rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.investmentBtn.mas_bottom).offset(30);
        make.height.equalTo(@kScrAdaptationH(44));
        make.width.equalTo(@kScrAdaptationH(100));
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
- (UILabel *)rechargesuccessLabel
{
    if (!_rechargesuccessLabel) {
        _rechargesuccessLabel = [[UILabel alloc] init];
        _rechargesuccessLabel.text = @"充值成功";
        _rechargesuccessLabel.font = [UIFont systemFontOfSize:kScrAdaptationH(15)];
    }
    return _rechargesuccessLabel;
}

- (UILabel *)rechargeNumLabel
{
    if (!_rechargeNumLabel) {
        _rechargeNumLabel = [[UILabel alloc] init];
        _rechargeNumLabel.text = @"成功充值 xx元";
        _rechargeNumLabel.font = [UIFont systemFontOfSize:kScrAdaptationH(12)];
    }
    return _rechargeNumLabel;
}
- (UILabel *)rechargePromptLabel
{
    if (!_rechargePromptLabel) {
        _rechargePromptLabel = [[UILabel alloc] init];
        _rechargePromptLabel.textAlignment = NSTextAlignmentCenter;
        _rechargePromptLabel.text = @"您的充值金额已到账至恒丰银行存管账户";
        _rechargePromptLabel.numberOfLines = 0;
        _rechargePromptLabel.font = [UIFont systemFontOfSize:kScrAdaptationH(12)];
    }
    return _rechargePromptLabel;
}
- (UIButton *)investmentBtn
{
    if (!_investmentBtn) {
        _investmentBtn = [[UIButton alloc] init];
        [_investmentBtn setTitle:@"立即投资" forState:UIControlStateNormal];
        [_investmentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _investmentBtn.layer.borderColor = COR12.CGColor;
        _investmentBtn.layer.borderWidth = 0.5;
        [_investmentBtn addTarget:self action:@selector(investmentBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _investmentBtn;
}

- (UIButton *)rechargeBtn
{
    if (!_rechargeBtn) {
        _rechargeBtn = [[UIButton alloc] init];
        [_rechargeBtn setTitle:@"继续充值" forState:UIControlStateNormal];
        [_rechargeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rechargeBtn addTarget:self action:@selector(rechargeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rechargeBtn;
}
@end
