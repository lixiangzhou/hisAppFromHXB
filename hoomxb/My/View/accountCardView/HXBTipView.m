//
//  HXBTipView.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBTipView.h"
#import "SVGKImage.h"
@interface HXBTipView ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation HXBTipView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.iconView];
        [self addSubview:self.tipLabel];
        [self setupSubViewFrame];
    }
    return self;
}

- (void)setupSubViewFrame
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_left);
        make.top.equalTo(self.iconView.mas_top);
        make.bottom.equalTo(self.tipLabel.mas_bottom);
    }];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.width.offset(kScrAdaptationH750(28));
        make.height.offset(kScrAdaptationH750(28));
    }];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(kScrAdaptationW750(12));
        make.top.equalTo(self);
        make.right.equalTo(self);
    }];
}

#pragma mark - 懒加载
- (UIImageView *)iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [SVGKImage imageNamed:@"prompt.svg"].UIImage;
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconView;
}

- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.text = @"如遇法定节假日，会顺延。";
        _tipLabel.numberOfLines = 0;
        _tipLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(26);
        _tipLabel.textColor = COR10;
    }
    return _tipLabel;
}
@end
