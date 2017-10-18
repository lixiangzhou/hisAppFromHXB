//
//  HXBTopUPView.m
//  hoomxb
//
//  Created by HXB on 2017/7/14.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBTopUPView.h"
@interface HXBTopUPView ()

///余额 title
@property (nonatomic,strong) UILabel *balanceLabel_const;
///余额展示
@property (nonatomic,strong) UILabel *balanceLabel;
///充值的button
@property (nonatomic,strong) UIButton *rechargeButton;
///点击了充值
@property (nonatomic,copy) void (^clickRechargeButton)();
///图片
@property (nonatomic,strong) UIImageView *rechargeImageView;
@property (nonatomic,strong) HXBTopUPViewManager *manager;
@end
@implementation HXBTopUPView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _manager = [[HXBTopUPViewManager alloc]init];
        [self setUP];
    }
    return self;
}

- (void)setUP {
    [self setUPSubViewsFrame];
    [self registerEvent];
}


- (void)setUPValueWithModel:(HXBTopUPViewManager *(^)(HXBTopUPViewManager *manager))setUPValueBlock {
    self.manager = setUPValueBlock(self.manager);
}

- (void)setManager:(HXBTopUPViewManager *)manager {
    _manager = manager;
    ///余额 title
    self.balanceLabel.text = manager.balanceLabelStr;
    ///余额展示
    self.balanceLabel_const.text = manager.balanceLabel_constStr;
    self.rechargeButton.userInteractionEnabled = true;
    ///充值的button
    [self.rechargeButton setTitle: manager.rechargeButtonStr forState:UIControlStateNormal];
}

///事件注册
- (void)registerEvent {
    [self.rechargeButton addTarget:self action:@selector(clickRechargeButton:)forControlEvents:UIControlEventTouchUpInside];
}

///点击了 充值按钮
- (void)clickRechargeButton: (UIButton *)button {
    NSLog(@"%@ 充值",self);
    self.clickRechargeButton();
}

///点击了充值
- (void)clickRechargeFunc: (void(^)())clickRechageButtonBlock {
    self.clickRechargeButton = clickRechageButtonBlock;
}

- (void)setUPSubViewsFrame {
    self.balanceLabel = [[UILabel alloc]init];
    self.balanceLabel_const = [[UILabel alloc]init];
    self.rechargeButton = [[UIButton alloc]init];
    self.rechargeImageView = [[UIImageView alloc]init];
    
    [self addSubview:self.rechargeImageView];
    [self addSubview: self.balanceLabel_const];
    [self addSubview: self.balanceLabel];
    [self addSubview: self.rechargeButton];
    [self.rechargeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(kScrAdaptationW750(-31));
        make.height.equalTo(@(kScrAdaptationH750(24)));
        make.width.equalTo(@(kScrAdaptationH750(18)));
    }];
    [self.rechargeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self);
        make.width.equalTo(@(kScrAdaptationW750(115)));
        make.height.equalTo(@(kScrAdaptationH750(30)));
    }];
    [self.rechargeButton setTitleColor: kHXBColor_RGB(0.45, 0.68, 1.00, 1.00) forState:UIControlStateNormal];
    self.rechargeImageView.svgImageString = @"arrow";
    self.rechargeButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
    [self.rechargeButton.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.bottom.equalTo(self.rechargeButton);
    }];
    
    [self.balanceLabel_const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(0);
        make.left.equalTo(self).offset(kScrAdaptationW750(30));
        make.height.equalTo(@(kScrAdaptationH750(30)));
    }];
    
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self.balanceLabel_const);
        make.left.equalTo(self.balanceLabel_const.mas_right).offset(kScrAdaptationW(5));
    }];
    self.balanceLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
    self.balanceLabel_const.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
    self.balanceLabel.textColor = kHXBColor_Grey_Font0_2;
    self.balanceLabel_const.textColor = kHXBColor_Grey_Font0_2;
    [self.balanceLabel sizeToFit];
    [self.balanceLabel_const sizeToFit];
}

@end
@implementation HXBTopUPViewManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
@end
