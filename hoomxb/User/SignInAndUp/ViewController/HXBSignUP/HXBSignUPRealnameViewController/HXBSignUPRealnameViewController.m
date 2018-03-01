//
//  HXBSignUPRealnameViewController.m
//  hoomxb
//
//  Created by HXB on 2017/6/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBSignUPRealnameViewController.h"
#import "HXBSignUPAndLoginRequest.h"
#import "HXBSignUPRealnameViewModel.h"

///实名认证的VC
@interface HXBSignUPRealnameViewController () <UITextFieldDelegate>
@property (nonatomic,strong) UIButton *goRealnameButton;
@property (nonatomic,strong) UITextField *nameTextField;
@property (nonatomic,strong) UITextField *idCardTextField;
@property (nonatomic,strong) UITextField *setupPasswordTextField;

@property (nonatomic, strong) HXBSignUPRealnameViewModel *viewModel;
@end

@implementation HXBSignUPRealnameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kWeakSelf
    self.viewModel = [[HXBSignUPRealnameViewModel alloc] initWithBlock:^UIView *{
        return weakSelf.view;
    }];
    [self setUPView];
}

- (void)setUPView {
    __weak typeof (self)weakSelf = self;
    self.goRealnameButton = [[UIButton alloc] initWithFrame:CGRectZero];
    self.nameTextField = [[UITextField alloc]initWithFrame:CGRectZero];
    self.idCardTextField = [[UITextField alloc]initWithFrame:CGRectZero];
    self.setupPasswordTextField = [[UITextField alloc]initWithFrame:CGRectZero];
    
    
    [self.view addSubview:self.goRealnameButton];
    [self.view addSubview:self.nameTextField];
    [self.view addSubview:self.idCardTextField];
    [self.view addSubview:self.setupPasswordTextField];
    
    [self.goRealnameButton setTitle:@"安全认证" forState:UIControlStateNormal];
    [self.goRealnameButton addTarget:self action:@selector(clickGoRealnameButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.nameTextField.placeholder = @"姓名";
    self.idCardTextField.placeholder = @"身份证号码";
    self.setupPasswordTextField.placeholder = @"设置交易密码";
    
    self.nameTextField.delegate = self;
    self.idCardTextField.delegate = self;
    self.setupPasswordTextField.delegate = self;
    
    
    
    [self.goRealnameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(weakSelf);
        make.height.equalTo(@(kScrAdaptationH(40)));
    }];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(kScrAdaptationH(20));
        make.right.equalTo(weakSelf).offset(kScrAdaptationW(-20));
        make.left.equalTo(weakSelf).offset(kScrAdaptationW(20));
        make.height.equalTo(@(kScrAdaptationH(40)));
    }];
    [self.idCardTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameTextField.mas_bottom).offset(kScrAdaptationH(20));
        make.right.equalTo(weakSelf.nameTextField);
        make.left.equalTo(weakSelf.nameTextField);
        make.height.equalTo(@(kScrAdaptationH(40)));
    }];
    [self.setupPasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.idCardTextField.mas_bottom).offset(kScrAdaptationH(20));
        make.right.equalTo(weakSelf.nameTextField);
        make.left.equalTo(weakSelf.nameTextField);
        make.height.equalTo(@(kScrAdaptationH(40)));
    }];
}

- (void) clickGoRealnameButton: (UIButton *) button{
    NSLog(@"确定安全认证");
    [self downLoadData_realname];
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (![textField isEqual:self.idCardTextField]) return YES;
    return !(textField.text.length >= 18);
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([textField isEqual:self.idCardTextField]) {
        if([NSString validateIDCardNumber: textField.text]) {
            [self.viewModel modifyTransactionPasswordWithIdCard:textField.text resultBlock:^(BOOL isSuccess) {
                
            }];
        }
    }
    if ([textField isEqual:self.setupPasswordTextField]) {
        // 符合密码规范
        self.goRealnameButton.userInteractionEnabled = [NSString checkPassWordWithString:self.setupPasswordTextField.text];
    }
    return YES;
}


- (void) downLoadData_realname {
    [HXBSignUPAndLoginRequest realnameRequestWithUserName:self.nameTextField.text andIdentityCard:self.idCardTextField.text andPassword:self.setupPasswordTextField.text andSuccessBlock:^(BOOL isExist) {
        if (isExist) {
            ///跳到认证成功页
            NSLog(@"认证成功");
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } andFailureBlock:^(NSError *error, NYBaseRequest *request) {
        kHXBRespons_ShowHUDWithError(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
