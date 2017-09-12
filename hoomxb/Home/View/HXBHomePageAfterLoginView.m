//
//  HXBHomePageAfterLoginView.m
//  HongXiaoBao
//
//  Created by HXB-C on 2016/11/15.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import "HXBHomePageAfterLoginView.h"
#import "HXB_XYTools.h"

@interface HXBHomePageAfterLoginView ()
@property (nonatomic, strong) UILabel *userTitleLabel;
@property (nonatomic, strong) UIButton *tipButton;


@end

@implementation HXBHomePageAfterLoginView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.userTitleLabel];
        [self addSubview:self.tipButton];
        [self setContentFrame];
    }
    return self;
}

- (void)setContentFrame{
    [self.userTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(@kScrAdaptationH(55));
    }];
}

- (void)tipButtonClick
{
    if (self.tipButtonClickBlock_homePageAfterLoginView) {
        self.tipButtonClickBlock_homePageAfterLoginView();
    }
}

- (void)setHeadTipString:(NSString *)headTipString {
    _headTipString = headTipString;
    self.userTitleLabel.text = self.headTipString;;
}

- (void)setTipString:(NSString *)tipString{
    _tipString = tipString;
    [self.tipButton setTitle:tipString forState:UIControlStateNormal];
    CGFloat width = [[HXB_XYTools shareHandle] WidthWithString:_tipString labelFont:kHXBFont_PINGFANGSC_REGULAR(17) addWidth:30];
    self.tipButton.frame = CGRectMake(kScreenWidth / 2 - kScrAdaptationW(width) / 2, kScrAdaptationH(86), kScrAdaptationW(width), kScrAdaptationH(30));
}

- (UILabel *)userTitleLabel{
    if (!_userTitleLabel) {
        _userTitleLabel = [[UILabel alloc]init];
        _userTitleLabel.textColor = COR15;
        _userTitleLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
        _userTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _userTitleLabel;
}

- (UIButton *)tipButton
{
    if (!_tipButton) {
        _tipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _tipButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _tipButton.layer.borderWidth = kXYBorderWidth;
        _tipButton.layer.cornerRadius = kScrAdaptationH(15.0f);
        [_tipButton setTitleColor:COR15 forState:UIControlStateNormal];
        _tipButton.titleLabel.font =  kHXBFont_PINGFANGSC_REGULAR(17);
        _tipButton.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.07];
        [_tipButton addTarget:self action:@selector(tipButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tipButton;
}

@end
