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

@interface HxbWithdrawViewController ()
@property (nonatomic, strong) UITextField *amountTextField;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) WithdrawBankView *mybankView;
@end

@implementation HxbWithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mybankView];
    [self.view addSubview:self.amountTextField];
    [self.view addSubview:self.nextButton];
    [self setCardViewFrame];
}
- (void)setCardViewFrame{
    if (![KeyChain hasBindBankcard]) {
        _mybankView.hidden = YES;
        [_amountTextField setY:64];
        [_nextButton setY:CGRectGetMaxY(_amountTextField.frame) + 20];
    }
}

- (void)nextButtonClick:(UIButton *)sender{
    if ([_amountTextField.text doubleValue] < 1) {
        [HxbHUDProgress showTextWithMessage:@"金额不能小于1"];
        return;
    }
    //实名认证
    if (![KeyChain isVerify]) {
        HxbSecurityCertificationViewController *securityCertificationVC = [[HxbSecurityCertificationViewController alloc]init];
        [self.navigationController pushViewController:securityCertificationVC animated:YES];
        return;
    }
    
    if (![KeyChain hasBindBankcard]) {
        HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc]init];
        [self.navigationController pushViewController:withdrawCardViewController animated:YES];
        return;
    }
}

- (WithdrawBankView *)mybankView{
    if (!_mybankView) {
        _mybankView = [[WithdrawBankView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 80)];
        _mybankView.backgroundColor = COR11;
    }
    return _mybankView;
}
- (UITextField *)amountTextField{
    if (!_amountTextField) {
        _amountTextField = [UITextField hxb_lineTextFieldWithFrame:CGRectMake(20, CGRectGetMaxY(_mybankView.frame), SCREEN_WIDTH - 40, 44)];
        _amountTextField.placeholder = @"请输入充值金额";
        
    }
    return _amountTextField;
}

- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [UIButton btnwithTitle:@"下一步" andTarget:self andAction:@selector(nextButtonClick:) andFrameByCategory:  CGRectMake(20,CGRectGetMaxY(_amountTextField.frame) + 20, SCREEN_WIDTH - 40,44)];
    }
    return _nextButton;
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

- (void)setContentViewFrame{
    [_bankLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.top.equalTo(self.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(40, 40));
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
        
    }
    return _bankNameLabel;
}

- (UILabel *)bankCardNumLabel{
    if (!_bankCardNumLabel) {
        
    }
    return _bankCardNumLabel;
}

- (UILabel *)amountLimitLabel{
    if (!_amountLimitLabel) {
        
    }
    return _amountLimitLabel;
}
@end
