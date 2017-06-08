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


/**
 用户昵称
 */
@property (nonatomic, strong) UILabel *userNameLabel;
/**
 累计收益
 */
@property (nonatomic, strong) UILabel *accumulatedIncomeLabel;
/**
 可用金额
 */
@property (nonatomic, strong) UILabel *availableAmountLabel;
/**
 是否显示密文的按钮
 */
@property (nonatomic, strong) UIButton *ciphertextButton;



@end

@implementation HXBHomePageLoginIndicationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.userNameLabel];
        [self addSubview:self.accumulatedIncomeLabel];
        [self addSubview:self.availableAmountLabel];
        [self addSubview:self.ciphertextButton];
        
        [self setupSubViewFrame];
        self.modle = @"";
    }
    return self;
}

#pragma mark Action Methods
- (void)setupSubViewFrame{
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(@16);
    }];
    [self.accumulatedIncomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.userNameLabel).offset(30);
    }];
    [self.availableAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.accumulatedIncomeLabel).offset(30);
    }];
    [self.ciphertextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.accumulatedIncomeLabel.mas_right);
        make.centerY.equalTo(self.accumulatedIncomeLabel);
        make.size.mas_equalTo(CGSizeMake(kScrAdaptationH(25), kScrAdaptationH(25)));
    }];
}
//- (void)buttonClicked
//{
//    id next = [self nextResponder];
//    while (![next isKindOfClass:[HxbHomeViewController class]]) {
//        next = [next nextResponder];
//    }
//    if ([next isKindOfClass:[HxbHomeViewController class]]) {
//        HxbHomeViewController *vc = (HxbHomeViewController *)next;
////        [vc loginOrSignUp];
//    }
//}
#pragma mark Set Methdos
- (void)setModle:(NSString *)modle
{
    _modle = modle;
    NSString *str = @"可用金额(元):789.76";
    NSMutableAttributedString *availableAmountAttrStr = [[NSMutableAttributedString alloc] initWithString:str];
    // 设置字体和设置字体的范围
    [availableAmountAttrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:17.0f]
                    range:NSMakeRange(8, str.length - 8)];
    self.availableAmountLabel.attributedText = availableAmountAttrStr;
    str = @"累计收益(元):789.76";
    NSMutableAttributedString *accumulatedIncomeAttrStr = [[NSMutableAttributedString alloc] initWithString:str];
    // 设置字体和设置字体的范围
    [accumulatedIncomeAttrStr addAttribute:NSFontAttributeName
                                   value:[UIFont systemFontOfSize:17.0f]
                                   range:NSMakeRange(8, str.length - 8)];
    self.accumulatedIncomeLabel.attributedText = accumulatedIncomeAttrStr;
    
}

/**
 点击隐藏金钱
 */
- (void)ciphertextButtonClick
{
   
    if (self.ciphertextButton.selected) {
        NSString *str = @"累计收益(元):789.76";
        NSMutableAttributedString *accumulatedIncomeAttrStr = [[NSMutableAttributedString alloc] initWithString:str];
        // 设置字体和设置字体的范围
        [accumulatedIncomeAttrStr addAttribute:NSFontAttributeName
                                         value:[UIFont systemFontOfSize:17.0f]
                                         range:NSMakeRange(8, str.length - 8)];
        self.accumulatedIncomeLabel.attributedText = accumulatedIncomeAttrStr;
    }else{
        NSString *str = @"累计收益(元):***";
        NSMutableAttributedString *accumulatedIncomeAttrStr = [[NSMutableAttributedString alloc] initWithString:str];
        // 设置字体和设置字体的范围
        [accumulatedIncomeAttrStr addAttribute:NSFontAttributeName
                                         value:[UIFont systemFontOfSize:17.0f]
                                         range:NSMakeRange(8, str.length - 8)];
        self.accumulatedIncomeLabel.attributedText = accumulatedIncomeAttrStr;
    }
    
    self.ciphertextButton.selected = !self.ciphertextButton.selected;
}

#pragma mark Get Methdos

- (UILabel *)userNameLabel
{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.textAlignment = NSTextAlignmentCenter;
        _userNameLabel.text = @"你好，hxb1234567";
        _userNameLabel.font = [UIFont systemFontOfSize:12];
    }
    return _userNameLabel;
}

- (UILabel *)accumulatedIncomeLabel
{
    if (!_accumulatedIncomeLabel) {
        _accumulatedIncomeLabel = [[UILabel alloc] init];
//        _accumulatedIncomeLabel.text = @"累计收益(元):789.76";
        _accumulatedIncomeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _accumulatedIncomeLabel;
}

- (UILabel *)availableAmountLabel
{
    if (!_availableAmountLabel) {
        _availableAmountLabel = [[UILabel alloc] init];
        _availableAmountLabel.font = [UIFont systemFontOfSize:12];
    }
    return _availableAmountLabel;
}
- (UIButton *)ciphertextButton
{
    if (!_ciphertextButton) {
        _ciphertextButton = [[UIButton alloc] init];
        _ciphertextButton.backgroundColor = [UIColor redColor];
        [_ciphertextButton addTarget:self action:@selector(ciphertextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ciphertextButton;
}
@end
