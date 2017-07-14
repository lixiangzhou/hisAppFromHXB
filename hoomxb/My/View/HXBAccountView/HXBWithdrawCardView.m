//
//  HXBWithdrawCardView.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBWithdrawCardView.h"
#import "HXBBankCardListViewController.h"
#import "SVGKImage.h"
#import "HXBCustomTextField.h"
@interface HXBWithdrawCardView ()
//@property (nonatomic, strong) UITextField *bankCardTextField;
@property (nonatomic, strong) UIButton *bankNameBtn;
//@property (nonatomic, strong) UITextField *phoneNumberTextField;
@property (nonatomic, strong) UIButton *nextButton;
//@property (nonatomic, strong) UILabel *cardholderTipLabel;
//@property (nonatomic, strong) UILabel *cardholderLabel;
@property (nonatomic, strong) HXBBaseView_TwoLable_View *cardholderLabel;
@property (nonatomic, strong) HXBCustomTextField *bankNameTextField;
@property (nonatomic, strong) HXBCustomTextField *bankCardTextField;
@property (nonatomic, strong) HXBCustomTextField *phoneNumberTextField;
@end

@implementation HXBWithdrawCardView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = BACKGROUNDCOLOR;
        [self addSubview:self.bankCardTextField];
        [self addSubview:self.bankNameTextField];
        [self addSubview:self.bankNameBtn];
        [self addSubview:self.phoneNumberTextField];
        [self addSubview:self.nextButton];
        [self addSubview:self.cardholderLabel];
        
//        [self addSubview:self.tieOnCard];
        [self setupSubViewFrame];
    }
    return self;
}

- (void)setupSubViewFrame
{
    [self.cardholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kScrAdaptationW750(164));
        make.right.equalTo(self.mas_right).offset(kScrAdaptationW750(-164));
        make.height.offset(kScrAdaptationH750(80));
        make.top.equalTo(self);
    }];
    
//    [self.tieOnCard mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self);
//        make.top.equalTo(self.cardholderLabel.mas_bottom).offset(-10);
//    }];
    [self.bankNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.cardholderLabel.mas_bottom);
        make.height.offset(kScrAdaptationH750(100));
    }];
    [self.bankNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.cardholderLabel.mas_bottom);
        make.height.offset(kScrAdaptationH750(100));
    }];
    
    
    [self.bankCardTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.offset(kScrAdaptationH750(100));
        make.top.equalTo(self.bankNameTextField.mas_bottom);
    }];
    [self.phoneNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.offset(kScrAdaptationH750(100));
        make.top.equalTo(self.bankCardTextField.mas_bottom);
    }];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kScrAdaptationW750(40));
        make.right.equalTo(self.mas_right).offset(kScrAdaptationW750(-40));
        make.height.offset(kScrAdaptationH750(82));
        make.top.equalTo(self.phoneNumberTextField.mas_bottom).offset(kScrAdaptationH750(136));
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
//- (void)drawRect:(CGRect)rect {
//    [super drawRect:rect];
//    CGContextRef currentContext = UIGraphicsGetCurrentContext();
//    //设置虚线颜色
//    CGContextSetStrokeColorWithColor(currentContext, COR11.CGColor);
//    //设置虚线宽度
//    CGContextSetLineWidth(currentContext, 1);
//    //设置虚线绘制起点
//    CGContextMoveToPoint(currentContext, 0, self.cardholderLabel.bottom);
//    //设置虚线绘制终点
//    CGContextAddLineToPoint(currentContext, self.width, self.cardholderLabel.bottom);
//    //设置虚线排列的宽度间隔:下面的arr中的数字表示先绘制3个点再绘制1个点
//    CGFloat arr[] = {3,1};
//    //下面最后一个参数“2”代表排列的个数。
//    CGContextSetLineDash(currentContext, 0, arr, 2);
//    CGContextDrawPath(currentContext, kCGPathStroke);
//}

#pragma mark - 懒加载
- (HXBCustomTextField *)bankCardTextField{
    if (!_bankCardTextField) {
        _bankCardTextField = [[HXBCustomTextField alloc] initWithFrame:CGRectZero];
        _bankCardTextField.placeholder = @"银行卡号";
        _bankCardTextField.leftImage = [SVGKImage imageNamed:@"bankcard.svg"].UIImage;
    }
    return _bankCardTextField;
}

- (HXBCustomTextField *)bankNameTextField
{
    if (!_bankNameTextField) {
        _bankNameTextField = [[HXBCustomTextField alloc] initWithFrame:CGRectZero];
        _bankNameTextField.placeholder = @"银行名称";
        _bankNameTextField.leftImage = [SVGKImage imageNamed:@"bank.svg"].UIImage;
        _bankNameTextField.rightImage = [SVGKImage imageNamed:@"arrow.svg"].UIImage;
    }
    return _bankNameTextField;
}

- (UIButton *)bankNameBtn{
    if (!_bankNameBtn) {
        _bankNameBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_bankCardTextField.frame) + 20, SCREEN_WIDTH - 40, 44)];
        [_bankNameBtn setBackgroundColor:[UIColor clearColor]];
        [_bankNameBtn addTarget:self action:@selector(bankNameBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bankNameBtn;
    
}


- (HXBCustomTextField *)phoneNumberTextField{
    if (!_phoneNumberTextField) {
        _phoneNumberTextField = [[HXBCustomTextField alloc] initWithFrame:CGRectZero];
        _phoneNumberTextField.placeholder = @"预留手机号";
        _phoneNumberTextField.leftImage = [SVGKImage imageNamed:@"mobile_number"].UIImage;
        _phoneNumberTextField.isHidenLine = YES;
    }
    return _phoneNumberTextField;
}



- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [UIButton btnwithTitle:@"绑卡" andTarget:self andAction:@selector(nextButtonClick) andFrameByCategory:CGRectMake(20, CGRectGetMaxY(_phoneNumberTextField.frame) + 40, SCREEN_WIDTH - 40, 44)];
        _nextButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(32);
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextButton.backgroundColor = RGB(245, 81, 81);
    }
    return _nextButton;
}
- (HXBBaseView_TwoLable_View *)cardholderLabel
{
    if (!_cardholderLabel) {
        _cardholderLabel = [[HXBBaseView_TwoLable_View alloc] init];
        [_cardholderLabel setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
            viewModelVM.leftLabelStr = @"持卡人：*惠";
            viewModelVM.rightLabelStr = @"210********029";
            viewModelVM.isLeftRight = YES;
            viewModelVM.leftLabelAlignment = NSTextAlignmentLeft;
            viewModelVM.rightLabelAlignment = NSTextAlignmentRight;
            viewModelVM.leftFont = kHXBFont_PINGFANGSC_REGULAR_750(28);
            viewModelVM.leftViewColor = RGB(153, 153, 153);
            viewModelVM.rightFont = kHXBFont_PINGFANGSC_REGULAR_750(28);
            viewModelVM.rightViewColor = RGB(153, 153, 153);
            return viewModelVM;
        }];
    }
    return _cardholderLabel;
}

//- (UILabel *)tieOnCard
//{
//    if (!_tieOnCard) {
//        _tieOnCard = [[UILabel alloc] init];
//        _tieOnCard.text = @"  绑定银行卡  ";
//        _tieOnCard.backgroundColor = [UIColor whiteColor];
//    }
//    return _tieOnCard;
//}

@end
