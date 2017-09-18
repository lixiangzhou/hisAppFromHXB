//
//  HXBRechargeView.m
//  hoomxb
//
//  Created by HXB on 2017/6/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRechargeView.h"

@interface HXBRechargeView () <UITextFieldDelegate>
///金额labelconst
@property (nonatomic,strong) HXBBaseTextField *buyTextField;

///点击了一键购买
@property (nonatomic,copy) void (^clickBuyButton)();

@end
@implementation HXBRechargeView


- (void)setIsEndEditing:(BOOL)isEndEditing {
    _isEndEditing = isEndEditing;
    [self.textField endEditing:isEndEditing];
    [self.buyTextField endEditing:isEndEditing];
    [self.buyTextField.textField endEditing:isEndEditing];
}

- (UITextField *)textField {
    return self.buyTextField.textField;
}

- (UIButton *)button {
    return self.buyTextField.button;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUPViews];
        [self registerEvent];
    }
    return self;
}

///设置ViewS
- (void)setUPViews {
    self.buyTextField = [[HXBBaseTextField alloc]initWithFrame:CGRectZero andBottomLienSpace:0 andBottomLienHeight:kScrAdaptationH(2) andRightButtonW:kScrAdaptationW(80)];
    self.buyTextField.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.leftLabel = [[UILabel alloc]init];
  
    
    [self addSubview:self.leftLabel];
    [self addSubview: self.buyTextField];
    
 
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kScrAdaptationH750(40));
        make.bottom.equalTo(self).offset(kScrAdaptationH750(-40));
        make.left.equalTo(self).offset(kScrAdaptationW750(30));
        make.width.equalTo(@(kScrAdaptationW750(112)));
        
    }];
  
  
    [self.buyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self.leftLabel).offset(kScrAdaptationH750(0));
        make.right.equalTo(self).offset(kScrAdaptationW750(-30));
        make.left.equalTo(self.leftLabel.mas_right).offset(kScrAdaptationW750(0));
    }];
   
    [self.buyTextField show];
//    self.buyTextField.textField.placeholder = self.placeholder;
    self.buyTextField.textField.delegate = self;
//    if (self.placeholder.length > 0) {
//        self.buyTextField.textField.attributedPlaceholder = [NSAttributedString setupAttributeStringWithString:self.placeholder WithRange:NSMakeRange(0, self.placeholder.length) andAttributeColor:kHXBColor_Font0_5 andAttributeFont:kHXBFont_PINGFANGSC_REGULAR(14)];
//    }
    [self.buyTextField.button setTitleColor:kHXBColor_Blue040610 forState:UIControlStateNormal];

    self.leftLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(36);
    self.leftLabel.textColor = kHXBColor_Grey_Font0_2;
    self.leftLabel.text = @"金额：";
}


- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
//    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self.placeholder];
//    // 设置字体和设置字体的范围
//    [attrStr addAttribute:NSForegroundColorAttributeName
//                    value:COR10
//                    range:NSMakeRange(0, self.placeholder.length)];
//    self.buyTextField.textField.placeholder = self.placeholder;
    self.buyTextField.textField.attributedPlaceholder = [NSAttributedString setupAttributeStringWithString:self.placeholder WithRange:NSMakeRange(0, self.placeholder.length) andAttributeColor:kHXBColor_Font0_6 andAttributeFont:kHXBFont_PINGFANGSC_REGULAR(14)];
}

///事件注册
- (void)registerEvent {
    [self.buyTextField.button addTarget:self action:@selector(clickBuyButton:) forControlEvents:UIControlEventTouchUpInside];
}

///点击了 购买按钮
- (void)clickBuyButton: (UIButton *)button {
    NSLog(@"%@ 一键购买",self);
    if (self.clickBuyButton) {
        self.clickBuyButton();
    }
}


///点击了一键购买
- (void)clickBuyButtonFunc:(void(^)())clickBuyButtonBlock {
    self.clickBuyButton = clickBuyButtonBlock;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}
@end

