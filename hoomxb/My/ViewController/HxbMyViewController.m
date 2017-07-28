//
//  HxbMyViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
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
@interface HxbMyViewController ()<MyViewDelegate>
@property (nonatomic,copy) NSString *imageName;
@property (nonatomic, strong) HXBRequestUserInfoViewModel *userInfoViewModel;
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
    //对controllerView进行布局
    //    [self setupSubView];

    
//    //散标列表 红利计划的Button
//    [self setupBUTTON];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.hidden = ![KeyChain isLogin];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    //加载用户数据
    [self loadData_userInfo];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
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
    self.myView.homeRefreshHeaderBlock = ^(){
        [weakSelf loadData_userInfo];
    };
  
    [self.view addSubview:self.myView];
    if (KeyChain.isLogin) {
//        [HXBAlertManager alertManager_loginAgainAlertWithView:self.view];
        return;
    }
}

///查看总资产
- (void)clickAllFinanceButton {
   
    kWeakSelf
    [self.myView clickAllFinanceButtonWithBlock:^(UILabel * _Nullable button) {
        //跳转资产目录
        if (!KeyChain.isLogin) {
//            [HXBAlertManager alertManager_loginAgainAlertWithView:self.view];
            return;
        }
        HXBMY_AllFinanceViewController *allFinanceViewController = [[HXBMY_AllFinanceViewController alloc]init];
        [weakSelf.navigationController pushViewController:allFinanceViewController animated:true];
    }];
}

- (void)setUserInfoViewModel:(HXBRequestUserInfoViewModel *)userInfoViewModel
{
    _userInfoViewModel = userInfoViewModel;
    self.myView.userInfoViewModel = self.userInfoViewModel;
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
    [self logicalJudgment:HXBRechargeAndWithdrawalsLogicalJudgment_Recharge];
}
/// 提现
- (void)didClickWithdrawBtn:(UIButton *)sender{
    
    [self logicalJudgment:HXBRechargeAndWithdrawalsLogicalJudgment_Withdrawals];
}
/**
 逻辑判断
 */
- (void)logicalJudgment:(HXBRechargeAndWithdrawalsLogicalJudgment)type
{
    if (!self.userInfoViewModel.userInfoModel.userInfo.isCreateEscrowAcc) {
        //开通存管银行账户
        HXBBindBankCardViewController *bindBankCardVC = [[HXBBindBankCardViewController alloc] init];
        [self.navigationController pushViewController:bindBankCardVC animated:YES];
        
    } else if ([self.userInfoViewModel.userInfoModel.userInfo.isCashPasswordPassed isEqualToString:@"1"] && [self.userInfoViewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"0"])
    {
        //进入绑卡界面
        HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc]init];
        withdrawCardViewController.title = @"绑卡";
        withdrawCardViewController.type = type;
        [self.navigationController pushViewController:withdrawCardViewController animated:YES];
    }else if (!([self.userInfoViewModel.userInfoModel.userInfo.isCashPasswordPassed isEqualToString:@"1"] && [self.userInfoViewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"]))
    {
        //完善信息
        HXBOpenDepositAccountViewController *openDepositAccountVC = [[HXBOpenDepositAccountViewController alloc] init];
        openDepositAccountVC.title = @"完善信息";
        openDepositAccountVC.type = type;
        [self.navigationController pushViewController:openDepositAccountVC animated:YES];
    }else
    {
        if (type == HXBRechargeAndWithdrawalsLogicalJudgment_Recharge) {
            HxbMyTopUpViewController *hxbMyTopUpViewController = [[HxbMyTopUpViewController alloc]init];
            [self.navigationController pushViewController:hxbMyTopUpViewController animated:YES];
        }else if (type == HXBRechargeAndWithdrawalsLogicalJudgment_Withdrawals){
            HxbWithdrawViewController *withdrawViewController = [[HxbWithdrawViewController alloc]init];
            if (!KeyChain.isLogin)  return;
            withdrawViewController.userInfoViewModel = self.userInfoViewModel;
            [self.navigationController pushViewController:withdrawViewController animated:YES];
        }
    }
}



- (void)clickBarButtonItem {
    NSLog(@"点击了返回按钮");
}

- (void)clickMyLoanButton: (UIButton *)button {
    NSLog(@"%@ - 散标被点击",self.class);
}
#pragma mark - 加载数据
- (void)loadData_userInfo {
    kWeakSelf
    [HXBRequestUserInfo downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        weakSelf.userInfoViewModel = viewModel;
        weakSelf.myView.isStopRefresh_Home = YES;
    } andFailure:^(NSError *error) {
        weakSelf.myView.isStopRefresh_Home = YES;
        NSLog(@"%@",self);
    }];
}
@end
