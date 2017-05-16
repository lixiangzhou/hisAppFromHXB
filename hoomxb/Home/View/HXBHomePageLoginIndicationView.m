//
//  HXBHomePageLoginIndicationView.m
//  HongXiaoBao
//
//  Created by 牛严 on 16/7/11.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import "HXBHomePageLoginIndicationView.h"
#import "HxbHomeViewController.h"

#import "UILabel+Util.h"

@interface HXBHomePageLoginIndicationView ()

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIImageView *leftImage;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation HXBHomePageLoginIndicationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.backView];
//        [self.backView addSubview:self.leftImage];
        [self.backView addSubview:self.contentLabel];
        [self.backView addSubview:self.loginButton];
    }
    return self;
}

#pragma mark Action Methods
- (void)buttonClicked
{
    id next = [self nextResponder];
    while (![next isKindOfClass:[HxbHomeViewController class]]) {
        next = [next nextResponder];
    }
    if ([next isKindOfClass:[HxbHomeViewController class]]) {
        HxbHomeViewController *vc = (HxbHomeViewController *)next;
//        [vc loginOrSignUp];
    }
}

#pragma mark Get Methdos
- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 72)];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (UIImageView *)leftImage
{
    if (!_leftImage) {
        _leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 12, 36, 36)];
        _leftImage.image = [UIImage imageNamed:@"homepage_yuanbao.png"];
    }
    return _leftImage;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 30, SCREEN_WIDTH - 170, 14)];
        _contentLabel.text = @"立即注册开启理财之旅!";
        _contentLabel.font = HXB_Text_Font(14);
        _contentLabel.textColor = COR9;
    }
    return _contentLabel;
}

- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 111, 20, 95, 32)];
        _loginButton.backgroundColor = [UIColor whiteColor];
        _loginButton.layer.borderColor = [MAIN_THEME_COLOR CGColor];
        _loginButton.layer.borderWidth = 1.f;
        [_loginButton setTitle:@"登录/注册" forState:UIControlStateNormal];
        [_loginButton setTitleColor:MAIN_THEME_COLOR forState:UIControlStateNormal];
        _loginButton.titleLabel.font = HXB_Text_Font(14);
        [_loginButton addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

@end
