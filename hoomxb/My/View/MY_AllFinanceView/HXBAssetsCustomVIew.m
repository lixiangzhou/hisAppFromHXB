//
//  HXBAssetsCustomVIew.m
//  hoomxb
//
//  Created by HXB-C on 2017/8/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBAssetsCustomVIew.h"

@interface HXBAssetsCustomVIew ()

@property (nonatomic, strong) UILabel *testLabel;

@property (nonatomic, strong) UILabel *numLabel;

@property (nonatomic, strong) UIView *circularView;

@end

@implementation HXBAssetsCustomVIew

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.circularView];
        [self addSubview:self.testLabel];
        [self addSubview:self.numLabel];
        [self setupSubViewFrame];
    }
    return self;
}

- (void)setupSubViewFrame
{
    [self.circularView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self);
        make.height.offset(kScrAdaptationW(10));
        make.width.offset(kScrAdaptationW(10));
    }];
    [self.testLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.circularView.mas_right).offset(kScrAdaptationW(10));
        make.centerY.equalTo(self);
    }];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.testLabel.mas_right).offset(kScrAdaptationW(10));
        make.centerY.equalTo(self);
    }];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.circularView.mas_left);
        make.right.equalTo(self.numLabel.mas_right);
        make.top.equalTo(self.testLabel.mas_top);
        make.bottom.equalTo(self.testLabel.mas_bottom);
    }];
}


- (void)circularViewColor:(UIColor *)color andTextStr:(NSString *)str andNumStr:(NSString *)numStr
{
    self.circularView.backgroundColor = color;
    self.testLabel.text = str;
    self.numLabel.text = numStr;
}


#pragma - mark 懒加载
- (UIView *)circularView
{
    if (!_circularView) {
        _circularView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScrAdaptationW(10), kScrAdaptationW(10))];
        _circularView.layer.cornerRadius = _circularView.frame.size.height * 0.5;
        _circularView.layer.masksToBounds = YES;
    }
    return _circularView;
}

- (UILabel *)testLabel
{
    if (!_testLabel) {
        _testLabel = [[UILabel alloc] init];
        _testLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _testLabel.textColor = COR8;
    }
    return _testLabel;
}

- (UILabel *)numLabel
{
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] init];
        _numLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _numLabel.textColor = COR6;
    }
    return _numLabel;
}

@end
