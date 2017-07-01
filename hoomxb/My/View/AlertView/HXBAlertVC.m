//
//  HXBAlertVC.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBAlertVC.h"

@interface HXBAlertVC ()
@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIButton *sureBtn;

@property (nonatomic, strong) UIButton *forgetBtn;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *message;

@property (nonatomic, strong) UITextField *pwdField;
@end

@implementation HXBAlertVC

- (instancetype)init
{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.cancelBtn];
    [self.contentView addSubview:self.sureBtn];
    [self.contentView addSubview:self.forgetBtn];
    [self.contentView addSubview:self.message];
    [self.contentView addSubview:self.pwdField];
    [self setupSubViewFrame];
}

- (void)setupSubViewFrame
{
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.equalTo(@150);
        make.width.equalTo(@250);
    }];
    [self.message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.centerX.equalTo(self.view);
    }];
    [self.pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.message.mas_bottom).offset(20);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
    }];
    [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdField.mas_bottom);
        make.right.equalTo(self.pwdField.mas_right);
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.width.equalTo(self.contentView).multipliedBy(0.5);
        make.height.with.equalTo(@44);
    }];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(self.contentView.mas_right);
        make.width.equalTo(self.contentView).multipliedBy(0.5);
        make.height.with.equalTo(@44);
    }];
    
}
- (void)buttonClick:(UIButton *)btn
{
    if ([btn.titleLabel.text isEqualToString:@"确认"]) {
        NSString *message = [NSString isOrNoPasswordStyle:self.pwdField.text];
        if (message.length > 0) {
            [HxbHUDProgress showTextWithMessage:message];
            return;
        }else
        {
            if (self.sureBtnClick) {
                self.sureBtnClick(self.pwdField.text);
            }
        }
    }else if ([btn.titleLabel.text isEqualToString:@"忘记密码"])
    {
        if (self.forgetBtnClick) {
            self.forgetBtnClick();
        }
    }
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn.layer.borderWidth = 0.5;
        _cancelBtn.layer.borderColor = COR12.CGColor;
    }
    return _cancelBtn;
}

- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc] init];
        [_sureBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn.layer.borderWidth = 0.5;
        _sureBtn.layer.borderColor = COR12.CGColor;
    }
    return _sureBtn;
}
- (UIButton *)forgetBtn
{
    if (!_forgetBtn) {
        _forgetBtn = [[UIButton alloc] init];
        [_forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        _forgetBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_forgetBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_forgetBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetBtn;
}
- (UILabel *)message
{
    if (!_message) {
        _message = [[UILabel alloc] init];
        _message.text = @"请输入交易密码";
    }
    return _message;
}

- (UITextField *)pwdField
{
    if (!_pwdField) {
        _pwdField = [[UITextField alloc] init];
        _pwdField.placeholder = @"请输入交易密码";
        _pwdField.secureTextEntry = YES;
        _pwdField.layer.borderWidth = 0.5;
        _pwdField.layer.borderColor = COR12.CGColor;
    }
    return _pwdField;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}
@end
