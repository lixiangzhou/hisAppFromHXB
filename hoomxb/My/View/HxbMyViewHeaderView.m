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
/**
 背景图片
 */
@property (nonatomic, strong) UIImageView *backgroundImage;
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
//@property (nonatomic, strong) UIView *buttonLineView;
@property (nonatomic, strong) UIButton *leftHeadButton;
@property (nonatomic, strong) UIButton *rightHeadButton;
//@property (nonatomic, strong) UIButton *allFinanceButton;
@property (nonatomic,copy) void(^clickAllFinanceButtonBlock)(UILabel *button);
@end


@implementation HxbMyViewHeaderView

- (void)clickAllFinanceButtonWithBlock: (void(^)(UILabel *button))clickAllFinanceButtonBlock {
    self.clickAllFinanceButtonBlock = clickAllFinanceButtonBlock;
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        [self addSubview: self.allFinanceButton];//总资产的button
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAllFinanceButton:)];
        [self.backgroundImage addGestureRecognizer:tap];
//        [self registerEvent];
        [self addSubview:self.backgroundImage];
        [self addSubview:self.allFinanceLabel];
        [self addSubview:self.allFinanceTitleLabel];
        [self addSubview:self.accumulatedProfitTitleLabel];
        [self addSubview:self.accumulatedProfitLabel];
        [self addSubview:self.buttonView];
        [self addSubview:self.lineView];
        [self.buttonView addSubview:self.balanceTitleLabel];
        [self.buttonView addSubview:self.balanceLabel];
        [self.buttonView addSubview:self.topupButton];
        [self.buttonView addSubview:self.withdrawButton];
        [self addSubview:self.leftHeadButton];
        [self addSubview:self.rightHeadButton];
        [self setupSubViewFrame];
    }
    return self;
}

/**
 设置frame
 */
- (void)setupSubViewFrame
{
    [self.backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.offset(kScrAdaptationH(200));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(kScrAdaptationH(101));
        make.width.offset(0.5);
        make.height.offset(kScrAdaptationH(40));
    }];
    [self.allFinanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self.lineView.mas_left);
        make.top.equalTo(self).offset(kScrAdaptationH(93));
        make.height.offset(kScrAdaptationH(33));
    }];
    [self.allFinanceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.allFinanceLabel);
        make.top.equalTo(self.allFinanceLabel.mas_bottom);
        make.height.offset(kScrAdaptationH(17));
    }];
    [self.rightHeadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.allFinanceTitleLabel.mas_right).offset(kScrAdaptationW(5));
        make.centerY.equalTo(self.allFinanceTitleLabel);
        make.height.width.offset(kScrAdaptationH(15));
    }];
    [self.accumulatedProfitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineView.mas_right);
        make.right.equalTo(self);
        make.centerY.equalTo(self.allFinanceLabel);
        make.height.offset(kScrAdaptationH(33));
    }];
    [self.accumulatedProfitTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.accumulatedProfitLabel);
        make.top.equalTo(self.accumulatedProfitLabel.mas_bottom);
        make.height.offset(kScrAdaptationH(17));

    }];
    [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.backgroundImage.mas_bottom);
        make.height.offset(kScrAdaptationH(76));
    }];
    [self.balanceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.buttonView).offset(kScrAdaptationW(15));
        make.top.equalTo(self.buttonView).offset(kScrAdaptationH(12));
        make.height.offset(kScrAdaptationH(21));
    }];
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.balanceTitleLabel.mas_left);
        make.top.equalTo(self.balanceTitleLabel.mas_bottom).offset(kScrAdaptationH(10));
    }];
    [self.withdrawButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.buttonView);
        make.right.equalTo(self.buttonView).offset(kScrAdaptationW(-15));
        make.height.offset(kScrAdaptationH(30));
        make.width.offset(kScrAdaptationW(90));
    }];
    [self.topupButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.buttonView);
        make.right.equalTo(self.withdrawButton.mas_left).offset(kScrAdaptationW(-20));
        make.height.offset(kScrAdaptationH(30));
        make.width.offset(kScrAdaptationW(90));
    }];
}

- (void)clickAllFinanceButton: (UITapGestureRecognizer *)tap {
    if (self.clickAllFinanceButtonBlock) {
        self.clickAllFinanceButtonBlock((UILabel *)tap.view);
    }
}

/**
 设置数据

 @param userInfoViewModel 数据模型
 */
- (void)setUserInfoViewModel:(HXBRequestUserInfoViewModel *)userInfoViewModel
{
    _userInfoViewModel = userInfoViewModel;
    
    NSString *allFinanceStr = userInfoViewModel.userInfoModel.userAssets.assetsTotal.intValue? [NSString GetPerMilWithDouble:userInfoViewModel.userInfoModel.userAssets.assetsTotal.doubleValue]:@"0.00";
    
    NSString *accumulatedProfitStr = userInfoViewModel.userInfoModel.userAssets.earnTotal.intValue? [NSString GetPerMilWithDouble:userInfoViewModel.userInfoModel.userAssets.earnTotal.doubleValue]: @"0.00";
    
    NSString *balance = userInfoViewModel.userInfoModel.userAssets.availablePoint.intValue ? [NSString GetPerMilWithDouble:userInfoViewModel.userInfoModel.userAssets.availablePoint.doubleValue] : @"0.00";
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
    NSString *allFinanceStr = [NSString GetPerMilWithDouble:[self.userInfoViewModel.userInfoModel.userAssets.assetsTotal doubleValue]]?:@"0.00";
    NSString *accumulatedProfitStr = [NSString GetPerMilWithDouble:[self.userInfoViewModel.userInfoModel.userAssets.earnTotal doubleValue]]?:@"0.00";
    NSString *balance = [NSString GetPerMilWithDouble:[self.userInfoViewModel.userInfoModel.userAssets.availablePoint doubleValue]]?:@"0.00";
    
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

#pragma mark - 懒加载
- (UIImageView *)backgroundImage
{
    if (!_backgroundImage) {
        _backgroundImage =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_bg"]];
        _backgroundImage.userInteractionEnabled = YES;
    }
    return _backgroundImage;
}

- (UILabel *)allFinanceLabel{
    if (!_allFinanceLabel) {
        _allFinanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height/2 - 60, self.width, 40)];
//        _allFinanceLabel.text = @"38.00";
        _allFinanceLabel.textAlignment = NSTextAlignmentCenter;
        _allFinanceLabel.font = kHXBFont_PINGFANGSC_REGULAR(24);
        _allFinanceLabel.textColor = COR15;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAllFinanceButton:)];
        [_allFinanceLabel addGestureRecognizer:tap];
        _allFinanceLabel.userInteractionEnabled = true;
    }
    return _allFinanceLabel;
}

- (UILabel *)allFinanceTitleLabel{
    if (!_allFinanceTitleLabel) {
        _allFinanceTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width/2, 40)];
        _allFinanceTitleLabel.text = @"持有资产(元)";
        _allFinanceTitleLabel.center = CGPointMake(self.width/2, 60);
        _allFinanceTitleLabel.textAlignment = NSTextAlignmentCenter;
        _allFinanceTitleLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _allFinanceTitleLabel.textColor = COR27;
    }
    return _allFinanceTitleLabel;
}

- (UILabel *)accumulatedProfitTitleLabel{
    if (!_accumulatedProfitTitleLabel) {
        _accumulatedProfitTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_allFinanceLabel.frame) + 60, self.width/2, 20)];
        _accumulatedProfitTitleLabel.text = @"累计收益(元)";
        _accumulatedProfitTitleLabel.textAlignment = NSTextAlignmentCenter;
        _accumulatedProfitTitleLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _accumulatedProfitTitleLabel.textColor = COR27;
    }
    return _accumulatedProfitTitleLabel;
}

- (UILabel *)accumulatedProfitLabel{
    if (!_accumulatedProfitLabel) {
        _accumulatedProfitLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_accumulatedProfitTitleLabel.frame) + 30, self.width/2, 20)];
//        _accumulatedProfitLabel.text = @"30.8";
        _accumulatedProfitLabel.textAlignment = NSTextAlignmentCenter;
        _accumulatedProfitLabel.font = kHXBFont_PINGFANGSC_REGULAR(24);
        _accumulatedProfitLabel.textColor = COR15;
    }
    return _accumulatedProfitLabel;
}


- (UILabel *)balanceTitleLabel{
    if (!_balanceTitleLabel) {
        _balanceTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width/2,CGRectGetMaxY(_allFinanceLabel.frame) + 60, self.width/2, 20)];
        _balanceTitleLabel.text = @"可用余额(元)";
        _balanceTitleLabel.textAlignment = NSTextAlignmentCenter;
        _balanceTitleLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
        _balanceTitleLabel.textColor = RGBA(51, 51, 51, 0.6);
    }
    return _balanceTitleLabel;
}

- (UILabel *)balanceLabel{
    if (!_balanceLabel) {
    _balanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width/2,CGRectGetMaxY(_balanceTitleLabel.frame) - 30, self.width/2, 20)];
//    _balanceLabel.text = @"38.00";
    _balanceLabel.textAlignment = NSTextAlignmentCenter;
    _balanceLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
    _balanceLabel.textColor = COR6;
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
        _topupButton.backgroundColor = RGB(255, 64, 79);
        [_topupButton setTitle:@"充值" forState:UIControlStateNormal];
        [_topupButton setTitleColor:COR15 forState:UIControlStateNormal];
        [_topupButton addTarget:self action:@selector(topupButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _topupButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
        _topupButton.layer.cornerRadius = kScrAdaptationW(4);
        _topupButton.layer.masksToBounds = YES;
        
    }
    return _topupButton;
}

- (UIButton *)withdrawButton{
    if (!_withdrawButton) {
        _withdrawButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width/2,0, self.width/2, 44)];
        _withdrawButton.backgroundColor = RGB(255, 247, 247);
        _withdrawButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
        [_withdrawButton setTitleColor:RGB(255, 64, 79) forState:UIControlStateNormal];
        [_withdrawButton setTitle:@"提现" forState:UIControlStateNormal];
        [_withdrawButton addTarget:self action:@selector(withdrawButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _withdrawButton.layer.borderWidth = 0.5;
        _withdrawButton.layer.borderColor = RGB(255, 133, 133).CGColor;
        _withdrawButton.layer.cornerRadius = kScrAdaptationW(4);
        _withdrawButton.layer.masksToBounds = YES;
    }
    return _withdrawButton;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(self.width/2, CGRectGetMaxY(_allFinanceLabel.frame) + 50, 0.5, CGRectGetMinY(_buttonView.frame) - CGRectGetMaxY(_allFinanceLabel.frame) - 60)];
        _lineView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    }
    return _lineView;
}



- (UIButton *)leftHeadButton{
    if (!_leftHeadButton) {
        _leftHeadButton = [[UIButton alloc]initWithFrame:CGRectMake(0, kScrAdaptationH(25), kScrAdaptationW(53), kScrAdaptationW(53))];
        [_leftHeadButton addTarget:self action:@selector(leftHeaderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *btnImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personal_center"]];
        btnImage.contentMode = UIViewContentModeScaleAspectFit;
        [_leftHeadButton addSubview:btnImage];
        [btnImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_leftHeadButton);
            make.width.height.offset(kScrAdaptationW(23));
        }];
    }
    return _leftHeadButton;
}

- (UIButton *)rightHeadButton{
    if (!_rightHeadButton) {
        _rightHeadButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 40 - 20, 40, 40, 40)];
        [_rightHeadButton setImage:[SVGKImage imageNamed:@"eye.svg"].UIImage forState:UIControlStateNormal];
        [_rightHeadButton setImage:[SVGKImage imageNamed:@"close_eye.svg"].UIImage forState:UIControlStateSelected];
        [_rightHeadButton addTarget:self action:@selector(rightHeadButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightHeadButton;
}
@end
