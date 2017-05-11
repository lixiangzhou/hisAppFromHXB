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

@interface HxbWithdrawCardViewController () <UITextFieldDelegate,HxbPickerAreaDelegate>

@property (nonatomic, strong) UITextField *bankCardTextField;
@property (nonatomic, strong) UITextField *bankNameTetxField;
@property (nonatomic, strong) UITextField *realNameTextField;
@property (nonatomic, strong) UITextField *locationTextField;
@property (nonatomic, strong) UIButton *nextButton;
@end

@implementation HxbWithdrawCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bankCardTextField];
    [self.view addSubview:self.bankNameTetxField];
    [self.view addSubview:self.realNameTextField];
    [self.view addSubview:self.locationTextField];
    [self.view addSubview:self.nextButton];
}

- (void)nextButtonClick:(UIButton *)sender{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"输入交易密码" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         UITextField *passwordTextField = alertController.textFields.firstObject;
        if (passwordTextField.text.length == 0) {
            return [HxbHUDProgress showTextWithMessage:@"密码不能为空"];
        }
        HxbWithdrawResultViewController *withdrawResultVC = [[HxbWithdrawResultViewController alloc]init];
        [self.navigationController pushViewController:withdrawResultVC animated:YES];
    }];
    
    UIAlertAction *cancalAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:okAction];
    [alertController addAction:cancalAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)pickerArea:(HxbPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area{
    NSString *text = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
    self.locationTextField.text = text;
}

#pragma mark - --- delegate 视图委托 ---

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.locationTextField resignFirstResponder];
    [[[HxbPickerArea alloc]initWithDelegate:self]show];
    
}
- (UITextField *)bankCardTextField{
    if (!_bankCardTextField) {
        _bankCardTextField = [UITextField hxb_lineTextFieldWithFrame:CGRectMake(20, 100, SCREEN_WIDTH - 40, 44)];
    }
    return _bankCardTextField;
}

- (UITextField *)bankNameTetxField{
    if (!_bankNameTetxField) {
        _bankNameTetxField = [UITextField hxb_lineTextFieldWithFrame:CGRectMake(20, CGRectGetMaxY(_bankCardTextField.frame) + 20, SCREEN_WIDTH - 40, 44)];
    }
    return _bankNameTetxField;
    
}

- (UITextField *)realNameTextField{
    if (!_realNameTextField) {
        _realNameTextField = [UITextField hxb_lineTextFieldWithFrame:CGRectMake(20, CGRectGetMaxY(_bankNameTetxField.frame) + 20, SCREEN_WIDTH - 40, 44)];
    }
    return _realNameTextField;
}

- (UITextField *)locationTextField{
    if (!_locationTextField) {
        _locationTextField = [UITextField hxb_lineTextFieldWithFrame:CGRectMake(20, CGRectGetMaxY(_realNameTextField.frame) + 20, SCREEN_WIDTH - 40, 44)];
        _locationTextField.delegate = self;
    }
    return _locationTextField;
}

- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [UIButton btnwithTitle:@"下一步" andTarget:self andAction:@selector(nextButtonClick:) andFrameByCategory:CGRectMake(20, CGRectGetMaxY(_locationTextField.frame) + 40, SCREEN_WIDTH - 40, 44)];
    }
    return _nextButton;
}
@end

