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

@property (nonatomic, strong) HXBRequestUserInfoViewModel *userInfoViewModel;

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
        
        [self loadNewDate];
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
- (void)loadNewDate
{
    kWeakSelf
    [HXBRequestUserInfo downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        if ([KeyChain.ciphertext isEqualToString:@"0"]) {
            weakSelf.ciphertextButton.selected = NO;
            weakSelf.availableAmountLabel.text = [NSString stringWithFormat:@"可用金额(元):%@",viewModel.userInfoModel.userAssets.availablePoint];
            weakSelf.accumulatedIncomeLabel.text = [NSString stringWithFormat:@"累计收益(元):%@",viewModel.userInfoModel.userAssets.earnTotal];
        }else
        {
            weakSelf.ciphertextButton.selected = YES;
            weakSelf.availableAmountLabel.text = [[NSString stringWithFormat:@"可用金额(元):%@",viewModel.userInfoModel.userAssets.availablePoint] replaceStringWithStartLocation:8 lenght:viewModel.userInfoModel.userAssets.availablePoint.length?:1];
            
            weakSelf.accumulatedIncomeLabel.text = [[NSString stringWithFormat:@"累计收益(元):%@",viewModel.userInfoModel.userAssets.earnTotal] replaceStringWithStartLocation:8 lenght:viewModel.userInfoModel.userAssets.earnTotal.length?:1];
        }
        weakSelf.userNameLabel.text = viewModel.userInfoModel.userInfo.username;
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
        self.accumulatedIncomeLabel.text = [self.accumulatedIncomeLabel.text replaceStringWithStartLocation:8 lenght:self.userInfoViewModel.userInfoModel.userAssets.earnTotal.length?:1];
        self.availableAmountLabel.text = [self.availableAmountLabel.text replaceStringWithStartLocation:8 lenght:self.userInfoViewModel.userInfoModel.userAssets.availablePoint.length?:1];
    }else
    {
        KeyChain.ciphertext = @"0";
        self.ciphertextButton.selected = NO;
        self.availableAmountLabel.text = [NSString stringWithFormat:@"可用金额(元):%@",self.userInfoViewModel.userInfoModel.userAssets.availablePoint];
        self.accumulatedIncomeLabel.text = [NSString stringWithFormat:@"累计收益(元):%@",self.userInfoViewModel.userInfoModel.userAssets.earnTotal];
        
    }
    
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
