//
//  HxbWithdrawCardViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbWithdrawCardViewController.h"
#import "HxbPickerArea.h"
#import "HxbWithdrawResultViewController.h"
#import "HXBBankCardModel.h"
#import "HXBWithdrawalsRequest.h"
#import "HXBAlertVC.h"
#import "HXBModifyTransactionPasswordViewController.h"
#import "HXBBankCardListViewController.h"
@interface HxbWithdrawCardViewController () <UITextFieldDelegate,HxbPickerAreaDelegate>

@property (nonatomic, strong) UITextField *bankCardTextField;
@property (nonatomic, strong) UIButton *bankNameBtn;
@property (nonatomic, strong) UITextField *realNameTextField;
//@property (nonatomic, strong) UITextField *locationTextField;
//@property (nonatomic, strong) UITextField *openingBank;
@property (nonatomic, strong) UIButton *nextButton;
/**
 bankCode
 */
@property (nonatomic, copy) NSString *bankCode;
/**
 数据模型
 */
@property (nonatomic, strong) HXBBankCardModel *bankCardModel;
@end

@implementation HxbWithdrawCardViewController

- (HXBBankCardModel *)bankCardModel
{
    if (!_bankCardModel) {
        _bankCardModel = [[HXBBankCardModel alloc] init];
    }
    return _bankCardModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认信息";
    [self.view addSubview:self.bankCardTextField];
    [self.view addSubview:self.bankNameBtn];
//    [self.view addSubview:self.locationTextField];
//    [self.view addSubview:self.openingBank];
    [self.view addSubview:self.realNameTextField];
    [self.view addSubview:self.nextButton];
}

- (void)nextButtonClick:(UIButton *)sender{
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
        modifyTransactionPasswordVC.userInfoModel = weakSelf.userInfoModel;
        [weakSelf.navigationController pushViewController:modifyTransactionPasswordVC animated:YES];
    };
    [self presentViewController:alertVC animated:NO completion:^{
        
    }];
}


- (void)pickerArea:(HxbPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area{
//    self.locationTextField.text = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
}

- (void)checkWithdrawals:(NSString *)paypassword
{
    self.view.userInteractionEnabled = NO;
    kWeakSelf
    NSMutableDictionary *requestArgument  = [NSMutableDictionary dictionary];
    requestArgument[@"bankno"] = weakSelf.bankCode;
//    requestArgument[@"city"] = self.bankCardModel.city; 
    requestArgument[@"bank"] = self.bankCardTextField.text;
    requestArgument[@"paypassword"] = paypassword;
    requestArgument[@"amount"] = self.amount;
    HXBWithdrawalsRequest *withdrawals = [[HXBWithdrawalsRequest alloc] init];
    [withdrawals withdrawalsRequestWithRequestArgument:requestArgument andSuccessBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
        weakSelf.view.userInteractionEnabled = YES;
        HxbWithdrawResultViewController *withdrawResultVC = [[HxbWithdrawResultViewController alloc]init];
        weakSelf.bankCardModel.arrivalTime = responseObject[@"data"][@"arrivalTime"];
        weakSelf.bankCardModel.bankType = weakSelf.bankNameBtn.titleLabel.text;
        weakSelf.bankCardModel.cardId = weakSelf.bankCardTextField.text;
        weakSelf.bankCardModel.amount = weakSelf.amount;
        withdrawResultVC.bankCardModel = weakSelf.bankCardModel;
        [weakSelf.navigationController pushViewController:withdrawResultVC animated:YES];
    } andFailureBlock:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
         NSLog(@"%@",error);
    }];

}

//- (void)setBankCardModel:(HXBBankCardModel *)bankCardModel
//{
//    _bankCardModel = bankCardModel;
//    if (bankCardModel.cardId.length) {
//        //银行卡号
//        self.bankCardTextField.text = bankCardModel.cardId;
//        self.bankCardTextField.enabled = NO;
//        //所属银行
//        [self.bankNameBtn setTitle:bankCardModel.bankType forState:UIControlStateNormal];
//        self.bankNameBtn.enabled = NO;
////        //开户地
////        self.locationTextField.text = bankCardModel.deposit;
////        self.locationTextField.enabled = NO;
////        //开户行
////        self.openingBank.text = bankCardModel.bankType;
////        self.openingBank.enabled = NO;
//        //持卡人
//        self.realNameTextField.text = bankCardModel.name;
//        self.realNameTextField.enabled = NO;
//    }
//}

- (void)bankNameBtnClick
{
    kWeakSelf
    HXBBankCardListViewController *bankCardListVC = [[HXBBankCardListViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:bankCardListVC];
    bankCardListVC.bankCardListBlock = ^(NSString *bankCode, NSString *bankName){
        [weakSelf.bankNameBtn setTitle:bankName forState:UIControlStateNormal];
        [weakSelf.bankNameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        weakSelf.bankCode = bankCode;
    };
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

#pragma mark - --- delegate 视图委托 ---

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    [self.locationTextField resignFirstResponder];
//    [[[HxbPickerArea alloc]initWithDelegate:self]show];
    
}
- (UITextField *)bankCardTextField{
    if (!_bankCardTextField) {
        _bankCardTextField = [UITextField hxb_lineTextFieldWithFrame:CGRectMake(20, 100, SCREEN_WIDTH - 40, 44)];
        _bankCardTextField.placeholder = @"银行卡号";
    }
    return _bankCardTextField;
}

- (UIButton *)bankNameBtn{
    if (!_bankNameBtn) {
        _bankNameBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_bankCardTextField.frame) + 20, SCREEN_WIDTH - 40, 44)];
        [_bankNameBtn setTitle:@"所属银行" forState:UIControlStateNormal];
        [_bankNameBtn setTitleColor:COR11 forState:UIControlStateNormal];
        [_bankNameBtn addTarget:self action:@selector(bankNameBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _bankNameBtn.layer.borderWidth = 0.5;
        _bankNameBtn.layer.borderColor = COR12.CGColor;
    }
    return _bankNameBtn;
    
}
//- (UITextField *)locationTextField{
//    if (!_locationTextField) {
//        _locationTextField = [UITextField hxb_lineTextFieldWithFrame:CGRectMake(20, CGRectGetMaxY(_bankNameTetxField.frame) + 20, SCREEN_WIDTH - 40, 44)];
//        _locationTextField.delegate = self;
//        _locationTextField.placeholder = @"开户地";
//    }
//    return _locationTextField;
//}

//- (UITextField *)openingBank
//{
//    if (!_openingBank) {
//        _openingBank = [UITextField hxb_lineTextFieldWithFrame:CGRectMake(20, CGRectGetMaxY(_locationTextField.frame) + 20, SCREEN_WIDTH - 40, 44)];
//        _openingBank.delegate = self;
//        _openingBank.placeholder = @"开户行";
//    }
//    return _openingBank;
//}

- (UITextField *)realNameTextField{
    if (!_realNameTextField) {
        _realNameTextField = [UITextField hxb_lineTextFieldWithFrame:CGRectMake(20, CGRectGetMaxY(self.bankNameBtn.frame) + 20, SCREEN_WIDTH - 40, 44)];
        _realNameTextField.placeholder = @"持卡人";
    }
    return _realNameTextField;
}



- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [UIButton btnwithTitle:@"下一步" andTarget:self andAction:@selector(nextButtonClick:) andFrameByCategory:CGRectMake(20, CGRectGetMaxY(_realNameTextField.frame) + 40, SCREEN_WIDTH - 40, 44)];
    }
    return _nextButton;
}
@end

