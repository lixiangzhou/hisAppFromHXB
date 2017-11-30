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
#import "HXBMyBankResultViewController.h"

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
    bankNameLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
    bankNameLabel.textColor = COR6;
    bankNameLabel.text = self.bankCardViewModel.bankNameNo4;
    [bankInfoView addSubview:bankNameLabel];
    
    // 银行卡号
    UILabel *bankNoLabel = [UILabel new];
    bankNoLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    bankNoLabel.textColor = COR10;
    bankNoLabel.text = self.bankCardViewModel.bankNoStarFormat;
    [bankInfoView addSubview:bankNoLabel];
    
    // 分割线
    UIView *sepLine = [UIView new];
    sepLine.backgroundColor = BACKGROUND_COLOR;
    [bankInfoView addSubview:sepLine];
    
    // 约束布局
    [bankInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(HXBStatusBarAndNavigationBarHeight));
        make.left.right.equalTo(self.view);
    }];
    
    [bankIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kScrAdaptationW(15)));
        make.top.equalTo(@(kScrAdaptationH(20)));
        make.bottom.equalTo(sepLine.mas_top).offset(kScrAdaptationH(-20));
        make.width.height.equalTo(@(kScrAdaptationW(40)));
    }];
    
    [bankNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bankIconView);
        make.left.equalTo(bankIconView.mas_right).offset(kScrAdaptationW(18));
    }];
    
    [bankNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bankIconView);
        make.left.equalTo(bankNameLabel);
    }];
    
    [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(bankInfoView);
        make.height.equalTo(@10);
    }];
}

- (void)setBottomView {
    // 身份证号
    UILabel *nameLabel = [UILabel new];
    nameLabel.text = [NSString stringWithFormat:@"认证姓名：%@", self.bankCardViewModel.userNameOnlyLast];
    nameLabel.textColor = COR6;
    nameLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
    [self.view addSubview:nameLabel];
    
    HXBCustomTextField *idCardTextField = [[HXBCustomTextField alloc] init];
    idCardTextField.leftImage = [UIImage imageNamed:@"idcard"];
    idCardTextField.placeholder = @"请输入身份证号";
    idCardTextField.isIDCardTextField = YES;
    idCardTextField.keyboardType = UIKeyboardTypeDecimalPad;
    idCardTextField.limitStringLength = 18;
    
    [self.view addSubview:idCardTextField];
    self.idCardTextField = idCardTextField;
    
    // 交易密码
    UILabel *transactionPwdLabel = [UILabel new];
    transactionPwdLabel.textColor = COR6;
    transactionPwdLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
    transactionPwdLabel.text = @"交易密码";
    [self.view addSubview:transactionPwdLabel];
    
    HXBCustomTextField *transactionPwdTextField = [[HXBCustomTextField alloc] init];
    transactionPwdTextField.leftImage = [UIImage imageNamed:@"password"];
    transactionPwdTextField.placeholder = @"请输入交易密码";
    transactionPwdTextField.limitStringLength = 6;
    transactionPwdTextField.keyboardType = UIKeyboardTypeNumberPad;
    transactionPwdTextField.clearRightMargin = 100;
    
    [self.view addSubview:transactionPwdTextField];
    self.transactionPwdTextField = transactionPwdTextField;
    
    UIButton *forgetPwdBtn = [UIButton buttonWithTitle:@"忘记密码?" andTarget:self andAction:@selector(forgetPwd) andFrameByCategory:CGRectZero];
    forgetPwdBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    [forgetPwdBtn setTitleColor:kHXBColor_Blue040610 forState:UIControlStateNormal];
    [transactionPwdTextField addSubview:forgetPwdBtn];
    
    UIImageView *tipIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tip"]];
    [self.view addSubview:tipIconView];
    
    
    // 底部描述
    UILabel *descLabel = [UILabel hxb_labelWithText:[NSString stringWithFormat:@"您正在解绑尾号%@的银行卡。解绑后需重新绑定方可购买红小宝平台理财产品，进行充值提现操作。", self.bankCardViewModel.bankNoLast4] fontSize:15 color:COR10];
    [self.view addSubview:descLabel];

    // 确认
    UIButton *unBindBtn = [UIButton buttonWithTitle:@"确认解绑" andTarget:self andAction:@selector(unBind) andFrameByCategory:CGRectZero];
    unBindBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(16);
    unBindBtn.backgroundColor = COR29;
    [unBindBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    unBindBtn.layer.cornerRadius = 4;
    unBindBtn.layer.masksToBounds = YES;
    [self.view addSubview:unBindBtn];
    
    // 约束布局
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bankInfoView.mas_bottom).offset(kScrAdaptationH(15));
        make.left.equalTo(@(kScrAdaptationW(15)));
    }];
    
    [idCardTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).equalTo(@(kScrAdaptationH(17.5)));
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(kScrAdaptationH(36)));
    }];
    
    [transactionPwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(idCardTextField.mas_bottom).offset(kScrAdaptationH(35));
        make.left.equalTo(nameLabel);
    }];
    
    [transactionPwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(transactionPwdLabel.mas_bottom).offset(kScrAdaptationH(17.5));
        make.left.right.height.equalTo(idCardTextField);
    }];
    
    [forgetPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(transactionPwdTextField).offset(-kScrAdaptationW(15));
        make.centerY.equalTo(transactionPwdTextField);
    }];
    
    [tipIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel);
        make.top.equalTo(transactionPwdTextField.mas_bottom).offset(kScrAdaptationH(35));
        make.width.height.equalTo(@(kScrAdaptationW(13)));
    }];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipIconView).offset(-2);
        make.left.equalTo(tipIconView.mas_right).offset(kScrAdaptationW(5));
        make.right.equalTo(self.view).offset(kScrAdaptationW(-15));
    }];
    
    [unBindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.left.equalTo(@(kScrAdaptationW(20)));
        make.right.equalTo(@(kScrAdaptationW(-20)));
        make.height.equalTo(@(kScrAdaptationH(41)));
        make.bottom.equalTo(@(kScrAdaptationH(-70)));
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
    NSString *idCardNo = [self.idCardTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *transactionPwd = [self.transactionPwdTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // 验证身份证号
    NSString *idCardNoMessage = [self.bankCardViewModel validateIdCardNo:idCardNo];
    if (idCardNoMessage) {
        [HxbHUDProgress showMessageCenter:idCardNoMessage];
        return;
    }
    
    // 验证交易密码
    NSString *transactionPwdMessage = [self.bankCardViewModel validateTransactionPwd:transactionPwd];
    if (transactionPwdMessage) {
        [HxbHUDProgress showMessageCenter:transactionPwdMessage];
        return;
    }
    
    [self.bankCardViewModel requestUnBindWithParam:@{@"idCardNo": idCardNo, @"cashPassword": transactionPwd} finishBlock:^(BOOL succeed, NSString *errorMessage, BOOL canPush) {
        if (canPush) {
            HXBMyBankResultViewController *VC = [HXBMyBankResultViewController new];
            VC.isSuccess = succeed;
            VC.describeText = errorMessage;
            [self.navigationController pushViewController:VC animated:YES];
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
