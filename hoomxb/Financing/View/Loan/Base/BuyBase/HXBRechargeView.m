//
//  HXBRechargeView.m
//  hoomxb
//
//  Created by HXB on 2017/6/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRechargeView.h"
static NSString *const kHXBPlan_JoinbalanceLabel_constStr = @"可用余额";

@interface HXBRechargeView () <UITextFieldDelegate>
///金额labelconst
@property (nonatomic,strong) UILabel *amountLabel_counst;
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
    
    
    self.amountLabel_counst = [[UILabel alloc]init];
  
    
    [self addSubview:self.amountLabel_counst];
    [self addSubview: self.buyTextField];
    
 
    [self.amountLabel_counst mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(kScrAdaptationW(30));
        make.height.equalTo(@(kScrAdaptationH750(40)));
        make.width.equalTo(@(kScrAdaptationW750(112)));
    }];
  
  
    [self.buyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self.amountLabel_counst).offset(kScrAdaptationH(0));
        make.right.equalTo(self).offset(kScrAdaptationW750(-30));
        make.left.equalTo(self.amountLabel_counst.mas_right).offset(kScrAdaptationW750(78));
    }];
   
 
    
    [self.buyTextField show];
    self.buyTextField.textField.placeholder = self.placeholder;
    self.buyTextField.textField.delegate = self;
    [self.buyTextField.button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
   
  
    self.amountLabel_counst.font = kHXBFont_PINGFANGSC_REGULAR_750(40);
    self.amountLabel_counst.textColor = kHXBColor_Grey_Font0_2;
    
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.buyTextField.textField.placeholder = self.placeholder;
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

