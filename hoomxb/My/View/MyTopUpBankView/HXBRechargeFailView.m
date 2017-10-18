//
//  HXBRechargeFailView.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRechargeFailView.h"

@interface HXBRechargeFailView ()
@property (nonatomic, strong) UILabel *rechargeFailLabel;


@property (nonatomic, strong) UILabel *rechargePromptLabel;

@property (nonatomic, strong) UIButton *investmentBtn;

@end

@implementation HXBRechargeFailView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.rechargeFailLabel];
        [self addSubview:self.rechargePromptLabel];
        [self addSubview:self.investmentBtn];
        [self setupSubViewFrame];
    }
    return self;
}

- (void)setFailureReasonText:(NSString *)failureReasonText
{
    _failureReasonText = failureReasonText;
    self.rechargePromptLabel.text = failureReasonText;
}

- (void)setupSubViewFrame
{
    [self.rechargeFailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(@130);
    }];

    [self.rechargePromptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.left.equalTo(self.mas_left).offset(kScrAdaptationH(20));
        make.right.equalTo(self.mas_right).offset(-kScrAdaptationH(20));
        make.top.equalTo(self.rechargeFailLabel.mas_bottom).offset(30);
    }];
    [self.investmentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kScrAdaptationH(20));
        make.right.equalTo(self.mas_right).offset(-kScrAdaptationH(20));
        make.top.equalTo(self.rechargePromptLabel.mas_bottom).offset(50);
        make.height.equalTo(@kScrAdaptationH(44));
    }];

}

- (void)investmentBtnClick
{
    if (self.investmentBtnClickBlock) {
        self.investmentBtnClickBlock();
    }
}

#pragma mark - 懒加载
- (UILabel *)rechargeFailLabel
{
    if (!_rechargeFailLabel) {
        _rechargeFailLabel = [[UILabel alloc] init];
        _rechargeFailLabel.text = @"充值失败";
        _rechargeFailLabel.font = [UIFont systemFontOfSize:kScrAdaptationH(15)];
    }
    return _rechargeFailLabel;
}


- (UILabel *)rechargePromptLabel
{
    if (!_rechargePromptLabel) {
        _rechargePromptLabel = [[UILabel alloc] init];
        _rechargePromptLabel.text = @"如返回失败原因，这里显示失败原因（中文显示正常的失败原因）。";
        _rechargePromptLabel.textAlignment = NSTextAlignmentCenter;
        _rechargePromptLabel.numberOfLines = 0;
        _rechargePromptLabel.font = [UIFont systemFontOfSize:kScrAdaptationH(12)];
    }
    return _rechargePromptLabel;
}
- (UIButton *)investmentBtn
{
    if (!_investmentBtn) {
        _investmentBtn = [[UIButton alloc] init];
        [_investmentBtn setTitle:@"重新充值" forState:UIControlStateNormal];
        [_investmentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_investmentBtn addTarget:self action:@selector(investmentBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _investmentBtn.layer.borderColor = COR12.CGColor;
        _investmentBtn.layer.borderWidth = kXYBorderWidth;
    }
    return _investmentBtn;
}



@end
