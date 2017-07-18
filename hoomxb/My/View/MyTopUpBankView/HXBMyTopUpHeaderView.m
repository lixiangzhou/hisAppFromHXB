//
//  HXBMyTopUpHeaderView.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/6.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyTopUpHeaderView.h"

@interface HXBMyTopUpHeaderView ()

@property (nonatomic, strong) UILabel *tipLabel;
@end


@implementation HXBMyTopUpHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = BACKGROUNDCOLOR;
        [self addSubview:self.tipLabel];
        [self sutupSubViewFrame];
    }
    return self;
}

- (void)sutupSubViewFrame
{
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

#pragma mark - 懒加载
- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.text = @"充值金额会进入恒丰银行个人存管账户";
        _tipLabel.textColor = COR10;
        _tipLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
    }
    return _tipLabel;
}

@end
