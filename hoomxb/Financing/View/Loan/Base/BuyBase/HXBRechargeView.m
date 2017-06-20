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
@property (nonatomic,strong) HXBRechargeView_Model *model;
@property (nonatomic,strong) HXBBaseTextField *buyTextField;
///余额 title
@property (nonatomic,strong) UILabel *balanceLabel_const;
///余额展示
@property (nonatomic,strong) UILabel *balanceLabel;
///充值的button
@property (nonatomic,strong) UIButton *rechargeButton;

///点击了一键购买
@property (nonatomic,copy) void (^clickBuyButton)();
///点击了充值
@property (nonatomic,copy) void (^clickRechargeButton)();
@end
@implementation HXBRechargeView
@synthesize model = _model;

- (void)setIsEndEditing:(BOOL)isEndEditing {
    _isEndEditing = isEndEditing;
    [self.textField endEditing:isEndEditing];
    [self.buyTextField endEditing:isEndEditing];
    [self.buyTextField.textField endEditing:isEndEditing];
}

- (HXBRechargeView_Model *)model {
    if (!_model) {
        _model = [[HXBRechargeView_Model alloc]init];
    }
    return _model;
}

- (void) setUPValueWithModel: (HXBRechargeView_Model *(^)(HXBRechargeView_Model *model))setUPValueBlock {
    self.model = setUPValueBlock(self.model);
}

- (void) setModel:(HXBRechargeView_Model *)model {
    ///余额 title
    self.balanceLabel.text = model.balanceLabelStr;
    ///余额展示
     self.balanceLabel_const.text = model.balanceLabel_constStr;
    ///充值的button
    [self.rechargeButton setTitle: model.rechargeButtonStr forState:UIControlStateNormal];
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
    
    self.rechargeButton = [[UIButton alloc]init];
    self.balanceLabel = [[UILabel alloc]init];
    self.balanceLabel_const = [[UILabel alloc]init];
    [self addSubview: self.buyTextField];
    [self addSubview: self.rechargeButton];
    [self addSubview: self.balanceLabel_const];
    [self addSubview: self.balanceLabel];
    
    [self.buyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kScrAdaptationH(0));
        make.left.equalTo(self).offset(kScrAdaptationW(20));
        make.height.equalTo(@(kScrAdaptationH(50)));
        make.right.equalTo(@(kScrAdaptationW(-20)));
    }];
    [self.balanceLabel_const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.buyTextField.mas_bottom).offset(kScrAdaptationH(5));
        make.left.equalTo(self.buyTextField);
        make.height.equalTo(self.buyTextField);
    }];
    [self.balanceLabel_const sizeToFit];
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self.balanceLabel_const);
        make.left.equalTo(self.balanceLabel_const.mas_right).offset(kScrAdaptationW(20));
    }];
    [self.balanceLabel sizeToFit];
    [self.rechargeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.balanceLabel);
        make.right.equalTo(self.buyTextField);
        make.width.equalTo(@(kScrAdaptationW(50)));
    }];
    
    [self.buyTextField show];
    self.buyTextField.textField.placeholder = self.placeholder;
    
    self.buyTextField.textField.delegate = self;
    self.buyTextField.textField.borderStyle = UITextBorderStyleRoundedRect;
//    [self.buyTextField.button setTitle:@"一键购买" forState:UIControlStateNormal];
    [self.buyTextField.button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    self.balanceLabel_const.text = kHXBPlan_JoinbalanceLabel_constStr;
//    [self.rechargeButton setTitle:@"充值" forState:UIControlStateNormal];
    [self.rechargeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    self.balanceLabel.text = @"111111";
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.buyTextField.textField.placeholder = self.placeholder;
}

///事件注册
- (void)registerEvent {
    [self.buyTextField.button addTarget:self action:@selector(clickBuyButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.rechargeButton addTarget:self action:@selector(clickRechargeButton:) forControlEvents:UIControlEventTouchUpInside];
}

///点击了 购买按钮
- (void)clickBuyButton: (UIButton *)button {
    NSLog(@"%@ 一键购买",self);
    if (self.clickBuyButton) {
        self.clickBuyButton();
    }
}
///点击了 充值按钮
- (void)clickRechargeButton: (UIButton *)button {
    NSLog(@"%@ 充值",self);
    self.clickRechargeButton();
}

///点击了一键购买
- (void)clickBuyButtonFunc:(void(^)())clickBuyButtonBlock {
    self.clickBuyButton = clickBuyButtonBlock;
}
///点击了充值
- (void)clickRechargeFunc: (void(^)())clickRechageButtonBlock {
    self.clickRechargeButton = clickRechageButtonBlock;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}
@end

@implementation HXBRechargeView_Model
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
@end
