//
//  HXBWithdrawCardView.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBWithdrawCardView.h"
#import "HXBBankCardListViewController.h"
@interface HXBWithdrawCardView ()
@property (nonatomic, strong) UITextField *bankCardTextField;
@property (nonatomic, strong) UIButton *bankNameBtn;
@property (nonatomic, strong) UITextField *phoneNumberTextField;
@property (nonatomic, strong) UIButton *nextButton;
//@property (nonatomic, strong) UILabel *cardholderTipLabel;
//@property (nonatomic, strong) UILabel *cardholderLabel;
@property (nonatomic, strong) HXBBaseView_TwoLable_View *cardholderLabel;
@property (nonatomic, strong) UILabel *tieOnCard;
@end

@implementation HXBWithdrawCardView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.bankCardTextField];
        [self addSubview:self.bankNameBtn];
        [self addSubview:self.phoneNumberTextField];
        [self addSubview:self.nextButton];
        [self addSubview:self.cardholderLabel];
        [self addSubview:self.tieOnCard];
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubViewFrame];
    }
    return self;
}

- (void)setupSubViewFrame
{
    [self.cardholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.equalTo(@44);
        make.top.equalTo(@84);
    }];
    
    [self.tieOnCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.cardholderLabel.mas_bottom).offset(-10);
    }];
    [self.bankNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.equalTo(@44);
        make.top.equalTo(self.cardholderLabel.mas_bottom).offset(20);
    }];
    [self.bankCardTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.equalTo(@44);
        make.top.equalTo(self.bankNameBtn.mas_bottom).offset(20);
    }];
    [self.phoneNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.equalTo(@44);
        make.top.equalTo(self.bankCardTextField.mas_bottom).offset(20);
    }];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.equalTo(@44);
        make.top.equalTo(self.phoneNumberTextField.mas_bottom).offset(20);
    }];
    
}

- (void)bankNameBtnClick
{
    if (self.bankNameBtnClickBlock) {
        self.bankNameBtnClickBlock(self.bankNameBtn);
    }
}

- (void)nextButtonClick
{
    if (self.nextButtonClickBlock) {
        self.nextButtonClickBlock(self.bankCardTextField.text);
    }
}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    //设置虚线颜色
    CGContextSetStrokeColorWithColor(currentContext, COR11.CGColor);
    //设置虚线宽度
    CGContextSetLineWidth(currentContext, 1);
    //设置虚线绘制起点
    CGContextMoveToPoint(currentContext, 0, self.cardholderLabel.bottom);
    //设置虚线绘制终点
    CGContextAddLineToPoint(currentContext, self.width, self.cardholderLabel.bottom);
    //设置虚线排列的宽度间隔:下面的arr中的数字表示先绘制3个点再绘制1个点
    CGFloat arr[] = {3,1};
    //下面最后一个参数“2”代表排列的个数。
    CGContextSetLineDash(currentContext, 0, arr, 2);
    CGContextDrawPath(currentContext, kCGPathStroke);
}

#pragma mark - 懒加载
- (UITextField *)bankCardTextField{
    if (!_bankCardTextField) {
        _bankCardTextField = [UITextField hxb_lineTextFieldWithFrame:CGRectMake(20, 100, SCREEN_WIDTH - 40, 44)];
        _bankCardTextField.placeholder = @"银行卡";
        _bankCardTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _bankCardTextField;
}

- (UIButton *)bankNameBtn{
    if (!_bankNameBtn) {
        _bankNameBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_bankCardTextField.frame) + 20, SCREEN_WIDTH - 40, 44)];
        [_bankNameBtn setTitle:@"所属名称" forState:UIControlStateNormal];
        [_bankNameBtn setTitleColor:COR11 forState:UIControlStateNormal];
        [_bankNameBtn addTarget:self action:@selector(bankNameBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _bankNameBtn.layer.borderWidth = 0.5;
        _bankNameBtn.layer.borderColor = COR12.CGColor;
    }
    return _bankNameBtn;
    
}


- (UITextField *)phoneNumberTextField{
    if (!_phoneNumberTextField) {
        _phoneNumberTextField = [UITextField hxb_lineTextFieldWithFrame:CGRectMake(20, CGRectGetMaxY(self.bankNameBtn.frame) + 20, SCREEN_WIDTH - 40, 44)];
        _phoneNumberTextField.placeholder = @"预留手机号";
    }
    return _phoneNumberTextField;
}



- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [UIButton btnwithTitle:@"绑卡" andTarget:self andAction:@selector(nextButtonClick) andFrameByCategory:CGRectMake(20, CGRectGetMaxY(_phoneNumberTextField.frame) + 40, SCREEN_WIDTH - 40, 44)];
    }
    return _nextButton;
}
- (HXBBaseView_TwoLable_View *)cardholderLabel
{
    if (!_cardholderLabel) {
        _cardholderLabel = [[HXBBaseView_TwoLable_View alloc] init];
        [_cardholderLabel setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
            viewModelVM.leftLabelStr = @"持卡人";
            viewModelVM.isLeftRight = YES;
            return viewModelVM;
        }];
    }
    return _cardholderLabel;
}

- (UILabel *)tieOnCard
{
    if (!_tieOnCard) {
        _tieOnCard = [[UILabel alloc] init];
        _tieOnCard.text = @"  绑定银行卡  ";
        _tieOnCard.backgroundColor = [UIColor whiteColor];
    }
    return _tieOnCard;
}

@end
