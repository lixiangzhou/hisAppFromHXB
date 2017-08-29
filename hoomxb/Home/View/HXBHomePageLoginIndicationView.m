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
#import "HXB_XYTools.h"

static CGFloat const xyWidth = 8.0f;

@interface HXBHomePageLoginIndicationView ()


/**
 累计收益金额
 */
@property (nonatomic, strong) UILabel *accumulatedLabel;
/**
 可用金额
 */
@property (nonatomic, strong) UILabel *availableLabel;

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
@property (nonatomic, assign) CGFloat availableWidth;


@property (nonatomic, strong) HXBRequestUserInfoViewModel *userInfoViewModel;

@end

@implementation HXBHomePageLoginIndicationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.accumulatedIncomeLabel];
        [self addSubview:self.availableAmountLabel];
        [self addSubview:self.accumulatedLabel];
        [self addSubview:self.availableLabel];
        [self addSubview:self.ciphertextButton];
        
        [self setupSubViewFrame];
        [self loadNewDate];
        
    }
    return self;
}

#pragma mark Action Methods
- (void)setupSubViewFrame{
    
    [self.accumulatedIncomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(-kScreenWidth / 2);
        make.top.equalTo(self).offset(kScrAdaptationH(60));
    }];
    [self.availableAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(-kScreenWidth / 2);
        make.top.equalTo(self.accumulatedIncomeLabel).offset(kScrAdaptationH(30));
    }];
    
    [self.accumulatedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScreenWidth / 2 + 5);
        make.right.equalTo(self);
        make.top.equalTo(self).offset(kScrAdaptationH(60));
    }];
    [self.availableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScreenWidth / 2 + 5);
        make.right.equalTo(self);
        make.top.equalTo(self.accumulatedIncomeLabel).offset(kScrAdaptationH(30));
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
            weakSelf.ciphertextButton.selected = NO;
            weakSelf.availableLabel.text = viewModel.userInfoModel.userAssets.availablePoint;
            [self.ciphertextButton mas_makeConstraints:^(MASConstraintMaker *make) {
                _availableWidth = [HXB_XYTools WidthWithString:weakSelf.availableLabel.text labelFont:kHXBFont_PINGFANGSC_REGULAR(15.0f) addWidth:xyWidth];
                make.left.equalTo(self).offset(kScreenWidth / 2 + _availableWidth + 2);
                make.centerY.equalTo(self.availableLabel);
                make.size.mas_equalTo(CGSizeMake(kScrAdaptationH(25), kScrAdaptationH(25)));
            }];
            weakSelf.accumulatedLabel.text = viewModel.userInfoModel.userAssets.earnTotal;
        }else
        {
            weakSelf.ciphertextButton.selected = YES;
            if (viewModel.userInfoModel.userAssets.availablePoint.length > 0) {
                weakSelf.availableLabel.text = [viewModel.userInfoModel.userAssets.availablePoint replaceStringWithStartLocation:0 lenght:viewModel.userInfoModel.userAssets.availablePoint.length?:1];
                [self.ciphertextButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    _availableWidth = [HXB_XYTools WidthWithString:weakSelf.availableLabel.text labelFont:kHXBFont_PINGFANGSC_REGULAR(15.0f) addWidth:xyWidth];
                    make.left.equalTo(self).offset(kScreenWidth / 2 + _availableWidth + 2);
                    make.centerY.equalTo(self.availableLabel);
                    make.size.mas_equalTo(CGSizeMake(kScrAdaptationH(25), kScrAdaptationH(25)));
                }];
                weakSelf.accumulatedLabel.text = [viewModel.userInfoModel.userAssets.earnTotal replaceStringWithStartLocation:0 lenght:viewModel.userInfoModel.userAssets.earnTotal.length?:1];
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
        self.ciphertextButton.selected = YES;
        self.accumulatedLabel.text = [self.accumulatedLabel.text replaceStringWithStartLocation:0 lenght:self.userInfoViewModel.userInfoModel.userAssets.earnTotal.length?:1];
        self.availableLabel.text = [self.availableLabel.text replaceStringWithStartLocation:0 lenght:self.userInfoViewModel.userInfoModel.userAssets.availablePoint.length?:1];
        [self.ciphertextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            _availableWidth = [HXB_XYTools WidthWithString:self.availableLabel.text labelFont:kHXBFont_PINGFANGSC_REGULAR(15.0f) addWidth:xyWidth];
            make.left.equalTo(self).offset(kScreenWidth / 2 + _availableWidth + 2);
            make.centerY.equalTo(self.availableLabel);
            make.size.mas_equalTo(CGSizeMake(kScrAdaptationH(25), kScrAdaptationH(25)));
        }];
        _availableWidth = [HXB_XYTools WidthWithString:self.availableLabel.text labelFont:kHXBFont_PINGFANGSC_REGULAR(15.0f) addWidth:xyWidth];
    } else {
        KeyChain.ciphertext = @"0";
        self.ciphertextButton.selected = NO;
        self.availableLabel.text = self.userInfoViewModel.userInfoModel.userAssets.availablePoint;
        [self.ciphertextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            _availableWidth = [HXB_XYTools WidthWithString:self.availableLabel.text labelFont:kHXBFont_PINGFANGSC_REGULAR(15.0f) addWidth:xyWidth];
            make.left.equalTo(self).offset(kScreenWidth / 2 + _availableWidth + 5);
            make.centerY.equalTo(self.availableLabel);
            make.size.mas_equalTo(CGSizeMake(kScrAdaptationH(25), kScrAdaptationH(25)));
        }];
        self.accumulatedLabel.text = self.userInfoViewModel.userInfoModel.userAssets.earnTotal;
        
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    HXBBaseTabBarController *tabBarController = (HXBBaseTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    tabBarController.selectedIndex = 2;
}

#pragma mark Get Methdos

- (UILabel *)accumulatedLabel
{
    if (!_accumulatedLabel) {
        _accumulatedLabel = [[UILabel alloc] init];
        _accumulatedLabel.textAlignment = NSTextAlignmentLeft;
        _accumulatedLabel.font = kHXBFont_PINGFANGSC_REGULAR(17.0f);
        _accumulatedLabel.textColor = [UIColor whiteColor];
    }
    return _accumulatedLabel;
}
- (UILabel *)availableLabel
{
    if (!_availableLabel) {
        _availableLabel = [[UILabel alloc] init];
        _availableLabel.textAlignment = NSTextAlignmentLeft;
        _availableLabel.font = kHXBFont_PINGFANGSC_REGULAR(15.0f);
        _availableLabel.textColor = [UIColor whiteColor];
    }
    return _availableLabel;
}


- (UILabel *)accumulatedIncomeLabel
{
    if (!_accumulatedIncomeLabel) {
        _accumulatedIncomeLabel = [[UILabel alloc] init];
        _accumulatedIncomeLabel.text = @"累计收益 (元) : ";
        _accumulatedIncomeLabel.font = kHXBFont_PINGFANGSC_REGULAR(17.0f);
        _accumulatedIncomeLabel.textColor = [UIColor whiteColor];
        _accumulatedIncomeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _accumulatedIncomeLabel;
}

- (UILabel *)availableAmountLabel
{
    if (!_availableAmountLabel) {
        _availableAmountLabel = [[UILabel alloc] init];
        _availableAmountLabel.text = @"可用金额 (元) : ";
        _availableAmountLabel.font = kHXBFont_PINGFANGSC_REGULAR(15.0f);
        _availableAmountLabel.textColor = [UIColor whiteColor];
        _availableAmountLabel.textAlignment = NSTextAlignmentRight;
    }
    return _availableAmountLabel;
}
- (UIButton *)ciphertextButton
{
    if (!_ciphertextButton) {
        _ciphertextButton = [[UIButton alloc] init];
        [_ciphertextButton setImage:[SVGKImage imageNamed:@"eye.svg"].UIImage forState:UIControlStateNormal];
        [_ciphertextButton setImage:[SVGKImage imageNamed:@"close_eye.svg"].UIImage forState:UIControlStateSelected];
        [_ciphertextButton addTarget:self action:@selector(ciphertextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ciphertextButton;
}
@end
