//
//  HXBFinBaseFlowChartChildView.m
//  hoomxb
//
//  Created by caihongji on 2018/3/29.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinBaseFlowChartChildView.h"

@interface HXBFinBaseFlowChartChildView()

@property (nonatomic, strong) UILabel* titleLb;
@property (nonatomic, strong) UIImageView* lineImv;
@property (nonatomic, strong) UILabel* stateLb;
@property (nonatomic, strong) UILabel* dateLb;

@end

@implementation HXBFinBaseFlowChartChildView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
        [self addConstraints];
    }
    return self;
}

- (UILabel *)titleLb
{
    if(!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.textColor = [UIColor whiteColor];
        _titleLb.font = kHXBFont_PINGFANGSC_REGULAR(11);
        _titleLb.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLb;
}

- (UIImageView *)lineImv
{
    if(!_lineImv) {
        _lineImv = [[UIImageView alloc] init];
    }
    
    return _lineImv;
}

- (UILabel *)stateLb
{
    if(!_stateLb) {
        _stateLb = [[UILabel alloc] init];
        _stateLb.textColor = [UIColor whiteColor];
        _stateLb.font = kHXBFont_PINGFANGSC_REGULAR(12);
    }
    
    return _stateLb;
}

- (UILabel *)dateLb
{
    if(!_dateLb) {
        _dateLb = [[UILabel alloc] init];
        _dateLb.textColor = [UIColor whiteColor];
        _dateLb.font = kHXBFont_PINGFANGSC_REGULAR(12);
    }
    
    return _dateLb;
}

- (void)setUI
{
    [self addSubview:self.titleLb];
    [self addSubview:self.lineImv];
    [self addSubview:self.stateLb];
    [self addSubview:self.dateLb];
}

- (void)addConstraints
{
    kWeakSelf
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(weakSelf);
        make.height.mas_equalTo(kScrAdaptationH(20));
    }];
    
    [self.lineImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleLb.mas_left);
        make.top.equalTo(weakSelf.titleLb.mas_bottom);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(kScrAdaptationH(10));
    }];
    
    [self.stateLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lineImv.mas_right).offset(2);
        make.top.equalTo(weakSelf.lineImv.mas_bottom).offset(kScrAdaptationH(2));
    }];
    
    [self.dateLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.stateLb);
        make.top.equalTo(weakSelf.stateLb.mas_bottom).offset(kScrAdaptationH(4));
    }];
}

- (void)updateView:(BOOL)isSelected titleContent:(NSString*)title stateContent:(NSString*)state dateContent:(NSString*)date
{
    self.titleLb.text = title;
    self.stateLb.text = state;
    self.dateLb.text = date;
    
    UIColor* backColor = kHXBColor_D8D8D8_100;
    UIColor* stateColor = kHXBFountColor_999999_100;
    UIColor* dateColor = kHXBFountColor_999999_100;
    if(isSelected) {
        backColor = kHXBColor_F55151_100;
        stateColor = kHXBFountColor_333333_100;
        dateColor = kHXBFountColor_666666_100;
    }
    [self updateShowState:backColor stateContentColor:stateColor dateContentColor:dateColor];
}

- (void)updateShowState:(UIColor*)backColor stateContentColor:(UIColor*)stateColor dateContentColor:(UIColor*)dateColor
{
    self.titleLb.backgroundColor = backColor;
    self.lineImv.backgroundColor = backColor;
    self.stateLb.textColor = stateColor;
    self.dateLb.textColor = dateColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
