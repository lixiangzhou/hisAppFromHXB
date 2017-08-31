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
#import "HXBRequestUserInfo.h"

#import "HXBBaseTabBarController.h"

#import "SVGKImage.h"


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
@property (nonatomic, strong) UIView *lineView;

/**
 是否显示密文的按钮
 */
@property (nonatomic, strong) UIButton *eyeButton;


@property (nonatomic, strong) HXBRequestUserInfoViewModel *userInfoViewModel;

@end

@implementation HXBHomePageLoginIndicationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.lineView];
        [self addSubview:self.allProfitLabel];
        [self addSubview:self.allProfitTitleLabel];
        [self addSubview:self.availableAmountLabel];
        [self addSubview:self.availableAmountTitleLabel];
        [self addSubview:self.eyeButton];
        [self setupSubViewFrame];
        [self loadNewDate];
        
    }
    return self;
}

#pragma mark Action Methods
- (void)setupSubViewFrame{
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(kScrAdaptationH(73));
        make.width.offset(0.5);
        make.height.offset(kScrAdaptationH(30));
    }];
    [self.allProfitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self.lineView.mas_left);
        make.top.equalTo(self).offset(kScrAdaptationH(60));
        make.height.offset(kScrAdaptationH(33));
    }];
    [self.allProfitTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.allProfitLabel);
        make.top.equalTo(self.allProfitLabel.mas_bottom);
        make.height.offset(kScrAdaptationH(17));
    }];
    [self.eyeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.allProfitTitleLabel.mas_right).offset(kScrAdaptationW(5));
        make.centerY.equalTo(self.allProfitTitleLabel);
        make.height.width.offset(kScrAdaptationH(15));
    }];
    [self.availableAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineView.mas_right);
        make.right.equalTo(self);
        make.centerY.equalTo(self.allProfitLabel);
        make.height.offset(kScrAdaptationH(33));
    }];
    [self.availableAmountTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.availableAmountLabel);
        make.top.equalTo(self.availableAmountLabel.mas_bottom);
        make.height.offset(kScrAdaptationH(17));
        
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
- (void)loadNewDate
{
    kWeakSelf
    [HXBRequestUserInfo downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        if ([KeyChain.ciphertext isEqualToString:@"0"]) {
            weakSelf.eyeButton.selected = NO;
            weakSelf.availableAmountLabel.text = [NSString GetPerMilWithDouble:viewModel.userInfoModel.userAssets.availablePoint.doubleValue];
            weakSelf.allProfitLabel.text = [NSString GetPerMilWithDouble:viewModel.userInfoModel.userAssets.earnTotal.doubleValue];
        } else {
            weakSelf.eyeButton.selected = YES;
            if (viewModel.userInfoModel.userAssets.availablePoint.length > 0) {
                weakSelf.availableAmountLabel.text = [viewModel.userInfoModel.userAssets.availablePoint replaceStringWithStartLocation:0 lenght:viewModel.userInfoModel.userAssets.availablePoint.length?:1];
                weakSelf.allProfitLabel.text = [viewModel.userInfoModel.userAssets.earnTotal replaceStringWithStartLocation:0 lenght:viewModel.userInfoModel.userAssets.earnTotal.length?:1];
            }
        }
        weakSelf.userInfoViewModel = viewModel;
    } andFailure:^(NSError *error) {
        
    }];
}

/**
 点击隐藏金钱
 */
- (void)ciphertextButtonClick
{
    if ([KeyChain.ciphertext isEqualToString:@"0"]) {
        KeyChain.ciphertext = @"1";
        self.eyeButton.selected = YES;
        self.allProfitLabel.text = [self.allProfitLabel.text replaceStringWithStartLocation:0 lenght:[NSString GetPerMilWithDouble:self.userInfoViewModel.userInfoModel.userAssets.earnTotal.doubleValue].length?:1];
        self.availableAmountLabel.text = [self.availableAmountLabel.text replaceStringWithStartLocation:0 lenght:[NSString GetPerMilWithDouble:self.userInfoViewModel.userInfoModel.userAssets.availablePoint.doubleValue].length?:1];
    } else {
        KeyChain.ciphertext = @"0";
        self.eyeButton.selected = NO;
        self.availableAmountLabel.text = [NSString GetPerMilWithDouble:self.userInfoViewModel.userInfoModel.userAssets.availablePoint.doubleValue];
        self.allProfitLabel.text = [NSString GetPerMilWithDouble:self.userInfoViewModel.userInfoModel.userAssets.earnTotal.doubleValue];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    HXBBaseTabBarController *tabBarController = (HXBBaseTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    tabBarController.selectedIndex = 2;
}

#pragma mark Get Methdos
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(self.width/2, kScrAdaptationH(50), 0.5, 40)];
        _lineView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    }
    return _lineView;
}

- (UILabel *)allProfitLabel{
    if (!_allProfitLabel) {
        _allProfitLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height/2 - 60, self.width, 40)];
        _allProfitLabel.textAlignment = NSTextAlignmentCenter;
        _allProfitLabel.font = kHXBFont_PINGFANGSC_REGULAR(20);
        _allProfitLabel.textColor = COR15;
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
        _allProfitTitleLabel.textColor = COR27;
    }
    return _allProfitTitleLabel;
}

- (UILabel *)availableAmountTitleLabel{
    if (!_availableAmountTitleLabel) {
        _availableAmountTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_allProfitLabel.frame) + 60, self.width/2, 20)];
        _availableAmountTitleLabel.text = @"可用金额(元)";
        _availableAmountTitleLabel.textAlignment = NSTextAlignmentCenter;
        _availableAmountTitleLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _availableAmountTitleLabel.textColor = COR27;
    }
    return _availableAmountTitleLabel;
}

- (UILabel *)availableAmountLabel{
    if (!_availableAmountLabel) {
        _availableAmountLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_allProfitTitleLabel.frame) + 30, self.width/2, 20)];
        _availableAmountLabel.textAlignment = NSTextAlignmentCenter;
        _availableAmountLabel.font = kHXBFont_PINGFANGSC_REGULAR(20);
        _availableAmountLabel.textColor = COR15;
    }
    return _availableAmountLabel;
}

- (UIButton *)eyeButton{
    if (!_eyeButton) {
        _eyeButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 40 - 20, 40, 40, 40)];
        [_eyeButton setImage:[SVGKImage imageNamed:@"eye.svg"].UIImage forState:UIControlStateNormal];
        [_eyeButton setImage:[SVGKImage imageNamed:@"close_eye.svg"].UIImage forState:UIControlStateSelected];
        [_eyeButton addTarget:self action:@selector(ciphertextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _eyeButton;
}

@end
