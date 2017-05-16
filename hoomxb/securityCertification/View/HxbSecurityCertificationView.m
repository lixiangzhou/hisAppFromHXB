//
//  HxbSecurityCertificationView.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbSecurityCertificationView.h"

@interface HxbSecurityCertificationView()
<
UITextFieldDelegate
>
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *identityCardNumTextField;
@property (nonatomic, strong) UITextField *payPasswordTextField;
@property (nonatomic, strong) UITextField *payPasswordConfirmTextField;
@property (nonatomic, strong) UIButton *securityCertificationButton;
@end

@implementation HxbSecurityCertificationView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.nameTextField];
        [self addSubview:self.identityCardNumTextField];
        [self addSubview:self.payPasswordTextField];
        [self addSubview:self.payPasswordConfirmTextField];
        [self addSubview:self.securityCertificationButton];
    }
    return self;
}
- (void)securityCertificationButtonClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(didClickSecurityCertificationButton)]) {
        if (_identityCardNumTextField.text.length == 0|| _nameTextField.text.length == 0 || _payPasswordTextField.text.length == 0 || _payPasswordConfirmTextField.text.length == 0) {
            return [HxbHUDProgress showTextWithMessage:@"不能有空"];
        }
//        if (![NSString validateIDCardNumber:_identityCardNumTextField.text]) {
//            return [HxbHUDProgress showTextWithMessage:@"请输入正确的身份证号"];
//        }
        if (_payPasswordTextField.text.length <8 ||_payPasswordConfirmTextField.text.length <8) {
            return [HxbHUDProgress showTextWithMessage:@"交易密码不能小于6位"];
        }
        if (![_payPasswordTextField.text isEqualToString:_payPasswordConfirmTextField.text]) {
             return [HxbHUDProgress showTextWithMessage:@"两次输入的密码不一致"];
        }
        [KeyChain setRealName:_nameTextField.text];
        [KeyChain setRealId:_identityCardNumTextField.text];
        [KeyChain setTradePwd:_payPasswordConfirmTextField.text];
        [self.delegate didClickSecurityCertificationButton];
    }
}
- (void)textFieldEditing{
    [_identityCardNumTextField.rac_textSignal subscribeNext:^(id x) {
       
    
        
    }];

}
- (UITextField *)nameTextField{
    if (!_nameTextField) {
        _nameTextField = [UITextField hxb_lineTextFieldWithFrame:CGRectMake(20, 64+44, SCREEN_WIDTH - 40, 44)];
        UILabel *leftLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,70, 44)];
        leftLable.text = @"姓名";
        leftLable.textColor = COR1;
        _nameTextField.leftViewMode = UITextFieldViewModeAlways;
        _nameTextField.delegate = self;
        _nameTextField.leftView = leftLable;
        _nameTextField.returnKeyType = UIReturnKeyNext;
    }
    return _nameTextField;
}

- (UITextField *)identityCardNumTextField{
    if (!_identityCardNumTextField) {
        _identityCardNumTextField = [UITextField hxb_lineTextFieldWithFrame:CGRectMake(20, CGRectGetMaxY(_nameTextField.frame) + 60, SCREEN_WIDTH - 40, 44)];
        //        [_passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        UILabel *leftLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,70, 44)];
        leftLable.text = @"身份证号";
        leftLable.textColor = COR1;
        _identityCardNumTextField.leftViewMode = UITextFieldViewModeAlways;
        _identityCardNumTextField.delegate = self;
        _identityCardNumTextField.leftView = leftLable;
        _identityCardNumTextField.returnKeyType = UIReturnKeyNext;
    }
    return _identityCardNumTextField;
}

- (UITextField *)payPasswordTextField{
    if (!_payPasswordTextField) {
        _payPasswordTextField = [UITextField hxb_lineTextFieldWithFrame:CGRectMake(20, CGRectGetMaxY(_identityCardNumTextField.frame) + 60, SCREEN_WIDTH - 40, 44)];
        //        [_passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        UILabel *leftLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,70, 44)];
        leftLable.text = @"交易密码";
        leftLable.textColor = COR1;
        _payPasswordTextField.leftViewMode = UITextFieldViewModeAlways;
        _payPasswordTextField.delegate = self;
        _payPasswordTextField.leftView = leftLable;
        _payPasswordTextField.returnKeyType = UIReturnKeyNext;
    }
    return _payPasswordTextField;
}

- (UITextField *)payPasswordConfirmTextField{
    if (!_payPasswordConfirmTextField)
    {
        _payPasswordConfirmTextField = [UITextField hxb_lineTextFieldWithFrame:CGRectMake(20, CGRectGetMaxY(_payPasswordTextField.frame) + 60, SCREEN_WIDTH - 40, 44)];
        //        [_passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        UILabel *leftLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,120, 44)];
        leftLable.text = @"确认交易密码";
        leftLable.textColor = COR1;
        _payPasswordConfirmTextField.leftViewMode = UITextFieldViewModeAlways;
        _payPasswordConfirmTextField.delegate = self;
        _payPasswordConfirmTextField.leftView = leftLable;
        _payPasswordConfirmTextField.returnKeyType = UIReturnKeyDone;
    }
    return _payPasswordConfirmTextField;
}

- (UIButton *)securityCertificationButton{
    if (!_securityCertificationButton) {
        _securityCertificationButton = [UIButton btnwithTitle:@"安全认证" andTarget:self andAction:@selector(securityCertificationButtonClick:) andFrameByCategory:CGRectMake(20, CGRectGetMaxY(_payPasswordConfirmTextField.frame) + 60, SCREEN_WIDTH - 40, 44)];
    }
    return _securityCertificationButton;
}

@end
