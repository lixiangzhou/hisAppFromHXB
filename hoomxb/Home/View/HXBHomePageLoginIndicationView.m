//
//  HXBHomePageLoginIndicationView.m
//  HongXiaoBao
//
//  Created by 牛严 on 16/7/11.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#define kEyesImageViewWith kScrAdaptationW(17)
#define kEyesImageViewHeight kScrAdaptationH(10)
#define kEyesButtonSize kScrAdaptationW(50)

#import "HXBHomePageLoginIndicationView.h"
#import "HxbHomeViewController.h"
#import "UILabel+Util.h"
#import "HXBRequestUserInfo.h"
#import "HXBBaseTabBarController.h"


@interface HXBHomePageLoginIndicationView ()


/**
 累计收益金额
 */
@property (nonatomic, strong) UILabel *allProfitLabel;
/**
 累计收益
 */
@property (nonatomic, strong) UILabel *allProfitTitleLabel;
/**
 可用金额
 */
@property (nonatomic, strong) UILabel *availableAmountLabel;
/**
 可用金额
 */
@property (nonatomic, strong) UILabel *availableAmountTitleLabel;
/**
 持有资产-标题
 */
@property (nonatomic, strong) UILabel *assetsTitleLabel;

/**
 持有资产
 */
@property (nonatomic, strong) UILabel *assetsLabel;

/**
 是否显示密文的按钮
 */
@property (nonatomic, strong) UIButton *eyeButton;



@end

@implementation HXBHomePageLoginIndicationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.allProfitLabel];
        [self addSubview:self.allProfitTitleLabel];
        [self addSubview:self.assetsTitleLabel];
        [self addSubview:self.assetsLabel];
        [self addSubview:self.availableAmountLabel];
        [self addSubview:self.availableAmountTitleLabel];
        [self addSubview:self.eyeButton];
        [self setupSubViewFrame];
        
    }
    return self;
}

#pragma mark Action Methods
- (void)setupSubViewFrame{
    
    [self.allProfitTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW(15));
        make.top.equalTo(self).offset(kScrAdaptationH(40));
        make.height.offset(kScrAdaptationH(15));
    }];
    
    [self.allProfitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.allProfitTitleLabel);
        make.top.equalTo(self.allProfitTitleLabel.mas_bottom).offset(kScrAdaptationH(10));
        make.height.offset(kScrAdaptationH(30));
    }];
    
    [self.assetsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.allProfitTitleLabel);
        make.top.equalTo(self.allProfitLabel.mas_bottom).offset(kScrAdaptationH(17.5));
        make.height.offset(kScrAdaptationH(15));
    }];
    
    [self.assetsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.assetsTitleLabel.mas_right).offset(kScrAdaptationW(10));
        make.centerY.equalTo(self.assetsTitleLabel);
        make.height.offset(kScrAdaptationH(15));
    }];
    
    [self.availableAmountTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.assetsTitleLabel);
        make.left.equalTo(self.mas_centerX);
        make.height.offset(kScrAdaptationH(15));
    }];
    
    [self.availableAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.availableAmountTitleLabel.mas_right).offset(kScrAdaptationW(10));
        make.centerY.equalTo(self.assetsTitleLabel);
        make.height.offset(kScrAdaptationH(15));
    }];
    
    [self.eyeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.allProfitLabel.mas_right).offset(kScrAdaptationW(6));
        make.centerY.equalTo(self.allProfitLabel);
        make.height.offset(kEyesButtonSize);
        make.width.offset(kEyesButtonSize);
    }];

}

#pragma mark Set Methdos
- (void)setUserInfoViewModel:(HXBRequestUserInfoViewModel *)userInfoViewModel {
    _userInfoViewModel = userInfoViewModel;
    [self loadNewDate:userInfoViewModel];
}


- (void)loadNewDate:(HXBRequestUserInfoViewModel *)viewModel
{
    if ([KeyChain.ciphertext isEqualToString:@"0"]) {
        self.eyeButton.selected = NO;
        if ([viewModel.userInfoModel.userAssets.availablePoint isEqualToString:HXBIdentifier]) {
            NSString *noDataText = @"--";
            self.availableAmountLabel.text = noDataText;
            self.allProfitLabel.text = noDataText;
            self.assetsLabel.text = noDataText;
        } else {
            self.availableAmountLabel.text = [NSString GetPerMilWithDouble:viewModel.userInfoModel.userAssets.availablePoint.doubleValue];
            self.allProfitLabel.text = [NSString GetPerMilWithDouble:viewModel.userInfoModel.userAssets.earnTotal.doubleValue];
            self.assetsLabel.text = [NSString GetPerMilWithDouble:viewModel.userInfoModel.userAssets.holdingTotalAssets.doubleValue];
        }
        
    } else {
        self.eyeButton.selected = YES;
        if (viewModel.userInfoModel.userAssets.availablePoint.length > 0) {
            self.availableAmountLabel.text = kSecuryText;
            self.allProfitLabel.text = kSecuryText;
            self.assetsLabel.text = kSecuryText;
        }
    }
}

/**
 点击隐藏金钱
 */
- (void)ciphertextButtonClick
{
    if ([KeyChain.ciphertext isEqualToString:@"0"]) {
        KeyChain.ciphertext = @"1";
        self.eyeButton.selected = YES;
        self.allProfitLabel.text = kSecuryText;
        self.availableAmountLabel.text = kSecuryText;
        self.assetsLabel.text = kSecuryText;
    } else {
        KeyChain.ciphertext = @"0";
        self.eyeButton.selected = NO;
        self.availableAmountLabel.text = [NSString GetPerMilWithDouble:self.userInfoViewModel.userInfoModel.userAssets.availablePoint.doubleValue];
        self.allProfitLabel.text = [NSString GetPerMilWithDouble:self.userInfoViewModel.userInfoModel.userAssets.earnTotal.doubleValue];
        double allAssets = self.userInfoViewModel.userInfoModel.userAssets.lenderPrincipal.doubleValue + self.userInfoViewModel.userInfoModel.userAssets.financePlanAssets.doubleValue;
        self.assetsLabel.text = [NSString stringWithFormat:@"%0.2lf",allAssets];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    HXBBaseTabBarController *tabBarController = (HXBBaseTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    tabBarController.selectedIndex = 2;
}


#pragma mark Get Methdos

- (UILabel *)allProfitLabel{
    if (!_allProfitLabel) {
        _allProfitLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height/2 - 60, self.width, 40)];
        _allProfitLabel.textAlignment = NSTextAlignmentCenter;
        _allProfitLabel.text = @"--";
        _allProfitLabel.font = kHXBFont_PINGFANGSC_REGULAR(24);
        _allProfitLabel.textColor = [UIColor blackColor];
    }
    return _allProfitLabel;
}

- (UILabel *)allProfitTitleLabel{
    if (!_allProfitTitleLabel) {
        _allProfitTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width/2, 40)];
        _allProfitTitleLabel.text = @"累计收益(元)";
        _allProfitTitleLabel.center = CGPointMake(self.width/2, 60);
        _allProfitTitleLabel.textAlignment = NSTextAlignmentCenter;
        _allProfitTitleLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _allProfitTitleLabel.textColor = COR10;
    }
    return _allProfitTitleLabel;
}

- (UILabel *)availableAmountTitleLabel{
    if (!_availableAmountTitleLabel) {
        _availableAmountTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_allProfitLabel.frame) + 60, self.width/2, 20)];
        _availableAmountTitleLabel.text = @"可用金额(元)";
        _availableAmountTitleLabel.textAlignment = NSTextAlignmentCenter;
        _availableAmountTitleLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _availableAmountTitleLabel.textColor = COR10;
    }
    return _availableAmountTitleLabel;
}

- (UILabel *)availableAmountLabel{
    if (!_availableAmountLabel) {
        _availableAmountLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_allProfitTitleLabel.frame) + 30, self.width/2, 20)];
        _availableAmountLabel.text = @"--";
        _availableAmountLabel.textAlignment = NSTextAlignmentCenter;
        _availableAmountLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _availableAmountLabel.textColor = [UIColor blackColor];
    }
    return _availableAmountLabel;
}

- (UILabel *)assetsTitleLabel {
    if (!_assetsTitleLabel) {
        _assetsTitleLabel = [[UILabel alloc] init];
        _assetsTitleLabel.text = @"持有资产(元)";
        _assetsTitleLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _assetsTitleLabel.textColor = COR10;
    }
    return _assetsTitleLabel;
}

- (UILabel *)assetsLabel {
    if (!_assetsLabel) {
        _assetsLabel = [[UILabel alloc] init];
        _assetsLabel.text = @"--";
        _assetsLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _assetsLabel.textColor = [UIColor blackColor];
    }
    return _assetsLabel;
}

- (UIButton *)eyeButton{
    if (!_eyeButton) {
        _eyeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_eyeButton setImage:[UIImage imageNamed:@"Home_eyes"] forState:UIControlStateNormal];
        [_eyeButton setImage:[UIImage imageNamed:@"Home_close_eye"] forState:UIControlStateSelected];
        [_eyeButton addTarget:self action:@selector(ciphertextButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _eyeButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        CGFloat topMargin = (kEyesButtonSize - kEyesImageViewHeight) / 2.0;
        CGFloat rightMargin = kEyesButtonSize - kEyesImageViewWith;
        _eyeButton.imageEdgeInsets =UIEdgeInsetsMake(topMargin, 0, topMargin, rightMargin);
        [self bringSubviewToFront:_eyeButton];
    }
    return _eyeButton;
}

@end
