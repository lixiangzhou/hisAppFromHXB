//
//  HXBUnBindCardController.m
//  hoomxb
//
//  Created by lxz on 2017/11/29.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBUnBindCardController.h"
#import "HXBBankCardViewModel.h"
#import "HXBModifyTransactionPasswordViewController.h"

@interface HXBUnBindCardController ()
@property (nonatomic, weak) UIView *bankInfoView;
@property (nonatomic, strong) HXBBankCardViewModel *bankCardViewModel;
@property (nonatomic, weak) HXBCustomTextField *idCardTextField;
@property (nonatomic, weak) HXBCustomTextField *transactionPwdTextField;
@end

@implementation HXBUnBindCardController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

#pragma mark - UI

- (void)setUI {
    self.title = @"解绑银行卡";
    
    self.isColourGradientNavigationBar = YES;
    
    [self setBankInfoView];
    [self setBottomView];
}

- (void)setBankInfoView {
    UIView *bankInfoView = [UIView new];
    [self.view addSubview:bankInfoView];
    self.bankInfoView = bankInfoView;
    
    // 银行卡图片
    UIImageView *bankIconView = [UIImageView new];
    bankIconView.svgImageString = self.bankCardViewModel.bankImageString;
    [bankInfoView addSubview:bankIconView];
    
    // 银行卡名
    UILabel *bankNameLabel = [UILabel new];
    bankNameLabel.text = self.bankCardViewModel.bankName;
    [bankInfoView addSubview:bankNameLabel];
    
    // 银行卡号
    UILabel *bankNumLabel = [UILabel new];
    bankNumLabel.text = self.bankCardViewModel.bankNumStarFormat;
    [bankInfoView addSubview:bankNumLabel];
    
    // 分割线
    UIView *sepLine = [UIView new];
    sepLine.backgroundColor = [UIColor lightGrayColor];
    [bankInfoView addSubview:sepLine];
    
    // 约束布局
    [bankInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(HXBStatusBarAndNavigationBarHeight));
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(kScrAdaptationH(80)));
    }];
    
    [bankIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@(kScrAdaptationW(10)));
        make.bottom.equalTo(@(kScrAdaptationH(-10)));
        make.width.equalTo(@(kScrAdaptationW(60)));
    }];
    
    [bankNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bankIconView);
        make.left.equalTo(bankIconView.mas_right).offset(kScrAdaptationW(20));
    }];
    
    [bankNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bankIconView);
        make.left.equalTo(bankNameLabel);
    }];
    
    [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(bankInfoView);
        make.height.equalTo(@0.5);
    }];
}

- (void)setBottomView {
    // 身份证号
    UILabel *nameLabel = [UILabel new];
    nameLabel.text = [NSString stringWithFormat:@"认证姓名：%@", self.bankCardViewModel.userNameOnlyLast];
    [self.view addSubview:nameLabel];
    
    HXBCustomTextField *idCardTextField = [[HXBCustomTextField alloc] init];
    idCardTextField.leftImage = [UIImage imageNamed:@"bankcard"];
    idCardTextField.placeholder = @"请输入身份证号码";
    idCardTextField.isIDCardTextField = YES;
    idCardTextField.keyboardType = UIKeyboardTypeDecimalPad;
    idCardTextField.limitStringLength = 18;
    
    [self.view addSubview:idCardTextField];
    self.idCardTextField = idCardTextField;
    
    // 交易密码
    UILabel *transactionPwdLabel = [UILabel new];
    transactionPwdLabel.text = @"交易密码";
    [self.view addSubview:transactionPwdLabel];
    
    UIButton *forgetPwdBtn = [UIButton buttonWithTitle:@"忘记密码" andTarget:self andAction:@selector(forgetPwd) andFrameByCategory:CGRectZero];
    [self.view addSubview:forgetPwdBtn];
    
    HXBCustomTextField *transactionPwdTextField = [[HXBCustomTextField alloc] init];
    transactionPwdTextField.leftImage = [UIImage imageNamed:@"bankcard"];
    transactionPwdTextField.placeholder = @"请输入交易密码";
    transactionPwdTextField.isIDCardTextField = YES;
    transactionPwdTextField.limitStringLength = 6;
    transactionPwdTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.view addSubview:transactionPwdTextField];
    self.transactionPwdTextField = transactionPwdTextField;
    
    // 底部描述
    UILabel *descLabel = [UILabel hxb_labelWithText:[NSString stringWithFormat:@"您正在解绑尾号%@的银行卡。解绑后需重新绑定方可购买红小宝平台理财产品，进行充值提现操作。", self.bankCardViewModel.bankNumLast4] fontSize:16 color:[UIColor lightGrayColor]];
    [self.view addSubview:descLabel];

    // 确认
    UIButton *unBindBtn = [UIButton buttonWithTitle:@"确认解绑" andTarget:self andAction:@selector(unBind) andFrameByCategory:CGRectZero];
    [self.view addSubview:unBindBtn];
    
    // 约束布局
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bankInfoView.mas_bottom).offset(kScrAdaptationW(20));
        make.left.equalTo(@(kScrAdaptationW(10)));
    }];
    
    [idCardTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).equalTo(@(kScrAdaptationH(10)));
        make.left.equalTo(nameLabel);
        make.right.equalTo(self.view).offset(-kScrAdaptationW(10));
        make.height.equalTo(@(kScrAdaptationH(30)));
    }];
    
    [transactionPwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(idCardTextField.mas_bottom).offset(kScrAdaptationH(20));
        make.left.equalTo(nameLabel);
    }];
    
    [transactionPwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(transactionPwdLabel.mas_bottom).offset(kScrAdaptationH(10));
        make.left.equalTo(nameLabel);
        make.right.equalTo(self.view).offset(-kScrAdaptationW(10));
        make.height.equalTo(@(kScrAdaptationH(30)));
    }];
    
    [forgetPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(transactionPwdTextField);
        make.bottom.equalTo(transactionPwdLabel);
    }];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(transactionPwdTextField.mas_bottom).offset(kScrAdaptationH(20));
        make.left.right.equalTo(transactionPwdTextField);
    }];
    
    [unBindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.left.equalTo(@(kScrAdaptationW(50)));
        make.right.equalTo(@(kScrAdaptationW(-50)));
        make.height.equalTo(@(kScrAdaptationH(40)));
        make.bottom.equalTo(@(kScrAdaptationH(-60)));
    }];
}

#pragma mark - Delegate Internal

#pragma mark -


#pragma mark - Delegate External

#pragma mark -


#pragma mark - Action
- (void)forgetPwd {
    HXBModifyTransactionPasswordViewController *modifyTransactionPasswordVC = [HXBModifyTransactionPasswordViewController new];
    modifyTransactionPasswordVC.title = @"修改交易密码";
    [self.navigationController pushViewController:modifyTransactionPasswordVC animated:YES];
}

- (void)unBind {
    NSString *idCardNum = [self.idCardTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *transactionPwd = [self.transactionPwdTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [self.bankCardViewModel requestUnBindWithIdCardNum:idCardNum transactionPwd:transactionPwd finishBlock:^(BOOL succeed, NSString *errorMessage, BOOL canPush) {
        if (canPush) {
            // push
        } else { 
            [HxbHUDProgress showMessageCenter:errorMessage];
        }
    }];
}

#pragma mark - Setter / Getter / Lazy
- (void)setBankCardModel:(HXBBankCardModel *)bankCardModel {
    _bankCardModel = bankCardModel;
    self.bankCardViewModel.bankCardModel = bankCardModel;
}

- (HXBBankCardViewModel *)bankCardViewModel {
    if (_bankCardViewModel == nil) {
        _bankCardViewModel = [HXBBankCardViewModel new];
    }
    return _bankCardViewModel;
}

#pragma mark - Helper


#pragma mark - Other


#pragma mark - Public

@end
