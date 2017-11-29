//
//  HXBBankView.m
//  hoomxb
//
//  Created by HXB-C on 2017/8/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBankView.h"
#import "HXBBankCardModel.h"
@interface HXBBankView ()

@property (nonatomic, strong) UIImageView *backImageView;

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *bankName;

@property (nonatomic, strong) UILabel *realName;

@property (nonatomic, strong) UILabel *bankNum;

@property (nonatomic, strong) UILabel *bankTip;

@property (nonatomic, strong) UIButton *unbundlingBtn;//解绑

@property (nonatomic, strong) HXBBankCardModel *bankCardModel;

@end

@implementation HXBBankView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScrAdaptationW(355), kScrAdaptationH(170))];
        self.backImageView.image = [UIImage imageNamed:@"hxb_card_bg"];
        [self addSubview:self.backImageView];

        [self.backImageView addSubview:self.iconView];
        [self.backImageView addSubview:self.bankName];
        [self.backImageView addSubview:self.realName];
        [self.backImageView addSubview:self.bankNum];
        [self.backImageView addSubview:self.unbundlingBtn];
        [self.backImageView addSubview:self.bankTip];
        [self setupSubViewFrame];
        [self loadBankData];
    }
    return self;
}

- (void)setHasUnbundlingBtn:(BOOL)hasUnbundlingBtn{
    _hasUnbundlingBtn = hasUnbundlingBtn;
    if (_hasUnbundlingBtn) {
        self.backImageView.userInteractionEnabled = YES;
        [self.unbundlingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@kScrAdaptationW750(130));
            make.right.equalTo(self.backImageView.mas_right).offset(kScrAdaptationW750(-40));
            make.top.equalTo(self.backImageView.mas_top).offset(kScrAdaptationH(20));
            make.height.offset(kScrAdaptationH750(40));
        }];
    }
}

- (void)clickUnbundlingBtn:(UIButton *)sender{
    kWeakSelf
    if (weakSelf.unbundBankBlock) {
        weakSelf.unbundBankBlock(self.bankCardModel);
    }
}

- (void)setupSubViewFrame
{
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW(20));
        make.top.equalTo(self).offset(kScrAdaptationH(20));
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
        self.bankCardModel = bankCardModel;
        //设置绑卡信息
        weakSelf.iconView.svgImageString = bankCardModel.bankCode;
        weakSelf.bankName.text = bankCardModel.bankType;
        weakSelf.realName.text = [NSString stringWithFormat:@"持卡人：%@",[bankCardModel.name replaceStringWithStartLocation:0 lenght:bankCardModel.name.length - 1]];
        if (bankCardModel.name.length > 4) {
            weakSelf.realName.text = [NSString stringWithFormat:@"持卡人：***%@",[bankCardModel.name substringFromIndex:bankCardModel.name.length - 1]];
        }
        weakSelf.bankNum.text = [bankCardModel.cardId hxb_hiddenBankCard];
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
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
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

- (UIButton *)unbundlingBtn{
    if (!_unbundlingBtn) {
        _unbundlingBtn = [[UIButton alloc]init];
        [_unbundlingBtn setTitle:@"解绑" forState:UIControlStateNormal];
        [_unbundlingBtn setBackgroundColor:[UIColor redColor]];
        [_unbundlingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _unbundlingBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(13);
        _unbundlingBtn.layer.cornerRadius = 4.0;
        _unbundlingBtn.layer.masksToBounds = YES;
        [_unbundlingBtn addTarget:self action:@selector(clickUnbundlingBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _unbundlingBtn;
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
