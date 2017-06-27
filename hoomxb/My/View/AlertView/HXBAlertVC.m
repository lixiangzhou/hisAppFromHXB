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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.view.alpha = 0.3;
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
        make.height.equalTo(@100);
        make.width.equalTo(@200);
    }];
    [self.message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.centerX.equalTo(self.view);
    }];
//    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@84);
//        make.centerX.equalTo(self.view);
//        make.height.with.equalTo(@50);
//    }];
//    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@84);
//        make.centerX.equalTo(self.view);
//        make.height.with.equalTo(@50);
//    }];
//    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@84);
//        make.centerX.equalTo(self.view);
//        make.height.with.equalTo(@50);
//    }];
//    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@84);
//        make.centerX.equalTo(self.view);
//        make.height.with.equalTo(@50);
//    }];
    
}
- (void)buttonClick:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:^{
        
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
        [_cancelBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc] init];
        [_sureBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}
- (UIButton *)forgetBtn
{
    if (!_forgetBtn) {
        _forgetBtn = [[UIButton alloc] init];
        [_forgetBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetBtn;
}
- (UILabel *)message
{
    if (!_message) {
        _message = [[UILabel alloc] init];
    }
    return _message;
}

- (UITextField *)pwdField
{
    if (!_pwdField) {
        _pwdField = [[UITextField alloc] init];
    }
    return _pwdField;
}

@end
