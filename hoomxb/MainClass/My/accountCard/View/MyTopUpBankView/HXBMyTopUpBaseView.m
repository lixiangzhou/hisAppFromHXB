//
//  HXBMyTopUpBaseView.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/6.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyTopUpBaseView.h"
#import "HXBMyTopUpBankView.h"
#import "HXBMyTopUpHeaderView.h"
#import "HXBLeftLabelTextView.h"
#import "HXBBankCardModel.h"
@interface HXBMyTopUpBaseView ()<UITextFieldDelegate>
//@property (nonatomic, strong) UITextField *amountTextField;
@property (nonatomic, strong) HXBLeftLabelTextView *amountTextField;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UILabel *availableBalanceLabel;
@property (nonatomic, strong) HXBMyTopUpHeaderView *myTopUpHeaderView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, strong) UIButton *phoneBtn;
@property (nonatomic, strong) UILabel *freeTipLabel;
/** 最小充值金额*/
@property (nonatomic, copy) NSString *minRechargeMoney;
@end

@implementation HXBMyTopUpBaseView
@synthesize amount = _amount;
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = BACKGROUNDCOLOR;
        [self addSubview:self.mybankView];
        [self addSubview:self.availableBalanceLabel];
        [self addSubview:self.freeTipLabel];
        [self addSubview:self.amountTextField];
        [self addSubview:self.nextButton];
        [self addSubview:self.myTopUpHeaderView];
        [self addSubview:self.tipLabel];
        [self addSubview:self.promptLabel];
        [self addSubview:self.phoneBtn];
        [self setCardViewFrame];
        
    }
    return self;
}



- (void)setViewModel:(HXBRequestUserInfoViewModel *)viewModel
{
    _viewModel = viewModel;
    self.availableBalanceLabel.text = [NSString stringWithFormat:@"可用金额：%@", [NSString hxb_getPerMilWithDouble:viewModel.userInfoModel.userAssets.availablePoint.doubleValue]];
    self.amountTextField.placeholder = [NSString stringWithFormat:@"最小充值金额为%d.00元",self.viewModel.userInfoModel.userInfo.minChargeAmount];
    if (_amountTextField.text.length > 0) {
        _nextButton.backgroundColor = COR29;
        _nextButton.userInteractionEnabled = YES;
    }
}

- (void)setCardViewFrame{
    [self.myTopUpHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top).offset(HXBStatusBarAndNavigationBarHeight);
        make.height.offset(kScrAdaptationH750(80));
    }];
    
    [self.mybankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.myTopUpHeaderView.mas_bottom);
        make.height.offset(kScrAdaptationH750(160));
    }];
    
    [self.availableBalanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kScrAdaptationW750(30));
        make.top.equalTo(self.mybankView.mas_bottom).offset(kScrAdaptationH750(20));
        make.height.offset(kScrAdaptationH750(33));
    }];
    
    [self.freeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kScrAdaptationH750(30));
        make.centerY.equalTo(self.availableBalanceLabel);
    }];
    
    [self.amountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.availableBalanceLabel.mas_bottom).offset(kScrAdaptationH750(20));
        make.height.offset(kScrAdaptationH750(130));
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kScrAdaptationW750(40));
        make.right.equalTo(self.mas_right).offset(kScrAdaptationW750(-40));
        make.top.equalTo(self.amountTextField.mas_bottom).offset(kScrAdaptationH750(100));
        make.height.offset(kScrAdaptationH750(80));
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kScrAdaptationW750(40));
        make.right.equalTo(self.mas_right).offset(kScrAdaptationW750(-40));
        make.bottom.equalTo(self.mas_bottom).offset(kScrAdaptationH750(-100) - HXBBottomAdditionHeight);
    }];
    
    [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipLabel.mas_bottom);
//        make.right.equalTo(self.mas_right).offset(kScrAdaptationW750(-40));
        make.left.equalTo(self.tipLabel.mas_left);
    }];
    
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kScrAdaptationW750(40));
        make.right.equalTo(self.mas_right).offset(kScrAdaptationW750(-40));
        make.bottom.equalTo(self.tipLabel.mas_top).offset(kScrAdaptationH750(-20));
        make.height.offset(kScrAdaptationH750(24));
    }];
    kWeakSelf
    _amountTextField.haveStr = ^(BOOL haveStr) {
        weakSelf.nextButton.userInteractionEnabled = haveStr;
        weakSelf.nextButton.backgroundColor = haveStr ? COR29 : COR12;
    };
    
}
- (void)phoneBtnClick
{
    [HXBAlertManager callupWithphoneNumber:kServiceMobile andWithTitle:@"红小宝客服电话" Message: kServiceMobile];
}
- (void)nextButtonClick:(UIButton *)sender{
    if ([_amountTextField.text doubleValue] < self.viewModel.userInfoModel.userInfo.minChargeAmount) {
        [HxbHUDProgress showMessageCenter:[NSString stringWithFormat:@"最小充值金额为%d元",self.viewModel.userInfoModel.userInfo.minChargeAmount] inView:self];
        return;
    }
    if (self.rechargeBlock) {
        self.rechargeBlock();
    }
}
- (void)setAmount:(NSString *)amount {
    _amount = amount;
    self.amountTextField.text = amount;
    if (amount.length) {
        _nextButton.backgroundColor = COR29;
        _nextButton.userInteractionEnabled = YES;
    } else {
        _nextButton.backgroundColor = COR26;
        _nextButton.userInteractionEnabled = NO;
    }
}
- (NSString *)amount
{
    return self.amountTextField.text;
}


- (HXBMyTopUpBankView *)mybankView{
    if (!_mybankView) {
        _mybankView = [[HXBMyTopUpBankView alloc]initWithFrame:CGRectMake(10, 113, SCREEN_WIDTH - 20, 80)];
        _mybankView.backgroundColor = [UIColor whiteColor];
    }
    return _mybankView;
}
- (HXBLeftLabelTextView *)amountTextField{
    if (!_amountTextField) {
        _amountTextField = [[HXBLeftLabelTextView alloc] init];
        _amountTextField.leftStr = @"hxb_my_message人民币";
        _amountTextField.backgroundColor = [UIColor whiteColor];
        _amountTextField.isDecimalPlaces = YES;
        _amountTextField.keyboardType = UIKeyboardTypeDecimalPad;
    }
    return _amountTextField;
}

- (UILabel *)availableBalanceLabel
{
    if (!_availableBalanceLabel) {
        _availableBalanceLabel = [[UILabel alloc] init];
//        _availableBalanceLabel.text = @"可用金额：123.78元";
        _availableBalanceLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        _availableBalanceLabel.textColor = RGB(51, 51, 51);
    }
    return _availableBalanceLabel;
}

- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [UIButton btnwithTitle:@"充值" andTarget:self andAction:@selector(nextButtonClick:) andFrameByCategory:  CGRectMake(20,CGRectGetMaxY(_amountTextField.frame) + 20, SCREEN_WIDTH - 40,44)];
        _nextButton.backgroundColor = COR26;
        _nextButton.userInteractionEnabled = NO;
    }
    return _nextButton;
}

- (HXBMyTopUpHeaderView *)myTopUpHeaderView
{
    if (!_myTopUpHeaderView) {
        _myTopUpHeaderView = [[HXBMyTopUpHeaderView alloc] init];
    }
    return _myTopUpHeaderView;
}
- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.text = @"1、禁止洗钱、信用卡套现、虚假交易等行为，一经发现并确认，将终止该账户的使用；";
        _tipLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        _tipLabel.numberOfLines = 0;
        _tipLabel.textColor = COR8;
    }
    return _tipLabel;
}

- (UIButton *)phoneBtn
{
    if (!_phoneBtn) {
        _phoneBtn  = [[UIButton alloc] init];
        NSString *string = [NSString stringWithFormat:@"2、如有疑问，请联系客服：%@", kServiceMobile];
        NSMutableAttributedString *str = [NSMutableAttributedString setupAttributeStringWithString:string WithRange:NSMakeRange(string.length - kServiceMobile.length, kServiceMobile.length) andAttributeColor:COR30];
        [str addAttribute:NSForegroundColorAttributeName value:COR8 range:NSMakeRange(0, string.length - kServiceMobile.length)];
        [_phoneBtn setAttributedTitle:str forState:(UIControlStateNormal)];
        [_phoneBtn addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _phoneBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    }
    return _phoneBtn;
}

- (UILabel *)promptLabel
{
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.text = @"温馨提示：";
        _promptLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        _promptLabel.textColor = RGB(115, 173, 255);
    }
    return _promptLabel;
}

- (UILabel *)freeTipLabel
{
    if (!_freeTipLabel) {
        _freeTipLabel = [[UILabel alloc] init];
        _freeTipLabel.text = @"充值免手续费";
        _freeTipLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        _freeTipLabel.textColor = COR11;
    }
    return _freeTipLabel;
}


@end
