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

@interface HXBOpenDepositAccountView ()<UITextFieldDelegate>
@property (nonatomic, strong) HXBDepositoryHeaderView *headerTipView;
@property (nonatomic, strong) HXBCustomTextField *nameTextField;
@property (nonatomic, strong) HXBCustomTextField *idCardTextField;
@property (nonatomic, strong) HXBCustomTextField *pwdTextField;
@property (nonatomic, strong) HXBDepositoryHeaderView *bottomTipView;
@property (nonatomic, strong) HXBCustomTextField *bankNameTextField;
@property (nonatomic, strong) HXBCustomTextField *bankNumberTextField;
@property (nonatomic, strong) HXBCustomTextField *phoneTextField;
//@property (nonatomic, strong) HXBFinBaseNegotiateView *negotiateView;
@property (nonatomic, strong) HXBAgreementView *negotiateView;

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
        [self addSubview:self.phoneTextField];
        [self addSubview:self.negotiateView];
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
    self.bankCode = bankCardModel.bankCode;
    
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
        make.top.equalTo(self.headerTipView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.offset(kScrAdaptationH(50));
    }];
    [self.idCardTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameTextField.mas_bottom);
        make.left.right.equalTo(self);
        make.height.offset(kScrAdaptationH(50));
    }];
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.idCardTextField.mas_bottom);
        make.left.right.equalTo(self);
        make.height.offset(kScrAdaptationH(50));
    }];
    [self.bottomTipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdTextField.mas_bottom).offset(kScrAdaptationH(50));
        make.left.right.equalTo(self);
        make.height.offset(kScrAdaptationH(37));
    }];
    [self.bankNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomTipView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.offset(kScrAdaptationH(50));
    }];
    [self.bankNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bankNameTextField.mas_bottom);
        make.left.right.equalTo(self);
        make.height.offset(kScrAdaptationH(50));
    }];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bankNumberTextField.mas_bottom);
        make.left.right.equalTo(self);
        make.height.offset(kScrAdaptationH(50));
    }];
    
 
    [self.negotiateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(kScrAdaptationH(40));
        make.centerX.equalTo(self);
        make.left.equalTo(self).offset(kScrAdaptationW(18));
        make.right.equalTo(self).offset(kScrAdaptationW(-18));
    }];
}

- (void)setBankName:(NSString *)bankName
{
    _bankName = bankName;
    self.bankNameTextField.text = bankName;
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
                              @"bankCode" : self.bankCode
                              };
        self.openAccountBlock(dic);
    }
}

- (BOOL)judgeIsTure
{
    BOOL isNull = NO;
    if (!(self.nameTextField.text.length > 0)) {
        [HxbHUDProgress showMessageCenter:@"真实姓名没有填写" inView:self];
        isNull = YES;
        return isNull;
    }
    if (!(self.idCardTextField.text.length > 0)) {
        [HxbHUDProgress showMessageCenter:@"身份证号没有填写" inView:self];
        isNull = YES;
        return isNull;
    }
    if (self.pwdTextField.text.length != 6) {
        [HxbHUDProgress showMessageCenter:@"交易密码为6位数字" inView:self];
        isNull = YES;
        return isNull;
    }
    if (!(self.bankCode.length > 0)) {
        [HxbHUDProgress showMessageCenter:@"没有选择银行" inView:self];
        isNull = YES;
        return isNull;
    }
    if (!(self.bankNumberTextField.text.length > 10 && self.bankNumberTextField.text.length <= 21)) {
        [HxbHUDProgress showMessageCenter:@"请输入正确的卡号" inView:self];
        isNull = YES;
        return isNull;
    }
    if (self.phoneTextField.text.length != 11) {
        [HxbHUDProgress showMessageCenter:@"请输入正确的预留手机号" inView:self];
        isNull = YES;
        return isNull;
    }
    return isNull;
}

- (BOOL)isjudgeIsNull
{
    BOOL isNull = NO;
    if (!(self.nameTextField.text.length > 0)) {
        isNull = YES;
        return isNull;
    }
    if (!(self.idCardTextField.text.length > 0)) {
        isNull = YES;
        return isNull;
    }
    if (!(self.pwdTextField.text.length > 0)) {
        isNull = YES;
        return isNull;
    }
    if (!(self.bankCode.length > 0)) {
        isNull = YES;
        return isNull;
    }
    if (!(self.bankNumberTextField.text.length > 0)) {
        isNull = YES;
        return isNull;
    }
    if (!(self.phoneTextField.text.length > 0)) {
        isNull = YES;
        return isNull;
    }
    return isNull;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location == 0 && [string isEqualToString:@""]) {
        self.isAgree = NO;
    }else
    {
        self.isAgree = YES;
    }
    self.bottomBtn.enabled = ![self isjudgeIsNull];
    if (![self isjudgeIsNull] && self.isAgree) {
        self.bottomBtn.backgroundColor = COR24;
    }else
    {
        self.bottomBtn.backgroundColor = COR26;
    }
    return YES;
}
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
    }
    return _idCardTextField;
}
- (HXBCustomTextField *)pwdTextField
{
    if (!_pwdTextField) {
        _pwdTextField = [[HXBCustomTextField alloc] init];
        _pwdTextField.leftImage = [UIImage imageNamed:@"transaction_password"];
        _pwdTextField.placeholder = @"交易密码";
        _pwdTextField.keyboardType = UIKeyboardTypeNumberPad;
        _pwdTextField.secureTextEntry = YES;
        _pwdTextField.delegate = self;
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
        kWeakSelf
        _bankNameTextField = [[HXBCustomTextField alloc] init];
        _bankNameTextField.leftImage = [SVGKImage imageNamed:@"bank_name.svg"].UIImage;
        _bankNameTextField.placeholder = @"银行名称";
        _bankNameTextField.rightImage = [SVGKImage imageNamed:@"more.svg"].UIImage;
        _bankNameTextField.delegate = self;
        _bankNameTextField.btnClick = ^{
            if (weakSelf.bankNameBlock) {
                weakSelf.bankNameBlock();
            }
        };
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
    }
    return _bankNumberTextField;
}

- (HXBCustomTextField *)phoneTextField
{
    if (!_phoneTextField) {
        _phoneTextField = [[HXBCustomTextField alloc] init];
        _phoneTextField.leftImage = [SVGKImage imageNamed:@"mobile.svg"].UIImage;
        _phoneTextField.placeholder = @"预留手机号码";
        _phoneTextField.delegate = self;
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
            if (isSelected && ![weakSelf isjudgeIsNull] ) {
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
        _bottomBtn.backgroundColor = COR26;
        _bottomBtn.enabled = NO;
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

@end
