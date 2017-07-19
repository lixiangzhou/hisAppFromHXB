//
//  HXBDepositoryHeaderView.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBDepositoryHeaderView.h"

@interface HXBDepositoryHeaderView ()

@property (nonatomic, strong) UIView *left_spot;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *right_spot;

@property (nonatomic, strong) UILabel *describeLabel;

@end

@implementation HXBDepositoryHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.height = kScrAdaptationH(37);
        [self addSubview:self.left_spot];
        [self addSubview:self.titleLabel];
        [self addSubview:self.right_spot];
        [self addSubview:self.describeLabel];
        [self setupSubViewFrame];
    }
    return self;
}

- (void)setupSubViewFrame
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self);
        make.height.offset(kScrAdaptationH(15));
    }];
    [self.left_spot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleLabel.mas_left).offset(kScrAdaptationW(-10));
        make.centerY.equalTo(self.titleLabel);
        make.height.offset(kScrAdaptationW(5));
        make.width.offset(kScrAdaptationW(5));
    }];
    [self.right_spot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(kScrAdaptationW(10));
        make.centerY.equalTo(self.titleLabel);
        make.height.offset(kScrAdaptationW(5));
        make.width.offset(kScrAdaptationW(5));
    }];
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kScrAdaptationH(10));
        make.height.offset(kScrAdaptationH(12));
    }];
}

- (void)setTitel:(NSString *)titel
{
    _titel = titel;
    self.titleLabel.text = titel;
}

- (void)setDescribe:(NSString *)describe
{
    _describe = describe;
    self.describeLabel.text = describe;
}
#pragma mark - 懒加载

- (UIView *)left_spot
{
    if (!_left_spot) {
        _left_spot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScrAdaptationW(5), kScrAdaptationW(5))];
        _left_spot.backgroundColor = COR25;
    }
    return _left_spot;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = COR25;
        _titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
    }
    return _titleLabel;
}

- (UIView *)right_spot
{
    if (!_right_spot) {
        _right_spot = [[UIView alloc] init];
        _right_spot.backgroundColor = COR25;
       
    }
    return _right_spot;
}

- (UILabel *)describeLabel
{
    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc] init];
        _describeLabel.textColor = COR10;
        _describeLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    }
    return _describeLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.right_spot.layer.cornerRadius = self.right_spot.width * 0.5;
    self.right_spot.layer.masksToBounds = YES;
    self.left_spot.layer.cornerRadius = self.left_spot.width * 0.5;
    self.left_spot.layer.masksToBounds = YES;
}
@end
