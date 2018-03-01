//
//  HXBPresentInformationView.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//
#define marginal kScrAdaptationW750(40)
#import "HXBPresentInformationView.h"
#import "HXBTipView.h"
#import "HXBBankCardModel.h"
@interface HXBPresentInformationView ()
@property (nonatomic, strong) UIImageView *icon;//图标
@property (nonatomic, strong) UILabel *tipLabel;//是否成功的处理提示
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *bankCardtipLabel;//银行卡提示标签
@property (nonatomic, strong) UILabel *bankCardNumberLabel;//银行卡尾号
@property (nonatomic, strong) UILabel *withdrawalsTipLabel;//提现金额标签
@property (nonatomic, strong) UILabel *withdrawalsNumberLabel;//提现金额
@property (nonatomic, strong) UILabel *withdrawalsTimeTipLabel;//提现到账时间标签
@property (nonatomic, strong) UILabel *withdrawalsTimeLabel;//提现到账时间
@property (nonatomic, strong) UIButton *backButton;
//@property (nonatomic, strong) HXBTipView *tipView;
@end

@implementation HXBPresentInformationView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.icon];
        [self addSubview:self.tipLabel];
        [self addSubview:self.backView];
        [self.backView addSubview:self.bankCardtipLabel];
        [self.backView addSubview:self.bankCardNumberLabel];
        [self.backView addSubview:self.withdrawalsTipLabel];
        [self.backView addSubview:self.withdrawalsNumberLabel];
        [self.backView addSubview:self.withdrawalsTimeTipLabel];
        [self.backView addSubview:self.withdrawalsTimeLabel];
//        [self addSubview:self.tipView];
        [self addSubview:self.backButton];
        [self setupSubViewFrame];
    }
    return self;
}
- (void)setupSubViewFrame
{
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kScrAdaptationH750(150) + 64);
        make.centerX.equalTo(self);
        make.height.offset(kScrAdaptationH750(198));
        make.width.offset(kScrAdaptationW750(310));
    }];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.icon.mas_bottom).offset(kScrAdaptationH750(70));
        make.height.offset(kScrAdaptationH750(38));
    }];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.tipLabel.mas_bottom).offset(kScrAdaptationH750(95));
        make.bottom.equalTo(self.withdrawalsTimeTipLabel.mas_bottom);
    }];
    [self.bankCardtipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(marginal);
        make.top.equalTo(self.backView.mas_top);
        make.height.offset(kScrAdaptationH750(30));
    }];
    [self.bankCardNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right).offset(-marginal);
        make.centerY.equalTo(self.bankCardtipLabel);
        make.height.offset(kScrAdaptationH750(30));
    }];
    [self.withdrawalsTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(marginal);
        make.top.equalTo(self.bankCardtipLabel.mas_bottom).offset(kScrAdaptationH750(28));
        make.height.offset(kScrAdaptationH750(30));
    }];
    [self.withdrawalsNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right).offset(-marginal);
        make.centerY.equalTo(self.withdrawalsTipLabel);
        make.height.offset(kScrAdaptationH750(30));
    }];
    [self.withdrawalsTimeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(marginal);
        make.top.equalTo(self.withdrawalsTipLabel.mas_bottom).offset(kScrAdaptationH750(28));
        make.height.offset(kScrAdaptationH750(30));
    }];
    [self.withdrawalsTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right).offset(-marginal);
        make.centerY.equalTo(self.withdrawalsTimeTipLabel);
        make.height.offset(kScrAdaptationH750(30));
    }];
//    [self.tipView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.backView.mas_bottom).offset(kScrAdaptationH750(30));
//        make.right.equalTo(self.backView.mas_right).offset(-marginal);
//        make.left.equalTo(self.backView).offset(marginal);
//    }];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(marginal);
        make.right.equalTo(self.mas_right).offset(-marginal);
        make.bottom.equalTo(self.mas_bottom).offset(kScrAdaptationH750(-208));
        make.height.offset(kScrAdaptationH750(82));
    }];
    
}
- (void)setBankCardModel:(HXBBankCardModel *)bankCardModel
{
    _bankCardModel = bankCardModel;
    self.bankCardNumberLabel.text = [NSString stringWithFormat:@"%@ 尾号 %@",self.bankCardModel.bankType,[self.bankCardModel.cardId substringFromIndex:self.bankCardModel.cardId.length - 4]];
//    self.bankCardModel.amount doubleValue
    
    self.withdrawalsNumberLabel.text = [NSString stringWithFormat:@"%@",[NSString hxb_getPerMilWithDouble:[self.bankCardModel.amount doubleValue]]];
    self.withdrawalsTimeLabel.text = self.bankCardModel.bankArriveTimeText;
}
- (void)backBttonClick:(UIButton *)sender{
    if (self.completeBlock) {
        self.completeBlock();
    }
}
#pragma mark - 懒加载
- (UILabel *)withdrawalsTimeLabel
{
    if (!_withdrawalsTimeLabel) {
        _withdrawalsTimeLabel = [[UILabel alloc] init];
        _withdrawalsTimeLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
        _withdrawalsTimeLabel.textColor = COR10;
        
    }
    return _withdrawalsTimeLabel;
}
- (UILabel *)withdrawalsTimeTipLabel
{
    if (!_withdrawalsTimeTipLabel) {
        _withdrawalsTimeTipLabel = [[UILabel alloc] init];
        _withdrawalsTimeTipLabel.text = @"预计到账时间";
        _withdrawalsTimeTipLabel.textColor = COR6;
        _withdrawalsTimeTipLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
    }
    return _withdrawalsTimeTipLabel;
}

- (UILabel *)withdrawalsNumberLabel
{
    if (!_withdrawalsNumberLabel) {
        _withdrawalsNumberLabel = [[UILabel alloc] init];
        _withdrawalsNumberLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
        _withdrawalsNumberLabel.textColor = COR10;
    }
    return _withdrawalsNumberLabel;
}

- (UILabel *)withdrawalsTipLabel
{
    if (!_withdrawalsTipLabel) {
        _withdrawalsTipLabel = [[UILabel alloc] init];
        _withdrawalsTipLabel.text = @"提现金额";
        _withdrawalsTipLabel.textColor = COR6;
        _withdrawalsTipLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
    }
    return _withdrawalsTipLabel;
}

- (UILabel *)bankCardNumberLabel
{
    if (!_bankCardNumberLabel) {
        _bankCardNumberLabel = [[UILabel alloc] init];
        _bankCardNumberLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
        _bankCardNumberLabel.textColor = COR10;
    }
    return _bankCardNumberLabel;
}
- (UILabel *)bankCardtipLabel
{
    if (!_bankCardtipLabel) {
        _bankCardtipLabel = [[UILabel alloc] init];
        _bankCardtipLabel.text = @"银行卡";
        _bankCardtipLabel.textColor = COR6;
        _bankCardtipLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
    }
    return _bankCardtipLabel;
}
- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}
- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.text = @"提现申请已受理";
        _tipLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(38);
        _tipLabel.textColor = COR6;
    }
    return _tipLabel;
}
- (UIImageView *)icon
{
    if (!_icon) {
        _icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shouli"]];
        _icon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _icon;
}
- (UIButton *)backButton{
    if (!_backButton) {
        _backButton = [UIButton btnwithTitle:@"完成" andTarget:self andAction:@selector(backBttonClick:) andFrameByCategory:CGRectZero];
    }
    return _backButton;
}
//- (HXBTipView *)tipView
//{
//    if (!_tipView) {
//        _tipView = [[HXBTipView alloc] init];
//        _tipView.text = @"如遇法定节假日，会顺延。";
//    }
//    return _tipView;
//}
@end
