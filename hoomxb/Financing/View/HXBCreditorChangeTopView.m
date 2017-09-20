//
//  HXBCreditorChangeTopView.m
//  hoomxb
//
//  Created by 肖扬 on 2017/9/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBCreditorChangeTopView.h"
//#import "HXBRechargeView.h"

@interface HXBCreditorChangeTopView ()<UITextFieldDelegate>
// 一键购买
@property (nonatomic,strong) UIView *rechargeView;
// 待转让金额
/** 电灯泡 */
@property (nonatomic, strong)  UIImageView *tipsImageView;
@property (nonatomic,strong) UILabel *creditorLabel;

@property (nonatomic, strong) HXBCustomTextField *rechargeViewTextField;
@property (nonatomic, strong) UIButton *rechargeBtn;
/** 银行限额弹框 */
@property (nonatomic, strong)  UILabel *cardLimitMoneyLabel;

@end
@implementation HXBCreditorChangeTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH(95))];
    topView.backgroundColor = [UIColor clearColor];
    [self addSubview:topView];
    [topView addSubview:self.tipsImageView];
    [topView addSubview:self.cardLimitMoneyLabel];
    [self setRechardView];
    [topView addSubview:_rechargeView];
    [topView addSubview:self.creditorLabel];
        [_creditorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(kScrAdaptationW750(70));
        make.width.offset(kScreenWidth - 2 * kScrAdaptationW(15));
        make.height.offset(kScrAdaptationH(35));
    }];
    [_tipsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW750(30));
        make.centerY.equalTo(_creditorLabel);
        make.height.width.equalTo(@(kScrAdaptationH750(30)));
    }];
}

- (void)setRechardView {
    kWeakSelf
    _rechargeView = [[UIView alloc] initWithFrame:CGRectMake(0, kScrAdaptationH(35), kScreenWidth, kScrAdaptationH(60))];
    _rechargeView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScrAdaptationW(15), 0, kScrAdaptationW(70), kScrAdaptationH(65))];
    label.text = @"金额：";
    
    _rechargeViewTextField = [[HXBCustomTextField alloc] initWithFrame:CGRectMake(label.left + kScrAdaptationW(5), kScrAdaptationH(15), kScreenWidth - kScrAdaptationW(95), kScrAdaptationH(35))];
    _rechargeViewTextField.keyboardType = UIKeyboardTypeDecimalPad;
    _rechargeViewTextField.isHidenLine = YES;
    _rechargeViewTextField.delegate = self;
    _rechargeViewTextField.isCleanAllBtn = YES;
    _rechargeViewTextField.block = ^(NSString *text) {
        weakSelf.changeBlock(text);
    };
    [_rechargeView addSubview:_rechargeViewTextField];
    [_rechargeView addSubview:label];
    
    _rechargeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _rechargeBtn.frame = CGRectMake(kScreenWidth - kScrAdaptationW(95), kScrAdaptationH750(35), kScrAdaptationW(80), kScrAdaptationH(30));
    [_rechargeBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_rechargeBtn setTitle:@"一键购买" forState:(UIControlStateNormal)];
    _rechargeBtn.layer.cornerRadius = kScrAdaptationW750(5);
    _rechargeBtn.layer.masksToBounds = true;
    _rechargeBtn.layer.borderColor = kHXBColor_Blue040610.CGColor;//(r:0.45 g:0.68 b:0.68 a:1.00)
    _rechargeBtn.layer.borderWidth = kXYBorderWidth;
    [_rechargeBtn setTitleColor:kHXBColor_Blue040610 forState:UIControlStateNormal];
    _rechargeBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
    [_rechargeView addSubview:_rechargeBtn];
}

- (void)clickButton:(UIButton *)sender {
    self.block();
}

- (UIImageView *)tipsImageView {
    if (!_tipsImageView) {
        _tipsImageView = [[UIImageView alloc] init];
        _tipsImageView.svgImageString = @"BUYtips";
     }
    return _tipsImageView;
}


- (UILabel *)creditorLabel {
    if (!_creditorLabel) {
        _creditorLabel = [[UILabel alloc] init];
        _creditorLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _creditorLabel.textColor = COR10;
    }
    return _creditorLabel;
}

- (UILabel *)cardLimitMoneyLabel {
    if (!_cardLimitMoneyLabel) {
        _cardLimitMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -kScrAdaptationH(35), kScreenWidth, kScrAdaptationH(35))];
        _cardLimitMoneyLabel.text = @"ahkjsdhakdshajdh";
        _cardLimitMoneyLabel.textAlignment = NSTextAlignmentCenter;
        _cardLimitMoneyLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _cardLimitMoneyLabel.textColor = [UIColor whiteColor];
        _cardLimitMoneyLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return _cardLimitMoneyLabel;
}


- (void)setCreditorMoney:(NSString *)creditorMoney {
    _creditorMoney = creditorMoney;
    _creditorLabel.text = creditorMoney;
}

- (void)setTotalMoney:(NSString *)totalMoney {
    _totalMoney = totalMoney;
    _rechargeViewTextField.text = totalMoney;
}

- (void)setPlaceholderStr:(NSString *)placeholderStr {
    _placeholderStr = placeholderStr;
    self.rechargeViewTextField.placeholder = _placeholderStr;
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType {
    _keyboardType = keyboardType;
    _rechargeViewTextField.keyboardType = keyboardType;
}


- (void)setIsHiddenBtn:(BOOL)isHiddenBtn {
    _isHiddenBtn = isHiddenBtn;
    if (isHiddenBtn) {
        _rechargeBtn.hidden = YES;
        _rechargeViewTextField.frame = CGRectMake(kScrAdaptationW(20), kScrAdaptationH(15), kScreenWidth - kScrAdaptationW(15), kScrAdaptationH(35));
    } else {
        _rechargeBtn.hidden = NO;
        _rechargeViewTextField.frame = CGRectMake(kScrAdaptationW(20), kScrAdaptationH(15), kScreenWidth - kScrAdaptationW(95), kScrAdaptationH(35));
    }
}

- (void)setDisableKeyBorad:(BOOL)disableKeyBorad {
    _disableKeyBorad = disableKeyBorad;
    _rechargeViewTextField.disableEdit = disableKeyBorad;
}

- (void)setCardStr:(NSString *)cardStr {
    _cardStr = cardStr;
    self.cardLimitMoneyLabel.text = cardStr;
}


- (void)setDisableBtn:(BOOL)disableBtn {
    _disableBtn = disableBtn;
    _rechargeBtn.userInteractionEnabled = !disableBtn;
    if (disableBtn) {
        _rechargeBtn.layer.borderColor = COR12.CGColor;
        [_rechargeBtn setTitleColor:COR12 forState:UIControlStateNormal];
    } else {
        _rechargeBtn.layer.borderColor = kHXBColor_Blue040610.CGColor;
        [_rechargeBtn setTitleColor:kHXBColor_Blue040610 forState:UIControlStateNormal];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.location == 0 && [string isEqualToString:@"0"]) return NO;
    if (range.location == 0 && [string isEqualToString:@"."]) return NO;
    if (range.location == 11) return NO;
    NSString *checkStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (range.location == 0 && [string isEqualToString:@""]) return YES;
    return [NSString checkBothDecimalPlaces:checkStr];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.5 animations:^{
        _cardLimitMoneyLabel.y = 0;
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.2 animations:^{
        _cardLimitMoneyLabel.y = -kScrAdaptationH(35);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
