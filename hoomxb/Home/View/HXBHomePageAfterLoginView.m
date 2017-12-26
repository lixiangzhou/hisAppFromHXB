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
        make.left.equalTo(self).offset(kScrAdaptationW(15));
        make.top.equalTo(self).offset(kScrAdaptationH(40) + HXBStatusBarAdditionHeight);
    }];
    [self.tipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userTitleLabel.mas_bottom).offset(kScrAdaptationW(15));
        make.left.equalTo(self.userTitleLabel.mas_left);
        make.height.offset(kScrAdaptationH(24));
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
}

- (UILabel *)userTitleLabel{
    if (!_userTitleLabel) {
        _userTitleLabel = [[UILabel alloc]init];
        _userTitleLabel.textColor = COR10;
        _userTitleLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _userTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _userTitleLabel;
}

- (UIButton *)tipButton
{
    if (!_tipButton) {
        _tipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tipButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _tipButton.titleLabel.font =  kHXBFont_PINGFANGSC_REGULAR(24);
        [_tipButton addTarget:self action:@selector(tipButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tipButton;
}

@end
