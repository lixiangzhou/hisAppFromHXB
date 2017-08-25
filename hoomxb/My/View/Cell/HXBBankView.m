//
//  HXBBankView.m
//  hoomxb
//
//  Created by HXB-C on 2017/8/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBankView.h"
#import "HXBBankCardModel.h"
@interface HXBBankView ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *bankName;

@property (nonatomic, strong) UILabel *realName;

@property (nonatomic, strong) UILabel *bankNum;

@property (nonatomic, strong) UILabel *bankTip;


@end

@implementation HXBBankView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.iconView];
        [self addSubview:self.bankName];
        [self addSubview:self.realName];
        [self addSubview:self.bankNum];
        [self addSubview:self.bankTip];
        [self setupSubViewFrame];
        [self loadBankData];
    }
    return self;
}


- (void)setupSubViewFrame
{
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW(20));
        make.top.equalTo(self).offset(kScrAdaptationH(15));
        make.width.offset(kScrAdaptationW(40));
        make.height.offset(kScrAdaptationW(40));
    }];
    [self.bankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(kScrAdaptationW(15));
        make.top.equalTo(self.iconView);
        make.height.offset(kScrAdaptationH(20));
    }];
    [self.realName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bankName.mas_left);
        make.top.equalTo(self.bankName.mas_bottom).offset(kScrAdaptationH(4));
        make.height.offset(kScrAdaptationH(16));
    }];
    [self.bankNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_left);
        make.right.equalTo(self);
        make.top.equalTo(self.iconView.mas_bottom).offset(kScrAdaptationH(20));
        make.height.offset(kScrAdaptationH(31));
    }];
    [self.bankTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_left);
        make.top.equalTo(self.bankNum.mas_bottom).offset(kScrAdaptationH(20));
        make.right.equalTo(self);
        make.height.offset(kScrAdaptationH(16));
    }];
}

- (void)loadBankData
{
    kWeakSelf
    NYBaseRequest *bankCardAPI = [[NYBaseRequest alloc] init];
    bankCardAPI.requestUrl = kHXBUserInfo_BankCard;
    bankCardAPI.requestMethod = NYRequestMethodGet;
    [bankCardAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
        NSInteger status =  [responseObject[@"status"] integerValue];
        if (status != 0) {
            [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
            return;
        }
        HXBBankCardModel *bankCardModel = [HXBBankCardModel yy_modelWithJSON:responseObject[@"data"]];
        //设置绑卡信息
        weakSelf.iconView.svgImageString = bankCardModel.bankCode;
        weakSelf.bankName.text = bankCardModel.bankType;
        weakSelf.realName.text = [NSString stringWithFormat:@"持卡人：%@",[bankCardModel.name replaceStringWithStartLocation:0 lenght:bankCardModel.name.length - 1]];
        weakSelf.bankNum.text = [bankCardModel.cardId replaceStringWithStartLocation:0 lenght:bankCardModel.cardId.length - 4];
        weakSelf.bankTip.text = bankCardModel.quota;
    } failure:^(NYBaseRequest *request, NSError *error) {
        NSLog(@"%@",error);
        [HxbHUDProgress showTextWithMessage:@"银行卡请求失败"];
    }];


}

#pragma mark - 懒加载
- (UIImageView *)iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (UILabel *)bankName
{
    if (!_bankName) {
        _bankName = [[UILabel alloc] init];
        _bankName.font = kHXBFont_PINGFANGSC_REGULAR(15);
        _bankName.textColor = COR7;
    }
    return _bankName;
}

- (UILabel *)realName
{
    if (!_realName) {
        _realName = [[UILabel alloc] init];
        _realName.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _realName.textColor = COR7;
    }
    return _realName;
}

- (UILabel *)bankNum
{
    if (!_bankNum) {
        _bankNum = [[UILabel alloc] init];
        _bankNum.font = kHXBFont_PINGFANGSC_REGULAR(24);
        _bankNum.textColor = COR29;
    }
    return _bankNum;
}

- (UILabel *)bankTip
{
    if (!_bankTip) {
        _bankTip = [[UILabel alloc] init];
        _bankTip.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _bankTip.textColor = COR10;
    }
    return _bankTip;
}

@end
