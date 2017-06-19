//
//  HXBJoinImmediateView.m
//  hoomxb
//
//  Created by HXB on 2017/6/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBJoinImmediateView.h"
#import "HXBRechargeView.h"///充值



@interface HXBJoinImmediateView ()<UITextFieldDelegate>
@property (nonatomic,strong) HXBJoinImmediateView_Model *model;
@property (nonatomic,strong) HXBRechargeView *rechargeView;
///加入上线
@property (nonatomic,strong) UILabel *upperLimitLabel;
@property (nonatomic,strong) UILabel *upperLimitLabel_const;

@property (nonatomic,strong) UIView  *profitView;
///收益方式
@property (nonatomic,strong) UILabel *profitTypeLable_Const;
///收益方法
@property (nonatomic,strong) UILabel *profitTypeLabel;

///预计收益
@property (nonatomic,strong) UILabel *profitLabel;
@property (nonatomic,strong) UILabel *profitLabel_count;


///确定加入
@property (nonatomic,strong) UIButton *addButton;

///点击了一键购买
@property (nonatomic,copy) void (^clickBuyButton)(NSString *capital);
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

@implementation HXBJoinImmediateView
- (void)setUPValueWithModelBlock:(HXBJoinImmediateView_Model *(^)(HXBJoinImmediateView_Model *model))setUPValueBlock {
    self.model = setUPValueBlock(self.model);
}
- (void)setModel:(HXBJoinImmediateView_Model *)model {
    _model = model;
    self.profitTypeLable_Const.text = model.profitTypeLable_ConstStr;// @"收益处理方式";
    self.profitTypeLabel.text = model.profitTypeLabelStr;//@"收益在投资";
    self.profitLabel_count.text = model.profitLabel_consttStr;//@"预计收益";
    self.upperLimitLabel.text = model.upperLimitLabelStr;///@"本期计划加入上线 50,000元";
    self.upperLimitLabel_const.text = model.upperLimitLabel_constStr;
    self.negotiateLabel.text = model.negotiateLabelStr;///@"我已阅读并同意";
    [self.negotiateButton setTitle: model.negotiateButtonStr forState: UIControlStateNormal];
    [self.addButton setTitle:model.addButtonStr forState:UIControlStateNormal];
    self.profitTypeLabel.text = model.profitTypeLabelStr;
    self.rechargeView.placeholder = model.rechargeViewTextField_placeholderStr;
    [self.rechargeView.button setTitle:model.buyButtonStr forState:UIControlStateNormal];
    kWeakSelf
    [self.rechargeView setUPValueWithModel:^HXBRechargeView_Model *(HXBRechargeView_Model *model) {
        ///余额 title
        model.balanceLabel_constStr = weakSelf.model.balanceLabel_constStr;
        ///余额展示
        model.balanceLabelStr = weakSelf.model.balanceLabelStr;
        ///充值的button
        model.rechargeButtonStr = weakSelf.model.rechargeButtonStr;
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
        _model = [[HXBJoinImmediateView_Model alloc]init];
        // 创建
        [self creatViews];
        // 布局
        [self layoutViews];
        /// setUPViews
        [self setUPViews];
        self.profitView.backgroundColor = [UIColor whiteColor];
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
    self.rechargeView.textField.delegate = self;
    self.rechargeView.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.upperLimitLabel = [[UILabel alloc]init];
    self.upperLimitLabel_const = [[UILabel alloc]init];
    self.profitView = [[UIView alloc]init];
    self.profitTypeLable_Const = [[UILabel alloc]init];
    self.profitTypeLabel = [[UILabel alloc]init];
    
    self.profitLabel = [[UILabel alloc]init];
    self.profitLabel_count = [[UILabel alloc]init];
    
    self.negotiateButton = [[UIButton alloc]init];
    self.negotiateLabel = [[UILabel alloc]init];
    
    self.addButton = [[UIButton alloc]init];
}

- (void)layoutViews {
    [self addSubview:self.rechargeView];
    [self addSubview:_upperLimitLabel];
    [self addSubview:self.upperLimitLabel_const];
    
    [self addSubview:_profitView];
    [self.profitView addSubview:self.profitTypeLable_Const];
    [self.profitView addSubview:self.profitTypeLabel];
    
    [self addSubview:self.profitLabel_count];
    [self addSubview:self.profitLabel];
    
    [self addSubview:self.negotiateLabel];
    [self addSubview:self.negotiateButton];
    
    [self addSubview:self.addButton];
    
    [self.rechargeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kScrAdaptationH(80));
        make.right.left.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(150)));
    }];
    [self.upperLimitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rechargeView.mas_bottom).offset(kScrAdaptationH(7));
        make.left.equalTo(self.upperLimitLabel_const.mas_right).offset(kScrAdaptationW(7));
    }];
    [self.upperLimitLabel_const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rechargeView.mas_bottom).offset(kScrAdaptationH(7));
        make.left.equalTo(self).offset(kScrAdaptationW(30));
    }];
    [self.profitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.upperLimitLabel.mas_bottom).offset(kScrAdaptationH(20));
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(50)));
    }];
    [self.profitTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.profitView);
        make.right.equalTo(self.profitView).offset(kScrAdaptationW(-20));
        make.height.equalTo(@(kScrAdaptationH(30)));
    }];
    [self.profitTypeLable_Const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.profitView);
        make.left.equalTo(self.profitView).offset(kScrAdaptationW(20));
        make.height.equalTo(self.profitTypeLabel);
    }];
    [self.profitLabel_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW(20));
        make.height.equalTo(@(kScrAdaptationH(20)));
        make.top.equalTo(self.profitView.mas_bottom).offset(10);
    }];
    [self.profitLabel_count sizeToFit];
    [self.profitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.profitLabel_count);
        make.left.equalTo(self.profitLabel_count.mas_right).offset(10);
        make.height.equalTo(self.profitLabel_count);
    }];
    
    
    [self.negotiateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW(50));
        make.height.equalTo(@(kScrAdaptationH(30)));
        make.top.equalTo(self.profitLabel_count.mas_bottom).offset(20);
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
        if (weakSelf.clickBuyButton) {
            weakSelf.clickBuyButton(weakSelf.rechargeView.textField.text);
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
- (void)clickBuyButtonFunc:(void(^)(NSString *capital))clickBuyButtonBlock {
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

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField {
    if ([textField isEqual:self.rechargeView.textField]) {
        // 先判断是否>=1000，再判断是否为1000的整数倍（追加时只需判断是否为1000的整数倍），错误，toast提示“起投金额1000元”或“投资金额应为1000的整数倍
        if (!(textField.text.floatValue >= 1000)) {
            NSLog(@"请输入大于等于1000");
            [HxbHUDProgress showTextWithMessage:@"起投金额1000元"];
            return false;
        }
        if ((textField.text.integerValue % 1000) != 0) {
            NSLog(@"1000的整数倍");
            [HxbHUDProgress showTextWithMessage:@"投资金额应为1000的整数倍"];
            return false;
        }
//        self.profitLabel.text = self.model.
        self.profitLabel.text = [self.model totalInterestWithAmount:textField.text.integerValue];
    }
    return true;
}
@end


@implementation HXBJoinImmediateView_Model
/**
预期收益
 */
- (NSString *) totalInterestWithAmount: (CGFloat)amount {
    return [NSString hxb_getPerMilWithDouble: ((amount * self.totalInterest.floatValue) / 100)];
}
@end
