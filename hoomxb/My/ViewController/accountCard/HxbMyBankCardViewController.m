//
//  HxbMyBankCardViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbMyBankCardViewController.h"
#import "NYBaseRequest.h"
#import "HXBBankCardModel.h"
#import "HXBUserInfoView.h"
#import "HXBFinLoanTruansfer_ContraceWebViewVC.h"
#import "HXBBankView.h"
@interface HxbMyBankCardViewController ()

/**
 数据模型
 */
@property (nonatomic, strong) HXBBankCardModel *bankCardModel;

@property (nonatomic, strong) HXBUserInfoView *userInfoView;

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) HXBBankView *bankView;

@property (nonatomic, strong) UIButton *phoneBtn;

@end

@implementation HxbMyBankCardViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self.view addSubview:self.tipLabel];
    if (self.isBank) {
        self.title = @"银行卡信息";
        self.tipLabel.text = @"您在红小宝平台充值，提现均会使用该卡";
        [self.view addSubview:self.bankView];
        [self.view addSubview:self.phoneBtn];
        [self setupBankViewFrame];
    }else
    {
        self.title = @"开户信息";
        self.tipLabel.text = @"您在红小宝已成功开通恒丰银行存管账户";
        [self.view addSubview:self.userInfoView];
        [self setupUserInfoViewFrame];
    }
    
}

- (void)setupBankViewFrame
{
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(69);
        make.height.offset(kScrAdaptationH(45));
    }];
    [self.bankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kScrAdaptationW(10));
        make.right.equalTo(self.view).offset(kScrAdaptationW(-10));
        make.top.equalTo(self.tipLabel.mas_bottom);
        make.height.offset(kScrAdaptationH(162));
    }];
    [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(kScrAdaptationH(-30));
    }];
}


- (void)setupUserInfoViewFrame
{
    [self.userInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(kScrAdaptationH(45) + 64);
        make.height.offset(kScrAdaptationH(135));
    }];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.bottom.equalTo(self.userInfoView.mas_top);
    }];
//    [self.bankView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(kScrAdaptationW750(20));
//        make.right.equalTo(self.view).offset(kScrAdaptationW750(-20));
//        make.top.equalTo(self.userInfoView.mas_bottom).offset(kScrAdaptationH750(20));
//        make.height.offset(120);
//    }];
//    [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.tipLabel.mas_right);
//        make.right.equalTo(self.view).offset(kScrAdaptationW750(-20));
//        make.centerY.equalTo(self.tipLabel);
//    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isColourGradientNavigationBar = YES;
    [self loadUserInfo];
}

- (void)loadUserInfo
{
    kWeakSelf
    [KeyChain downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        weakSelf.userInfoView.leftStrArr = @[@"真实姓名",@"身份证号",@"存管协议"];
        NSString *realName = [viewModel.userInfoModel.userInfo.realName replaceStringWithStartLocation:0 lenght:viewModel.userInfoModel.userInfo.realName.length - 1];
        NSString *idCard = [viewModel.userInfoModel.userInfo.idNo replaceStringWithStartLocation:1 lenght:viewModel.userInfoModel.userInfo.idNo.length - 2];
        weakSelf.userInfoView.rightArr = @[realName,idCard,@"《恒丰银行协议》"];
        
    } andFailure:^(NSError *error) {
        
    }];
}

//- (void)bindBankCardClick
//{
//    //进入绑卡界面
//    HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc]init];
//    withdrawCardViewController.title = @"绑卡";
//    withdrawCardViewController.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
//    [self.navigationController pushViewController:withdrawCardViewController animated:YES];
//}

#pragma mark - 事件处理

- (void)phoneBtnClick
{
//    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"4001551888"];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    [HXBAlertManager callupWithphoneNumber:kServiceMobile andWithMessage:@"请联系客服"];
}


#pragma mark - getter/setter
- (HXBUserInfoView *)userInfoView
{
    if (!_userInfoView) {
        kWeakSelf
        _userInfoView = [[HXBUserInfoView alloc] initWithFrame:CGRectZero];
        _userInfoView.agreementBlock = ^{
            NSLog(@"《存管开户协议》");
            HXBFinLoanTruansfer_ContraceWebViewVC *webViewVC = [[HXBFinLoanTruansfer_ContraceWebViewVC alloc] init];
            webViewVC.URL = kHXB_Negotiate_depository;
            webViewVC.title = @"存管协议";
            [weakSelf.navigationController pushViewController:webViewVC animated:true];
        };
    }
    return _userInfoView;
}
- (HXBBankView *)bankView
{
    if (!_bankView) {
        _bankView = [[HXBBankView alloc] initWithFrame:CGRectZero];
    }
    return _bankView;
}

- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        
        _tipLabel.textColor = COR11;
        _tipLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

- (UIButton *)phoneBtn
{
    if (!_phoneBtn) {
        _phoneBtn  = [[UIButton alloc] init];
        NSString *string = [NSString stringWithFormat:@"如需解绑，请联系红小宝客服：%@", kServiceMobile];
        NSMutableAttributedString *str = [NSMutableAttributedString setupAttributeStringWithString:string WithRange:NSMakeRange(string.length - kServiceMobile.length, kServiceMobile.length) andAttributeColor:COR30];
        
        [str addAttribute:NSForegroundColorAttributeName value:COR8 range:NSMakeRange(0, string.length - kServiceMobile.length)];
        [_phoneBtn setAttributedTitle:str forState:(UIControlStateNormal)];
        [_phoneBtn addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _phoneBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    }
    return _phoneBtn;
}

@end
