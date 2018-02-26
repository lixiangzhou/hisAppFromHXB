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

@property (nonatomic,strong) UITableView *hxbBaseVCScrollView;
@property (nonatomic,copy) void(^trackingScrollViewBlock)(UIScrollView *scrollView);

@property (nonatomic, strong) HXBOpenDepositAccountVCViewModel *openDepositAccountVM;

@end

@implementation HXBOpenDepositAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.hxbBaseVCScrollView addSubview:self.mainView];
    self.hxbBaseVCScrollView.tableHeaderView = self.mainView;
    self.hxbBaseVCScrollView.frame = CGRectMake(0, HXBStatusBarAndNavigationBarHeight, kScreenWidth, kScreenHeight - HXBStatusBarAndNavigationBarHeight);
    self.hxbBaseVCScrollView.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [self loadUserInfo];
    [self setupSubView];
}

- (void)setupSubView
{
    kWeakSelf
    [self.hxbBaseVCScrollView hxb_headerWithRefreshBlock:^{
        [weakSelf loadUserInfo];
        [weakSelf.hxbBaseVCScrollView.mj_header endRefreshing];
    }];
    [self.view addSubview:self.mainView.bottomBtn];
    [self.hxbBaseVCScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    self.mainView.frame = CGRectMake(0, 0, kScreenW, self.hxbBaseVCScrollView.height);
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.hxbBaseVCScrollView endEditing:YES];
}
- (void)loadUserInfo
{
    kWeakSelf
    [KeyChain downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {

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
        
//        if ([viewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"]) {
//            //已经绑卡
//            NYBaseRequest *bankCardAPI = [[NYBaseRequest alloc] init];
//            bankCardAPI.requestUrl = kHXBUserInfo_BankCard;
//            bankCardAPI.requestMethod = NYRequestMethodGet;
//            [bankCardAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
//                NSLog(@"%@",responseObject);
//                NSInteger status =  [responseObject[@"status"] integerValue];
//                if (status != 0) {
//                    [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
//                    return;
//                }
//                HXBBankCardModel *bankCardModel = [HXBBankCardModel yy_modelWithJSON:responseObject[@"data"]];
//                //设置绑卡信息
//                [weakSelf.mainView setupBankCardData:bankCardModel];
//            } failure:^(NYBaseRequest *request, NSError *error) {
//                NSLog(@"%@",error);
//                [HxbHUDProgress showTextWithMessage:@"银行卡请求失败"];
//            }];
//        }
        
    } andFailure:^(NSError *error) {
        
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
    [self.openDepositAccountVM openDepositAccountRequestWithArgument:dic andCallBack:^(BOOL isSuccess) {
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
    [self.hxbBaseVCScrollView.panGestureRecognizer removeObserver: self forKeyPath:@"state"];
    NSLog(@"✅被销毁 %@",self);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"state"]) {
        NSNumber *tracking = change[NSKeyValueChangeNewKey];
        if (tracking.integerValue == UIGestureRecognizerStateBegan && self.trackingScrollViewBlock) {
            self.trackingScrollViewBlock(self.hxbBaseVCScrollView);
        }
        return;
    }
    
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:nil];
}

#pragma mark - 懒加载
- (HXBOpenDepositAccountVCViewModel *)openDepositAccountVM {
    if (!_openDepositAccountVM) {
        kWeakSelf
        _openDepositAccountVM = [[HXBOpenDepositAccountVCViewModel alloc] initWithBlock:^UIView *{
            return weakSelf.view;
        }];
    }
    return _openDepositAccountVM;
}

- (UITableView *)hxbBaseVCScrollView {
    if (!_hxbBaseVCScrollView) {
        
        _hxbBaseVCScrollView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        self.automaticallyAdjustsScrollViewInsets = NO;
        [self.view insertSubview:_hxbBaseVCScrollView atIndex:0];
        [_hxbBaseVCScrollView.panGestureRecognizer addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
        _hxbBaseVCScrollView.tableFooterView = [[UIView alloc]init];
        _hxbBaseVCScrollView.backgroundColor = kHXBColor_BackGround;
        [HXBMiddlekey AdaptationiOS11WithTableView:_hxbBaseVCScrollView];
    }
    return _hxbBaseVCScrollView;
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
            [weakSelf.openDepositAccountVM checkCardBinResultRequestWithBankNumber:bankNumber andisToastTip:NO andCallBack:^(BOOL isSuccess) {
                if (isSuccess) {
                    [weakSelf checkCardBin:weakSelf.openDepositAccountVM.cardBinModel];
                }
                else {
                    weakSelf.mainView.isCheckFailed = YES;
                }
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
