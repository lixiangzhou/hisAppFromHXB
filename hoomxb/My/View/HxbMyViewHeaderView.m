//
//  HxbMyViewHeaderView.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/4.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbMyViewHeaderView.h"
#import "SVGKit/SVGKImage.h"
#import "HXBMyRequestAccountModel.h"
@interface HxbMyViewHeaderView ()

@property (nonatomic, strong) UIImageView *backgroundImage;//背景图片
@property (nonatomic, strong) UILabel *allAssetsTitleLabel;
@property (nonatomic, strong) UILabel *allAssetsLabel;//总资产
//@property (nonatomic, strong) UILabel *holdingAssetsTitleLabel;
//@property (nonatomic, strong) UILabel *holdingAssetsLabel;//持有资产
@property (nonatomic, strong) UILabel *accumulatedProfitTitleLabel;
@property (nonatomic, strong) UILabel *accumulatedProfitLabel;//累计收益
@property (nonatomic, strong) UILabel *balanceTitleLabel;
@property (nonatomic, strong) UILabel *balanceLabel;//可用余额
@property (nonatomic, strong) UIView *buttonView;
@property (nonatomic, strong) UIButton *topupButton;
@property (nonatomic, strong) UIButton *withdrawButton;
@property (nonatomic, strong) UIImageView *topupImgV;
@property (nonatomic, strong) UIImageView *withdrawImgV;
@property (nonatomic, strong) UIView *lineView;
//@property (nonatomic, strong) UIView *buttonLineView;
@property (nonatomic, strong) UIButton *personalCenterButton;//个人中心
@property (nonatomic, strong) UIButton *securyButton;//加密
@property (nonatomic, assign) double allAssets;
//@property (nonatomic, strong) UIButton *allFinanceButton;
@property (nonatomic, strong) UIImageView *topupAndWithdrawBgImg;
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
        [self addSubview:self.allAssetsTitleLabel];
        [self addSubview:self.allAssetsLabel];
        [self addSubview:self.securyButton];
        [self addSubview:self.balanceTitleLabel];
        [self addSubview:self.balanceLabel];
        [self addSubview:self.accumulatedProfitTitleLabel];
        [self addSubview:self.accumulatedProfitLabel];
        [self addSubview:self.buttonView];
        [self addSubview:self.topupAndWithdrawBgImg];
        
        [self addSubview:self.topupImgV];
        [self addSubview:self.topupButton];
        [self addSubview:self.withdrawImgV];
        [self addSubview:self.withdrawButton];
        [self addSubview:self.lineView];
        
        [self addSubview:self.personalCenterButton];
       
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
        make.height.offset(kScrAdaptationH750(530));
    }];
    [self.allAssetsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW750(29));
        make.top.equalTo(self).offset(kScrAdaptationH750(156));
        make.height.equalTo(@kScrAdaptationH750(24));
        make.width.equalTo(@kScrAdaptationW750(160));
    }];
    [self.allAssetsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW750(30));
        make.top.equalTo(self).offset(kScrAdaptationH750(206));
        make.height.equalTo(@kScrAdaptationH750(80));
        make.width.equalTo(@kScrAdaptationW750(620));
    }];
    [self.securyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@kScrAdaptationW750(675));
        make.width.equalTo(@kScrAdaptationW750(45));
        make.centerY.equalTo(self.allAssetsLabel);
        make.height.offset(kScrAdaptationH750(100));
    }];
    [self.balanceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW750(30));
        make.width.equalTo(@kScrAdaptationW750(200));
        make.top.equalTo(self).offset(kScrAdaptationH750(340));
        make.height.equalTo(@kScrAdaptationH750(24));
    }];
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.balanceTitleLabel.mas_left);
        make.top.equalTo(self.balanceTitleLabel.mas_bottom).offset(kScrAdaptationH750(16));
        make.width.equalTo(@kScrAdaptationW750(280));
        make.height.equalTo(@kScrAdaptationH750(28));
    }];
    [self.accumulatedProfitTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@kScrAdaptationW750(346));
        make.width.equalTo(@kScrAdaptationW750(200));
        make.top.equalTo(@kScrAdaptationH750(339));
        make.height.equalTo(@kScrAdaptationH750(24));
    }];
    [self.accumulatedProfitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.accumulatedProfitTitleLabel.mas_left);
        make.top.equalTo(self.accumulatedProfitTitleLabel.mas_bottom).offset(kScrAdaptationH750(16));
        make.width.equalTo(@kScrAdaptationW750(280));
        make.height.equalTo(@kScrAdaptationH750(28));
    }];
    [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self);
        make.top.equalTo(self.backgroundImage.mas_bottom);
//        make.height.offset(kScrAdaptationH750(45));
        make.height.offset(kScrAdaptationH750(575+43-530));//575+72-530
    }];
    [self.topupAndWithdrawBgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW750(35));
        make.width.equalTo(@kScrAdaptationW750(680));
        make.top.equalTo(self.backgroundImage.mas_bottom).offset(kScrAdaptationH750(-(45+29)));
        make.height.offset(kScrAdaptationH750(29+43+90));
    }];
    [self.topupImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topupAndWithdrawBgImg).offset(kScrAdaptationH750(28+29));
        make.left.equalTo(self.topupAndWithdrawBgImg).offset(kScrAdaptationW750(100+35));
        make.height.equalTo(@kScrAdaptationH750(34));
        make.width.equalTo(@kScrAdaptationW750(80));
    }];
    [self.topupButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topupAndWithdrawBgImg).offset(kScrAdaptationH750(28+29));
        make.left.equalTo(self.topupAndWithdrawBgImg).offset(kScrAdaptationW750(167+35));
        make.height.equalTo(@kScrAdaptationH750(34));
        make.width.equalTo(@kScrAdaptationW750(120));
    }];
    [self.withdrawImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topupAndWithdrawBgImg).offset(kScrAdaptationH750(24+29));
        make.left.equalTo(self.topupAndWithdrawBgImg).offset(kScrAdaptationW750(377+35));
        make.height.equalTo(@kScrAdaptationH750(41));
        make.width.equalTo(@kScrAdaptationW750(80));
    }];
    [self.withdrawButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topupAndWithdrawBgImg).offset(kScrAdaptationH750(28+29));
        make.left.equalTo(self.topupAndWithdrawBgImg).offset(kScrAdaptationW750(446+35));
        make.height.equalTo(@kScrAdaptationH750(34));
        make.width.equalTo(@kScrAdaptationW750(130));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.withdrawImgV.mas_top);
        make.width.offset(0.5);
        make.height.offset(kScrAdaptationH750(40));
    }];
    
    
//    [self.holdingAssetsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self);
//        make.right.equalTo(self.lineView.mas_left);
//        make.top.equalTo(self).offset(kScrAdaptationH(93));
//        make.height.offset(kScrAdaptationH(33));
//    }];
//    [self.holdingAssetsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.holdingAssetsLabel);
//        make.top.equalTo(self.holdingAssetsLabel.mas_bottom);
//        make.height.offset(kScrAdaptationH(17));
//    }];

    
//    [self.balanceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.buttonView).offset(kScrAdaptationW(15));
//        make.top.equalTo(self.buttonView).offset(kScrAdaptationH(12));
//        make.height.offset(kScrAdaptationH(21));
//    }];
//    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.balanceTitleLabel.mas_left);
//        make.top.equalTo(self.balanceTitleLabel.mas_bottom).offset(kScrAdaptationH(10));
//    }];
    
    
}

- (void)clickAllFinanceButton: (UITapGestureRecognizer *)tap {
    if (self.clickAllFinanceButtonBlock) {
        self.clickAllFinanceButtonBlock((UILabel *)tap.view);
    }
}

/**
 设置数据

 @param accountInfoViewModel 数据模型
 */
- (void)setAccountInfoViewModel:(HXBMyRequestAccountModel *)accountInfoViewModel{
    _accountInfoViewModel = accountInfoViewModel;
    _allAssets = accountInfoViewModel.financePlanAssets;
    NSString *allAssetsStr = _allAssets? [NSString GetPerMilWithDouble:_allAssets]:@"0.00";
    
    NSString *accumulatedProfitStr = accountInfoViewModel.earnTotal? [NSString GetPerMilWithDouble:accountInfoViewModel.earnTotal]: @"0.00";
    
    NSString *balance = accountInfoViewModel.availablePoint ? [NSString GetPerMilWithDouble:accountInfoViewModel.availablePoint] : @"0.00";
    if ([KeyChain.ciphertext isEqualToString:@"0"])
    {
        self.securyButton.selected = NO;
        //        self.holdingAssetsLabel.text = allFinanceStr;
        self.accumulatedProfitLabel.text = accumulatedProfitStr;
        self.balanceLabel.text = balance;
        self.allAssetsLabel.text = allAssetsStr;
    }else
    {
        self.securyButton.selected = YES;
        //        self.holdingAssetsLabel.text = kSecuryText;
        self.accumulatedProfitLabel.text = kSecuryText;
        self.balanceLabel.text = kSecuryText;
        self.allAssetsLabel.text = kSecuryText;
    }
}

/*
- (void)setUserInfoViewModel:(HXBRequestUserInfoViewModel *)userInfoViewModel
{
    _userInfoViewModel = userInfoViewModel;
    _allAssets = [userInfoViewModel.userInfoModel.userAssets.assetsTotal doubleValue];
    NSString *allAssetsStr = _allAssets? [NSString GetPerMilWithDouble:_allAssets]:@"0.00";
    
    NSString *accumulatedProfitStr = userInfoViewModel.userInfoModel.userAssets.earnTotal.intValue? [NSString GetPerMilWithDouble:userInfoViewModel.userInfoModel.userAssets.earnTotal.doubleValue]: @"0.00";
    
    NSString *balance = userInfoViewModel.userInfoModel.userAssets.availablePoint.doubleValue ? [NSString GetPerMilWithDouble:userInfoViewModel.userInfoModel.userAssets.availablePoint.doubleValue] : @"0.00";
    if ([KeyChain.ciphertext isEqualToString:@"0"])
    {
        self.securyButton.selected = NO;
//        self.holdingAssetsLabel.text = allFinanceStr;
        self.accumulatedProfitLabel.text = accumulatedProfitStr;
        self.balanceLabel.text = balance;
        self.allAssetsLabel.text = allAssetsStr;
    }else
    {
        self.securyButton.selected = YES;
//        self.holdingAssetsLabel.text = kSecuryText;
        self.accumulatedProfitLabel.text = kSecuryText;
        self.balanceLabel.text = kSecuryText;
        self.allAssetsLabel.text = kSecuryText;
    }
}
*/

- (void)leftHeaderButtonClick:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(didClickLeftHeadBtn:)]) {
        [self.delegate didClickLeftHeadBtn:sender];
    }
}

- (void)securyButtonClick:(UIButton *)rightHeadBtn
{
//    NSString *allFinanceStr = [NSString GetPerMilWithDouble:_allAssets]?:@"0.00";
//    NSString *accumulatedProfitStr = [NSString GetPerMilWithDouble:[self.userInfoViewModel.userInfoModel.userAssets.earnTotal doubleValue]]?:@"0.00";
//    NSString *balance = [NSString GetPerMilWithDouble:[self.userInfoViewModel.userInfoModel.userAssets.availablePoint doubleValue]]?:@"0.00";
    
    NSString *allAssetsStr = _allAssets? [NSString GetPerMilWithDouble:_allAssets]:@"0.00";
    NSString *accumulatedProfitStr = _accountInfoViewModel.earnTotal? [NSString GetPerMilWithDouble:_accountInfoViewModel.earnTotal]: @"0.00";
    NSString *balance = _accountInfoViewModel.availablePoint ? [NSString GetPerMilWithDouble:_accountInfoViewModel.availablePoint] : @"0.00";
    
    if ([KeyChain.ciphertext isEqualToString:@"0"]){
        KeyChain.ciphertext = @"1";
        self.securyButton.selected = YES;
//        self.holdingAssetsLabel.text = kSecuryText;
        self.accumulatedProfitLabel.text = kSecuryText;
        self.balanceLabel.text = kSecuryText;
        self.allAssetsLabel.text = kSecuryText;
    }else
    {
        KeyChain.ciphertext = @"0";
        self.securyButton.selected = NO;
//        self.holdingAssetsLabel.text = allFinanceStr;
        self.accumulatedProfitLabel.text = accumulatedProfitStr;
        self.balanceLabel.text = balance;
        self.allAssetsLabel.text = allAssetsStr;
    }
}


- (void)topupButtonClick:(id)sender{
    kWeakSelf
    UIButton *tmpBtn = nil;
    if (!sender||sender!=_topupButton) {
        tmpBtn = weakSelf.topupButton;
    }else{
        tmpBtn = (UIButton *)sender;
    }
    if ([self.delegate respondsToSelector:@selector(didClickTopUpBtn:)]) {
        [self.delegate didClickTopUpBtn:tmpBtn];
    }
}

- (void)withdrawButtonClick:(id)sender{
    kWeakSelf
    UIButton *tmpBtn = nil;
    if (!sender||sender!=_withdrawButton) {
        tmpBtn = weakSelf.withdrawButton;
    }else{
        tmpBtn = (UIButton *)sender;
    }
    if ([self.delegate respondsToSelector:@selector(didClickWithdrawBtn:)]) {
        [self.delegate didClickWithdrawBtn:tmpBtn];
    }
}

#pragma mark - 懒加载
- (UIImageView *)backgroundImage
{
    if (!_backgroundImage) {
        _backgroundImage =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top"]];
        _backgroundImage.userInteractionEnabled = YES;
    }
    return _backgroundImage;
}

//- (UILabel *)holdingAssetsLabel{
//    if (!_holdingAssetsLabel) {
//        _holdingAssetsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height/2 - 60, self.width, 40)];
////        _holdingAssetsLabel.text = @"38.00";
//        _holdingAssetsLabel.textAlignment = NSTextAlignmentCenter;
//        _holdingAssetsLabel.font = kHXBFont_PINGFANGSC_REGULAR(24);
//        _holdingAssetsLabel.textColor = COR15;
//        _holdingAssetsLabel.text = @"--";
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAllFinanceButton:)];
//        [_holdingAssetsLabel addGestureRecognizer:tap];
//        _holdingAssetsLabel.userInteractionEnabled = true;
//    }
//    return _holdingAssetsLabel;
//}

//[UILabel alloc]initWithFrame:CGRectMake(kScrAdaptationW750(<#W#>), kScrAdaptationH750(<#H#>), kScrAdaptationW750(<#W#>), kScrAdaptationH750(<#H#>));

- (UILabel *)allAssetsLabel{
    if (!_allAssetsLabel) {
        _allAssetsLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScrAdaptationW750(30), kScrAdaptationH750(206), kScrAdaptationW750(620), kScrAdaptationH750(80))];
        _allAssetsLabel.text = @"--";
        _allAssetsLabel.textAlignment = NSTextAlignmentLeft;
        _allAssetsLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(80);
        _allAssetsLabel.textColor = COR15;
    }
    return _allAssetsLabel;
}

- (UILabel *)allAssetsTitleLabel{
    if (!_allAssetsTitleLabel) {
        _allAssetsTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScrAdaptationW750(29), kScrAdaptationH750(156), self.width/2, kScrAdaptationH750(24))];
        _allAssetsTitleLabel.text = @"持有资产(元)";
        _allAssetsTitleLabel.textAlignment = NSTextAlignmentLeft;
        _allAssetsTitleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        _allAssetsTitleLabel.textColor = COR27;
    }
    return _allAssetsTitleLabel;
}

//- (UILabel *)holdingAssetsTitleLabel{
//    if (!_holdingAssetsTitleLabel) {
//        _holdingAssetsTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width/2, 40)];
//        _holdingAssetsTitleLabel.text = @"持有资产(元)";
//        _holdingAssetsTitleLabel.center = CGPointMake(self.width/2, 60);
//        _holdingAssetsTitleLabel.textAlignment = NSTextAlignmentLeft;
//        _holdingAssetsTitleLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
//        _holdingAssetsTitleLabel.textColor = COR27;
//    }
//    return _holdingAssetsTitleLabel;
//}

- (UILabel *)accumulatedProfitTitleLabel{
    if (!_accumulatedProfitTitleLabel) {
        _accumulatedProfitTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScrAdaptationW750(346),kScrAdaptationH750(339), kScrAdaptationW750(200), kScrAdaptationH750(24))];
        _accumulatedProfitTitleLabel.text = @"累计收益(元)";
        _accumulatedProfitTitleLabel.textAlignment = NSTextAlignmentLeft;
        _accumulatedProfitTitleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        _accumulatedProfitTitleLabel.textColor = COR27;
    }
    return _accumulatedProfitTitleLabel;
}

- (UILabel *)accumulatedProfitLabel{
    if (!_accumulatedProfitLabel) {
        _accumulatedProfitLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScrAdaptationW750(346),kScrAdaptationH750(380), kScrAdaptationW750(280), kScrAdaptationH750(28))];
        _accumulatedProfitLabel.text = @"--";
//        _accumulatedProfitLabel.text = @"30.8";
        _accumulatedProfitLabel.textAlignment = NSTextAlignmentLeft;
        _accumulatedProfitLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(32);
        _accumulatedProfitLabel.textColor = COR15;
    }
    return _accumulatedProfitLabel;
}


- (UILabel *)balanceTitleLabel{
    if (!_balanceTitleLabel) {
        _balanceTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScrAdaptationW750(30),kScrAdaptationH750(340),kScrAdaptationH750(200), kScrAdaptationH750(24))];
        _balanceTitleLabel.text = @"可用金额(元)";
        _balanceTitleLabel.textAlignment = NSTextAlignmentLeft;
        _balanceTitleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        _balanceTitleLabel.textColor = COR27;
    }
    return _balanceTitleLabel;
}

- (UILabel *)balanceLabel{
    if (!_balanceLabel) {
    _balanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScrAdaptationW750(30),kScrAdaptationH750(380), kScrAdaptationW750(280), kScrAdaptationH750(28))];
//    _balanceLabel.text = @"38.00";
        _balanceLabel.text = @"--";
    _balanceLabel.textAlignment = NSTextAlignmentLeft;
    _balanceLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(32);
    _balanceLabel.textColor = COR15;
 }
    return _balanceLabel;

}

- (UIView *)buttonView{
    if (!_buttonView) {
        _buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame) - (45+43), self.width, 45+43)];
        _buttonView.backgroundColor = [UIColor whiteColor];
    }
    return _buttonView;
}

- (UIImageView *)topupAndWithdrawBgImg{
    if (!_topupAndWithdrawBgImg) {
        _topupAndWithdrawBgImg = [[UIImageView alloc]initWithFrame:CGRectMake(kScrAdaptationW750(35), kScrAdaptationH750(486-29), kScrAdaptationW750(680), kScrAdaptationH750(162))];
        _topupAndWithdrawBgImg.image = [UIImage imageNamed:@"my_topupAndWithdrawBgImg"];
        _topupAndWithdrawBgImg.userInteractionEnabled = YES;
    }
    return _topupAndWithdrawBgImg;
}

- (UIImageView *)topupImgV{
    if (!_topupImgV) {
        _topupImgV = [[UIImageView alloc]initWithFrame:CGRectMake(kScrAdaptationW750(100+70), kScrAdaptationH750(514), kScrAdaptationW750(80), kScrAdaptationH750(34))];
        _topupImgV.image = [UIImage imageNamed:@"my_topup"];
        _topupImgV.contentMode = UIViewContentModeScaleAspectFit;
        _topupImgV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topupButtonClick:)];
        [_topupImgV addGestureRecognizer:tap];
    }
    return _topupImgV;
}

- (UIButton *)topupButton{
    if (!_topupButton) {
        _topupButton = [[UIButton alloc]initWithFrame:CGRectMake(kScrAdaptationW750(167+70),kScrAdaptationH750(514),kScrAdaptationW750(120),kScrAdaptationH750(34))];
        [_topupButton setTitle:@"充值" forState:UIControlStateNormal];
//        [_topupButton setImage:[UIImage imageNamed:@"my_topup"] forState:UIControlStateNormal];
        [_topupButton setTitleColor:RGB(255, 64, 79) forState:UIControlStateNormal];
        [_topupButton addTarget:self action:@selector(topupButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _topupButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(32);
    }
    return _topupButton;
}

- (UIImageView *)withdrawImgV{
    if (!_withdrawImgV) {
        _withdrawImgV = [[UIImageView alloc]initWithFrame:CGRectMake(kScrAdaptationW750(447+70), kScrAdaptationH750(510), kScrAdaptationW750(80), kScrAdaptationH750(41))];
        _withdrawImgV.contentMode = UIViewContentModeScaleAspectFit;
        _withdrawImgV.image = [UIImage imageNamed:@"my_withdraw"];
        _withdrawImgV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(withdrawButtonClick:)];
        [_withdrawImgV addGestureRecognizer:tap];
    }
    return _withdrawImgV;
}

- (UIButton *)withdrawButton{
    if (!_withdrawButton) {
        _withdrawButton = [[UIButton alloc]initWithFrame:CGRectMake(kScrAdaptationW750(446+70),kScrAdaptationH750(514),kScrAdaptationW750(130),kScrAdaptationH750(34))];
        [_withdrawButton setTitleColor:RGB(255, 64, 79) forState:UIControlStateNormal];
        [_withdrawButton setTitle:@"提现" forState:UIControlStateNormal];
        _withdrawButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(32);
        [_withdrawButton addTarget:self action:@selector(withdrawButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _withdrawButton;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(kScrAdaptationW750(375), kScrAdaptationH750(486+25), 0.5, kScrAdaptationH750(40))];
        _lineView.backgroundColor = RGBA(245, 81, 81, 1);
    }
    return _lineView;
}



- (UIButton *)personalCenterButton{
    if (!_personalCenterButton) {
        _personalCenterButton = [[UIButton alloc]initWithFrame:CGRectMake(0, kScrAdaptationH(20), kScrAdaptationW(53), kScrAdaptationW(53))];
        [_personalCenterButton addTarget:self action:@selector(leftHeaderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *btnImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personal_center"]];
        btnImage.contentMode = UIViewContentModeScaleAspectFit;
        [_personalCenterButton addSubview:btnImage];
        [btnImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_personalCenterButton);
            make.width.height.offset(kScrAdaptationW(23));
        }];
    }
    return _personalCenterButton;
}

- (UIButton *)securyButton{
    if (!_securyButton) {
        _securyButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 40 - 20, 40, 40, 40)];
        [_securyButton setImage:[UIImage imageNamed:@"my_eyes"] forState:UIControlStateNormal];
        [_securyButton setImage:[UIImage imageNamed:@"my_closedEyes"] forState:UIControlStateSelected];
        _securyButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_securyButton addTarget:self action:@selector(securyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _securyButton;
}
@end
