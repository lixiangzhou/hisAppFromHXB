//
//  HxbMyViewHeaderView.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/4.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbMyViewHeaderView.h"

@interface HxbMyViewHeaderView ()
@property (nonatomic, strong) UILabel *allFinanceTitleLabel;
@property (nonatomic, strong) UILabel *allFinanceLabel;
@property (nonatomic, strong) UILabel *accumulatedProfitTitleLabel;
@property (nonatomic, strong) UILabel *accumulatedProfitLabel;
@property (nonatomic, strong) UILabel *balanceTitleLabel;
@property (nonatomic, strong) UILabel *balanceLabel;
@property (nonatomic, strong) UIView *buttonView;
@property (nonatomic, strong) UIButton *topupButton;
@property (nonatomic, strong) UIButton *withdrawButton;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *buttonLineView;
@property (nonatomic, strong) UIButton *leftHeadButton;
@property (nonatomic, strong) UIButton *rightHeadButton;
@end


@implementation HxbMyViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COR1;
        [self addSubview:self.allFinanceLabel];
        [self addSubview:self.allFinanceTitleLabel];
        [self addSubview:self.accumulatedProfitTitleLabel];
        [self addSubview:self.accumulatedProfitLabel];
        [self addSubview:self.balanceTitleLabel];
        [self addSubview:self.balanceLabel];
        [self addSubview:self.buttonView];
        [self addSubview:self.lineView];
        [self.buttonView addSubview:self.topupButton];
        [self.buttonView addSubview:self.withdrawButton];
        [self.buttonView addSubview:self.buttonLineView];
        [self addSubview:self.leftHeadButton];
        [self addSubview:self.rightHeadButton];
    }
    return self;
}

- (void)leftHeaderButtonClick:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(didClickLeftHeadBtn:)]) {
        [self.delegate didClickLeftHeadBtn:sender];
    }
}

- (void)topupButtonClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(didClickTopUpBtn:)]) {
        [self.delegate didClickTopUpBtn:sender];
    }
}

- (void)withdrawButtonClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(didClickWithdrawBtn:)]) {
        [self.delegate didClickWithdrawBtn:sender];
    }
}

- (UILabel *)allFinanceLabel{
    if (!_allFinanceLabel) {
        _allFinanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height/2 - 60, self.width, 40)];
        _allFinanceLabel.text = @"38.00";
        _allFinanceLabel.textAlignment = NSTextAlignmentCenter;
        _allFinanceLabel.font = [UIFont systemFontOfSize:40];
        _allFinanceLabel.textColor = [UIColor whiteColor];
    }
    return _allFinanceLabel;
}

- (UILabel *)allFinanceTitleLabel{
    if (!_allFinanceTitleLabel) {
        _allFinanceTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width/2, 40)];
        _allFinanceTitleLabel.text = @"总资产";
        _allFinanceTitleLabel.center = CGPointMake(self.width/2, 60);
        _allFinanceTitleLabel.textAlignment = NSTextAlignmentCenter;
        _allFinanceTitleLabel.font = [UIFont systemFontOfSize:20];
        _allFinanceTitleLabel.textColor = [UIColor whiteColor];
    }
    return _allFinanceTitleLabel;
}

- (UILabel *)accumulatedProfitTitleLabel{
    if (!_accumulatedProfitTitleLabel) {
        _accumulatedProfitTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_allFinanceLabel.frame) + 60, self.width/2, 20)];
        _accumulatedProfitTitleLabel.text = @"累计收益";
        _accumulatedProfitTitleLabel.textAlignment = NSTextAlignmentCenter;
        _accumulatedProfitTitleLabel.font = [UIFont systemFontOfSize:20];
        _accumulatedProfitTitleLabel.textColor = [UIColor whiteColor];
    }
    return _accumulatedProfitTitleLabel;
}

- (UILabel *)accumulatedProfitLabel{
    if (!_accumulatedProfitLabel) {
        _accumulatedProfitLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_accumulatedProfitTitleLabel.frame) + 30, self.width/2, 20)];
        _accumulatedProfitLabel.text = @"30.8";
        _accumulatedProfitLabel.textAlignment = NSTextAlignmentCenter;
        _accumulatedProfitLabel.font = [UIFont systemFontOfSize:20];
        _accumulatedProfitLabel.textColor = [UIColor whiteColor];    }
    return _accumulatedProfitLabel;
}


- (UILabel *)balanceTitleLabel{
    if (!_balanceTitleLabel) {
        _balanceTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width/2,CGRectGetMaxY(_allFinanceLabel.frame) + 60, self.width/2, 20)];
        _balanceTitleLabel.text = @"账户余额";
        _balanceTitleLabel.textAlignment = NSTextAlignmentCenter;
        _balanceTitleLabel.font = [UIFont systemFontOfSize:20];
        _balanceTitleLabel.textColor = [UIColor whiteColor];
    }
    return _balanceTitleLabel;
}

- (UILabel *)balanceLabel{
    if (!_balanceLabel) {
    _balanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width/2,CGRectGetMaxY(_balanceTitleLabel.frame) + 30, self.width/2, 20)];
    _balanceLabel.text = @"38.00";
    _balanceLabel.textAlignment = NSTextAlignmentCenter;
    _balanceLabel.font = [UIFont systemFontOfSize:20];
    _balanceLabel.textColor = [UIColor whiteColor];
 }
    return _balanceLabel;

}

- (UIView *)buttonView{
    if (!_buttonView) {
        _buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame) - 44, self.width, 44)];
        _buttonView.backgroundColor = [UIColor whiteColor];
    }
    return _buttonView;
}

- (UIButton *)topupButton{
    if (!_topupButton) {
        _topupButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0, self.width/2, 44)];
        _topupButton.backgroundColor = [UIColor whiteColor];
        [_topupButton setTitle:@"充值" forState:UIControlStateNormal];
        [_topupButton setTitleColor:COR1 forState:UIControlStateNormal];
        [_topupButton addTarget:self action:@selector(topupButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topupButton;
}

- (UIButton *)withdrawButton{
    if (!_withdrawButton) {
        _withdrawButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width/2,0, self.width/2, 44)];
        _withdrawButton.backgroundColor = [UIColor whiteColor];
        [_withdrawButton setTitle:@"提现" forState:UIControlStateNormal];
        [_withdrawButton setTitleColor:COR1 forState:UIControlStateNormal];
        [_withdrawButton addTarget:self action:@selector(withdrawButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _withdrawButton;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(self.width/2, CGRectGetMaxY(_allFinanceLabel.frame) + 50, 0.5, CGRectGetMinY(_buttonView.frame) - CGRectGetMaxY(_allFinanceLabel.frame) - 60)];
        _lineView.backgroundColor = [UIColor whiteColor];
    }
    return _lineView;
}

- (UIView *)buttonLineView{
    if (!_buttonLineView) {
        _buttonLineView = [[UIView alloc]initWithFrame:CGRectMake(self.width/2, 5, 0.5, 44 - 10)];
        _buttonLineView.backgroundColor = [UIColor blackColor];
    }
    return _buttonLineView;
}

- (UIButton *)leftHeadButton{
    if (!_leftHeadButton) {
        _leftHeadButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 40, 40, 40)];
        [_leftHeadButton setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
        [_leftHeadButton addTarget:self action:@selector(leftHeaderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftHeadButton;
}

- (UIButton *)rightHeadButton{
    if (!_rightHeadButton) {
        _rightHeadButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 40 - 20, 40, 40, 40)];
        [_rightHeadButton setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];;
    }
    return _rightHeadButton;
}
@end
