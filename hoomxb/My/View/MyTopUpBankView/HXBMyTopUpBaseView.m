//
//  HXBMyTopUpBaseView.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/6.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyTopUpBaseView.h"
#import "HXBMyTopUpBankView.h"
#import "HXBMyTopUpHeaderView.h"
#import "HXBLeftLabelTextView.h"
@interface HXBMyTopUpBaseView ()<UITextFieldDelegate>
//@property (nonatomic, strong) UITextField *amountTextField;
@property (nonatomic, strong) HXBLeftLabelTextView *amountTextField;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UILabel *availableBalanceLabel;
@property (nonatomic, strong) HXBMyTopUpBankView *mybankView;
@property (nonatomic, strong) HXBMyTopUpHeaderView *myTopUpHeaderView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *promptLabel;
@end

@implementation HXBMyTopUpBaseView
@synthesize amount = _amount;
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = BACKGROUNDCOLOR;
        [self addSubview:self.mybankView];
        [self addSubview:self.availableBalanceLabel];
        [self addSubview:self.amountTextField];
        [self addSubview:self.nextButton];
        [self addSubview:self.myTopUpHeaderView];
        [self addSubview:self.tipLabel];
        [self addSubview:self.promptLabel];
        [self setCardViewFrame];
        
    }
    return self;
}



- (void)setViewModel:(HXBRequestUserInfoViewModel *)viewModel
{
    self.availableBalanceLabel.text = [NSString stringWithFormat:@"可用金额：%@元",viewModel.availablePoint_NOTYUAN];
}

- (void)setCardViewFrame{
    
    [self.myTopUpHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top).offset(64);
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
    
    [self.amountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.availableBalanceLabel.mas_bottom).offset(kScrAdaptationH750(20));
        make.height.offset(kScrAdaptationH750(100));
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
        make.bottom.equalTo(self.mas_bottom).offset(kScrAdaptationH750(-100));
    }];
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kScrAdaptationW750(40));
        make.right.equalTo(self.mas_right).offset(kScrAdaptationW750(-40));
        make.bottom.equalTo(self.tipLabel.mas_top).offset(kScrAdaptationH750(-20));
        make.height.offset(kScrAdaptationH750(24));
    }];
}

- (void)nextButtonClick:(UIButton *)sender{
    if ([_amountTextField.text doubleValue] < 1) {
        [HxbHUDProgress showMessageCenter:@"金额不能小于1" inView:self];
        return;
    }
    if (self.rechargeBlock) {
        self.rechargeBlock();
    }
}
- (void)setAmount:(NSString *)amount {
    _amount = amount;
    self.amountTextField.text = amount;
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
        _amountTextField.leftStr = @"充值金额:";
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
        _tipLabel.text = @"红小宝充值仅限储蓄卡，不可使用信用卡，一旦发现恶意充值，套现等行为，将对账户做出严肃处理。";
        _tipLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        _tipLabel.numberOfLines = 0;
        _tipLabel.textColor = COR8;
    }
    return _tipLabel;
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

@end
