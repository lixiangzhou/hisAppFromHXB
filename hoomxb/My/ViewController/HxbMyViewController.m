//
//  HxbMyViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbMyViewController.h"
#import "AppDelegate.h"
#import "HxbMyView.h"
#import "HxbAccountInfoViewController.h"
#import "HxbWithdrawViewController.h"
#import "HXBRequestUserInfo.h"
#import "HXBMY_AllFinanceViewController.h"
#import "HXBBindBankCardViewController.h"
#import "HXBOpenDepositAccountViewController.h"
#import "HxbWithdrawCardViewController.h"
#import "HxbMyTopUpViewController.h"
#import "HXBSignUPAndLoginRequest_EnumManager.h"
#import "HXBDepositoryAlertViewController.h"
#import "HXBMyRequestAccountModel.h"
#import "HXBRequestAccountInfo.h"

#import "HXBInviteListViewController.h"

@interface HxbMyViewController ()<MyViewDelegate>
@property (nonatomic, strong) HXBRequestUserInfoViewModel *userInfoViewModel;
@property (nonatomic, strong) HxbMyView *myView;
@end

@implementation HxbMyViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self hideNavigationBar:animated];
    //加载用户数据
    if ([KeyChain isLogin]) {
        //        [self loadData_userInfo];
        [self loadData_accountInfo];//账户内数据总览
    } else {
        [self transparentNavigationTitle];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self transparentNavigationTitle];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - UI
- (void)setupSubView {
    [self setupMyView];
    [self clickAllFinanceButton];
}

- (void)setupMyView{
    kWeakSelf
    self.myView = [[HxbMyView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.myView.delegate = self;
    self.myView.userInteractionEnabled = YES;
    self.myView.homeRefreshHeaderBlock = ^(){ //下拉加载回调的Block
        [weakSelf loadData_userInfo];
        [weakSelf loadData_accountInfo];//账户内数据总览
    };
    
    [self.view addSubview:self.myView];
}

/// 查看总资产
- (void)clickAllFinanceButton {
    kWeakSelf
    [self.myView clickAllFinanceButtonWithBlock:^(UILabel * _Nullable button) {
        //跳转资产目录
        if (KeyChain.isLogin) {
            HXBMY_AllFinanceViewController *allFinanceViewController = [[HXBMY_AllFinanceViewController alloc]init];
            [weakSelf.navigationController pushViewController:allFinanceViewController animated:YES];
        }
    }];
}

#pragma mark - Setter Getter
- (void)setUserInfoViewModel:(HXBRequestUserInfoViewModel *)userInfoViewModel
{
    _userInfoViewModel = userInfoViewModel;
    self.myView.userInfoViewModel = self.userInfoViewModel;
}

#pragma mark - MyViewDelegate
- (void)didLeftHeadBtnClick:(UIButton *)sender{
    HxbAccountInfoViewController *accountInfoVC = [[HxbAccountInfoViewController alloc]init];
    accountInfoVC.userInfoViewModel = self.userInfoViewModel;
    [self.navigationController pushViewController:accountInfoVC animated:YES];
}
///充值
- (void)didClickTopUpBtn:(UIButton *)sender{
    [HXBUmengManagar HXB_clickEventWithEnevtId:kHXBUmeng_topup_money];
    [self logicalJudgment:HXBRechargeAndWithdrawalsLogicalJudgment_Recharge];
}
/// 提现
- (void)didClickWithdrawBtn:(UIButton *)sender{
    [HXBUmengManagar HXB_clickEventWithEnevtId:kHXBUmeng_withdraw_money];
    [self logicalJudgment:HXBRechargeAndWithdrawalsLogicalJudgment_Withdrawals];
}

#pragma mark - Helper
/**
 逻辑判断
 */
- (void)logicalJudgment:(HXBRechargeAndWithdrawalsLogicalJudgment)type
{
    kWeakSelf
    [KeyChain downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        weakSelf.userInfoViewModel = viewModel;
        if (weakSelf.userInfoViewModel.userInfoModel.userInfo.isUnbundling) {
            [HXBAlertManager callupWithphoneNumber:kServiceMobile andWithTitle:@"温馨提示" Message:[NSString stringWithFormat:@"您的身份信息不完善，请联系客服 %@", kServiceMobile]];
            return;
        }
        if (!weakSelf.userInfoViewModel.userInfoModel.userInfo.isCreateEscrowAcc) {
            
            HXBDepositoryAlertViewController *alertVC = [[HXBDepositoryAlertViewController alloc] init];
            alertVC.immediateOpenBlock = ^{
                [HXBUmengManagar HXB_clickEventWithEnevtId:kHXBUmeng_alertBtn];
                HXBOpenDepositAccountViewController *openDepositAccountVC = [[HXBOpenDepositAccountViewController alloc] init];
                //                openDepositAccountVC.userModel = viewModel;
                openDepositAccountVC.title = @"开通存管账户";
                openDepositAccountVC.type = type;
                [weakSelf.navigationController pushViewController:openDepositAccountVC animated:YES];
            };
            [weakSelf presentViewController:alertVC animated:NO completion:nil];
            
            
        } else if ([weakSelf.userInfoViewModel.userInfoModel.userInfo.isCashPasswordPassed isEqualToString:@"1"] && [weakSelf.userInfoViewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"0"])
        {
            //进入绑卡界面
            HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc]init];
            withdrawCardViewController.title = @"绑卡";
            withdrawCardViewController.type = type;
            withdrawCardViewController.userInfoModel = self.userInfoViewModel.userInfoModel;
            [weakSelf.navigationController pushViewController:withdrawCardViewController animated:YES];
        } else if (!([weakSelf.userInfoViewModel.userInfoModel.userInfo.isCashPasswordPassed isEqualToString:@"1"] && [weakSelf.userInfoViewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"]))
        {
            //完善信息
            HXBOpenDepositAccountViewController *openDepositAccountVC = [[HXBOpenDepositAccountViewController alloc] init];
            openDepositAccountVC.title = @"完善信息";
            openDepositAccountVC.type = type;
            [weakSelf.navigationController pushViewController:openDepositAccountVC animated:YES];
        } else
        {
            if (type == HXBRechargeAndWithdrawalsLogicalJudgment_Recharge) {
                HxbMyTopUpViewController *hxbMyTopUpViewController = [[HxbMyTopUpViewController alloc]init];
                [weakSelf.navigationController pushViewController:hxbMyTopUpViewController animated:YES];
            } else if (type == HXBRechargeAndWithdrawalsLogicalJudgment_Withdrawals){
                if (!KeyChain.isLogin)  return;
                HxbWithdrawViewController *withdrawViewController = [[HxbWithdrawViewController alloc]init];
                [weakSelf.navigationController pushViewController:withdrawViewController animated:YES];
            }
        }
    } andFailure:^(NSError *error) {
        
    }];
}

#pragma mark - Network
- (void)loadData_accountInfo{
    kWeakSelf
    [HXBRequestAccountInfo downLoadAccountInfoNoHUDWithSeccessBlock:^(HXBMyRequestAccountModel *viewModel) {
        weakSelf.myView.accountModel = viewModel;
        weakSelf.myView.isStopRefresh_Home = YES;
    } andFailure:^(NSError *error) {
        weakSelf.myView.isStopRefresh_Home = YES;
    }];
}
- (void)loadData_userInfo {
    kWeakSelf
    [HXBRequestUserInfo downLoadUserInfoNoHUDWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        weakSelf.userInfoViewModel = viewModel;
        weakSelf.myView.isStopRefresh_Home = YES;
    } andFailure:^(NSError *error) {
        weakSelf.myView.isStopRefresh_Home = YES;
    }];
}
@end
