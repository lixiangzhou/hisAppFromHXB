//
//  HXBMY_AllFinanceView.m
//  hoomxb
//
//  Created by HXB on 2017/6/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_AllFinanceView.h"
#import "HXBProportionalBarView.h"
#import "HXBAssetsCustomVIew.h"
@interface HXBMY_AllFinanceView ()

@property (nonatomic, strong) UILabel *totalAssetsLabel;
@property (nonatomic, strong) UILabel *totalAssetsNumberLabel;
@property (nonatomic, strong) HXBProportionalBarView *proportionalBarView;
@property (nonatomic, strong) HXBAssetsCustomVIew *plainView;//计划
@property (nonatomic, strong) HXBAssetsCustomVIew *loanView;//散标
@property (nonatomic, strong) HXBAssetsCustomVIew *availableView;//可用金额
@property (nonatomic, strong) HXBAssetsCustomVIew *frozenView;//冻结金额

@end
@implementation HXBMY_AllFinanceView


- (void)setViewModel:(HXBRequestUserInfoViewModel *)viewModel
{
    _viewModel = viewModel;
    self.totalAssetsNumberLabel.text = [NSString GetPerMilWithDouble:viewModel.userInfoModel.userAssets.assetsTotal.doubleValue];
    [self calculateProportionValue];
    [self.plainView circularViewColor:RGB(255, 126, 127) andTextStr:@"红利计划" andNumStr:[NSString GetPerMilWithDouble:viewModel.userInfoModel.userAssets.financePlanAssets.doubleValue]];
    [self.loanView circularViewColor:RGB(128, 218, 255) andTextStr:@"散标债权" andNumStr:[NSString GetPerMilWithDouble:viewModel.userInfoModel.userAssets.lenderPrincipal.doubleValue]];
    [self.availableView circularViewColor:RGB(161, 147, 249) andTextStr:@"可用金额" andNumStr:[NSString GetPerMilWithDouble:viewModel.userInfoModel.userAssets.availablePoint.doubleValue]];
    [self.frozenView circularViewColor:RGB(255, 192, 162) andTextStr:@"冻结金额" andNumStr:[NSString GetPerMilWithDouble:viewModel.userInfoModel.userAssets.frozenPoint.doubleValue]];
}
/**
 计算比例值
 */
- (void)calculateProportionValue
{
    NSString *financePlanAssets = [NSString stringWithFormat:@"%f",self.viewModel.userInfoModel.userAssets.financePlanAssets.doubleValue/self.viewModel.userInfoModel.userAssets.assetsTotal.doubleValue];
    NSString *lenderPrincipal = [NSString stringWithFormat:@"%f",self.viewModel.userInfoModel.userAssets.lenderPrincipal.doubleValue/self.viewModel.userInfoModel.userAssets.assetsTotal.doubleValue];
    NSString *availablePoint = [NSString stringWithFormat:@"%f",self.viewModel.userInfoModel.userAssets.availablePoint.doubleValue/self.viewModel.userInfoModel.userAssets.assetsTotal.doubleValue];
    NSString *frozenPoint = [NSString stringWithFormat:@"%f",self.viewModel.userInfoModel.userAssets.frozenPoint.doubleValue/self.viewModel.userInfoModel.userAssets.assetsTotal.doubleValue];
    [self.proportionalBarView drawLineWithRatioArr:@[financePlanAssets,availablePoint,lenderPrincipal,frozenPoint] andWithColorArr:@[RGB(255, 126, 127),RGB(161, 147, 249),RGB(128, 218, 255),RGB(255, 197, 162)]];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUPViews];
    }
    return self;
}

- (void)setUPViews {
    [self creatViews];
    [self setUPFrames];

}

- (void)creatViews {
    [self addSubview:self.totalAssetsLabel];
    [self addSubview:self.totalAssetsNumberLabel];
    [self addSubview:self.proportionalBarView];
    [self addSubview:self.plainView];
    [self addSubview:self.loanView];
    [self addSubview:self.availableView];
    [self addSubview:self.frozenView];
}



- (void)setUPFrames {
    [self.totalAssetsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW(20));
        make.top.equalTo(self).offset(kScrAdaptationH(30));
        make.height.offset(kScrAdaptationH(17));
    }];
    [self.totalAssetsNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.totalAssetsLabel.mas_left);
        make.top.equalTo(self.totalAssetsLabel.mas_bottom).offset(kScrAdaptationH(10));
        make.height.offset(kScrAdaptationH(28));
    }];
    [self.proportionalBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.totalAssetsLabel.mas_left);
        make.right.equalTo(self).offset(kScrAdaptationW(-20));
        make.top.equalTo(self.totalAssetsNumberLabel.mas_bottom).offset(kScrAdaptationH(30));
        make.height.offset(kScrAdaptationH(15));
    }];
    [self.plainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.totalAssetsLabel.mas_left);
        make.top.equalTo(self.proportionalBarView.mas_bottom).offset(kScrAdaptationH(30));
        make.height.offset(kScrAdaptationH(16));
    }];
    [self.loanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.totalAssetsLabel.mas_left);
        make.top.equalTo(self.plainView.mas_bottom).offset(kScrAdaptationH(20));
        make.height.offset(kScrAdaptationH(16));
    }];
    [self.availableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW(215));
        make.centerY.equalTo(self.plainView);
        make.height.offset(kScrAdaptationH(16));
    }];
    [self.frozenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.availableView.mas_left);
        make.centerY.equalTo(self.loanView);
        make.height.offset(kScrAdaptationH(16));
    }];
}

#pragma mark - 懒加载
- (HXBAssetsCustomVIew *)loanView
{
    if (!_loanView) {
        _loanView = [[HXBAssetsCustomVIew alloc] init];
    }
    return _loanView;
}
- (HXBAssetsCustomVIew *)plainView
{
    if (!_plainView) {
        _plainView = [[HXBAssetsCustomVIew alloc] init];
    }
    return _plainView;
}
- (HXBAssetsCustomVIew *)availableView
{
    if (!_availableView) {
        _availableView = [[HXBAssetsCustomVIew alloc] init];
    }
    return _availableView;
}
- (HXBAssetsCustomVIew *)frozenView
{
    if (!_frozenView) {
        _frozenView = [[HXBAssetsCustomVIew alloc] init];
    }
    return _frozenView;
}

- (UILabel *)totalAssetsLabel
{
    if (!_totalAssetsLabel) {
        _totalAssetsLabel = [[UILabel alloc] init];
        _totalAssetsLabel.text = @"总资产(元)";
        _totalAssetsLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        _totalAssetsLabel.textColor = COR28;
    }
    return _totalAssetsLabel;
}

- (UILabel *)totalAssetsNumberLabel
{
    if (!_totalAssetsNumberLabel) {
        _totalAssetsNumberLabel = [[UILabel alloc] init];
//        _totalAssetsNumberLabel.text = @"10000000";
        _totalAssetsNumberLabel.font = kHXBFont_PINGFANGSC_REGULAR(24);
        _totalAssetsNumberLabel.textColor = COR8;
    }
    return _totalAssetsNumberLabel;
}
- (HXBProportionalBarView *)proportionalBarView
{
    if (!_proportionalBarView) {
        _proportionalBarView = [[HXBProportionalBarView alloc] initWithFrame:CGRectMake(20, 100, self.width - 40, kScrAdaptationH(15))];
        _proportionalBarView.layer.cornerRadius = _proportionalBarView.frame.size.height * 0.5;
        _proportionalBarView.layer.masksToBounds = YES;
    }
    return _proportionalBarView;
}
@end
