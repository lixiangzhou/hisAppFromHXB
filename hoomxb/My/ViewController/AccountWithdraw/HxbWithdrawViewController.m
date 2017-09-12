//
//  HxbWithdrawViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbWithdrawViewController.h"
#import "HxbSecurityCertificationViewController.h"
#import "HxbWithdrawCardViewController.h"
#import "HXBBankCardModel.h"
#import "HXBWithdrawalsRequest.h"
#import "HxbWithdrawResultViewController.h"
#import "HXBAlertVC.h"
#import "HXBModifyTransactionPasswordViewController.h"
#import "HXBCallPhone_BottomView.h"
@interface HxbWithdrawViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *amountTextField;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *availableBalanceLabel;
@property (nonatomic, strong) UILabel *freeTipLabel;
@property (nonatomic, strong) UIButton *nextButton;

@property (nonatomic, strong) WithdrawBankView *mybankView;

@property (nonatomic, strong) HXBCallPhone_BottomView *callPhoneView;
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, strong) UILabel *tiedCardLabel;
@property (nonatomic, strong) UILabel *reminderLabel;
/**
 数据模型
 */
@property (nonatomic, strong) HXBBankCardModel *bankCardModel;
@end

@implementation HxbWithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    self.isColourGradientNavigationBar = YES;
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self.view addSubview:self.backView];
    [self.view addSubview:self.mybankView];
    [self.view addSubview:self.amountTextField];
    [self.view addSubview:self.nextButton];
    [self.view addSubview:self.availableBalanceLabel];
    [self.view addSubview:self.freeTipLabel];
    [self.view addSubview:self.callPhoneView];
    [self.view addSubview:self.promptLabel];
    [self.view addSubview:self.tiedCardLabel];
    [self.view addSubview:self.reminderLabel];
    [self setCardViewFrame];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.amountTextField.text = @"";
    self.nextButton.backgroundColor = COR12;
    self.nextButton.userInteractionEnabled = NO;
}
- (void)loadData
{
    kWeakSelf
    [KeyChain downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        weakSelf.userInfoViewModel = viewModel;
        weakSelf.availableBalanceLabel.text =  [NSString stringWithFormat:@"可提金额：%@",[NSString hxb_getPerMilWithDouble:viewModel.userInfoModel.userAssets.availablePoint.doubleValue]];
    } andFailure:^(NSError *error) {
        
    }];
}

- (void)setCardViewFrame{
    
//    if (![self.userInfoViewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"]) {
//        self.mybankView.hidden = YES;
//        [self.availableBalanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.offset(kScrAdaptationH750(30));
//            make.top.equalTo(self.view).offset(kScrAdaptationH750(20));
//        }];
//    }else
//    {
    [self loadBankCard];
    [self.availableBalanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kScrAdaptationH750(30));
        make.top.equalTo(self.mybankView.mas_bottom).offset(kScrAdaptationH750(20));
    }];
    [self.freeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kScrAdaptationH750(30));
        make.centerY.equalTo(self.availableBalanceLabel);
    }];
//    }
    
    [self.amountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.availableBalanceLabel.mas_bottom).offset(kScrAdaptationH750(20));
        make.left.equalTo(self.view).offset(kScrAdaptationW750(30));
        make.right.equalTo(self.view).offset(kScrAdaptationW750(-30));
        make.height.offset(kScrAdaptationH750(100));
    }];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.availableBalanceLabel.mas_bottom).offset(kScrAdaptationH750(20));
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.offset(kScrAdaptationH750(100));
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.amountTextField.mas_bottom).offset(kScrAdaptationH750(100));
        make.left.equalTo(self.view).offset(kScrAdaptationW750(40));
        make.right.equalTo(self.view).offset(kScrAdaptationW750(-40));
        make.height.offset(kScrAdaptationH750(82));
    }];
    [self.callPhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(kScrAdaptationH750(-100));
        make.left.equalTo(self.view).offset(kScrAdaptationW750(40));
    }];
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.callPhoneView.mas_top).offset(kScrAdaptationH750(-10));
        make.left.equalTo(self.view).offset(kScrAdaptationW750(40));
        make.right.equalTo(self.view).offset(-kScrAdaptationW750(40));
    }];
    [self.tiedCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.promptLabel.mas_top).offset(kScrAdaptationH750(-10));
        make.left.equalTo(self.view).offset(kScrAdaptationW750(40));
        make.right.equalTo(self.view).offset(-kScrAdaptationW750(40));
    }];
    [self.reminderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.tiedCardLabel.mas_top).offset(kScrAdaptationH750(-20));
        make.left.equalTo(self.view).offset(kScrAdaptationW750(40));
    }];

}

- (void)withdrawals
{
    kWeakSelf
    HXBAlertVC *alertVC = [[HXBAlertVC alloc] init];
    alertVC.isCode = NO;
    alertVC.messageTitle = @"请输入您的交易密码";
    alertVC.sureBtnClick = ^(NSString *pwd){
        if (pwd.length == 0) {
            return [HxbHUDProgress showTextWithMessage:@"密码不能为空"];
            return;
        }
        [weakSelf checkWithdrawals:pwd];
    };
    alertVC.forgetBtnClick = ^(){
        HXBModifyTransactionPasswordViewController *modifyTransactionPasswordVC = [[HXBModifyTransactionPasswordViewController alloc] init];
        modifyTransactionPasswordVC.title = @"修改交易密码";
        modifyTransactionPasswordVC.userInfoModel = weakSelf.userInfoViewModel.userInfoModel;
        [weakSelf.navigationController pushViewController:modifyTransactionPasswordVC animated:YES];
    };
    [self presentViewController:alertVC animated:NO completion:^{
        
    }];

}

- (void)checkWithdrawals:(NSString *)paypassword
{
//    self.view.userInteractionEnabled = NO;
    kWeakSelf
    NSMutableDictionary *requestArgument  = [NSMutableDictionary dictionary];
    requestArgument[@"bankno"] = self.bankCardModel.bankCode;
    requestArgument[@"city"] = self.bankCardModel.city;
    requestArgument[@"bank"] = self.bankCardModel.cardId;
    requestArgument[@"paypassword"] = paypassword;
    requestArgument[@"amount"] = self.bankCardModel.amount;
    HXBWithdrawalsRequest *withdrawals = [[HXBWithdrawalsRequest alloc] init];
    [withdrawals withdrawalsRequestWithRequestArgument:requestArgument andSuccessBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
//        weakSelf.view.userInteractionEnabled = YES;
        HxbWithdrawResultViewController *withdrawResultVC = [[HxbWithdrawResultViewController alloc]init];
        weakSelf.bankCardModel.arrivalTime = responseObject[@"data"][@"arrivalTime"];
        withdrawResultVC.bankCardModel = weakSelf.bankCardModel;
        [weakSelf.navigationController pushViewController:withdrawResultVC animated:YES];
    } andFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
   
    
}

- (void)nextButtonClick:(UIButton *)sender{
    kWeakSelf
    self.bankCardModel.amount = self.amountTextField.text;
    if ([_amountTextField.text doubleValue] < 1) {
        [HxbHUDProgress showTextWithMessage:@"金额不能小于1"];
        return;
    }
    if ([_amountTextField.text doubleValue] > [self.userInfoViewModel.userInfoModel.userAssets.availablePoint doubleValue]) {
        [HxbHUDProgress showTextWithMessage:@"余额不足"];
        return;
    }
    
    if ([self.userInfoViewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"]) {
        [self withdrawals];
        return;
    }
    [HXBRequestUserInfo downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        //实名认证
        if (!viewModel.userInfoModel.userInfo.isAllPassed.integerValue) {
            HxbSecurityCertificationViewController *securityCertificationVC = [[HxbSecurityCertificationViewController alloc]init];
            securityCertificationVC.userInfoViewModel = viewModel;
            [weakSelf.navigationController pushViewController:securityCertificationVC animated:YES];
            return;
        }else
        {
            HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc]init];
            withdrawCardViewController.title = @"确认信息";
            withdrawCardViewController.amount = self.amountTextField.text;
            withdrawCardViewController.userInfoModel = weakSelf.userInfoViewModel.userInfoModel;
            [weakSelf.navigationController pushViewController:withdrawCardViewController animated:YES];
            return;
        }
    } andFailure:^(NSError *error) {
        
    }];
   
}

- (WithdrawBankView *)mybankView{
    if (!_mybankView) {
        _mybankView = [[WithdrawBankView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, kScrAdaptationH750(160))];
    }
    return _mybankView;
}

- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}
- (UITextField *)amountTextField{
    if (!_amountTextField) {
        _amountTextField = [[UITextField alloc] init];
        _amountTextField.keyboardType = UIKeyboardTypeDecimalPad;
        _amountTextField.delegate = self;
        _amountTextField.backgroundColor = [UIColor whiteColor];
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScrAdaptationW750(150), kScrAdaptationH750(42))];
        tipLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
        tipLabel.textColor = RGB(51, 51, 51);
        tipLabel.text = @"提现金额:";
        _amountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _amountTextField.leftViewMode = UITextFieldViewModeAlways;
        _amountTextField.leftView = tipLabel;
        _amountTextField.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
        _amountTextField.textColor = RGB(51, 51, 51);
    }
    return _amountTextField;
}
//参数一：range,要被替换的字符串的range，如果是新键入的那么就没有字符串被替换，range.lenth=0,第二个参数：替换的字符串，即键盘即将键入或者即将粘贴到textfield的string
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if (range.location == 0 && [string isEqualToString:@"0"]) return NO;
    if (range.location == 0 && [string isEqualToString:@"."]) return NO;
    NSString *str = nil;
    if (string.length) {
        str = [NSString stringWithFormat:@"%@%@",textField.text,string];
    } else if(!string.length) {
        NSInteger length = textField.text.length;
        NSRange range = NSMakeRange(length - 1, 1);
        NSMutableString *strM = textField.text.mutableCopy;
        [strM deleteCharactersInRange:range];
        str = strM.copy;
    }
    if (str.length > 0) {
        _nextButton.backgroundColor = COR29;
        _nextButton.userInteractionEnabled = YES;
    } else {
        _nextButton.backgroundColor = COR12;
        _nextButton.userInteractionEnabled = NO;
    }
    if (range.location == 0 && [string isEqualToString:@""]) return YES;
    if (range.location == 11) return NO;
    //第一个参数，被替换字符串的range，第二个参数，即将键入或者粘贴的string，返回的是改变过后的新str，即textfield的新的文本内容
    NSString *checkStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    return [NSString checkBothDecimalPlaces:checkStr];
}


- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [UIButton btnwithTitle:@"提现" andTarget:self andAction:@selector(nextButtonClick:) andFrameByCategory:  CGRectMake(20,self.view.height - 100, SCREEN_WIDTH - 40,44)];
    }
    _nextButton.backgroundColor = COR12;
    _nextButton.userInteractionEnabled = NO;
    return _nextButton;
}

- (UILabel *)availableBalanceLabel
{
    if (!_availableBalanceLabel) {
        _availableBalanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.amountTextField.bottom + 20, 0, 0)];
        _availableBalanceLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        _availableBalanceLabel.textColor = RGB(51, 51, 51);
    }
    return _availableBalanceLabel;
}

- (UILabel *)freeTipLabel
{
    if (!_freeTipLabel) {
        _freeTipLabel = [[UILabel alloc] init];
        _freeTipLabel.text = @"提现免手续费";
        _freeTipLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        _freeTipLabel.textColor = COR11;
    }
    return _freeTipLabel;
}

//- (UILabel *)tipLabel
//{
//    if (!_tipLabel) {
//        _tipLabel = [[UILabel alloc] init];
//        _tipLabel.text = @"3、禁止恶意提现";
//        _tipLabel.textColor = COR8;
//        _tipLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
//    }
//    return _tipLabel;
//}

- (HXBCallPhone_BottomView *)callPhoneView
{
    if (!_callPhoneView) {
        _callPhoneView = [[HXBCallPhone_BottomView alloc] init];
        _callPhoneView.leftTitle = @"3、如提现过程中有疑问，请联系客服：";
        _callPhoneView.phoneNumber = [NSString stringWithFormat:@"%@。",kServiceMobile];
//        _callPhoneView.supplementText = @"(周一至周五 9:00-19:00)";
    }
    return _callPhoneView;
}

- (UILabel *)promptLabel
{
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.text = @"2、禁止洗钱、信用卡套现、虚假交易等行为，一经发现并确认，将终止该账户的使用；";
        _promptLabel.textColor = COR8;
        _promptLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        _promptLabel.numberOfLines = 0;
    }
    return _promptLabel;
}
- (UILabel *)tiedCardLabel
{
    if (!_tiedCardLabel) {
        _tiedCardLabel = [[UILabel alloc] init];
        _tiedCardLabel.text = @"1、预计到账时间为两个工作日，双休日和法定节假日顺延处理；";
        _tiedCardLabel.textColor = COR8;
        _tiedCardLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        _tiedCardLabel.numberOfLines = 0;
    }
    return _tiedCardLabel;
}
- (UILabel *)reminderLabel
{
    if (!_reminderLabel) {
        _reminderLabel = [[UILabel alloc] init];
        _reminderLabel.text = @"温馨提示：";
        _reminderLabel.textColor = RGB(115, 173, 255);
        _reminderLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
    }
    return _reminderLabel;
}
/**
 设置数据
 */
- (void)setUserInfoViewModel:(HXBRequestUserInfoViewModel *)userInfoViewModel
{   
    _userInfoViewModel = userInfoViewModel;
    self.availableBalanceLabel.text = [NSString stringWithFormat:@"可提金额：%@", [NSString hxb_getPerMilWithDouble:[userInfoViewModel.userInfoModel.userAssets.availablePoint floatValue]]];
}

- (void)loadBankCard
{
    kWeakSelf
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
        weakSelf.bankCardModel = [HXBBankCardModel yy_modelWithJSON:responseObject[@"data"]];
        self.mybankView.bankCardModel = weakSelf.bankCardModel;
    } failure:^(NYBaseRequest *request, NSError *error) {
        NSLog(@"%@",error);
        [HxbHUDProgress showTextWithMessage:@"银行卡请求失败"];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)leftBackBtnClick
{
    NSInteger index = self.navigationController.viewControllers.count;
    UIViewController *VC = self.navigationController.viewControllers[index - 2];
    if ([VC isKindOfClass:NSClassFromString(@"HXBOpenDepositAccountViewController")] || [VC isKindOfClass:NSClassFromString(@"HxbWithdrawCardViewController")]) {
        [self.navigationController popToViewController:self.navigationController.viewControllers[index - 3] animated:YES];
    }else
    {
        [super leftBackBtnClick];
    }
}


@end

@interface WithdrawBankView ()
@property (nonatomic, strong) UIImageView *bankLogoImageView;
@property (nonatomic, strong) UILabel *bankNameLabel;
@property (nonatomic, strong) UILabel *bankCardNumLabel;
@property (nonatomic, strong) UILabel *amountLimitLabel;
@property (nonatomic, strong) UILabel *arrivalDateLabel;
@end

@implementation WithdrawBankView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bankLogoImageView];
        [self addSubview:self.bankNameLabel];
        [self addSubview:self.bankCardNumLabel];
        [self addSubview:self.amountLimitLabel];
        [self addSubview:self.arrivalDateLabel];
        [self getpaymentDate];
        [self setContentViewFrame];
    }
    return self;
}

/**
 回去到账时间
 */
- (void)getpaymentDate
{
    kWeakSelf
    HXBWithdrawalsRequest *paymentDate = [[HXBWithdrawalsRequest alloc] init];
    [paymentDate paymentDateRequestWithSuccessBlock:^(id responseObject) {
        
        weakSelf.arrivalDateLabel.text = [NSString stringWithFormat:@"预计%@(T+2工作日)到账",[[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:responseObject[@"data"][@"arrivalTime"] andDateFormat:@"yyyy-MM-dd"]];
        
    } andFailureBlock:^(NSError *error) {
        
    }];
}



- (void)setBankCardModel:(HXBBankCardModel *)bankCardModel
{
    _bankCardModel = bankCardModel;
    self.bankNameLabel.text = self.bankCardModel.bankType;
    self.bankCardNumLabel.text = [NSString stringWithFormat:@"(尾号%@)",[self.bankCardModel.cardId substringFromIndex:self.bankCardModel.cardId.length - 4]];
    self.bankLogoImageView.svgImageString = self.bankCardModel.bankCode;
}


- (void)setContentViewFrame{
    [self.bankLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kScrAdaptationW750(30));
        make.top.equalTo(self.mas_top).offset(kScrAdaptationH750(40));
        make.size.mas_equalTo(CGSizeMake(kScrAdaptationW750(80), kScrAdaptationH750(80)));
    }];
    [self.bankNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bankLogoImageView.mas_right).offset(kScrAdaptationW750(36));
        make.top.equalTo(self).offset(kScrAdaptationH750(44));
        make.height.offset(kScrAdaptationH750(28));
    }];
    [self.bankCardNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bankNameLabel.mas_right);
        make.centerY.equalTo(self.bankNameLabel);
    }];
    [self.arrivalDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bankNameLabel.mas_left);
        make.top.equalTo(self.bankNameLabel.mas_bottom).offset(kScrAdaptationH750(20));
    }];
}
- (UILabel *)arrivalDateLabel
{
    if (!_arrivalDateLabel) {
        _arrivalDateLabel = [[UILabel alloc] init];
        _arrivalDateLabel.text = [NSString stringWithFormat:@"预计%@(T+2工作日)到账",[[HXBBaseHandDate sharedHandleDate] stringFromDate:[NSDate date] andDateFormat:@"yyyy-MM-dd"]];
        _arrivalDateLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        _arrivalDateLabel.textColor = RGB(153, 153, 153);
    }
    return _arrivalDateLabel;
}
- (UIImageView *)bankLogoImageView{
    if (!_bankLogoImageView) {
        _bankLogoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"默认"]];
        _bankLogoImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _bankLogoImageView;
}

- (UILabel *)bankNameLabel{
    if (!_bankNameLabel) {
        _bankNameLabel = [[UILabel alloc] init];
        _bankNameLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
        _bankNameLabel.textColor = RGB(51, 51, 51);
    }
    return _bankNameLabel;
}

- (UILabel *)bankCardNumLabel{
    if (!_bankCardNumLabel) {
        _bankCardNumLabel = [[UILabel alloc] init];
        _bankCardNumLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
        _bankCardNumLabel.textColor = RGB(51, 51, 51);
    }
    return _bankCardNumLabel;
}

- (UILabel *)amountLimitLabel{
    if (!_amountLimitLabel) {
        
    }
    return _amountLimitLabel;
}

@end
