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
#import "HXBCardBinModel.h"
#import "HXBOpenDepositAccountRequest.h"
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
@property (nonatomic, strong) UIButton *seeLimitBtn;
/** bankCardID */
@property (nonatomic, copy) NSString *bankCardID;
@property (nonatomic, strong) UIView *line;
@end

@implementation HXBWithdrawCardView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kHXBColor_BackGround;
        [self addSubview:self.bankCardTextField];
        [self addSubview:self.bankNameTextField];
        [self addSubview:self.seeLimitBtn];
        [self addSubview:self.phoneNumberTextField];
        [self addSubview:self.nextButton];
        [self addSubview:self.cardholderLabel];
        [self addSubview:self.line];
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

    [self.seeLimitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cardholderLabel.mas_bottom);;
        make.right.equalTo(self);
        make.height.offset(kScrAdaptationH(50));
        make.width.offset(kScrAdaptationW(100));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seeLimitBtn.mas_bottom);;
        make.right.equalTo(self).offset(kScrAdaptationW(-15));
        make.left.equalTo(self).offset(kScrAdaptationW(15));
        make.height.offset(0.5);
    }];
    
    [self.bankCardTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.seeLimitBtn.mas_left).offset(kScrAdaptationH(20));
        make.top.equalTo(self.cardholderLabel.mas_bottom);
        make.height.offset(kScrAdaptationH750(100));
    }];
    
    [self.bankNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.offset(kScrAdaptationH750(100));
        make.top.equalTo(self.bankCardTextField.mas_bottom);
    }];

//    [self.phoneNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left);
//        make.right.equalTo(self.mas_right);
//        make.height.offset(kScrAdaptationH750(100));
//        make.top.equalTo(self.bankNameTextField.mas_bottom).offset(kScrAdaptationH(10));
//    }];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kScrAdaptationW750(40));
        make.right.equalTo(self.mas_right).offset(kScrAdaptationW750(-40));
        make.height.offset(kScrAdaptationH750(82));
        make.top.equalTo(self.phoneNumberTextField.mas_bottom).offset(kScrAdaptationH750(123));
    }];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.bankNameTextField.hidden){
        self.phoneNumberTextField.frame = CGRectMake(0, CGRectGetMaxY(self.bankCardTextField.frame) + kScrAdaptationH(10), kScreenWidth, kScrAdaptationH750(100));
    }
}


- (void)nextButtonClick
{
    if (self.nextButtonClickBlock) {
        kWeakSelf
        if ([self judgeIsNull]) return;
        [HXBOpenDepositAccountRequest checkCardBinResultRequestWithSmscode:_bankCardID andisToastTip:YES andSuccessBlock:^(HXBCardBinModel *cardBinModel) {
//            [weakSelf checkCardBin:cardBinModel];
            weakSelf.cardBinModel = cardBinModel;
            NSDictionary *dic = @{
                                  @"bankCard" : _bankCardID,
                                  @"bankReservedMobile" : self.phoneNumberTextField.text,
                                  @"bankCode" : self.cardBinModel.bankCode
                                  };
            self.nextButtonClickBlock(dic);
            
        } andFailureBlock:^(NSError *error) {
            weakSelf.isCheckFailed = YES;
        }];
        
    }
}
- (BOOL)judgeIsNull
{
    BOOL isNull = NO;
//    if (!(self.bankCode.length > 0)) {
//        [HxbHUDProgress showMessageCenter:@"没有选择银行" inView:self];
//        isNull = YES;
//        return isNull;
//    }
    if (!(self.bankCardTextField.text.length > 0)) {
        [HxbHUDProgress showMessageCenter:@"银行卡号不能为空" inView:self];
        isNull = YES;
        return isNull;
    }
    if (!(self.bankCardTextField.text.length >= 10 && self.bankCardTextField.text.length <= 31)) {
        [HxbHUDProgress showMessageCenter:@"您银行卡号有误，请重新输入" inView:self];
        isNull = YES;
        return isNull;
    }
    if (self.cardBinModel.creditCard) {
        [HxbHUDProgress showMessageCenter:@"此卡为信用卡，暂不支持" inView:self];
        isNull = YES;
        return isNull;
    }
//    if (!(self.cardBinModel.bankCode.length > 0)) {
//        [HxbHUDProgress showMessageCenter:@"银行卡号没有校验成功，请稍后再试" inView:self];
//        isNull = YES;
//        return isNull;
//    }
    if (!(self.phoneNumberTextField.text.length > 0)) {
        [HxbHUDProgress showMessageCenter:@"预留手机号不能为空" inView:self];
        isNull = YES;
        return isNull;
    }
    if (self.phoneNumberTextField.text.length != 11) {
        [HxbHUDProgress showMessageCenter:@"预留手机号有误" inView:self];
        isNull = YES;
        return isNull;
    }
    
    
//    if (!(self.bankCardTextField.text.length >= 10 && self.bankCardTextField.text.length <= 31)) {
//
//        [HxbHUDProgress showMessageCenter:@"请输入正确的卡号" inView:self];
//        isNull = YES;
//        return isNull;
//    }
//    if (![NSString isMobileNumber:self.phoneNumberTextField.text]) {
//        [HxbHUDProgress showMessageCenter:@"请输入正确手机号" inView:self];
//        isNull = YES;
//        return isNull;
//    }
    return isNull;
}

//- (void)setBankName:(NSString *)bankName
//{
//    _bankName = bankName;
//    self.bankNameTextField.text = bankName;
//}



#pragma mark - 懒加载
- (HXBCustomTextField *)bankCardTextField{
    if (!_bankCardTextField) {
        _bankCardTextField = [[HXBCustomTextField alloc] initWithFrame:CGRectZero];
        _bankCardTextField.placeholder = @"银行卡号";
        _bankCardTextField.keyboardType = UIKeyboardTypeNumberPad;
        _bankCardTextField.delegate = self;
        _bankCardTextField.limitStringLength = 31;
        _bankCardTextField.leftImage = [UIImage imageNamed:@"bankcard"];
        _bankCardTextField.isHidenLine = YES;
        kWeakSelf
        _bankCardTextField.block = ^(NSString *text) {
            _bankCardID = [_bankCardTextField.text stringByReplacingOccurrencesOfString:@" "  withString:@""];
            if (_bankCardID.length >= 12) {
                if (weakSelf.checkCardBin) {
                    weakSelf.checkCardBin(weakSelf.bankCardID);
                    
                }
            }
        };
    }
    return _bankCardTextField;
}

- (void)seeLimitBtnClick
{
    if (self.bankNameBtnClickBlock) {
        self.bankNameBtnClickBlock();
    }

}

//卡bin校验成功
- (void)setCardBinModel:(HXBCardBinModel *)cardBinModel
{
    _cardBinModel = cardBinModel;
    [self showKabinWithCardBinModel:cardBinModel];
//    if (cardBinModel.creditCard) {
//
//    }else
//    {
//        if (cardBinModel.support) {
//            [self showKabinWithCardBinModel:cardBinModel];
//        }
//    }
    
   
}

/**
 是否显示卡bin
 */
- (void)showKabinWithCardBinModel:(HXBCardBinModel *)cardBinModel
{
    self.bankNameTextField.hidden = NO;
    self.line.hidden = NO;
    [UIView animateWithDuration:kBankbin_AnimationTime animations:^{
        self.phoneNumberTextField.frame = CGRectMake(0, CGRectGetMaxY(self.bankNameTextField.frame) + kScrAdaptationH(10), kScreenWidth, kScrAdaptationH(50));
        [self layoutIfNeeded];
    }];
    
    
    if (!cardBinModel.creditCard) {
        self.bankNameTextField.svgImageName = cardBinModel.bankCode;
        self.bankNameTextField.text = [NSString stringWithFormat:@"%@：%@",cardBinModel.bankName,cardBinModel.quota];
    }else
    {
        self.bankNameTextField.svgImageName = cardBinModel.bankCode;
        self.bankNameTextField.text = @"此卡为信用卡，暂不支持";
    }
}

//卡bin校验失败
- (void)setIsCheckFailed:(BOOL)isCheckFailed
{
    _isCheckFailed = isCheckFailed;
    if (isCheckFailed) {
        self.line.hidden = YES;
        self.bankNameTextField.hidden = YES;
        [UIView animateWithDuration:kBankbin_AnimationTime animations:^{
            self.phoneNumberTextField.frame = CGRectMake(0, CGRectGetMaxY(self.bankCardTextField.frame) + kScrAdaptationH(10), kScreenWidth, kScrAdaptationH750(100));
            [self layoutIfNeeded];
        }];
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [self setIsCheckFailed:YES];
    return YES;
}

- (HXBCustomTextField *)bankNameTextField
{
    if (!_bankNameTextField) {
        _bankNameTextField = [[HXBCustomTextField alloc] initWithFrame:CGRectZero];
        _bankNameTextField.placeholder = @"银行名称";
        _bankNameTextField.svgImageName = @"默认";
        _bankNameTextField.hidden = YES;
        _bankNameTextField.userInteractionEnabled = NO;
//        _bankNameTextField.rightImage = [SVGKImage imageNamed:@"more.svg"].UIImage;
        _bankNameTextField.isHidenLine = YES;
//        _bankNameTextField.btnClick = ^{
//            if (weakSelf.bankNameBtnClickBlock) {
//                weakSelf.bankNameBtnClickBlock();
//            }
//        };
        
    }
    return _bankNameTextField;
}

- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = COR12;
        _line.hidden = YES;
    }
    return _line;
}


- (HXBCustomTextField *)phoneNumberTextField{
    if (!_phoneNumberTextField) {
        _phoneNumberTextField = [[HXBCustomTextField alloc] initWithFrame:CGRectZero];
        _phoneNumberTextField.placeholder = @"预留手机号";
        _phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneNumberTextField.delegate = self;
        _phoneNumberTextField.limitStringLength = 11;
        _phoneNumberTextField.leftImage = [UIImage imageNamed:@"mobile_number"];
        _phoneNumberTextField.isHidenLine = YES;
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
    } else if (textField.superview == _bankCardTextField) {
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
        if ([self isPureInt:string]) {
            if (_bankCardTextField.text.length % 5 == 4 && _bankCardTextField.text.length < 30) {
                _bankCardTextField.text = [NSString stringWithFormat:@"%@ ", _bankCardTextField.text];
            }
            if (str.length > 31) {
                str = [str substringToIndex:31];
                _bankCardTextField.text = str;
                [_bankCardTextField resignFirstResponder];
                return NO;
            }
        } else if ([string isEqualToString:@""]) {
            if ((_bankCardTextField.text.length - 2) % 5 == 4 && _bankCardTextField.text.length < 30) {
                _bankCardTextField.text = [_bankCardTextField.text substringToIndex:_bankCardTextField.text.length - 1];
            }
            return YES;
        } else {
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
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

- (UIButton *)seeLimitBtn
{
    if (!_seeLimitBtn) {
        _seeLimitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_seeLimitBtn setTitle:@"查看银行限额" forState:(UIControlStateNormal)];
        [_seeLimitBtn setTitleColor:kHXBColor_Blue040610 forState:(UIControlStateNormal)];
        _seeLimitBtn.backgroundColor = [UIColor whiteColor];
        [_seeLimitBtn addTarget:self action:@selector(seeLimitBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        _seeLimitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _seeLimitBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        
    }
    return _seeLimitBtn;
}


@end
