
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
#import "HXBTopUPView.h"//充值的view
#import "HXBFinBaseNegotiateView.h"//协议
@interface HXBFin_JoinimmediateView_Loan()<UITextFieldDelegate>

@property (nonatomic,strong) HXBFin_JoinimmediateView_Loan_ViewModel *model;
@property (nonatomic,strong) HXBRechargeView *rechargeView;//一键购买
@property (nonatomic,strong) HXBTopUPView *topUPView;
//加入上线
@property (nonatomic,strong) UIImageView *remainAmountLabelImageView;
@property (nonatomic,strong) UILabel *remainAmountLabel;
@property (nonatomic,strong) UILabel *remainAmount_Const;


/////预计收益
//@property (nonatomic,strong) UILabel *profitLabel;
//@property (nonatomic,strong) UILabel *profitLabel_const;
///散标投资标的剩余可投金额
@property (nonatomic,strong) UILabel *loanAcountLable_Const;
@property (nonatomic,strong) UILabel *loanAcountLabel;

///确定加入
@property (nonatomic,strong) UIButton *addButton;
///点击了一键购买
@property (nonatomic,copy) void (^clickBuyButton)(NSString *capitall,UITextField *textField);
///点击了充值
@property (nonatomic,copy) void (^clickRechargeButton)(UITextField *textField);
//点击了 服务协议clickNegotiateButton
@property (nonatomic,copy) void (^clickNegotiateButton)();
///点击了加入
@property (nonatomic,copy) void (^clickAddButton)(NSString *capital);
@property (nonatomic,strong) HXBFinBaseNegotiateView *negotiateView;
@property (nonatomic,assign) BOOL addButtonEndEditing;
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
    self.remainAmountLabel.text = model.remainAmountLabelStr;
    self.remainAmount_Const.text = model.remainAmountLabel_ConstStr;// @"标的剩余可投金额";
//    self.profitLabel_const.text = model.JoinImmediateView_Model.profitLabel_consttStr;//@"预计收益";
    self.negotiateView.negotiateStr = model.JoinImmediateView_Model.negotiateLabelStr;///@"我已阅读并同意";
    
    [self.addButton setTitle:model.JoinImmediateView_Model.addButtonStr forState:UIControlStateNormal];
    
    self.rechargeView.placeholder = model.JoinImmediateView_Model.rechargeViewTextField_placeholderStr;
    if (model.buyTextFieldText.length) {
        self.rechargeView.textField.text = model.buyTextFieldText;
    }
    [self.rechargeView.button setTitle:model.JoinImmediateView_Model.buyButtonStr forState:UIControlStateNormal];
    self.addButtonEndEditing = model.addButtonEndEditing;
    [self changeAddButtonWihtUserInteractionEnabled:model.addButtonEndEditing];//button是否可以点击
    kWeakSelf
    [self.topUPView setUPValueWithModel:^HXBTopUPViewManager *(HXBTopUPViewManager *model) {
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
        self.backgroundColor = kHXBColor_BackGround;
        /// 添加事件
        [self registerEvent];
    }
    return self;
}



///设置ViewS
- (void)creatViews {
    self.remainAmountLabelImageView = [[UIImageView alloc]init];
    self.remainAmountLabel = [[UILabel alloc]init];
    self.remainAmount_Const = [[UILabel alloc]init];
    
    self.rechargeView = [[HXBRechargeView alloc]init];
    self.rechargeViewTextField = self.rechargeView.textField;
    self.rechargeView.textField.delegate = self;
    self.rechargeView.textField.keyboardType = UIKeyboardTypeDecimalPad;
    
    self.topUPView = [[HXBTopUPView alloc]initWithFrame:CGRectZero];
    
    self.loanAcountLable_Const = [[UILabel alloc]init];
    self.loanAcountLabel = [[UILabel alloc]init];
    
//    self.profitLabel = [[UILabel alloc]init];
//    self.profitLabel_const = [[UILabel alloc]init];
    //充值
    self.topUPView = [[HXBTopUPView alloc]init];
    
    ///服务协议
    self.negotiateView = [[HXBFinBaseNegotiateView alloc]init];
    ///加入button
    self.addButton = [UIButton btnwithTitle:@"确认加入" andTarget:self andAction:@selector(clickAddButton:) andFrameByCategory:CGRectZero];
}

- (void)layoutViews {
    [self addSubview:_remainAmountLabelImageView];
    [self addSubview:_remainAmountLabel];
    [self addSubview:_remainAmount_Const];
    
    [self addSubview:self.rechargeView];
    [self addSubview:self.topUPView];
    
    [self addSubview:self.loanAcountLabel];
    [self addSubview:self.loanAcountLable_Const];

    [self addSubview:self.negotiateView];
    [self addSubview:self.addButton];
    
    //    [self addSubview:self.profitLabel_const];
    //    [self addSubview:self.profitLabel];
    
    [self.remainAmountLabelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@(kScrAdaptationH750(30)));
        make.height.width.equalTo(@(kScrAdaptationH750(30)));
    }];
    [self.remainAmount_Const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.remainAmountLabelImageView);
        make.height.equalTo(@(kScrAdaptationH750(28)));
        make.left.equalTo(self.remainAmountLabelImageView.mas_right).offset(kScrAdaptationW750(10));
    }];
    [self.remainAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.remainAmount_Const.mas_right).offset(kScrAdaptationW750(5));
        make.height.equalTo(self.remainAmount_Const);
        make.centerY.equalTo(self.remainAmount_Const);
    }];
    self.remainAmountLabelImageView.svgImageString = @"BUYtips";
    self.remainAmount_Const.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
    self.remainAmountLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
    self.remainAmountLabel.textColor = kHXBColor_Font0_6;
    self.remainAmount_Const.textColor = kHXBColor_Font0_6;
    
    //一键购买
    [self.rechargeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.remainAmount_Const.mas_bottom).offset(kScrAdaptationH750(30));
        make.right.left.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH750(140)));
    }];
    
    [self.topUPView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rechargeView.mas_bottom).offset(kScrAdaptationH750(23));
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH750(120)));
    }];
    [self.negotiateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topUPView.mas_bottom).offset(kScrAdaptationH750(20));
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH750(26)));
    }];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.negotiateView.mas_bottom).offset(kScrAdaptationH750(100));
        make.height.equalTo(@(kScrAdaptationH750(80)));
        make.left.equalTo(@(kScrAdaptationW750(40)));
        make.right.equalTo(@(kScrAdaptationW750(-40)));
    }];
    [self.loanAcountLable_Const sizeToFit];
//    //预计收益
//    [self.profitLabel_const mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(kScrAdaptationW(8));
//        make.top.equalTo(self.rechargeView.mas_bottom).offset(kScrAdaptationH(8));
//        make.height.equalTo(@(kScrAdaptationH(20)));
//    }];
//    [self.profitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.profitLabel_const.mas_right).offset(kScrAdaptationW(8));
//        make.height.equalTo(self.profitLabel_const);
//        make.top.equalTo(self.profitLabel_const);
//    }];
    //    [self.profitLabel sizeToFit];
    //    [self.profitLabel_const sizeToFit];
}
- (void)setUPViews {
    self.rechargeView.backgroundColor = [UIColor whiteColor];
    self.topUPView.backgroundColor = [UIColor whiteColor];
}

- (void)registerEvent {
    __weak typeof(self) weakSelf = self;
    //一键购买
    [self.rechargeView clickBuyButtonFunc:^{
        NSString *str = nil;
//        if (weakSelf.model.amount.floatValue > weakSelf.model.remainAmountLabelStr.floatValue) {
        str = [NSString stringWithFormat:@"%.2lf",weakSelf.model.remainAmountLabelStr.floatValue];
//        }else {
//            str = [NSString stringWithFormat:@"%.2lf",weakSelf.model.amount.floatValue];
//        }
        weakSelf.rechargeView.textField.text = str;
        if (weakSelf.clickBuyButton) {
            weakSelf.clickBuyButton(weakSelf.rechargeView.textField.text,weakSelf.rechargeView.textField);
        }
    }];
    
    //充值
    [self.topUPView clickRechargeFunc:^{
        if (weakSelf.clickRechargeButton) {
            weakSelf.clickRechargeButton(self.rechargeViewTextField);
        }
    }];

    //协议
    [self.negotiateView clickNegotiateWithBlock:^{
        NSLog(@"点击了 《红利假话服务协议》");
        if (self.clickNegotiateButton) {
            self.clickNegotiateButton();
        }
    }];
    [self.negotiateView clickCheckMarkWithBlock:^(BOOL isSelected) {
        [weakSelf changeAddButtonWihtUserInteractionEnabled:!isSelected];
    }];
}

- (void)changeAddButtonWihtUserInteractionEnabled:(BOOL)userInteractionEnabled {
    _addButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(32);
    _addButton.userInteractionEnabled = userInteractionEnabled;
    if (!userInteractionEnabled || !self.addButtonEndEditing) {
        _addButton.userInteractionEnabled = false;
        _addButton.backgroundColor = kHXBColor_Font0_6;
        [_addButton setTitleColor:kHXBColor_Grey_Font0_2 forState:UIControlStateNormal];
        return;
    }
    _addButton.backgroundColor = kHXBColor_Red_090303;
    [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
- (void)clickRechargeFunc: (void(^)(UITextField *textField))clickRechageButtonBlock {
    self.clickRechargeButton = clickRechageButtonBlock;
}


- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if ([theTextField isEqual:self.rechargeView.textField]) {
        [theTextField resignFirstResponder];
    }
    return YES;
}

///计算预计收益
- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField isEqual:self.rechargeView.textField]) {
        
        NSString *amount = [textField.text hxb_StringWithFormatAndDeleteLastChar:string];
        
//        self.profitLabel.text = [self.model.JoinImmediateView_Model totalInterestWithAmount:amount.floatValue];
    }
    return true;
}
- (BOOL) textFieldShouldEndEditing:(UITextField *)textField {
    if ([textField isEqual:self.rechargeView.textField]) {
//        先判断是否>=1000，再判断是否为1000的整数倍（追加时只需判断是否为1000的整数倍），错误，toast提示“起投金额1000元”或“投资金额应为1000的整数倍
//        if (!(textField.text.floatValue >= 1000)) {
//            NSLog(@"请输入大于等于1000");
//            [HxbHUDProgress showTextWithMessage:@"起投金额1000元"];
//            return false;
//        }
//        if ((textField.text.integerValue % 1000) != 0) {
//            NSLog(@"1000的整数倍");
//            [HxbHUDProgress showTextWithMessage:@"投资金额应为1000的整数倍"];
//            return false;
//        }
        //        self.profitLabel.text = self.model.
        
//        self.profitLabel.text = [self.model.JoinImmediateView_Model totalInterestWithAmount:textField.text.integerValue];
    }
    return true;
}
@end

@implementation HXBFin_JoinimmediateView_Loan_ViewModel
- (void)setProfitLabelStr:(NSString *)profitLabelStr {
    _profitLabelStr = [_JoinImmediateView_Model totalInterestWithAmount:profitLabelStr.floatValue];
}
@end
