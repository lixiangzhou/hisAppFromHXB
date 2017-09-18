//
//  HXBOpenDepositAccountView.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBOpenDepositAccountView.h"
#import "HXBDepositoryHeaderView.h"
#import "HXBCustomTextField.h"
#import "HXBFinBaseNegotiateView.h"
#import "SVGKImage.h"
#import "HXBBankCardModel.h"
#import "HXBAgreementView.h"
#import "HXBCardBinModel.h"
@interface HXBOpenDepositAccountView ()<UITextFieldDelegate>
@property (nonatomic, strong) HXBDepositoryHeaderView *headerTipView;
@property (nonatomic, strong) HXBCustomTextField *nameTextField;
@property (nonatomic, strong) HXBCustomTextField *idCardTextField;
@property (nonatomic, strong) HXBCustomTextField *pwdTextField;
@property (nonatomic, strong) HXBDepositoryHeaderView *bottomTipView;
@property (nonatomic, strong) HXBCustomTextField *bankNameTextField;
@property (nonatomic, strong) HXBCustomTextField *bankNumberTextField;
@property (nonatomic, strong) UIButton *seeLimitBtn;
@property (nonatomic, strong) HXBCustomTextField *phoneTextField;
//@property (nonatomic, strong) HXBFinBaseNegotiateView *negotiateView;
@property (nonatomic, strong) HXBAgreementView *negotiateView;
@property (nonatomic, strong) UIView *line;
/**
 是否同意协议
 */
@property (nonatomic, assign) BOOL isAgree;


/**
 存管协议
 */
@property (nonatomic,copy) void(^clickTrustAgreement)(BOOL isThirdpart);
@end

@implementation HXBOpenDepositAccountView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.headerTipView];
        [self addSubview:self.nameTextField];
        [self addSubview:self.idCardTextField];
        [self addSubview:self.pwdTextField];
        [self addSubview:self.bottomTipView];
        [self addSubview:self.bankNameTextField];
        [self addSubview:self.bankNumberTextField];
        [self addSubview:self.seeLimitBtn];
        [self addSubview:self.phoneTextField];
        [self addSubview:self.negotiateView];
        [self addSubview:self.line];
//        [self addSubview:self.bottomBtn];
        [self setupSubViewFrame];
        self.isAgree = YES;
       
    }
    return self;
}


- (void)setUserModel:(HXBRequestUserInfoViewModel *)userModel
{
    _userModel = userModel;

    if (userModel.userInfoModel.userInfo.isCreateEscrowAcc)
    {
        [self.bottomBtn setTitle:@"提交" forState:UIControlStateNormal];
    }else
    {
        [self.bottomBtn setTitle:@"开通恒丰银行存管账户" forState:UIControlStateNormal];
    }
    
    //设置用户信息
    [self setupUserIfoData:userModel];
    
    if ([userModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"]) {
        //已经绑卡
        NYBaseRequest *bankCardAPI = [[NYBaseRequest alloc] init];
        bankCardAPI.requestUrl = kHXBUserInfo_BankCard;
        bankCardAPI.requestMethod = NYRequestMethodGet;
        [bankCardAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
            NSLog(@"%@",responseObject);
            NSInteger status =  [responseObject[@"status"] integerValue];
            if (status != 0) {
                [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
                return;
            }
            HXBBankCardModel *bankCardModel = [HXBBankCardModel yy_modelWithJSON:responseObject[@"data"]];
            //设置绑卡信息
            [self setupBankCardData:bankCardModel];
        } failure:^(NYBaseRequest *request, NSError *error) {
            NSLog(@"%@",error);
            [HxbHUDProgress showTextWithMessage:@"银行卡请求失败"];
        }];
    }

}

#warning 肖扬
- (void)setupUserIfoData:(HXBRequestUserInfoViewModel *)viewModel
{
    if ([viewModel.userInfoModel.userInfo.isIdPassed isEqualToString:@"1"]) {
        self.nameTextField.text = [viewModel.userInfoModel.userInfo.realName replaceStringWithStartLocation:0 lenght:viewModel.userInfoModel.userInfo.realName.length - 1];
        self.nameTextField.isHidenLine = YES;
        self.nameTextField.userInteractionEnabled = NO;
        
        self.idCardTextField.text = [viewModel.userInfoModel.userInfo.idNo replaceStringWithStartLocation:1 lenght:viewModel.userInfoModel.userInfo.idNo.length - 2];
        self.idCardTextField.isHidenLine = YES;
        self.idCardTextField.userInteractionEnabled = NO;
    }
}

- (void)setupBankCardData:(HXBBankCardModel *)bankCardModel
{
    self.bankNameTextField.text = bankCardModel.bankType;
    self.bankNameTextField.isHidenLine = YES;
    self.bankNameTextField.userInteractionEnabled = NO;
//    self.bankCode = bankCardModel.bankCode;
    
    self.bankNumberTextField.text = [bankCardModel.cardId replaceStringWithStartLocation:0 lenght:bankCardModel.cardId.length - 4];
    self.bankNumberTextField.isHidenLine = YES;
    self.bankNumberTextField.userInteractionEnabled = NO;
    
    
    self.phoneTextField.text = bankCardModel.securyMobile;
    self.phoneTextField.isHidenLine = YES;
    self.phoneTextField.userInteractionEnabled = NO;
}

- (void)setupSubViewFrame
{
    [self.headerTipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kScrAdaptationH(20));
        make.left.right.equalTo(self);
        make.height.offset(kScrAdaptationH(37));
    }];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerTipView.mas_bottom).offset(kScrAdaptationH(20));
        make.left.right.equalTo(self);
        make.height.offset(kScrAdaptationH(50));
    }];
    [self.idCardTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameTextField.mas_bottom).offset(kScrAdaptationH(10));
        make.left.right.equalTo(self);
        make.height.offset(kScrAdaptationH(50));
    }];
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.idCardTextField.mas_bottom).offset(kScrAdaptationH(10));
        make.left.right.equalTo(self);
        make.height.offset(kScrAdaptationH(50));
    }];
    [self.bottomTipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdTextField.mas_bottom).offset(kScrAdaptationH(35));
        make.left.right.equalTo(self);
        make.height.offset(kScrAdaptationH(37));
    }];
    [self.seeLimitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomTipView.mas_bottom).offset(kScrAdaptationH(20));
        make.right.equalTo(self);
        make.height.offset(kScrAdaptationH(50));
        make.width.offset(kScrAdaptationW(100));
    }];
    [self.bankNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomTipView.mas_bottom).offset(kScrAdaptationH(20));
        make.left.equalTo(self);
        make.right.equalTo(self.seeLimitBtn.mas_left).offset(kScrAdaptationW(20));
        make.height.offset(kScrAdaptationH(50));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seeLimitBtn.mas_bottom);;
        make.right.equalTo(self).offset(kScrAdaptationW(-15));
        make.left.equalTo(self).offset(kScrAdaptationW(15));
        make.height.offset(0.5);
    }];
    [self.bankNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bankNumberTextField.mas_bottom);
        make.left.right.equalTo(self);
        make.height.offset(kScrAdaptationH(50));
    }];
    
    
//    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.bankNumberTextField.mas_bottom).offset(kScrAdaptationH(10));
//        make.left.right.equalTo(self);
//        make.height.offset(kScrAdaptationH(50));
//    }];
    
    [self.negotiateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(kScrAdaptationH(-65));
        make.centerX.equalTo(self);
        make.left.equalTo(self).offset(kScrAdaptationW(18));
        make.right.equalTo(self).offset(kScrAdaptationW(-18));
    }];
}

//- (void)setBankName:(NSString *)bankName
//{
//    _bankName = bankName;
//    self.bankNameTextField.text = bankName;
//}
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.bankNameTextField.hidden) {
        self.phoneTextField.frame = CGRectMake(0, CGRectGetMaxY(self.bankNumberTextField.frame) + kScrAdaptationH(10), kScreenWidth, kScrAdaptationH(50));
    }
}

- (void)setCardBinModel:(HXBCardBinModel *)cardBinModel
{
    _cardBinModel = cardBinModel;
//    self.bankNumberTextField.isHidenLine = NO;
    self.line.hidden = NO;
    self.bankNameTextField.hidden = NO;
    [UIView animateWithDuration:1.0 animations:^{
        self.phoneTextField.frame = CGRectMake(0, CGRectGetMaxY(self.bankNameTextField.frame) + kScrAdaptationH(10), kScreenWidth, kScrAdaptationH(50));
    }];
    [self layoutIfNeeded];
    if (cardBinModel.isDebit) {
        self.bankNameTextField.svgImageName = cardBinModel.bankCode;
        self.bankNameTextField.text = [NSString stringWithFormat:@"%@：%@",cardBinModel.bankName,cardBinModel.quota];
    }else
    {
        self.bankNameTextField.svgImageName = @"默认";
        self.bankNameTextField.text = @"此卡为信用卡，暂不支持";
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.superview == self.bankNumberTextField) {
        self.line.backgroundColor = COR29;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.superview == self.bankNumberTextField) {
        self.line.backgroundColor = COR12;
    }
}

- (void)bottomBtnClick
{
    if (self.openAccountBlock) {
        if ([self judgeIsTure]) return;
        NSDictionary *dic = @{
                              @"realName" : self.nameTextField.text,
                              @"identityCard" : self.idCardTextField.text,
                              @"password" : self.pwdTextField.text,
                              @"bankCard" : self.bankNumberTextField.text,
                              @"bankReservedMobile" : self.phoneTextField.text,
                              @"bankCode" : self.cardBinModel.bankCode
                              };
        self.openAccountBlock(dic);
    }
}

- (BOOL)judgeIsTure
{
    BOOL isNull = NO;
    if (!(self.nameTextField.text.length > 0)) {
        [HxbHUDProgress showMessageCenter:@"真实姓名不能为空" inView:self];
        isNull = YES;
        return isNull;
    }
    if (!(self.idCardTextField.text.length > 0)) {
        [HxbHUDProgress showMessageCenter:@"身份证号不能为空" inView:self];
        isNull = YES;
        return isNull;
    }
    if(self.idCardTextField.text.length != 18)
    {
        [HxbHUDProgress showMessageCenter:@"身份证号输入有误" inView:self];
        isNull = YES;
        return isNull;
    }
    if(!(self.pwdTextField.text.length > 0))
    {
        [HxbHUDProgress showMessageCenter:@"交易密码不能为空" inView:self];
        isNull = YES;
        return isNull;
    }
    if (self.pwdTextField.text.length != 6) {
        [HxbHUDProgress showMessageCenter:@"交易密码为6位数字" inView:self];
        isNull = YES;
        return isNull;
    }
//    if (!(self.bankCode.length > 0)) {
//        [HxbHUDProgress showMessageCenter:@"银行名称不能为空" inView:self];
//        isNull = YES;
//        return isNull;
//    }
    if (!(self.bankNumberTextField.text.length > 0)) {
        [HxbHUDProgress showMessageCenter:@"银行卡号不能为空" inView:self];
        isNull = YES;
        return isNull;
    }
    if (!(self.bankNumberTextField.text.length >= 10 && self.bankNumberTextField.text.length <= 25)) {
        [HxbHUDProgress showMessageCenter:@"银行卡号输入有误" inView:self];
        isNull = YES;
        return isNull;
    }
    if (!(self.phoneTextField.text.length > 0)) {
        [HxbHUDProgress showMessageCenter:@"预留手机号不能为空" inView:self];
        isNull = YES;
        return isNull;
    }
    if (self.phoneTextField.text.length != 11) {
        [HxbHUDProgress showMessageCenter:@"预留手机号有误" inView:self];
        isNull = YES;
        return isNull;
    }
    return isNull;
}

- (BOOL)isjudgeIsNull:(UIView *)textField
{
    BOOL isNull = NO;
    if (!(self.nameTextField.text.length > 0) && textField != self.nameTextField) {
        isNull = YES;
        return isNull;
    }
    if (!(self.idCardTextField.text.length > 0) && textField != self.idCardTextField) {
        isNull = YES;
        return isNull;
    }
    if (!(self.pwdTextField.text.length > 0) && textField != self.pwdTextField) {
        isNull = YES;
        return isNull;
    }
//    if (!(self.bankCode.length > 0)) {
//        isNull = YES;
//        return isNull;
//    }
    if (!(self.bankNumberTextField.text.length > 0) && textField != self.bankNumberTextField) {
        isNull = YES;
        return isNull;
    }
    if (!(self.phoneTextField.text.length > 0) && textField != self.phoneTextField) {
        isNull = YES;
        return isNull;
    }
    return isNull;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    /*下面代码为所有输入textField响应底部按钮
    if (self.isAgree) {
        if (range.location == 0 && [string isEqualToString:@""]) {
            self.bottomBtn.backgroundColor = COR26;
            self.bottomBtn.enabled = NO;
        }else
        {
            if (![self isjudgeIsNull:textField.superview])
            {
                self.bottomBtn.backgroundColor = COR24;
                self.bottomBtn.enabled = YES;
            }
        }
    }else
    {
        self.bottomBtn.backgroundColor = COR26;
        self.bottomBtn.enabled = NO;
    }
    */
    
    if ([string isEqualToString:@""]) {
        return YES;
    }else
    {
        if (self.nameTextField == textField.superview && [string isEqualToString:@" "]) {
            return NO;
        }
        return [self limitNumberCount:textField.superview];
    }
    
    
}


- (BOOL)limitNumberCount:(UIView *)textField
{
    
    if (self.idCardTextField.text.length > 17 && self.idCardTextField == textField) {
        return NO;
    }
    if (self.pwdTextField.text.length > 5 && self.pwdTextField == textField) {
        return NO;
    }
    if (self.bankNumberTextField.text.length > 24 && self.bankNumberTextField == textField) {
        return NO;
    }
    if (self.phoneTextField.text.length > 10 && self.phoneTextField == textField) {
        return NO;
    }
    return YES;
}

- (void)seeLimitBtnClick
{
    if (self.bankNameBlock) {
        self.bankNameBlock();
    }
}

//- (void)setBankCode:(NSString *)bankCode
//{
//    _bankCode = bankCode;
//    if (self.isAgree && ![self isjudgeIsNull:nil]) {
//        self.bottomBtn.backgroundColor = COR24;
//        self.bottomBtn.enabled = YES;
//    }else
//    {
//        self.bottomBtn.backgroundColor = COR26;
//        self.bottomBtn.enabled = NO;
//    }
//}

#pragma mark - 懒加载
- (HXBDepositoryHeaderView *)headerTipView
{
    if (!_headerTipView) {
        _headerTipView = [[HXBDepositoryHeaderView alloc] init];
        _headerTipView.titel = @"安全认证";
        _headerTipView.describe = @"按国家规定投资用户需满18岁";
    }
    return _headerTipView;
}
- (HXBCustomTextField *)nameTextField
{
    if (!_nameTextField) {
        _nameTextField = [[HXBCustomTextField alloc] init];
        _nameTextField.leftImage = [SVGKImage imageNamed:@"name.svg"].UIImage;
        _nameTextField.placeholder = @"真实姓名";
        _nameTextField.delegate = self;
        _nameTextField.isHidenLine = YES;
    }
    return _nameTextField;
}

- (HXBCustomTextField *)idCardTextField
{
    if (!_idCardTextField) {
        _idCardTextField = [[HXBCustomTextField alloc] init];
        _idCardTextField.leftImage = [SVGKImage imageNamed:@"id_number.svg"].UIImage;
        _idCardTextField.placeholder = @"身份证号";
        _idCardTextField.delegate = self;
        _idCardTextField.isIDCardTextField = YES;
        _idCardTextField.isHidenLine = YES;
    }
    return _idCardTextField;
}
- (HXBCustomTextField *)pwdTextField
{
    if (!_pwdTextField) {
        _pwdTextField = [[HXBCustomTextField alloc] init];
        _pwdTextField.leftImage = [UIImage imageNamed:@"transaction_password"];
        _pwdTextField.placeholder = @"请设置6位纯数字的交易密码";
        _pwdTextField.secureTextEntry = YES;
        _pwdTextField.keyboardType = UIKeyboardTypeNumberPad;
        _pwdTextField.delegate = self;
        _pwdTextField.isHidenLine = YES;
    }
    return _pwdTextField;
}
- (HXBDepositoryHeaderView *)bottomTipView
{
    if (!_bottomTipView) {
        _bottomTipView = [[HXBDepositoryHeaderView alloc] init];
        _bottomTipView.titel = @"银行卡";
        _bottomTipView.describe = @"实名认证与银行卡需为同一人";
    }
    return _bottomTipView;
}
- (HXBCustomTextField *)bankNameTextField
{
    if (!_bankNameTextField) {
        _bankNameTextField = [[HXBCustomTextField alloc] init];
        _bankNameTextField.leftImage = [SVGKImage imageNamed:@"默认.svg"].UIImage;
        _bankNameTextField.hidden = YES;
        _bankNameTextField.placeholder = @"银行名称";
//        _bankNameTextField.rightImage = [SVGKImage imageNamed:@"more.svg"].UIImage;
        _bankNameTextField.delegate = self;
        _bankNameTextField.isHidenLine = YES;
        _bankNameTextField.userInteractionEnabled = NO;
        _bankNameTextField.textColor = COR10;
    }
    return _bankNameTextField;
}
- (HXBCustomTextField *)bankNumberTextField
{
    if (!_bankNumberTextField) {
        _bankNumberTextField = [[HXBCustomTextField alloc] init];
        _bankNumberTextField.leftImage = [SVGKImage imageNamed:@"card.svg"].UIImage;
        _bankNumberTextField.placeholder = @"银行卡号";
        _bankNumberTextField.delegate = self;
        _bankNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
        _bankNumberTextField.isHidenLine = YES;
        kWeakSelf
        _bankNumberTextField.block = ^(NSString *text) {
            if (text.length>=12) {
                if (weakSelf.checkCardBin) {
                    weakSelf.checkCardBin(text);
                }
            }
        };
    }
    return _bankNumberTextField;
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

- (HXBCustomTextField *)phoneTextField
{
    if (!_phoneTextField) {
        _phoneTextField = [[HXBCustomTextField alloc] init];
        _phoneTextField.svgImageName = @"mobile";
        _phoneTextField.placeholder = @"银行预留手机号";
        _phoneTextField.delegate = self;
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.isHidenLine = YES;
    }
    return _phoneTextField;
}

- (HXBAgreementView *)negotiateView
{
    if (!_negotiateView) {
        kWeakSelf
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"我已查看并同意《红小宝平台授权协议》,《恒丰银行股份有限公司杭州分行网络交易资金账户三方协议》"];
        
        NSDictionary *linkAttributes = @{
                                         NSForegroundColorAttributeName:kHXBColor_Blue040610,
                                         NSFontAttributeName:kHXBFont_PINGFANGSC_REGULAR(12)
                                         };
        NSMutableAttributedString *attributedString = [HXBAgreementView configureLinkAttributedString:attString withString:@"《红小宝平台授权协议》" sameStringEnable:NO linkAttributes:linkAttributes activeLinkAttributes:linkAttributes parameter:nil clickLinkBlock:^{
            if (weakSelf.clickTrustAgreement) {
                weakSelf.clickTrustAgreement(NO);
            }
        }];
        attributedString = [HXBAgreementView configureLinkAttributedString:attributedString withString:@"《恒丰银行股份有限公司杭州分行网络交易资金账户三方协议》" sameStringEnable:NO linkAttributes:linkAttributes activeLinkAttributes:linkAttributes parameter:nil clickLinkBlock:^{
            if (weakSelf.clickTrustAgreement) {
                weakSelf.clickTrustAgreement(YES);
            }
        }];
        _negotiateView = [[HXBAgreementView alloc] initWithFrame:CGRectZero];
        _negotiateView.text = attributedString;
        _negotiateView.agreeBtnBlock = ^(BOOL isSelected){
            weakSelf.isAgree = isSelected;
            if (isSelected) {
                weakSelf.bottomBtn.backgroundColor = COR24;
                weakSelf.bottomBtn.enabled = YES;
            }else
            {
                weakSelf.bottomBtn.backgroundColor = COR26;
                weakSelf.bottomBtn.enabled = NO;
            }
        };
    }
    return _negotiateView;
}


- (UIButton *)bottomBtn
{
    if (!_bottomBtn) {
        _bottomBtn = [[UIButton alloc] init];
        _bottomBtn.backgroundColor = COR24;
        [_bottomBtn setTitle:@"开通恒丰银行存管账户" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _bottomBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(16);
        [_bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}
- (void)clickTrustAgreementWithBlock:(void (^)(BOOL isThirdpart))clickTrustAgreement {
    self.clickTrustAgreement = clickTrustAgreement;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
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
@end
