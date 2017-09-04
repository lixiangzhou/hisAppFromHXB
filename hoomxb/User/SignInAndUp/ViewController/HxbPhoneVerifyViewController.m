//
//  HxbPhoneVerifyViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/2.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbPhoneVerifyViewController.h"
#import "HxbSignUpViewController.h"

@interface HxbPhoneVerifyViewController ()
<
UITextFieldDelegate
>
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UIButton *nextButton;
@end

@implementation HxbPhoneVerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.nextButton];
}

- (void)textFieldDidChange:(UITextField *)textField{
 
}

- (void)nextButtonClick:(UIButton *)sender{
    HxbSignUpViewController *signUpViewController = [[HxbSignUpViewController alloc]init];
    [self.navigationController pushViewController:signUpViewController animated:true];
}

- (UITextField *)phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [UITextField hxb_lineTextFieldWithFrame:CGRectMake(20, SCREEN_HEIGHT/3, SCREEN_WIDTH - 40, 44)];
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_phoneTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        UILabel *leftLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,70, 44)];
        leftLable.text = @"手机号";
        leftLable.textColor = COR1;
        _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        _phoneTextField.leftView = leftLable;
    }
    return _phoneTextField;
}

- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [UIButton btnwithTitle:@"下一步" andTarget:self andAction:@selector(nextButtonClick:) andFrameByCategory:CGRectMake(20, CGRectGetMaxY(_phoneTextField.frame) + 100 , SCREEN_WIDTH - 40, 44)];
    }
    return _nextButton;
}

@end
