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
#import "HxbWithdrawCardViewController.h"
@interface HxbMyBankCardViewController ()

/**
 数据模型
 */
@property (nonatomic, strong) HXBBankCardModel *bankCardModel;

@property (nonatomic, strong) HXBUserInfoView *userInfoView;

@property (nonatomic, strong) HXBUserInfoView *bankView;


@end

@implementation HxbMyBankCardViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"开通存管账户";
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self.view addSubview:self.userInfoView];
    [self.view addSubview:self.bankView];
    [self setupSubViewFrame];
    
}

- (void)setupSubViewFrame
{
    [self.userInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kScrAdaptationW750(20));
        make.right.equalTo(self.view).offset(kScrAdaptationW750(-20));
        make.top.equalTo(self.view).offset(kScrAdaptationH750(20));
        make.height.offset(120);
    }];
    [self.bankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kScrAdaptationW750(20));
        make.right.equalTo(self.view).offset(kScrAdaptationW750(-20));
        make.top.equalTo(self.userInfoView.mas_bottom).offset(kScrAdaptationH750(20));
        make.height.offset(120);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadUserInfo];
}

- (void)loadUserInfo
{
    kWeakSelf
    [KeyChain downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        weakSelf.userInfoView.leftStrArr = @[@"安全认证",@"姓名",@"身份证",@"存管开通协议"];
        NSString *realName = [viewModel.userInfoModel.userInfo.realName replaceStringWithStartLocation:0 lenght:viewModel.userInfoModel.userInfo.realName.length - 1];
        NSString *idCard = [viewModel.userInfoModel.userInfo.idNo replaceStringWithStartLocation:2 lenght:viewModel.userInfoModel.userInfo.idNo.length - 4];
        weakSelf.userInfoView.rightArr = @[@"已认证",realName,idCard,@"协议"];
        
        if ([viewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"]) {
            [weakSelf loadBankCardData];
        }else
        {
            weakSelf.bankView.leftStrArr = @[@"银行卡"];
            UITapGestureRecognizer *bankViewTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bindBankCardClick)];
            [weakSelf.bankView addGestureRecognizer:bankViewTapGestureRecognizer];
            weakSelf.bankView.userInteractionEnabled = YES;
        }
        
    } andFailure:^(NSError *error) {
        
    }];
}

- (void)bindBankCardClick
{
    //进入绑卡界面
    HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc]init];
    withdrawCardViewController.title = @"绑卡";
    withdrawCardViewController.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
    [self.navigationController pushViewController:withdrawCardViewController animated:YES];
}

- (void)loadBankCardData
{
    kWeakSelf
    NYBaseRequest *bankCardAPI = [[NYBaseRequest alloc] init];
    bankCardAPI.requestUrl = kHXBUserInfo_BankCard;
    bankCardAPI.requestMethod = NYRequestMethodGet;
    [bankCardAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
        NSInteger status =  [responseObject[@"status"] integerValue];
        if (status != 0) {
            [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
            return;
        }
        weakSelf.bankCardModel = [HXBBankCardModel yy_modelWithJSON:responseObject[@"data"]];
        
        weakSelf.bankView.leftStrArr = @[@"银行卡",@"银行",@"卡号"];
        NSString *bankCard = [NSString stringWithFormat:@"（尾号%@）",[weakSelf.bankCardModel.cardId substringFromIndex:weakSelf.bankCardModel.cardId.length - 4]];
        if (!weakSelf.bankCardModel.bankType) {
            weakSelf.bankCardModel.bankType = @"";
        }
        weakSelf.bankView.rightArr = @[@"已绑定",weakSelf.bankCardModel.bankType,bankCard];
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        NSLog(@"%@",error); 
        [HxbHUDProgress showTextWithMessage:@"银行卡请求失败"];
    }];

}

#pragma mark - UITableViewDelegate



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
- (HXBUserInfoView *)bankView
{
    if (!_bankView) {
        _bankView = [[HXBUserInfoView alloc] initWithFrame:CGRectZero];
    }
    return _bankView;
}

@end
