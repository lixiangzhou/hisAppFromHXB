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

- (void)setCardViewFrame{
    
    [self.myTopUpHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
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
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.top.equalTo(self.availableBalanceLabel.mas_bottom).offset(20);
    }];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.top.equalTo(self.amountTextField.mas_bottom).offset(50);
        make.height.equalTo(@44);
    }];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.bottom.equalTo(self.mas_bottom).offset(-20);
    }];
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.bottom.equalTo(self.tipLabel.mas_top).offset(-5);
    }];
}

- (void)nextButtonClick:(UIButton *)sender{
    if ([_amountTextField.text doubleValue] < 1) {
        [HxbHUDProgress showTextWithMessage:@"金额不能小于1"];
        return;
    }
    if (self.rechargeBlock) {
        self.rechargeBlock();
    }
    
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
        _amountTextField.placeholder = @"请输入充值金额"
        _amountTextField.leftStr = @"充值金额:";
        _amountTextField.leftViewMode = UITextFieldViewModeAlways;
        _amountTextField.leftView = amounttipLabel;
        _amountTextField.delegate = self;
        _amountTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }
    return _amountTextField;
}

- (UILabel *)availableBalanceLabel
{
    if (!_availableBalanceLabel) {
        _availableBalanceLabel = [[UILabel alloc] init];
        _availableBalanceLabel.text = @"可用金额：123.78元";
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
        _tipLabel.text = @"1、红小宝充值仅限储蓄卡，不可使用信用卡，一旦发现恶意充值，套现等行为，将对账户做出严肃处理。";
        _tipLabel.font = [UIFont systemFontOfSize:12];
        _tipLabel.numberOfLines = 0;
        _tipLabel.textColor = COR12;
    }
    return _tipLabel;
}
- (UILabel *)promptLabel
{
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.text = @"温馨提示：";
        _promptLabel.font = [UIFont systemFontOfSize:12];
    }
    return _promptLabel;
}
#pragma make UITextFieldDelegate
//参数一：range,要被替换的字符串的range，如果是新键入的那么就没有字符串被替换，range.lenth=0,第二个参数：替换的字符串，即键盘即将键入或者即将粘贴到textfield的string
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if (string.length == 0) {
        return YES;
    }
    //第一个参数，被替换字符串的range，第二个参数，即将键入或者粘贴的string，返回的是改变过后的新str，即textfield的新的文本内容
    NSString *checkStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    return [NSString checkBothDecimalPlaces:checkStr];
}

@end
