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
#import "HXBFinLoanTruansfer_ContraceWebViewVC.h"///存管的服务协议
#import "HxbWithdrawViewController.h"
#import "HXBModifyTransactionPasswordViewController.h"//修改手机号
#import "HXBBankCardModel.h"
@interface HXBOpenDepositAccountViewController ()<UITableViewDelegate>

@property (nonatomic, strong) HXBOpenDepositAccountView *mainView;

@property (nonatomic, strong) HXBRequestUserInfoViewModel *userModel;


@end

@implementation HXBOpenDepositAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.hxbBaseVCScrollView addSubview:self.mainView];
    self.hxbBaseVCScrollView.tableHeaderView = self.mainView;
    self.hxbBaseVCScrollView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64);
    self.hxbBaseVCScrollView.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [self loadUserInfo];
    [self setupSubView];
}

- (void)setupSubView
{
    kWeakSelf
    [self.hxbBaseVCScrollView hxb_GifHeaderWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
        [weakSelf loadUserInfo];
        [weakSelf.hxbBaseVCScrollView.mj_header endRefreshing];
    } andSetUpGifHeaderBlock:^(MJRefreshGifHeader *gifHeader) {
        
    }];
    [self.view addSubview:self.mainView.bottomBtn];
    [self.mainView.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.offset(kScrAdaptationH(49));
    }];
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
    HXBOpenDepositAccountRequest *openDepositAccountRequest = [[HXBOpenDepositAccountRequest alloc] init];
    [openDepositAccountRequest openDepositAccountRequestWithArgument:dic andSuccessBlock:^(id responseObject) {
        if ([self.title isEqualToString:@"完善信息"]) {
            [HxbHUDProgress showTextWithMessage:@"提交成功"];
        }else{
            [HxbHUDProgress showTextWithMessage:@"开户成功"];
        }
        if (weakSelf.type == HXBRechargeAndWithdrawalsLogicalJudgment_Recharge) {
            HxbMyTopUpViewController *hxbMyTopUpViewController = [[HxbMyTopUpViewController alloc]init];
            [self.navigationController pushViewController:hxbMyTopUpViewController animated:YES];
        }else if (weakSelf.type == HXBRechargeAndWithdrawalsLogicalJudgment_Withdrawals){
            HxbWithdrawViewController *withdrawViewController = [[HxbWithdrawViewController alloc]init];
            if (!KeyChain.isLogin)  return;
            [self.navigationController pushViewController:withdrawViewController animated:YES];
        }else if(weakSelf.type == HXBRechargeAndWithdrawalsLogicalJudgment_Other)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }else if(weakSelf.type == HXBRechargeAndWithdrawalsLogicalJudgment_signup)
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }else if (weakSelf.type == HXBChangePhone){
            HXBModifyTransactionPasswordViewController *modifyTransactionPasswordVC = [[HXBModifyTransactionPasswordViewController alloc] init];
            modifyTransactionPasswordVC.title = @"修改绑定手机号";
            modifyTransactionPasswordVC.userInfoModel = self.userModel.userInfoModel;
            [self.navigationController pushViewController:modifyTransactionPasswordVC animated:YES];
        }
    } andFailureBlock:^(NSError *error) {
        
    }];
}

#pragma mark - 懒加载
- (HXBOpenDepositAccountView *)mainView
{
    if (!_mainView) {
        kWeakSelf
        _mainView = [[HXBOpenDepositAccountView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
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
            HXBFinLoanTruansfer_ContraceWebViewVC *webViewVC = [[HXBFinLoanTruansfer_ContraceWebViewVC alloc] init];
            if (isThirdpart) {
                webViewVC.URL = kHXB_Negotiate_thirdpart;
//                webViewVC.title = @"恒丰银行股份有限公司杭州分行网络交易资金账户三方协议";
            }else
            {
                webViewVC.URL = kHXB_Negotiate_authorize;
//                webViewVC.title = @"红小宝平台授权协议";
            }
            [weakSelf.navigationController pushViewController:webViewVC animated:true];
        }];
        
        //卡bin校验
        _mainView.checkCardBin = ^(NSString *bankNumber) {
            [HXBOpenDepositAccountRequest checkCardBinResultRequestWithSmscode:bankNumber andisToastTip:NO andSuccessBlock:^(HXBCardBinModel *cardBinModel) {
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
