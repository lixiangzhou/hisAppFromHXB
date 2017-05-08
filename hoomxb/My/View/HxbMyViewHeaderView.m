//
//  HxbMyViewHeaderView.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/4.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbMyViewHeaderView.h"

@interface HxbMyViewHeaderView ()
@property (nonatomic, strong) UILabel *allFinanceLabel;
@property (nonatomic, strong) UILabel *accumulatedProfitTitleLabel;
@property (nonatomic, strong) UILabel *accumulatedProfitLabel;
@property (nonatomic, strong) UILabel *balanceTitleLabel;
@property (nonatomic, strong) UILabel *balanceLabel;
@end


@implementation HxbMyViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COR1;
        [self addSubview:self.allFinanceLabel];
        [self addSubview:self.accumulatedProfitTitleLabel];
    }
    return self;
}

- (UILabel *)allFinanceLabel{
    if (!_allFinanceLabel) {
        _allFinanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height/2 - 60, self.width, 30)];
        _allFinanceLabel.text = @"38.00";
        _allFinanceLabel.textAlignment = NSTextAlignmentCenter;
        _allFinanceLabel.font = [UIFont systemFontOfSize:30];
        _allFinanceLabel.textColor = [UIColor whiteColor];
    }
    return _allFinanceLabel;
}

- (UILabel *)accumulatedProfitTitleLabel{
    if (!_accumulatedProfitTitleLabel) {
        _accumulatedProfitTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_allFinanceLabel.frame) + 100, self.width/2, 20)];
        _accumulatedProfitTitleLabel.text = @"累计收益";
        _accumulatedProfitTitleLabel.textAlignment = NSTextAlignmentCenter;
        _accumulatedProfitTitleLabel.font = [UIFont systemFontOfSize:20];
        _accumulatedProfitTitleLabel.textColor = [UIColor whiteColor];
    }
    return _accumulatedProfitTitleLabel;
}

@end
