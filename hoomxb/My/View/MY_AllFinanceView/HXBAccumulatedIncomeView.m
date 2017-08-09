//
//  HXBAccumulatedIncomeView.m
//  hoomxb
//
//  Created by HXB-C on 2017/8/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBAccumulatedIncomeView.h"
#import "HXBProgressView.h"
#import "HXBAssetsCustomVIew.h"

@interface HXBAccumulatedIncomeView ()

@property (nonatomic, strong) UILabel *accumulatedIncomeLabel;

@property (nonatomic, strong) UILabel *accumulatedNumLabel;

@property (nonatomic, strong) UILabel *planAccumulatedLabel;

@property (nonatomic, strong) UILabel *loanAccumulatedLabel;

@property (nonatomic, strong) HXBProgressView *planProgressView;

@property (nonatomic, strong) HXBProgressView *loanProgressView;

@property (nonatomic, strong) HXBAssetsCustomVIew *planAssetsView;

@property (nonatomic, strong) HXBAssetsCustomVIew *loanAssetsView;
@end

@implementation HXBAccumulatedIncomeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.accumulatedIncomeLabel];
        [self addSubview:self.accumulatedNumLabel];
        [self addSubview:self.planProgressView];
        [self addSubview:self.loanProgressView];
        [self addSubview:self.planAssetsView];
        [self addSubview:self.loanAssetsView];
        [self addSubview:self.planAccumulatedLabel];
        [self addSubview:self.loanAccumulatedLabel];
        [self setupSubViewFrame];
    }
    return self;
}


- (void)setupSubViewFrame
{
    [self.accumulatedIncomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW(20));
        make.top.equalTo(self).offset(kScrAdaptationH(30));
        make.height.offset(kScrAdaptationH(17));
    }];
    [self.accumulatedNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.accumulatedIncomeLabel.mas_left);
        make.top.equalTo(self.accumulatedIncomeLabel.mas_bottom).offset(kScrAdaptationH(10));
        make.height.offset(kScrAdaptationH(28));
    }];
    [self.planProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW(38));
        make.top.equalTo(self.accumulatedNumLabel.mas_bottom).offset(kScrAdaptationH(30));
        make.width.offset(kScrAdaptationW(100));
        make.height.offset(kScrAdaptationW(100));
    }];
    [self.loanProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.planProgressView.mas_right).offset(kScrAdaptationW(99));
        make.centerY.equalTo(self.planProgressView);
        make.width.offset(kScrAdaptationW(100));
        make.height.offset(kScrAdaptationW(100));
    }];
    [self.planAssetsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.planProgressView);
        make.top.equalTo(self.planProgressView.mas_bottom).offset(kScrAdaptationH(30));
    }];
    [self.loanAssetsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.loanProgressView);
        make.top.equalTo(self.loanProgressView.mas_bottom).offset(kScrAdaptationH(30));
    }];
    [self.planAccumulatedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.planProgressView);
    }];
    [self.loanAccumulatedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.loanProgressView);
    }];
}

#pragma mark - 懒加载

- (HXBAssetsCustomVIew *)planAssetsView
{
    if (!_planAssetsView) {
        _planAssetsView = [[HXBAssetsCustomVIew alloc] init];
        [_planAssetsView circularViewColor:RGB(255, 126, 127) andTextStr:@"红利计划累计收益" andNumStr:@""];
    }
    return _planAssetsView;
}

- (HXBAssetsCustomVIew *)loanAssetsView
{
    if (!_loanAssetsView) {
        _loanAssetsView = [[HXBAssetsCustomVIew alloc] init];
        [_loanAssetsView circularViewColor:RGB(255, 197, 162) andTextStr:@"散标债权累计收益" andNumStr:@""];
    }
    return _loanAssetsView;
}

- (UILabel *)accumulatedIncomeLabel
{
    if (!_accumulatedIncomeLabel) {
        _accumulatedIncomeLabel = [[UILabel alloc] init];
        _accumulatedIncomeLabel.text = @"累计收益(元)";
        _accumulatedIncomeLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        _accumulatedIncomeLabel.textColor = COR28;
    }
    return _accumulatedIncomeLabel;
}

- (UILabel *)accumulatedNumLabel
{
    if (!_accumulatedNumLabel) {
        _accumulatedNumLabel = [[UILabel alloc] init];
        _accumulatedNumLabel.text = @"10000000.00";
        _accumulatedNumLabel.font = kHXBFont_PINGFANGSC_REGULAR(24);
        _accumulatedNumLabel.textColor = COR8;
    }
    return _accumulatedNumLabel;
}

- (HXBProgressView *)planProgressView
{
    if (!_planProgressView) {
        _planProgressView = [[HXBProgressView alloc] init];
        _planProgressView.progress = 0.8;
        _planProgressView.progressColor = RGB(255, 126, 127);
    }
    return _planProgressView;
}

- (HXBProgressView *)loanProgressView
{
    if (!_loanProgressView) {
        _loanProgressView = [[HXBProgressView alloc] init];
        _loanProgressView.progress = 0.6;
        _loanProgressView.progressColor = RGB(255, 197, 162);
    }
    return _loanProgressView;
}
- (UILabel *)planAccumulatedLabel
{
    if (!_planAccumulatedLabel) {
        _planAccumulatedLabel = [[UILabel alloc] init];
        _planAccumulatedLabel.text = @"345.67";
        _planAccumulatedLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _planAccumulatedLabel.textColor = COR8;
    }
    return _planAccumulatedLabel;
}
- (UILabel *)loanAccumulatedLabel
{
    if (!_loanAccumulatedLabel) {
        _loanAccumulatedLabel = [[UILabel alloc] init];
        _loanAccumulatedLabel.text = @"345.67";
        _loanAccumulatedLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _loanAccumulatedLabel.textColor = COR8;
    }
    return _loanAccumulatedLabel;
}
@end
