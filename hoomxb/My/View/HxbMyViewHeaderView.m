//
//  HxbMyViewHeaderView.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/4.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbMyViewHeaderView.h"
#import "SVGKImage.h"
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
@property (nonatomic, strong) UIButton *allFinanceButton;
@property (nonatomic,copy) void(^clickAllFinanceButtonBlock)(UILabel *button);
@end


@implementation HxbMyViewHeaderView

- (void)clickAllFinanceButtonWithBlock: (void(^)(UILabel *button))clickAllFinanceButtonBlock {
    self.clickAllFinanceButtonBlock = clickAllFinanceButtonBlock;
}
///总资产的button
- (UIButton *)allFinanceButton {
    if (!_allFinanceButton) {
        _allFinanceButton = [[UIButton alloc]init];
    }
    return _allFinanceButton;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COR1;
//        [self addSubview: self.allFinanceButton];//总资产的button
   
//        [self setUPFrame];
//        [self registerEvent];
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
- (void)registerEvent {
    [self.allFinanceButton addTarget:self action:@selector(clickAllFinanceButton:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)clickAllFinanceButton: (UITapGestureRecognizer *)tap {
    if (self.clickAllFinanceButtonBlock) {
        self.clickAllFinanceButtonBlock((UILabel *)tap.view);
    }
}
- (void)setUPFrame {
    [self.allFinanceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(80)));
    }];
}

/**
 设置数据

 @param userInfoViewModel 数据模型
 */
- (void)setUserInfoViewModel:(HXBRequestUserInfoViewModel *)userInfoViewModel
{
    _userInfoViewModel = userInfoViewModel;
    
    NSString *allFinanceStr = [NSString hxb_getPerMilWithDouble:[userInfoViewModel.userInfoModel.userAssets.assetsTotal doubleValue]]?:@"0.00";
    NSString *accumulatedProfitStr = [NSString hxb_getPerMilWithDouble:[userInfoViewModel.userInfoModel.userAssets.earnTotal doubleValue]]?:@"0.00";
    NSString *balance = [NSString hxb_getPerMilWithDouble:[userInfoViewModel.userInfoModel.userAssets.availablePoint doubleValue]]?:@"0.00";
    if ([KeyChain.ciphertext isEqualToString:@"0"])
    {
        self.rightHeadButton.selected = NO;
        self.allFinanceLabel.text = allFinanceStr;
        self.accumulatedProfitLabel.text = accumulatedProfitStr;
        self.balanceLabel.text = balance;
    }else
    {
         self.rightHeadButton.selected = YES;
        
        self.allFinanceLabel.text = [allFinanceStr replaceStringWithStartLocation:0 lenght:allFinanceStr.length];
        
        self.accumulatedProfitLabel.text = [accumulatedProfitStr replaceStringWithStartLocation:0 lenght:accumulatedProfitStr.length];
        
        self.balanceLabel.text = [balance replaceStringWithStartLocation:0 lenght:balance.length];
    }
}


- (void)leftHeaderButtonClick:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(didClickLeftHeadBtn:)]) {
        [self.delegate didClickLeftHeadBtn:sender];
    }
}

- (void)rightHeadButtonClick:(UIButton *)rightHeadBtn
{
    NSString *allFinanceStr = [NSString hxb_getPerMilWithDouble:[self.userInfoViewModel.userInfoModel.userAssets.assetsTotal doubleValue]]?:@"0.00";
    NSString *accumulatedProfitStr = [NSString hxb_getPerMilWithDouble:[self.userInfoViewModel.userInfoModel.userAssets.earnTotal doubleValue]]?:@"0.00";
    NSString *balance = [NSString hxb_getPerMilWithDouble:[self.userInfoViewModel.userInfoModel.userAssets.availablePoint doubleValue]]?:@"0.00";
    
    if ([KeyChain.ciphertext isEqualToString:@"0"]){
        KeyChain.ciphertext = @"1";
        self.rightHeadButton.selected = YES;
        self.allFinanceLabel.text = [allFinanceStr replaceStringWithStartLocation:0 lenght:allFinanceStr.length];
        self.accumulatedProfitLabel.text = [accumulatedProfitStr replaceStringWithStartLocation:0 lenght:accumulatedProfitStr.length];
        self.balanceLabel.text = [balance replaceStringWithStartLocation:0 lenght:balance.length];
    }else
    {
        KeyChain.ciphertext = @"0";
        self.rightHeadButton.selected = NO;
        self.allFinanceLabel.text = allFinanceStr;
        self.accumulatedProfitLabel.text = accumulatedProfitStr;
        self.balanceLabel.text = balance;
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
//        _allFinanceLabel.text = @"38.00";
        _allFinanceLabel.textAlignment = NSTextAlignmentCenter;
        _allFinanceLabel.font = [UIFont systemFontOfSize:40];
        _allFinanceLabel.textColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAllFinanceButton:)];
        [_allFinanceLabel addGestureRecognizer:tap];
        _allFinanceLabel.userInteractionEnabled = true;
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
//        _accumulatedProfitLabel.text = @"30.8";
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
//    _balanceLabel.text = @"38.00";
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
        [_rightHeadButton setImage:[SVGKImage imageNamed:@"password_eye_open.svg"].UIImage forState:UIControlStateNormal];
        [_rightHeadButton setImage:[SVGKImage imageNamed:@"password_eye_close.svg"].UIImage forState:UIControlStateSelected];
        [_rightHeadButton addTarget:self action:@selector(rightHeadButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightHeadButton;
}
@end
