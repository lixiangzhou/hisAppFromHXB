//
//  HXBCreditorChangeTopView.m
//  hoomxb
//
//  Created by 肖扬 on 2017/9/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBCreditorChangeTopView.h"
#import "HXBMy_Withdraw_notifitionView.h"


@interface HXBCreditorChangeTopView ()<UITextFieldDelegate>
// 一键购买
@property (nonatomic,strong) UIView *rechargeView;
// 待转让金额
@property (nonatomic,strong) UILabel *creditorLabel;
@property (nonatomic, strong) HXBMy_Withdraw_notifitionView *notifitionView;
@property (nonatomic, strong) HXBCustomTextField *rechargeViewTextField;
@property (nonatomic, strong) UIButton *rechargeBtn;
/** 银行限额弹框 */
@property (nonatomic, strong)  UILabel *cardLimitMoneyLabel;
/** 预期收益 */
@property (nonatomic, strong)  UILabel *profitLabel;
/** 收益方式 */
@property (nonatomic, strong)  UILabel *profitTypeLabel;
/** 预期收益 */
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIImageView *leftImage;

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
    [self addSubview:self.notifitionView];
    [self addSubview:self.topView];
    [self addSubview:self.backView];
    [self addSubview:self.rechargeView];
    [self.topView addSubview:self.creditorLabel];
    [self.rechargeView addSubview:self.rechargeViewTextField];
    [self.rechargeView addSubview:self.leftImage];
    [self.rechargeView addSubview:self.rechargeBtn];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH(0.5))];
    lineView.backgroundColor = COR26;
    [self.backView addSubview:lineView];
    [self.backView addSubview:self.profitLabel];
    [self.backView addSubview:self.profitTypeLabel];
    [self setupFrame];
}

- (void)setupFrame {
    kWeakSelf
    [_notifitionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.width.equalTo(self);
        make.height.offset(kScrAdaptationH(0));
    }];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_notifitionView.mas_bottom);
        make.left.equalTo(self);
        make.width.equalTo(self);
        make.height.offset(kScrAdaptationH(35));
    }];
    
    [_creditorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView);
        make.left.equalTo(self).offset(kScrAdaptationW750(30));
        make.width.offset(kScreenWidth - 2 * kScrAdaptationW(15));
        make.height.offset(kScrAdaptationH(35));
    }];
    
    [_rechargeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView).offset(kScrAdaptationH(35));
        make.left.equalTo(self);
        make.width.offset(kScreenWidth);
        make.height.offset(kScrAdaptationH(65));
    }];
    
    [_leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_rechargeView).offset(kScrAdaptationH750(46.5));
        make.left.equalTo(self).offset(kScrAdaptationW(15));
        make.width.offset(kScrAdaptationW750(27));
        make.height.offset(kScrAdaptationW750(37));
    }];
    
    [_rechargeViewTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_rechargeView).offset(kScrAdaptationH(15));
        make.left.equalTo(self).offset(kScrAdaptationW(5));
        make.width.offset(kScreenWidth - kScrAdaptationW(95));
        make.height.offset(kScrAdaptationH(35));
    }];

    [_rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_rechargeView).offset(kScrAdaptationH750(35));
        make.left.equalTo(self).offset(kScreenWidth - kScrAdaptationW(95));
        make.width.offset(kScrAdaptationW(80));
        make.height.offset(kScrAdaptationH(30));
    }];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_bottom).offset(kScrAdaptationH(65));
        make.left.equalTo(self);
        make.width.offset(kScreenWidth);
        make.height.offset(kScrAdaptationH(35));
    }];
    
    [_profitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf.backView);
        make.left.equalTo(weakSelf).offset(kScrAdaptationW(15));
        make.right.equalTo(weakSelf).offset(-kScrAdaptationW(75));
        make.height.offset(kScrAdaptationH(35));
    }];
    
    [_profitTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.profitLabel);
        make.width.offset(kScrAdaptationW(60));
        make.height.offset(kScrAdaptationH(24));
        make.right.equalTo(weakSelf.backView).offset(kScrAdaptationH(-15));
    }];
}

- (void)setHiddenProfitLabel:(BOOL)hiddenProfitLabel {
    _hiddenProfitLabel = hiddenProfitLabel;
    _backView.hidden = hiddenProfitLabel;
}

- (void)clickButton:(UIButton *)sender {
    self.block();
}

- (void)alertTip {
    if (self.alertTipBlock) {
        self.alertTipBlock();
    }
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
        _cardLimitMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH(40))];
        _cardLimitMoneyLabel.textAlignment = NSTextAlignmentCenter;
        _cardLimitMoneyLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _cardLimitMoneyLabel.textColor = [UIColor whiteColor];
        _cardLimitMoneyLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return _cardLimitMoneyLabel;
}
- (UILabel *)profitLabel {
    if (!_profitLabel) {
        _profitLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _profitLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _profitLabel.textColor = COR10;
    }
    return _profitLabel;
}
- (UILabel *)profitTypeLabel {
    if (!_profitTypeLabel) {
        _profitTypeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _profitTypeLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _profitTypeLabel.textColor = COR29;
        _profitTypeLabel.textAlignment = NSTextAlignmentCenter;
        _profitTypeLabel.layer.borderWidth = kXYBorderWidth;
        _profitTypeLabel.layer.borderColor = COR29.CGColor;
        _profitTypeLabel.layer.cornerRadius = kScrAdaptationW(4);
    }
    return _profitTypeLabel;
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
    _rechargeBtn.hidden = _isHiddenBtn;
    if (isHiddenBtn) {
        [_rechargeViewTextField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_rechargeView).offset(kScrAdaptationH(15));
            make.left.equalTo(self).offset(kScrAdaptationW(5));
            make.width.offset(kScreenWidth - kScrAdaptationW(15));
            make.height.offset(kScrAdaptationH(35));
        }];
    } else {
        [_rechargeViewTextField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_rechargeView).offset(kScrAdaptationH(15));
            make.left.equalTo(self).offset(kScrAdaptationW(5));
            make.width.offset(kScreenWidth - kScrAdaptationW(95));
            make.height.offset(kScrAdaptationH(35));
        }];
    }
}

- (void)setDisableKeyBorad:(BOOL)disableKeyBorad {
    _disableKeyBorad = disableKeyBorad;
    _rechargeViewTextField.disableEdit = disableKeyBorad;
}

- (void)setCardStr:(NSString *)cardStr {
    _cardStr = cardStr;
}

- (void)setHasBank:(BOOL)hasBank {
    _hasBank = hasBank;
    if (_hasBank) {
        [_notifitionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.width.equalTo(self);
            make.height.offset(kScrAdaptationH(40));
        }];
        _notifitionView.messageCount = _cardStr;
        _notifitionView.hidden = NO;
    } else {
        [_notifitionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.width.equalTo(self);
            make.height.offset(kScrAdaptationH(0));
        }];
        _notifitionView.hidden = YES;
    }
}

- (void)setProfitType:(NSString *)profitType {
    _profitTypeLabel.hidden = !profitType.length;
    if (profitType.length) {
        _profitTypeLabel.text = profitType;
        CGFloat width = [profitType boundingRectWithSize:CGSizeMake(100, 100) options:0 attributes:@{NSFontAttributeName: self.profitTypeLabel.font} context:nil].size.width;
        [_profitTypeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(width + 12);
        }];
    }
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

- (void)setProfitStr:(NSString *)profitStr {
    _profitStr = profitStr;
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:profitStr];
    if (profitStr.length > 5) {
        [attributedStr addAttribute:NSForegroundColorAttributeName value:COR29 range:NSMakeRange(4, profitStr.length - 5)];
    }
    _profitLabel.attributedText = attributedStr;
}

- (void)setProfitStr:(NSString *)profitStr andSubsidy:(NSString *)subsidy {
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:@"预期收益" attributes:@{NSForegroundColorAttributeName: COR10}];
    [attrText appendAttributedString:[[NSAttributedString alloc] initWithString:profitStr attributes:@{NSForegroundColorAttributeName: COR29}]];
    [attrText appendAttributedString:[[NSAttributedString alloc] initWithString:@"元，加息收益" attributes:@{NSForegroundColorAttributeName: COR10}]];
    [attrText appendAttributedString:[[NSAttributedString alloc] initWithString:subsidy attributes:@{NSForegroundColorAttributeName: COR29}]];
    [attrText appendAttributedString:[[NSAttributedString alloc] initWithString:@"元 " attributes:@{NSForegroundColorAttributeName: COR10}]];
    
    NSTextAttachment *attachment = [NSTextAttachment new];
    attachment.image = [UIImage imageNamed:@"lightblue_tip"];
    attachment.bounds = CGRectMake(0, -2, 14, 14);
    [attrText appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
    
    _profitLabel.attributedText = attrText;
}

- (void)setIsNewPlan:(BOOL)isNewPlan {
    _isNewPlan = isNewPlan;
    if (isNewPlan) {
        kWeakSelf
        [_profitLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf).offset(-kScrAdaptationW(15));
        }];
        _profitTypeLabel.hidden = YES;
        
        [self.backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alertTip)]];
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

- (HXBMy_Withdraw_notifitionView *)notifitionView {
    if (!_notifitionView) {
        _notifitionView = [[HXBMy_Withdraw_notifitionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH(0))];
    }
    _notifitionView.hidden = YES;
    _notifitionView.block = ^{
        NSLog(@"点击了消息");
    };
    return _notifitionView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _topView;
}
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectZero];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}
- (UIView *)rechargeView {
    if (!_rechargeView) {
        _rechargeView = [[UIView alloc] initWithFrame:CGRectZero];
        _rechargeView.backgroundColor = [UIColor whiteColor];
    }
    return _rechargeView;
}

- (UIImageView *)leftImage {
    if (!_leftImage) {
        _leftImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _leftImage.image = [UIImage imageNamed:@"hxb_my_message人民币"];
        _leftImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _leftImage;
}

- (HXBCustomTextField *)rechargeViewTextField {
    kWeakSelf;
    if (!_rechargeViewTextField) {
        _rechargeViewTextField = [[HXBCustomTextField alloc] initWithFrame:CGRectZero];
        _rechargeViewTextField.keyboardType = UIKeyboardTypeDecimalPad;
        _rechargeViewTextField.isHidenLine = YES;
        _rechargeViewTextField.delegate = self;
        _rechargeViewTextField.isLagerText = YES;
        _rechargeViewTextField.isCleanAllBtn = YES;
        _rechargeViewTextField.block = ^(NSString *text) {
            weakSelf.changeBlock(text);
        };
    }
    return _rechargeViewTextField;
}


- (UIButton *) rechargeBtn{
    if (!_rechargeBtn) {
        _rechargeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _rechargeBtn.frame = CGRectZero;
        [_rechargeBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [_rechargeBtn setTitle:@"一键购买" forState:(UIControlStateNormal)];
        _rechargeBtn.layer.cornerRadius = kScrAdaptationW750(5);
        _rechargeBtn.layer.masksToBounds = YES;
        _rechargeBtn.layer.borderColor = kHXBColor_Blue040610.CGColor;//(r:0.45 g:0.68 b:0.68 a:1.00)
        _rechargeBtn.layer.borderWidth = kXYBorderWidth;
        [_rechargeBtn setTitleColor:kHXBColor_Blue040610 forState:UIControlStateNormal];
        _rechargeBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
    }
    return _rechargeBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
