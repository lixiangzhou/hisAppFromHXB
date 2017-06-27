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
@interface HxbWithdrawCardViewController () <UITextFieldDelegate,HxbPickerAreaDelegate>

@property (nonatomic, strong) UITextField *bankCardTextField;
@property (nonatomic, strong) UITextField *bankNameTetxField;
@property (nonatomic, strong) UITextField *realNameTextField;
//@property (nonatomic, strong) UITextField *locationTextField;
//@property (nonatomic, strong) UITextField *openingBank;
@property (nonatomic, strong) UIButton *nextButton;
@end

@implementation HxbWithdrawCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认信息";
    [self.view addSubview:self.bankCardTextField];
    [self.view addSubview:self.bankNameTetxField];
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

- (void)setBankCardModel:(HXBBankCardModel *)bankCardModel
{
    _bankCardModel = bankCardModel;
    if (bankCardModel.cardId.length) {
        //银行卡号
        self.bankCardTextField.text = bankCardModel.cardId;
        self.bankCardTextField.enabled = NO;
        //所属银行
        self.bankNameTetxField.text = bankCardModel.bankType;
        self.bankNameTetxField.enabled = NO;
//        //开户地
//        self.locationTextField.text = bankCardModel.deposit;
//        self.locationTextField.enabled = NO;
//        //开户行
//        self.openingBank.text = bankCardModel.bankType;
//        self.openingBank.enabled = NO;
        //持卡人
        self.realNameTextField.text = bankCardModel.name;
        self.realNameTextField.enabled = NO;
    }
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

- (UITextField *)bankNameTetxField{
    if (!_bankNameTetxField) {
        _bankNameTetxField = [UITextField hxb_lineTextFieldWithFrame:CGRectMake(20, CGRectGetMaxY(_bankCardTextField.frame) + 20, SCREEN_WIDTH - 40, 44)];
        _bankNameTetxField.placeholder = @"所属银行";
    }
    return _bankNameTetxField;
    
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
        _realNameTextField = [UITextField hxb_lineTextFieldWithFrame:CGRectMake(20, CGRectGetMaxY(_bankNameTetxField.frame) + 20, SCREEN_WIDTH - 40, 44)];
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

