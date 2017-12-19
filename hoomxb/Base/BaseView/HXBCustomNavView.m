//
//  HXBCustomNavView.m
//  hoomxb
//
//  Created by HXB-C on 2017/12/18.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBCustomNavView.h"

@interface HXBCustomNavView ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation HXBCustomNavView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, HXBStatusBarAndNavigationBarHeight)];
    if (self) {
        [self setUI];
    }
    return self;
}



#pragma mark - UI

- (void)setUI {
    [self addSubview:self.titleLabel];
    [self addSubview:self.bottomLine];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.offset(HXBNavigationBarHeight);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.offset(kHXBDivisionLineHeight);
    }];
}

#pragma mark - Action


#pragma mark - Setter / Getter / Lazy

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setNavAlpha:(CGFloat)navAlpha {
    _navAlpha = navAlpha;
    self.alpha = navAlpha;
}

- (void)setNavBackgroundColor:(UIColor *)navBackgroundColor {
    _navBackgroundColor = navBackgroundColor;
    self.backgroundColor = navBackgroundColor;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.titleLabel.textColor = titleColor;
}

- (void)setTitleFount:(UIFont *)titleFount {
    _titleFount = titleFount;
    self.titleLabel.font = titleFount;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(18);
    }
    return _titleLabel;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = COR12;
    }
    return _bottomLine;
}

#pragma mark - Helper


#pragma mark - Other


#pragma mark - Public

@end
