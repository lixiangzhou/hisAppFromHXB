//
//  HXBMyTopUpBankView.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/6.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyTopUpBankView.h"
#import "HXBBankCardModel.h"

@interface HXBMyTopUpBankView()

@property (nonatomic, strong) UIImageView *bankLogoImageView;
@property (nonatomic, strong) UILabel *bankNameLabel;
@property (nonatomic, strong) UILabel *bankCardNumLabel;
@property (nonatomic, strong) UILabel *amountLimitLabel;

@end

@implementation HXBMyTopUpBankView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bankLogoImageView];
        [self addSubview:self.bankNameLabel];
        [self addSubview:self.bankCardNumLabel];
        [self addSubview:self.amountLimitLabel];
        [self setContentViewFrame];
        
        [self loadBankCard];
    }
    return self;
}


- (void)loadBankCard
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
        weakSelf.bankNameLabel.text = bankCardModel.bankType;
        weakSelf.bankCardNumLabel.text = [NSString stringWithFormat:@"（尾号%@）",[bankCardModel.cardId substringFromIndex:bankCardModel.cardId.length - 4]];
        weakSelf.amountLimitLabel.text = bankCardModel.quota;
        weakSelf.bankLogoImageView.svgImageString = bankCardModel.bankCode;
        if (weakSelf.bankLogoImageView.image == nil) {
            weakSelf.bankLogoImageView.svgImageString = @"默认";
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        NSLog(@"%@",error);
        [HxbHUDProgress showTextWithMessage:@"银行卡请求失败"];
    }];
    
}


- (void)setContentViewFrame{
    [self.bankLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(kScrAdaptationW750(30));
        make.size.mas_equalTo(CGSizeMake(kScrAdaptationH750(80), kScrAdaptationH750(80)));
    }];
    [self.bankNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bankLogoImageView.mas_right).offset(kScrAdaptationW750(36));
        make.top.equalTo(self.mas_top).offset(kScrAdaptationH750(44));
        make.height.offset(kScrAdaptationH750(28));
    }];
    [self.bankCardNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bankNameLabel);
        make.left.equalTo(self.bankNameLabel.mas_right);
        make.height.offset(kScrAdaptationH750(28));
    }];
    [self.amountLimitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bankNameLabel.mas_left);
        make.right.equalTo(self.mas_right).offset(20);
        make.top.equalTo(self.bankNameLabel.mas_bottom).offset(kScrAdaptationH750(20));
    }];
    
}

- (UIImageView *)bankLogoImageView{
    if (!_bankLogoImageView) {
        _bankLogoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"默认"]];
        _bankLogoImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _bankLogoImageView;
}

- (UILabel *)bankNameLabel{
    if (!_bankNameLabel) {
        _bankNameLabel = [[UILabel alloc] init];
//        _bankNameLabel.text = @"招商银行";
        _bankNameLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
        _bankNameLabel.textColor = RGB(51, 51, 51);
    }
    return _bankNameLabel;
}

- (UILabel *)bankCardNumLabel{
    if (!_bankCardNumLabel) {
        _bankCardNumLabel = [[UILabel alloc] init];
//        _bankCardNumLabel.text = @"(尾号1234)";
        _bankCardNumLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
        _bankCardNumLabel.textColor = RGB(51, 51, 51);
    }
    return _bankCardNumLabel;
}

- (UILabel *)amountLimitLabel{
    if (!_amountLimitLabel) {
        _amountLimitLabel = [[UILabel alloc] init];
        _amountLimitLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        _amountLimitLabel.numberOfLines = 0;
        _amountLimitLabel.textColor = COR10;
        _amountLimitLabel.text = @"单笔限额：xx元，单日限额：xx元，单月限额：xx元";
    }
    return _amountLimitLabel;
}


@end
