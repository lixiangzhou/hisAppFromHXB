//
//  HXBMyTopUpHeaderView.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/6.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyTopUpHeaderView.h"

@interface HXBMyTopUpHeaderView ()

@property (nonatomic, strong) UILabel *tipLabel;
@end


@implementation HXBMyTopUpHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = COR32;
        [self addSubview:self.tipLabel];
        [self sutupSubViewFrame];
    }
    return self;
}

- (void)sutupSubViewFrame {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kScrAdaptationH750(80), kScreenWidth, kScrAdaptationH750(0.5))];
    lineView.backgroundColor = COR32;
    lineView.layer.shadowColor = [UIColor grayColor].CGColor;//shadowColor阴影颜色
    lineView.layer.shadowOffset = CGSizeMake(1, 1);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    lineView.layer.shadowOpacity = 0.6;//阴影透明度，默认0
    lineView.layer.shadowRadius = 1;//阴影半径，默认3
    [self addSubview:lineView];
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
        _tipLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
    }
    return _tipLabel;
}

@end
