
//
//  HXBFin_JoinimmediateView_Loan.m
//  hoomxb
//
//  Created by HXB on 2017/6/20.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_JoinimmediateView_Loan.h"
#import "HXBRechargeView.h"
#import "HXBJoinImmediateView.h"
@interface HXBFin_JoinimmediateView_Loan()<UITextFieldDelegate>

@property (nonatomic,strong) HXBFin_JoinimmediateView_Loan_ViewModel *model;
@property (nonatomic,strong) HXBRechargeView *rechargeView;



///预计收益
@property (nonatomic,strong) UILabel *profitLabel;
@property (nonatomic,strong) UILabel *profitLabel_const;
///散标投资标的剩余可投金额
@property (nonatomic,strong) UILabel *loanAcountLable_Const;
@property (nonatomic,strong) UILabel *loanAcountLabel;

///确定加入
@property (nonatomic,strong) UIButton *addButton;
///点击了一键购买
@property (nonatomic,copy) void (^clickBuyButton)(NSString *capitall,UITextField *textField);
///点击了充值
@property (nonatomic,copy) void (^clickRechargeButton)();
//点击了 服务协议clickNegotiateButton
@property (nonatomic,copy) void (^clickNegotiateButton)();
///点击了加入
@property (nonatomic,copy) void (^clickAddButton)(NSString *capital);
///服务协议
@property (nonatomic,strong) UILabel *negotiateLabel;
///服务协议 button
@property (nonatomic,strong) UIButton *negotiateButton;
@end
@implementation HXBFin_JoinimmediateView_Loan

- (void)setIsEndEditing:(BOOL)isEndEditing {
    _isEndEditing = isEndEditing;
    [self endEditing:isEndEditing];
    self.rechargeView.isEndEditing = isEndEditing;
}

- (void)setUPValueWithModelBlock:(HXBFin_JoinimmediateView_Loan_ViewModel *(^)(HXBFin_JoinimmediateView_Loan_ViewModel *model))setUPValueBlock {
    self.model = setUPValueBlock(self.model);
}

- (void)setModel:(HXBFin_JoinimmediateView_Loan_ViewModel *)model {
    
    _model = model;
    self.loanAcountLable_Const.text = model.loanAcountLable_ConstStr;// @"标的剩余可投金额";
    self.loanAcountLabel.text = model.loanAcountLabelStr;//
    self.profitLabel_const.text = model.JoinImmediateView_Model.profitLabel_consttStr;//@"预计收益";
    self.negotiateLabel.text = model.JoinImmediateView_Model.negotiateLabelStr;///@"我已阅读并同意";
    [self.negotiateButton setTitle: model.JoinImmediateView_Model.negotiateButtonStr forState: UIControlStateNormal];
    [self.addButton setTitle:model.JoinImmediateView_Model.addButtonStr forState:UIControlStateNormal];
    self.rechargeView.placeholder = model.JoinImmediateView_Model.rechargeViewTextField_placeholderStr;
    [self.rechargeView.button setTitle:model.JoinImmediateView_Model.buyButtonStr forState:UIControlStateNormal];
    kWeakSelf
    [self.rechargeView setUPValueWithModel:^HXBRechargeView_Model *(HXBRechargeView_Model *model) {
        ///余额 title
        model.balanceLabel_constStr = weakSelf.model.JoinImmediateView_Model.balanceLabel_constStr;
        ///余额展示
        model.balanceLabelStr = weakSelf.model.JoinImmediateView_Model.balanceLabelStr;
        ///充值的button
        model.rechargeButtonStr = weakSelf.model.JoinImmediateView_Model.rechargeButtonStr;
        return model;
    }];
}

- (void)setIsPlan:(BOOL)isPlan {
    _isPlan = isPlan;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _model = [[HXBFin_JoinimmediateView_Loan_ViewModel alloc]init];
        _model.JoinImmediateView_Model = [[HXBJoinImmediateView_Model alloc]init];
        // 创建
        [self creatViews];
        // 布局
        [self layoutViews];
        /// setUPViews
        [self setUPViews];
        self.backgroundColor = [UIColor colorWithWhite:.95 alpha:1];
        /// 添加事件
        [self registerEvent];
    }
    return self;
}
- (void)setUPViews {
    [self.negotiateButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.addButton.backgroundColor = [UIColor blueColor];
    
    [self.negotiateButton addTarget:self action:@selector(clickNegotiateButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.addButton addTarget:self action:@selector(clickAddButton:) forControlEvents:UIControlEventTouchUpInside];
}



///设置ViewS
- (void)creatViews {
    self.rechargeView = [[HXBRechargeView alloc]init];
    self.rechargeViewTextField = self.rechargeView.textField;
    self.rechargeView.textField.delegate = self;
    self.rechargeView.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.loanAcountLable_Const = [[UILabel alloc]init];
    self.loanAcountLabel = [[UILabel alloc]init];
    
    self.profitLabel = [[UILabel alloc]init];
    self.profitLabel_const = [[UILabel alloc]init];
    
    self.negotiateButton = [[UIButton alloc]init];
    self.negotiateLabel = [[UILabel alloc]init];
    
    self.addButton = [[UIButton alloc]init];
}

- (void)layoutViews {
    [self addSubview:self.rechargeView];
    
    [self addSubview:self.loanAcountLabel];
    [self addSubview:self.loanAcountLable_Const];
    
    [self addSubview:self.profitLabel_const];
    [self addSubview:self.profitLabel];
    
    [self addSubview:self.negotiateLabel];
    [self addSubview:self.negotiateButton];
    
    [self addSubview:self.addButton];
    
    [self.rechargeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kScrAdaptationH(80));
        make.right.left.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(150)));
    }];
    
    //预计收益
    [self.profitLabel_const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW(8));
        make.top.equalTo(self.rechargeView.mas_bottom).offset(kScrAdaptationH(8));
        make.height.equalTo(@(kScrAdaptationH(20)));
    }];
    [self.profitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.profitLabel_const.mas_right).offset(kScrAdaptationW(8));
        make.height.equalTo(self.profitLabel_const);
        make.top.equalTo(self.profitLabel_const);
    }];
    
    ///标的剩余可投金额
    [self.loanAcountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.profitLabel_const);
        make.right.equalTo(self).offset(-8);
        make.width.equalTo(@(kScrAdaptationW(80)));
    }];
    [self.loanAcountLable_Const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.loanAcountLabel.mas_left).offset(kScrAdaptationW(-8));
        make.top.bottom.equalTo(self.profitLabel_const).offset(0);
        make.width.equalTo(@(kScrAdaptationW(80)));
    }];
    
//    [self.loanAcountLabel sizeToFit];
    [self.loanAcountLable_Const sizeToFit];
    [self.profitLabel sizeToFit];
    [self.profitLabel_const sizeToFit];
    
    [self.negotiateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW(50));
        make.height.equalTo(@(kScrAdaptationH(30)));
        make.top.equalTo(self.profitLabel_const.mas_bottom).offset(20);
    }];
    [self.negotiateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.negotiateLabel.mas_right).offset(0);
        make.height.bottom.equalTo(self.negotiateLabel);
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.negotiateButton.mas_bottom).offset(50);
        make.width.equalTo(@(kScrAdaptationW(60)));
        make.height.equalTo(@(kScrAdaptationH(50)));
        make.centerX.equalTo(self);
    }];
}


- (void)registerEvent {
    __weak typeof(self) weakSelf = self;
    [self.rechargeView clickRechargeFunc:^{
        if (weakSelf.clickRechargeButton) {
            weakSelf.clickRechargeButton();
        }
    }];
    [self.rechargeView clickBuyButtonFunc:^{
        NSString *str = nil;
        if (weakSelf.model.amount.floatValue > weakSelf.model.loanAcountLabelStr.floatValue) {
            str = weakSelf.model.loanAcountLabelStr;
        }else {
            str = weakSelf.model.amount;
        }
        weakSelf.rechargeView.textField.text = str;
        if (weakSelf.clickBuyButton) {
            weakSelf.clickBuyButton(weakSelf.rechargeView.textField.text,weakSelf.rechargeView.textField);
        }
    }];
}

//点击了 服务协议
- (void)clickNegotiateButton: (UIButton *)button {
    NSLog(@"点击了 红利假话服务协议》");
    if (self.clickNegotiateButton) {
        self.clickNegotiateButton();
    }
}

///点击了加入
- (void)clickAddButton: (UIButton *)button {
    NSLog(@"点了确认加入");
    if (self.clickAddButton) {
        self.clickAddButton(self.rechargeView.textField.text);
    }
}

//点击了 服务协议
- (void)clickNegotiateButtonFunc: (void(^)())clickNegotiateButtonBlock{
    self.clickNegotiateButton = clickNegotiateButtonBlock;
}

///点击了加入
- (void)clickAddButtonFunc: (void(^)(NSString *capital))clickAddButtonBlock{
    self.clickAddButton = clickAddButtonBlock;
}

///点击了一键购买
- (void)clickBuyButtonFunc:(void(^)(NSString *capitall,UITextField *textField))clickBuyButtonBlock {
    self.clickBuyButton = clickBuyButtonBlock;
}
///点击了充值
- (void)clickRechargeFunc: (void(^)())clickRechageButtonBlock {
    self.clickRechargeButton = clickRechageButtonBlock;
}


- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if ([theTextField isEqual:self.rechargeView.textField]) {
        [theTextField resignFirstResponder];
    }
    return YES;
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField isEqual:self.rechargeView.textField]) {
        
        NSString *amount = [textField.text hxb_StringWithFormatAndDeleteLastChar:string];
        
        self.profitLabel.text = [self.model.JoinImmediateView_Model totalInterestWithAmount:amount.floatValue];
    }
    return true;
}
- (BOOL) textFieldShouldEndEditing:(UITextField *)textField {
    if ([textField isEqual:self.rechargeView.textField]) {
        // 先判断是否>=1000，再判断是否为1000的整数倍（追加时只需判断是否为1000的整数倍），错误，toast提示“起投金额1000元”或“投资金额应为1000的整数倍
//        if (!(textField.text.floatValue >= 1000)) {
//            NSLog(@"请输入大于等于1000");
//            [HxbHUDProgress showTextWithMessage:@"起投金额1000元"];
//            return false;
//        }
//        if ((textField.text.integerValue % 1000) != 0) {
//            NSLog(@"1000的整数倍");
//            [HxbHUDProgress showTextWithMessage:@"投资金额应为1000的整数倍"];
//            return false;
//        }
        //        self.profitLabel.text = self.model.
        
        self.profitLabel.text = [self.model.JoinImmediateView_Model totalInterestWithAmount:textField.text.integerValue];
    }
    return true;
}
@end

@implementation HXBFin_JoinimmediateView_Loan_ViewModel
- (void)setProfitLabelStr:(NSString *)profitLabelStr {
    _profitLabelStr = [_JoinImmediateView_Model totalInterestWithAmount:profitLabelStr.floatValue];
}
@end
