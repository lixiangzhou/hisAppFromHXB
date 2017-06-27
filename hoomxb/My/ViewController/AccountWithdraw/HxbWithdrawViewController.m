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
@interface HxbWithdrawViewController ()
@property (nonatomic, strong) UITextField *amountTextField;
@property (nonatomic, strong) UILabel *availableBalanceLabel;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UILabel *arrivalDateLabel;
@property (nonatomic, strong) WithdrawBankView *mybankView;
/**
 数据模型
 */
@property (nonatomic, strong) HXBBankCardModel *bankCardModel;
@end

@implementation HxbWithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    [self.view addSubview:self.mybankView];
    [self.view addSubview:self.amountTextField];
    [self.view addSubview:self.nextButton];
    [self.view addSubview:self.availableBalanceLabel];
    [self.view addSubview:self.tipLabel];
    [self.view addSubview:self.arrivalDateLabel];
    [self setCardViewFrame];
    
}
- (void)setCardViewFrame{
    
    if (![self.userInfoViewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"]) {
        self.mybankView.hidden = YES;
        [_amountTextField setY:100];
        
    }else
    {
        [self loadBankCard];
    }
    [self.availableBalanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(self.amountTextField.mas_bottom).offset(20);
    }];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.centerY.equalTo(self.availableBalanceLabel);
    }];
    [self.arrivalDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(self.availableBalanceLabel.mas_bottom).offset(50);
    }];
}

- (void)withdrawals
{
    kWeakSelf
    HXBAlertVC *alertVC = [[HXBAlertVC alloc] init];
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
    self.view.userInteractionEnabled = NO;
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
        weakSelf.view.userInteractionEnabled = YES;
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
        [HxbHUDProgress showTextWithMessage:@"金额不能大于余额"];
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
            [weakSelf.navigationController pushViewController:securityCertificationVC animated:YES];
            return;
        }else
        {
            HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc]init];
            if ([viewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"]) {
                 withdrawCardViewController.bankCardModel = weakSelf.bankCardModel;
            }
            withdrawCardViewController.userInfoModel = weakSelf.userInfoViewModel.userInfoModel;
            [weakSelf.navigationController pushViewController:withdrawCardViewController animated:YES];
            return;
        }
    } andFailure:^(NSError *error) {
        
    }];
   
}

- (WithdrawBankView *)mybankView{
    if (!_mybankView) {
        _mybankView = [[WithdrawBankView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 80)];
    }
    return _mybankView;
}
- (UITextField *)amountTextField{
    if (!_amountTextField) {
        _amountTextField = [UITextField hxb_lineTextFieldWithFrame:CGRectMake(20, CGRectGetMaxY(self.mybankView.frame) + 20, SCREEN_WIDTH - 40, 44)];
        _amountTextField.placeholder = @"请输入充值金额";
        
    }
    return _amountTextField;
}

- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [UIButton btnwithTitle:@"下一步" andTarget:self andAction:@selector(nextButtonClick:) andFrameByCategory:  CGRectMake(20,self.view.height - 100, SCREEN_WIDTH - 40,44)];
    }
    return _nextButton;
}

- (UILabel *)availableBalanceLabel
{
    if (!_availableBalanceLabel) {
        _availableBalanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.amountTextField.bottom + 20, 0, 0)];
        _availableBalanceLabel.text = @"可用余额 : 0.00元";
        
    }
    return _availableBalanceLabel;
}
- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.text = @"提现免手续费";
        _tipLabel.textColor = COR12;
    }
    return _tipLabel;
}
- (UILabel *)arrivalDateLabel
{
    if (!_arrivalDateLabel) {
        _arrivalDateLabel = [[UILabel alloc] init];
        _arrivalDateLabel.text = [NSString stringWithFormat:@"预计%@(T+2工作日)到账",[[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:[NSDate date] andDateFormat:@"yyyy-MM-dd"]];
    }
    return _arrivalDateLabel;
}
/**
 设置数据
 */
- (void)setUserInfoViewModel:(HXBRequestUserInfoViewModel *)userInfoViewModel
{   
    _userInfoViewModel = userInfoViewModel;
    self.availableBalanceLabel.text = [NSString stringWithFormat:@"可用余额 : %@元",userInfoViewModel.userInfoModel.userAssets.availablePoint];
}

- (void)loadBankCard
{
    kWeakSelf
    NYBaseRequest *bankCardAPI = [[NYBaseRequest alloc] init];
    bankCardAPI.requestUrl = @"/account/user/card";
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

@end

@interface WithdrawBankView ()
@property (nonatomic, strong) UIImageView *bankLogoImageView;
@property (nonatomic, strong) UILabel *bankNameLabel;
@property (nonatomic, strong) UILabel *bankCardNumLabel;
@property (nonatomic, strong) UILabel *amountLimitLabel;
@end

@implementation WithdrawBankView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bankLogoImageView];
        [self addSubview:self.bankNameLabel];
        [self addSubview:self.bankCardNumLabel];
        [self addSubview:self.amountLimitLabel];
        
        [self setContentViewFrame];
    }
    return self;
}

- (void)setBankCardModel:(HXBBankCardModel *)bankCardModel
{
    _bankCardModel = bankCardModel;
    self.bankNameLabel.text = self.bankCardModel.bankType;
    self.bankCardNumLabel.text = [NSString stringWithFormat:@"尾号 %@",[self.bankCardModel.cardId substringFromIndex:self.bankCardModel.cardId.length - 4]];

}


- (void)setContentViewFrame{
    [self.bankLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.top.equalTo(self.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [self.bankNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bankLogoImageView.mas_right).offset(20);
        make.centerY.equalTo(self);
    }];
    [self.bankCardNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-20);
        make.centerY.equalTo(self);
    }];
}

- (UIImageView *)bankLogoImageView{
    if (!_bankLogoImageView) {
        _bankLogoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zhaoshang"]];
        
    }
    return _bankLogoImageView;
}

- (UILabel *)bankNameLabel{
    if (!_bankNameLabel) {
        _bankNameLabel = [[UILabel alloc] init];
        
    }
    return _bankNameLabel;
}

- (UILabel *)bankCardNumLabel{
    if (!_bankCardNumLabel) {
        _bankCardNumLabel = [[UILabel alloc] init];
    }
    return _bankCardNumLabel;
}

- (UILabel *)amountLimitLabel{
    if (!_amountLimitLabel) {
        
    }
    return _amountLimitLabel;
}
@end
