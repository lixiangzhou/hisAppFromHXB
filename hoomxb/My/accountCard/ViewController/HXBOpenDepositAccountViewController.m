//
//  HXBOpenDepositAccountViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBOpenDepositAccountViewController.h"
#import "HXBBankCardListViewController.h"
#import "HxbMyTopUpViewController.h"
#import "HXBOpenDepositAccountView.h"
#import "HXBOpenDepositAccountRequest.h"
#import "HxbWithdrawViewController.h"
#import "HXBModifyTransactionPasswordViewController.h"//修改手机号
#import "HXBBankCardModel.h"
#import "HxbAccountInfoViewController.h"
#import "HXBOpenDepositAccountVCViewModel.h"
@interface HXBOpenDepositAccountViewController ()<UITableViewDelegate>

@property (nonatomic, strong) HXBOpenDepositAccountView *mainView;

@property (nonatomic, strong) HXBRequestUserInfoViewModel *userModel;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) HXBOpenDepositAccountVCViewModel *viewModel;

@end

@implementation HXBOpenDepositAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.tableHeaderView = self.mainView;
    self.tableView.frame = CGRectMake(0, HXBStatusBarAndNavigationBarHeight, kScreenWidth, kScreenHeight - HXBStatusBarAndNavigationBarHeight);
    self.tableView.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [self loadUserInfo];
    [self setupSubView];
}

- (void)setupSubView
{
    kWeakSelf
    [self.tableView hxb_headerWithRefreshBlock:^{
        [weakSelf loadUserInfo];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    [self.view addSubview:self.mainView.bottomBtn];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.offset(HXBStatusBarAndNavigationBarHeight);
        make.bottom.equalTo(self.mainView.bottomBtn.mas_top);
    }];
    [self.mainView.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.offset(kScrAdaptationH(49));
        make.bottom.equalTo(self.view).offset(-HXBBottomAdditionHeight);
    }];
    [self.view layoutIfNeeded];
    self.mainView.frame = CGRectMake(0, 0, kScreenW, self.tableView.height);
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
- (void)loadUserInfo
{
    kWeakSelf
    [self.viewModel downLoadUserInfoWithResultBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        if (viewModel) {
            if (viewModel.userInfoModel.userInfo.isCreateEscrowAcc)
            {
                [weakSelf.mainView.bottomBtn setTitle:@"提交" forState:UIControlStateNormal];
            }else
            {
                [weakSelf.mainView.bottomBtn setTitle:@"开通恒丰银行存管账户" forState:UIControlStateNormal];
            }
            //设置用户信息
            [weakSelf.mainView setupUserIfoData:viewModel];
            
            weakSelf.mainView.userModel = viewModel;
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isBlueGradientNavigationBar = YES;
}

- (void)checkCardBin:(HXBCardBinModel *)cardBinModel
{
    self.mainView.cardBinModel = cardBinModel;
}

//进入银行卡列表
- (void)enterBankCardListVC
{
    kWeakSelf
    HXBBankCardListViewController *bankCardListVC = [[HXBBankCardListViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:bankCardListVC];
//    bankCardListVC.bankCardListBlock = ^(NSString *bankCode, NSString *bankName){
//        weakSelf.mainView.bankCode = bankCode;
//        weakSelf.mainView.bankName = bankName;
//    };
    [weakSelf presentViewController:nav animated:YES completion:nil];
}
//开通账户
- (void)bottomBtnClick:(NSDictionary *)dic
{
    [self openStorageWithArgument:dic];
}

/**
 开通存管账户
 */
- (void)openStorageWithArgument:(NSDictionary *)dic{
    kWeakSelf
    [HXBUmengManagar HXB_clickEventWithEnevtId:kHXBUmeng_commitBtn];
    [self.viewModel openDepositAccountRequestWithArgument:dic andCallBack:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf openDepositRequestSuccess];
        }
    }];
}

- (void)openDepositRequestSuccess {
    if ([self.title isEqualToString:@"完善信息"]) {
        [HxbHUDProgress showTextWithMessage:@"提交成功"];
    } else {
        [HxbHUDProgress showTextWithMessage:@"开户成功"];
    }
    if (self.type == HXBRechargeAndWithdrawalsLogicalJudgment_Recharge) {
        HxbMyTopUpViewController *hxbMyTopUpViewController = [[HxbMyTopUpViewController alloc]init];
        [self.navigationController pushViewController:hxbMyTopUpViewController animated:YES];
    } else if (self.type == HXBRechargeAndWithdrawalsLogicalJudgment_Withdrawals){
        HxbWithdrawViewController *withdrawViewController = [[HxbWithdrawViewController alloc]init];
        if (!KeyChain.isLogin)  return;
        [self.navigationController pushViewController:withdrawViewController animated:YES];
    } else if(self.type == HXBRechargeAndWithdrawalsLogicalJudgment_Other)
    {
        if (_isFromUnbundBank) {
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[HxbAccountInfoViewController class]]) {
                    HxbAccountInfoViewController *accountInfoVC = (HxbAccountInfoViewController *)controller;
                    [self.navigationController popToViewController:accountInfoVC animated:YES];
                    break;
                }
            }
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else if(self.type == HXBRechargeAndWithdrawalsLogicalJudgment_signup)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (self.type == HXBChangePhone){
        HXBModifyTransactionPasswordViewController *modifyTransactionPasswordVC = [[HXBModifyTransactionPasswordViewController alloc] init];
        modifyTransactionPasswordVC.title = @"修改绑定手机号";
        modifyTransactionPasswordVC.userInfoModel = self.userModel.userInfoModel;
        [self.navigationController pushViewController:modifyTransactionPasswordVC animated:YES];
    }
}

- (void)dealloc {
    NSLog(@"✅被销毁 %@",self);
}

#pragma mark - 懒加载
- (HXBOpenDepositAccountVCViewModel *)viewModel {
    if (!_viewModel) {
        kWeakSelf
        _viewModel = [[HXBOpenDepositAccountVCViewModel alloc] initWithBlock:^UIView *{
            return weakSelf.view;
        }];
    }
    return _viewModel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        self.automaticallyAdjustsScrollViewInsets = NO;
        [self.view insertSubview:_tableView atIndex:0];
        [_tableView.panGestureRecognizer addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor = kHXBColor_BackGround;
        [HXBMiddlekey AdaptationiOS11WithTableView:_tableView];
    }
    return _tableView;
}

- (HXBOpenDepositAccountView *)mainView
{
    if (!_mainView) {
        kWeakSelf
        _mainView = [[HXBOpenDepositAccountView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _mainView.backgroundColor = kHXBColor_BackGround;
        _mainView.userModel = self.userModel;
        
        _mainView.bankNameBlock = ^{
            [weakSelf enterBankCardListVC];
        };
        _mainView.openAccountBlock = ^(NSDictionary *dic) {
            [weakSelf bottomBtnClick:dic];
        };
        [_mainView clickTrustAgreementWithBlock:^(BOOL isThirdpart) {
            NSLog(@"《存管开户协议》");
            HXBBaseWKWebViewController *webViewVC = [[HXBBaseWKWebViewController alloc] init];
            if (isThirdpart) {
                webViewVC.pageUrl = [NSString splicingH5hostWithURL:kHXB_Negotiate_thirdpart];
            }else
            {
                webViewVC.pageUrl = [NSString splicingH5hostWithURL:kHXB_Negotiate_authorize];
            }
            [weakSelf.navigationController pushViewController:webViewVC animated:YES];
        }];
        
        //卡bin校验
        _mainView.checkCardBin = ^(NSString *bankNumber) {
            [HXBOpenDepositAccountRequest checkCardBinResultRequestWithBankNumber:bankNumber andisToastTip:NO andSuccessBlock:^(HXBCardBinModel *cardBinModel) {
                [weakSelf checkCardBin:cardBinModel];
            } andFailureBlock:^(NSError *error) {
                weakSelf.mainView.isCheckFailed = YES;
            }];
        };
        
    }
    return _mainView;
}
- (void)leftBackBtnClick
{
    if (self.type == HXBRechargeAndWithdrawalsLogicalJudgment_signup) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
    {
        [super leftBackBtnClick];
    }
}
@end
