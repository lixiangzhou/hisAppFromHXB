//
//  HxbBindCardViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/9.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbBindCardViewController.h"
#import "HxbPickerArea.h"

@interface HxbBindCardViewController () <UITextFieldDelegate,HxbPickerAreaDelegate>

@property (nonatomic, strong) UITextField *bankCardTextField;
@property (nonatomic, strong) UITextField *bankNameTetxField;
@property (nonatomic, strong) UITextField *realNameTextField;
@property (nonatomic, strong) UITextField *locationTextField;
@end

@implementation HxbBindCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bankCardTextField];
    [self.view addSubview:self.bankNameTetxField];
    [self.view addSubview:self.realNameTextField];
    [self.view addSubview:self.locationTextField];
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
@end
