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
@interface HXBWithdrawCardView ()<UITextFieldDelegate>
//@property (nonatomic, strong) UITextField *bankCardTextField;
//@property (nonatomic, strong) UIButton *bankNameBtn;
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
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bankCardTextField];
        [self addSubview:self.bankNameTextField];
        [self addSubview:self.phoneNumberTextField];
        [self addSubview:self.nextButton];
        [self addSubview:self.cardholderLabel];
        
//        [self addSubview:self.tieOnCard];
        [self setupSubViewFrame];
        
        [self loadUserInfoData];
    }
    return self;
}

- (void)loadUserInfoData
{
    [KeyChain downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        [self.cardholderLabel setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
            viewModelVM.leftLabelStr = [NSString stringWithFormat:@"持卡人：%@",[viewModel.userInfoModel.userInfo.realName replaceStringWithStartLocation:0 lenght:viewModel.userInfoModel.userInfo.realName.length - 1]];
            if (viewModel.userInfoModel.userInfo.realName.length > 4) {
                viewModelVM.leftLabelStr = [NSString stringWithFormat:@"持卡人：***%@", [viewModel.userInfoModel.userInfo.realName substringFromIndex:viewModel.userInfoModel.userInfo.realName.length - 1]];
            }
            viewModelVM.rightLabelStr = [viewModel.userInfoModel.userInfo.idNo replaceStringWithStartLocation:1 lenght:viewModel.userInfoModel.userInfo.idNo.length - 2];
            return viewModelVM;
        }];
    } andFailure:^(NSError *error) {
        
    }];
}


- (void)setupSubViewFrame
{
    [self.cardholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kScrAdaptationW750(150));
        make.right.equalTo(self.mas_right).offset(kScrAdaptationW750(-150));
        make.height.offset(kScrAdaptationH750(80));
        make.top.equalTo(self);
    }];
    
//    [self.tieOnCard mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self);
//        make.top.equalTo(self.cardholderLabel.mas_bottom).offset(-10);
//    }];

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


- (void)nextButtonClick
{
    if (self.nextButtonClickBlock) {
        if ([self judgeIsNull]) return;
        NSDictionary *dic = @{
                              @"bankCard" : self.bankCardTextField.text,
                              @"bankReservedMobile" : self.phoneNumberTextField.text,
                              @"bankCode" : self.bankCode
                              };
        self.nextButtonClickBlock(dic);
    }
}
- (BOOL)judgeIsNull
{
    BOOL isNull = NO;
    if (!(self.bankCode.length > 0)) {
        [HxbHUDProgress showMessageCenter:@"没有选择银行" inView:self];
        isNull = YES;
        return isNull;
    }
    if (!(self.bankCardTextField.text.length >= 10 && self.bankCardTextField.text.length <= 25)) {
        
        [HxbHUDProgress showMessageCenter:@"请输入正确的卡号" inView:self];
        isNull = YES;
        return isNull;
    }
    if (![NSString isMobileNumber:self.phoneNumberTextField.text]) {
        [HxbHUDProgress showMessageCenter:@"请输入正确手机号" inView:self];
        isNull = YES;
        return isNull;
    }
    return isNull;
}

- (void)setBankName:(NSString *)bankName
{
    _bankName = bankName;
    self.bankNameTextField.text = bankName;
}

#pragma mark - 懒加载
- (HXBCustomTextField *)bankCardTextField{
    if (!_bankCardTextField) {
        _bankCardTextField = [[HXBCustomTextField alloc] initWithFrame:CGRectZero];
        _bankCardTextField.placeholder = @"银行卡号";
        _bankCardTextField.keyboardType = UIKeyboardTypeNumberPad;
        _bankCardTextField.delegate = self;
        _bankCardTextField.limitStringLength = 25;
        _bankCardTextField.leftImage = [UIImage imageNamed:@"bankcard"];
    }
    return _bankCardTextField;
}

- (HXBCustomTextField *)bankNameTextField
{
    if (!_bankNameTextField) {
        kWeakSelf
        _bankNameTextField = [[HXBCustomTextField alloc] initWithFrame:CGRectZero];
        _bankNameTextField.placeholder = @"银行名称";
        _bankNameTextField.leftImage = [SVGKImage imageNamed:@"bank.svg"].UIImage;
        _bankNameTextField.rightImage = [SVGKImage imageNamed:@"more.svg"].UIImage;

        _bankNameTextField.btnClick = ^{
            if (weakSelf.bankNameBtnClickBlock) {
                weakSelf.bankNameBtnClickBlock();
            }
        };
        
    }
    return _bankNameTextField;
}



- (HXBCustomTextField *)phoneNumberTextField{
    if (!_phoneNumberTextField) {
        _phoneNumberTextField = [[HXBCustomTextField alloc] initWithFrame:CGRectZero];
        _phoneNumberTextField.placeholder = @"预留手机号";
        _phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneNumberTextField.delegate = self;
        _phoneNumberTextField.limitStringLength = 11;
        _phoneNumberTextField.leftImage = [UIImage imageNamed:@"mobile_number"];
    }
    return _phoneNumberTextField;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.superview == _phoneNumberTextField) {
        NSString *str = nil;
        if (string.length) {
            str = [NSString stringWithFormat:@"%@%@",textField.text,string];
        } else if(!string.length) {
            NSInteger length = self.phoneNumberTextField.text.length;
            NSRange range = NSMakeRange(length - 1, 1);
            NSMutableString *strM = self.phoneNumberTextField.text.mutableCopy;
            [strM deleteCharactersInRange:range];
            str = strM.copy;
        }
        if (str.length > 11) {
            return NO;
        }
    } else {
        NSString *str = nil;
        if (string.length) {
            str = [NSString stringWithFormat:@"%@%@",textField.text,string];
        } else if(!string.length) {
            NSInteger length = self.bankCardTextField.text.length;
            NSRange range = NSMakeRange(length - 1, 1);
            NSMutableString *strM = self.bankCardTextField.text.mutableCopy;
            [strM deleteCharactersInRange:range];
            str = strM.copy;
        }
        if (str.length > 25) {
            return NO;
        }
    }
    
    return YES;
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
//            viewModelVM.leftLabelStr = @"持卡人：*惠";
//            viewModelVM.rightLabelStr = @"210********029";
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
