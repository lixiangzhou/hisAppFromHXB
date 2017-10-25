//
//  HxbFinancialAdvisorViewController.m
//  hoomxb
//
//  Created by hxb on 2017/10/25.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbFinancialAdvisorViewController.h"

@interface HxbFinancialAdvisorViewController ()

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIImageView *businessCardImageView;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation HxbFinancialAdvisorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的理财顾问";
    [self.view addSubview:self.headerView];
    [self setupSubViewFrame];
}

- (void)setupSubViewFrame
{
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.headerView);
    }];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundImageView).offset(kScrAdaptationH(-87/2));
        make.centerX.equalTo(self.backgroundImageView);
        make.width.offset(kScrAdaptationW(87));
        make.height.offset(kScrAdaptationW(87));
    }];
}

- (NSMutableAttributedString *)call
{
    NSString *str = @"客服热线（工作日9:00-18:00）";
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    [attributedStr addAttribute:NSFontAttributeName
     
                          value:kHXBFont_PINGFANGSC_REGULAR_750(24)
     
                          range:NSMakeRange(4, str.length - 4)];
    
    [attributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:COR10
     
                          range:NSMakeRange(4, str.length - 4)];
    
    return attributedStr;
}


- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH , kScrAdaptationH(172.5))];
        [_headerView addSubview:self.backgroundImageView];
    }
    return _headerView;
}

- (UIImageView *)businessCardImageView{
    if (!_businessCardImageView) {
        _businessCardImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScrAdaptationW(87), kScrAdaptationW(87))];
        _businessCardImageView.svgImageString = @"logo";
    }
    return _logoImageView;
}

- (UIImageView *)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScrAdaptationW(87), kScrAdaptationW(87))];
        _logoImageView.svgImageString = @"logo";
    }
    return _logoImageView;
}

- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _backgroundImageView.svgImageString = @"bj";
        [_backgroundImageView addSubview:self.logoImageView];
    }
    return _backgroundImageView;
}
@end
