//
//  HXBJoinImmediateView.m
//  hoomxb
//
//  Created by HXB on 2017/6/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBJoinImmediateView.h"
#import "HXBRechargeView.h"///购买
#import "HXBtopUPView.h"///充值
#import "HXBFinBaseNegotiateView.h"///服务协议

@interface HXBJoinImmediateView ()<UITextFieldDelegate>
@property (nonatomic,strong) HXBJoinImmediateView_Model *model;
///加入上线
@property (nonatomic,strong) UILabel *upperLimitLabel;
@property (nonatomic,strong) UIImageView *upperLimitImageView;
@property (nonatomic,strong) UILabel *upperLimitLabel_const;
//一键购买
@property (nonatomic,strong) HXBRechargeView *rechargeView;
///预计收益
@property (nonatomic,strong) UILabel *profitLabel;
@property (nonatomic,strong) UILabel *profitLabel_count;
///充值
@property (nonatomic,strong) HXBTopUPView *topUPView;

@property (nonatomic,strong) UIView  *profitView;
///收益方式
@property (nonatomic,strong) UILabel *profitTypeLable_Const;
///收益方法
@property (nonatomic,strong) UILabel *profitTypeLabel;
@property (nonatomic,strong) HXBFinBaseNegotiateView *negotiateView;

///确定加入
@property (nonatomic,strong) UIButton *addButton;

///点击了一键购买
@property (nonatomic,copy) void (^clickBuyButton)(NSString *capitall,UITextField *textField);
///点击了充值
@property (nonatomic,copy) void (^clickRechargeButton)();
//点击了 服务协议clickNegotiateButton
@property (nonatomic,copy) void (^clickNegotiateButton)();
///点击了加入
@property (nonatomic,copy) void (^clickAddButton)(UITextField *textField,NSString *capital);


@end

@implementation HXBJoinImmediateView

- (void)setIsEndEditing:(BOOL)isEndEditing {
    _isEndEditing = isEndEditing;
    [self endEditing:isEndEditing];
    self.rechargeView.isEndEditing = isEndEditing;
}

- (void)setUPValueWithModelBlock:(HXBJoinImmediateView_Model *(^)(HXBJoinImmediateView_Model *model))setUPValueBlock {
    self.model = setUPValueBlock(self.model);
}
- (void)setModel:(HXBJoinImmediateView_Model *)model {
    _model = model;
    self.profitTypeLable_Const.text = model.profitTypeLable_ConstStr;// @"收益处理方式";
    self.profitTypeLabel.text = model.profitTypeLabelStr;//@"收益在投资";
    self.profitLabel_count.text = model.profitLabel_consttStr;//@"预计收益";
    self.upperLimitLabel.text = [NSString hxb_getPerMilWithIntegetNumber:model.upperLimitLabelStr.doubleValue];///@"本期计划加入上线 50,000元";
    self.upperLimitLabel_const.text = model.upperLimitLabel_constStr;
  
    [self.addButton setTitle:model.addButtonStr forState:UIControlStateNormal];
    [self setUPAddButtonValueWithSelecter:true];///设置button 为可以点击
    self.profitTypeLabel.text = model.profitTypeLabelStr;
    self.rechargeView.placeholder = model.rechargeViewTextField_placeholderStr;
    [self.rechargeView.button setTitle:model.buyButtonStr forState:UIControlStateNormal];
    kWeakSelf
    [self.topUPView setUPValueWithModel:^HXBTopUPViewManager *(HXBTopUPViewManager *model) {
        ///余额 title
        model.balanceLabel_constStr = weakSelf.model.balanceLabel_constStr;
        ///余额展示
        model.balanceLabelStr = weakSelf.model.balanceLabelStr;
        ///充值的button
        model.rechargeButtonStr = weakSelf.model.rechargeButtonStr;
        return model;
    }];
    self.negotiateView.negotiateStr = model.negotiateLabelStr;
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
        /// 添加事件
        [self registerEvent];
    }
    return self;
}
- (void)setUPViews {
    self.profitView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = kHXBColor_BackGround;
    self.addButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(32);
    self.addButton.userInteractionEnabled = false;
    [self.addButton addTarget:self action:@selector(clickAddButton:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setUPAddButtonValueWithSelecter:(BOOL) userInteractionEnabled {
    _addButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(32);
    _addButton.userInteractionEnabled = userInteractionEnabled;
    if (!userInteractionEnabled) {
        _addButton.backgroundColor = kHXBColor_Font0_5;
        return;
    }
    _addButton.backgroundColor = kHXBColor_Red_090303;
    [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}


///设置ViewS
- (void)creatViews {
    //上限
    self.upperLimitLabel = [[UILabel alloc]init];
    self.upperLimitImageView = [[UIImageView alloc]init];
    self.upperLimitLabel_const = [[UILabel alloc]init];
    
    //一键购买
    self.rechargeView = [[HXBRechargeView alloc]init];
    self.rechargeView.backgroundColor = [UIColor whiteColor];
    self.rechargeViewTextField = self.rechargeView.textField;
    self.rechargeView.textField.delegate = self;
    self.rechargeViewTextField.keyboardType = UIKeyboardTypeNumberPad;
    //充值
    self.topUPView = [[HXBTopUPView alloc]init];
    
    // 预期收益
    self.profitView = [[UIView alloc]init];
    self.profitLabel = [[UILabel alloc]init];
    self.profitLabel_count = [[UILabel alloc]init];
  
    ///服务协议
    self.negotiateView = [[HXBFinBaseNegotiateView alloc]init];
    [self clickNegotiateBtn];
    self.addButton = [[UIButton alloc]init];
}

- (void)layoutViews {
    [self addSubview:self.upperLimitImageView];
    [self addSubview:_upperLimitLabel];
    [self addSubview:self.upperLimitLabel_const];

    //一键购买
    [self addSubview:self.rechargeView];
    
    //预期收益
    [self addSubview:_profitView];
    [self.profitView addSubview:self.profitLabel_count];
    [self.profitView addSubview:self.profitLabel];
    [self.profitView addSubview:self.topUPView];
    
    ///服务协议
    [self addSubview:self.negotiateView];
    
    [self addSubview:self.addButton];
    
    
    //上线
    [self.upperLimitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kScrAdaptationH750(30));
        make.left.equalTo(self).offset(kScrAdaptationW750(30));
        make.height.width.equalTo(@(kScrAdaptationH750(30)));
    }];
    [self.upperLimitLabel_const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.upperLimitImageView);
        make.left.equalTo(self.upperLimitImageView.mas_right).offset(kScrAdaptationW750(10));
        make.height.equalTo(@(kScrAdaptationH750(28)));
    }];
    [self.upperLimitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.upperLimitLabel_const);
        make.left.equalTo(self.upperLimitLabel_const.mas_right).offset(kScrAdaptationW750(2));
        make.height.equalTo(@(kScrAdaptationH750(28)));
    }];
  
    _upperLimitImageView.svgImageString = @"BUYtips";
    self.upperLimitLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
    self.upperLimitLabel.textColor = kHXBColor_Font0_6;
    self.upperLimitLabel_const.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
    self.upperLimitLabel_const.textColor = kHXBColor_Font0_6;

    
    [self.rechargeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.upperLimitLabel.mas_bottom).offset(kScrAdaptationH750(30));
        make.right.left.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH750(140)));
    }];
    
    //充值这一组
    [self.profitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rechargeView.mas_bottom).offset(kScrAdaptationH750(20));
        make.height.equalTo(@(kScrAdaptationH750(190)));
        make.right.left.equalTo(self);
    }];
    [self.profitLabel_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.profitView).offset(kScrAdaptationH750(50));
        make.left.equalTo(self).offset(kScrAdaptationW750(30));
        make.height.equalTo(@(kScrAdaptationH750(30)));
    }];
    self.profitLabel_count.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
    self.profitLabel_count.textColor = kHXBColor_Grey_Font0_2;
    [self.profitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.profitLabel_count);
        make.left.equalTo(self.profitLabel_count.mas_right).offset(kScrAdaptationW750(8));
    }];
    self.profitLabel.text = @"0.00元";
    self.profitLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
    self.profitLabel.textColor = kHXBColor_Grey_Font0_2;
    
    [self.topUPView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.profitLabel.mas_bottom).offset(kScrAdaptationH750(30));
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH750(30)));
    }];
 
    [self.negotiateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.profitView.mas_bottom).offset(kScrAdaptationH750(20));
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH750(26)));
    }];
    
    //加入
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.negotiateView.mas_bottom).offset(kScrAdaptationH750(100));
        make.left.equalTo(self).offset(kScrAdaptationW750(40));
        make.right.equalTo(self).offset(kScrAdaptationW750(-40));
        make.height.equalTo(@(kScrAdaptationH750(82)));
    }];
    self.addButton.backgroundColor = kHXBColor_Red_090303;
    self.addButton.layer.cornerRadius = kScrAdaptationH750(5);
    self.addButton.layer.masksToBounds = true;
}


- (void)registerEvent {
    __weak typeof(self) weakSelf = self;
    [self.topUPView clickRechargeFunc:^{
        if (weakSelf.clickRechargeButton) {
            weakSelf.clickRechargeButton();
        }
    }];
    [self.rechargeView clickBuyButtonFunc:^{
        if (weakSelf.clickBuyButton) {
            weakSelf.clickBuyButton(weakSelf.rechargeView.textField.text,weakSelf.rechargeView.textField);
            weakSelf.profitLabel.text = [weakSelf.model totalInterestWithAmount:weakSelf.rechargeView.textField.text.floatValue];
        }
    }];
    [self.negotiateView clickCheckMarkWithBlock:^(BOOL isSelected) {
        [weakSelf setUPAddButtonValueWithSelecter:isSelected];
    }];
}

//点击了 服务协议
- (void)clickNegotiateBtn{
    NSLog(@"点击了《红利服务协议》");
    kWeakSelf
    [self.negotiateView clickNegotiateWithBlock:^{
        if (weakSelf.clickNegotiateButton) {
            weakSelf.clickNegotiateButton();
        }
    }];
    
}

///点击了加入
- (void)clickAddButton: (UIButton *)button {
    NSLog(@"点了确认加入");
    // 先判断是否>=1000，再判断是否为1000的整数倍（追加时只需判断是否为1000的整数倍），错误，toast提示“起投金额1000元”或“投资金额应为1000的整数倍
    if (self.clickAddButton) {
        self.clickAddButton(self.rechargeView.textField,self.rechargeView.textField.text);
        self.profitLabel.text = [self.model totalInterestWithAmount:self.rechargeView.textField.text.floatValue];
    }
}

//点击了 服务协议
- (void)clickNegotiateButtonFunc: (void(^)())clickNegotiateButtonBlock{
    self.clickNegotiateButton = clickNegotiateButtonBlock;
}

///点击了加入
- (void)clickAddButtonFunc: (void(^)(UITextField *textField,NSString *capital))clickAddButtonBlock{
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.location == 0 && [string isEqualToString:@"0"]) return NO;
    if ([string isEqualToString:@"."]) return NO;
    if (range.location == 11) return NO;
    if ([textField isEqual:self.rechargeView.textField]) {
        NSString *amount = [textField.text hxb_StringWithFormatAndDeleteLastChar:string];
        self.profitLabel.text = [self.model totalInterestWithAmount:amount.floatValue];
    }
    return true;
}
- (BOOL) textFieldShouldEndEditing:(UITextField *)textField {

    self.profitLabel.text = [self.model totalInterestWithAmount:textField.text.floatValue];
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
