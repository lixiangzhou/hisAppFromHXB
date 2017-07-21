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
        make.width.offset(kScrAdaptationH750(30));
        make.height.offset(kScrAdaptationH750(30));
    }];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(kScrAdaptationW750(12));
        make.top.equalTo(self);
        make.right.equalTo(self);
    }];
}
- (void)setText:(NSString *)text
{
    _text = text;
    self.tipLabel.text = text;
    if (text.length > 0) {
        self.iconView.hidden = NO;
    }
}

#pragma mark - 懒加载
- (UIImageView *)iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage imageNamed:@"tip"];
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
        _iconView.hidden = YES;
    }
    return _iconView;
}

- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.numberOfLines = 0;
        _tipLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(26);
        _tipLabel.textColor = COR10;
    }
    return _tipLabel;
}
@end
