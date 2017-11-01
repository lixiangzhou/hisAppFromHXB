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
@interface HxbMyViewController ()<MyViewDelegate>
@property (nonatomic,copy) NSString *imageName;
@property (nonatomic, strong) HXBRequestUserInfoViewModel *userInfoViewModel;
@property (nonatomic, strong) HXBMyRequestAccountModel *accountModel;
@property (nonatomic, strong) HxbMyView *myView;
@end

@implementation HxbMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageName = @"1";
    //防止跳转的时候，tableView向上或者向下移动
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = true;
    };
    //登录的测试

//    对controllerView进行布局
    [self setupSubView];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMyDate) name:@"提现充值" object:nil];
    //对controllerView进行布局
    //    [self setupSubView];

    
//    //散标列表 红利计划的Button
//    [self setupBUTTON];
}

//- (void)reloadMyDate {
//    [self loadData_userInfo];
//}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.view.hidden = ![KeyChain isLogin];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top"] forBarMetrics:(UIBarMetricsDefaultPrompt)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    //加载用户数据
    if ([KeyChain isLogin]) {
//        [self loadData_userInfo];
        [self loadData_accountInfo];//账户内数据总览
    }else
    {
//        self.userInfoViewModel = nil;
        self.accountModel = nil;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

//MARK: 对controllerView进行布局
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
//    if (KeyChain.isLogin) {
////        [HXBAlertManager alertManager_loginAgainAlertWithView:self.view];
//        return;
//    }
}

///查看总资产
- (void)clickAllFinanceButton {
   
    kWeakSelf
    [self.myView clickAllFinanceButtonWithBlock:^(UILabel * _Nullable button) {
        //跳转资产目录
        if (KeyChain.isLogin) {
            HXBMY_AllFinanceViewController *allFinanceViewController = [[HXBMY_AllFinanceViewController alloc]init];
            [weakSelf.navigationController pushViewController:allFinanceViewController animated:true];
        }
    }];
}

- (void)setUserInfoViewModel:(HXBRequestUserInfoViewModel *)userInfoViewModel
{
    _userInfoViewModel = userInfoViewModel;
    self.myView.userInfoViewModel = self.userInfoViewModel;
}

- (void)setAccountModel:(HXBMyRequestAccountModel *)accountModel{
    _accountModel = accountModel;
    self.myView.accountModel = self.accountModel;
}

- (void)didLeftHeadBtnClick:(UIButton *)sender{
    HxbAccountInfoViewController *accountInfoVC = [[HxbAccountInfoViewController alloc]init];
    accountInfoVC.userInfoViewModel = self.userInfoViewModel;
    [self.navigationController pushViewController:accountInfoVC animated:YES];
}
///充值
- (void)didClickTopUpBtn:(UIButton *)sender{
    //        #import "HxbMyTopUpViewController.h"
    //        HxbMyTopUpViewController *hxbMyTopUpViewController = [[HxbMyTopUpViewController alloc]init];
    //        [self.navigationController pushViewController:hxbMyTopUpViewController animated:YES];
    [HXBUmengManagar HXB_clickEventWithEnevtId:kHXBUmeng_topup_money];
    [self logicalJudgment:HXBRechargeAndWithdrawalsLogicalJudgment_Recharge];
}
/// 提现
- (void)didClickWithdrawBtn:(UIButton *)sender{
    [HXBUmengManagar HXB_clickEventWithEnevtId:kHXBUmeng_withdraw_money];
    [self logicalJudgment:HXBRechargeAndWithdrawalsLogicalJudgment_Withdrawals];
}
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
            
//            HXBBaseAlertViewController *alertVC = [[HXBBaseAlertViewController alloc]initWithMassage:@"您尚未开通存管账户请开通后在进行投资" andLeftButtonMassage:@"立即开通" andRightButtonMassage:@"取消"];
//            [alertVC setClickLeftButtonBlock:^{
//                HXBOpenDepositAccountViewController *openDepositAccountVC = [[HXBOpenDepositAccountViewController alloc] init];
//                openDepositAccountVC.title = @"开通存管账户";
//                openDepositAccountVC.type = type;
//                [weakSelf.navigationController pushViewController:openDepositAccountVC animated:YES];
//            }];
//            [weakSelf.navigationController presentViewController:alertVC animated:YES completion:nil];
            //        //开通存管银行账户
            //        HXBBindBankCardViewController *bindBankCardVC = [[HXBBindBankCardViewController alloc] init];
            //        bindBankCardVC.type = type;
            //        [self.navigationController pushViewController:bindBankCardVC animated:YES];
            
        } else if ([weakSelf.userInfoViewModel.userInfoModel.userInfo.isCashPasswordPassed isEqualToString:@"1"] && [weakSelf.userInfoViewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"0"])
        {
            //进入绑卡界面
            HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc]init];
            withdrawCardViewController.title = @"绑卡";
            withdrawCardViewController.type = type;
            withdrawCardViewController.userInfoModel = self.userInfoViewModel.userInfoModel;
            [weakSelf.navigationController pushViewController:withdrawCardViewController animated:YES];
        }else if (!([weakSelf.userInfoViewModel.userInfoModel.userInfo.isCashPasswordPassed isEqualToString:@"1"] && [weakSelf.userInfoViewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"]))
        {
            //完善信息
            HXBOpenDepositAccountViewController *openDepositAccountVC = [[HXBOpenDepositAccountViewController alloc] init];
            openDepositAccountVC.title = @"完善信息";
            openDepositAccountVC.type = type;
            [weakSelf.navigationController pushViewController:openDepositAccountVC animated:YES];
        }else
        {
            if (type == HXBRechargeAndWithdrawalsLogicalJudgment_Recharge) {
                HxbMyTopUpViewController *hxbMyTopUpViewController = [[HxbMyTopUpViewController alloc]init];
                [weakSelf.navigationController pushViewController:hxbMyTopUpViewController animated:YES];
            }else if (type == HXBRechargeAndWithdrawalsLogicalJudgment_Withdrawals){
                HxbWithdrawViewController *withdrawViewController = [[HxbWithdrawViewController alloc]init];
                if (!KeyChain.isLogin)  return;
                withdrawViewController.userInfoViewModel = self.userInfoViewModel;
                [weakSelf.navigationController pushViewController:withdrawViewController animated:YES];
            }
        }

        
    } andFailure:^(NSError *error) {
        
    }];
}



- (void)clickBarButtonItem {
    NSLog(@"点击了返回按钮");
}

- (void)clickMyLoanButton: (UIButton *)button {
    NSLog(@"%@ - 散标被点击",self.class);
}

#pragma mark - 加载数据
- (void)loadData_accountInfo{
    kWeakSelf
    [HXBRequestAccountInfo downLoadAccountInfoNoHUDWithSeccessBlock:^(HXBMyRequestAccountModel *viewModel) {
        weakSelf.accountModel = viewModel;
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
