//
//  HxbMyBankCardViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbMyBankCardViewController.h"
#import "NYBaseRequest.h"
#import "HXBBankCardModel.h"
#import "HXBUserInfoView.h"
#import "HXBBankView.h"
#import "HXBUnBindCardController.h"
#import "HXBGeneralAlertVC.h"
#import "HXBOpenDepositAccountViewController.h"
#import "HXBBankCardViewModel.h"

#import "HXBLazyCatAccountWebViewController.h"

@interface HxbMyBankCardViewController ()

/**
 数据模型
 */
@property (nonatomic, strong) HXBBankCardModel *bankCardModel;
@property (nonatomic, strong) HXBBankCardViewModel *viewModel;
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
    kWeakSelf
    self.viewModel = [[HXBBankCardViewModel alloc] initWithBlock:^UIView *{
        return weakSelf.view;
    }];
    if (self.isBank) {
        self.title = @"银行卡信息";
        self.tipLabel.text = @"您在红小宝平台充值，提现均会使用该卡";
        [self.view addSubview:self.bankView];
        [self.view addSubview:self.phoneBtn];
        [self setupRightBarBtn];
        kWeakSelf
        self.bankView.unbundBankBlock = ^(HXBBankCardModel *bankCardModel) {
            weakSelf.bankCardModel = bankCardModel;
        };
        [self setupBankViewFrame];
    }else
    {
        self.title = @"开户信息";
        self.tipLabel.text = @"您在红小宝已成功开通恒丰银行存管账户";
        [self.view addSubview:self.userInfoView];
        [self setupUserInfoViewFrame];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isColourGradientNavigationBar = YES;
    if (!self.isBank) {
        [self loadUserInfo];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)setupRightBarBtn {
    UIButton *unbundBankBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScrAdaptationW(31), kScrAdaptationH(19))];
    [unbundBankBtn setTitle:@"解绑" forState:UIControlStateNormal];
    unbundBankBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
    [unbundBankBtn setTitleColor:RGB(254, 254, 254) forState:UIControlStateNormal];
    [unbundBankBtn addTarget:self action:@selector(clickUnbundBankBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *unbundBankBtnItem = [[UIBarButtonItem alloc] initWithCustomView:unbundBankBtn];
    self.navigationItem.rightBarButtonItem = unbundBankBtnItem;
}

- (void)clickUnbundBankBtn:(UIButton *)sender {
    self.navigationItem.rightBarButtonItem.enabled = NO;
    kWeakSelf
    if (!self.bankCardModel.enableUnbind) {
        [HxbHUDProgress showTextWithMessage:self.bankCardModel.enableUnbindReason];
        self.navigationItem.rightBarButtonItem.enabled = YES;
    } else {
        //            HXBUnBindCardController *VC = [HXBUnBindCardController new];
        //            VC.bankCardModel = self.bankCardModel;
        //            [self.navigationController pushViewController:VC animated:YES];
        
        [self.viewModel requestUnBindWithParam:nil finishBlock:^(BOOL succeed, NSString *errorMessage, BOOL canPush) {
            self.navigationItem.rightBarButtonItem.enabled = YES;
            if (succeed) {
                HXBLazyCatAccountWebViewController *lazyCatWebVC = [HXBLazyCatAccountWebViewController new];
                lazyCatWebVC.requestModel = weakSelf.viewModel.lazyCatRequestModel;
                [weakSelf.navigationController pushViewController:lazyCatWebVC animated:YES];
            }
        }];
    }
}

- (void)setupBankViewFrame
{
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(69 + HXBStatusBarAdditionHeight);
        make.height.offset(kScrAdaptationH(45));
    }];
    [self.bankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kScrAdaptationW(15));
        make.right.equalTo(self.view).offset(kScrAdaptationW(-15));
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
        make.top.equalTo(self.view).offset(kScrAdaptationH(45) + HXBStatusBarAndNavigationBarHeight);
        make.height.offset(kScrAdaptationH(135));
    }];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(HXBStatusBarAndNavigationBarHeight);
        make.bottom.equalTo(self.userInfoView.mas_top);
    }];
}

- (void)loadUserInfo
{
    kWeakSelf
    [self.viewModel downLoadUserInfo:YES resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.userInfoView.leftStrArr = @[@"真实姓名",@"身份证号",@"存管协议"];
            NSString *realName = [weakSelf.viewModel.userInfoModel.userInfoModel.userInfo.realName replaceStringWithStartLocation:0 lenght:weakSelf.viewModel.userInfoModel.userInfoModel.userInfo.realName.length - 1];
            NSString *idCard = [weakSelf.viewModel.userInfoModel.userInfoModel.userInfo.idNo replaceStringWithStartLocation:1 lenght:weakSelf.viewModel.userInfoModel.userInfoModel.userInfo.idNo.length - 2];
            weakSelf.userInfoView.rightArr = @[realName,idCard,@"《恒丰银行…协议》"];
        }
    }];
}

#pragma mark - 事件处理

- (void)phoneBtnClick
{

    [HXBAlertManager callupWithphoneNumber:kServiceMobile andWithTitle:@"红小宝客服电话" Message:kServiceMobile];
}

#pragma mark - getter/setter
- (HXBUserInfoView *)userInfoView
{
    if (!_userInfoView) {
        kWeakSelf
        _userInfoView = [[HXBUserInfoView alloc] initWithFrame:CGRectZero];
        _userInfoView.agreementBlock = ^{
            NSLog(@"《存管开户协议》");
            [HXBBaseWKWebViewController pushWithPageUrl:[NSString splicingH5hostWithURL:kHXB_Negotiate_thirdpart] fromController:weakSelf];
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
        NSString *string = [NSString stringWithFormat:@"如有问题，请联系红小宝客服：%@", kServiceMobile];
        NSMutableAttributedString *str = [NSMutableAttributedString setupAttributeStringWithString:string WithRange:NSMakeRange(string.length - kServiceMobile.length, kServiceMobile.length) andAttributeColor:COR30];
        
        [str addAttribute:NSForegroundColorAttributeName value:COR8 range:NSMakeRange(0, string.length - kServiceMobile.length)];
        [_phoneBtn setAttributedTitle:str forState:(UIControlStateNormal)];
        [_phoneBtn addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _phoneBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    }
    return _phoneBtn;
}

@end
