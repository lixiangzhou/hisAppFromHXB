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
#import "HxbWithdrawViewController.h"
#import "HXBModifyTransactionPasswordViewController.h"//修改手机号
#import "HXBBankCardModel.h"
#import "HxbAccountInfoViewController.h"
#import "HXBOpenDepositAccountVCViewModel.h"

#import "HXBLazyCatAccountWebViewController.h"
#import "SVGKit/SVGKImage.h"
#import "HXBCustomTextField.h"

#define kInputHeight 50

#import "HXBOpenDepositoryResultController.h"
#import "HXBLazyCatResponseDelegate.h"
#import "HXBLazyCatResponseModel.h"

@interface HXBOpenDepositAccountViewController () <UITextFieldDelegate>
/*
@property (nonatomic, strong) HXBOpenDepositAccountView *mainView;

@property (nonatomic,strong) UITableView *tableView;
*/

@property (nonatomic, weak) UIScrollView *scrollView;
/// 姓名
@property (nonatomic, weak) HXBCustomTextField *nameView;
/// 身份证号
@property (nonatomic, weak) HXBCustomTextField *idView;
/// 银行卡号
@property (nonatomic, weak) HXBCustomTextField *bankNoView;
/// 银行卡名称
@property (nonatomic, weak) HXBCustomTextField *bankNameView;

@property (nonatomic, strong) HXBOpenDepositAccountVCViewModel *viewModel;

@end

@implementation HXBOpenDepositAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    kWeakSelf
    self.viewModel = [[HXBOpenDepositAccountVCViewModel alloc] initWithBlock:^UIView *{
        return weakSelf.view;
    }];

    [self setUI];
}

#pragma mark - UI
- (void)setUI {
    self.isBlueGradientNavigationBar = YES;
    
    [self setScrollView];
    
    [self setNameAndIdView];
    
    [self setBankView];

    [self setBottomView];
}

- (void)setNameAndIdView {
    UIView *sectionView1 = [self viewTitle:@"安全认证" description:@"按国家规定投资用户需满18岁"];
    [self.scrollView addSubview:sectionView1];
    
    HXBCustomTextField *nameView = [[HXBCustomTextField alloc] init];
    nameView.leftImage = [SVGKImage imageNamed:@"name.svg"].UIImage;
    nameView.placeholder = @"真实姓名";
    nameView.delegate = self;
    [self.scrollView addSubview:nameView];
    self.nameView = nameView;

    HXBCustomTextField *idView = [[HXBCustomTextField alloc] init];
    idView.leftImage = [SVGKImage imageNamed:@"id_number.svg"].UIImage;
    idView.placeholder = @"身份证号";
    idView.delegate = self;
    idView.isIDCardTextField = YES;
    [self.scrollView addSubview:idView];
    self.idView = idView;
    
    [sectionView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@40);
        make.left.right.equalTo(self.view);
    }];
    
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sectionView1.mas_bottom).offset(30);
        make.left.equalTo(sectionView1);
        make.right.equalTo(sectionView1);
        make.height.equalTo(@kInputHeight);
    }];
    
    [idView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameView.mas_bottom);
        make.left.equalTo(sectionView1);
        make.right.equalTo(sectionView1);
        make.height.equalTo(@kInputHeight);
    }];
}

- (void)setBankView {
    UIView *sectionView2 = [self viewTitle:@"银行卡" description:@"实名认证与银行卡需为同一人"];
    [self.scrollView addSubview:sectionView2];
    
    HXBCustomTextField *bankNoView = [[HXBCustomTextField alloc] init];
    bankNoView.leftImage = [SVGKImage imageNamed:@"card.svg"].UIImage;
    bankNoView.placeholder = @"银行卡号";
    bankNoView.delegate = self;
    bankNoView.limitStringLength = 31;
    bankNoView.keyboardType = UIKeyboardTypeNumberPad;
    
    kWeakSelf
    bankNoView.block = ^(NSString *text) {
        NSString *bankNumber = [text stringByReplacingOccurrencesOfString:@" "  withString:@""];
        if (bankNumber.length>=12) {
            [weakSelf.viewModel checkCardBinResultRequestWithBankNumber:bankNumber andisToastTip:NO andCallBack:^(BOOL isSuccess) {
                if (isSuccess) {
                    if (weakSelf.viewModel.cardBinModel.creditCard) {
                        weakSelf.bankNameView.svgImageName = weakSelf.viewModel.cardBinModel.bankCode;
                        weakSelf.bankNameView.text = @"此卡为信用卡，暂不支持";
                    } else {
                        weakSelf.bankNameView.svgImageName = weakSelf.viewModel.cardBinModel.bankCode;
                        weakSelf.bankNameView.text = [NSString stringWithFormat:@"%@：%@",weakSelf.viewModel.cardBinModel.bankName, weakSelf.viewModel.cardBinModel.quota];
                    }
                    [weakSelf showBankNameView];
                } else {
                    [weakSelf hideBankNameView];
                }
            }];
        }
    };
    [self.scrollView addSubview:bankNoView];
    self.bankNoView = bankNoView;
    
    UIButton *checkLimitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkLimitBtn setTitle:@"查看银行限额" forState:(UIControlStateNormal)];
    checkLimitBtn.backgroundColor = [UIColor whiteColor];
    [checkLimitBtn setTitleColor:kHXBColor_Blue040610 forState:(UIControlStateNormal)];
    [checkLimitBtn addTarget:self action:@selector(checkBankLimit) forControlEvents:(UIControlEventTouchUpInside)];
    checkLimitBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
    [checkLimitBtn sizeToFit];
    [bankNoView addSubview:checkLimitBtn];
    
    HXBCustomTextField *bankNameView = [[HXBCustomTextField alloc] init];
    bankNameView.leftImage = [SVGKImage imageNamed:@"默认.svg"].UIImage;
    bankNameView.alpha = 0;
    bankNameView.placeholder = @"银行名称";
    bankNameView.delegate = self;
    bankNameView.userInteractionEnabled = NO;
    bankNameView.textColor = COR10;
//    [self.scrollView addSubview:bankNameView];
    [self.scrollView insertSubview:bankNameView belowSubview:bankNoView];
    self.bankNameView = bankNameView;
    
    [sectionView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.idView.mas_bottom).offset(50);
        make.left.right.equalTo(self.view);
    }];
    
    [bankNoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sectionView2.mas_bottom).offset(30);
        make.left.equalTo(sectionView2);
        make.right.equalTo(sectionView2);
        make.height.equalTo(@kInputHeight);
    }];
    
    [checkLimitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bankNoView).offset(-20);
        make.centerY.equalTo(bankNoView);
    }];
    
    [bankNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bankNoView).offset(0);
        make.left.equalTo(sectionView2);
        make.right.equalTo(sectionView2);
        make.height.equalTo(@kInputHeight);
    }];
}

- (void)setScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.alwaysBounceVertical = YES;
    scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.offset(HXBStatusBarAndNavigationBarHeight);
    }];
}

- (void)setBottomView {
    UIButton *bottomBtn = [[UIButton alloc] init];
    bottomBtn.backgroundColor = COR24;
    [bottomBtn setTitle:@"开通恒丰银行存管账户" forState:UIControlStateNormal];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bottomBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(16);
    bottomBtn.layer.cornerRadius = 4;
    bottomBtn.layer.masksToBounds = YES;
    [bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:bottomBtn];
    
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bankNameView.mas_bottom).offset(40);
        make.left.equalTo(self.view).offset(35);
        make.right.equalTo(self.view).offset(-35);
        make.height.equalTo(@41);
    }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if (self.bankNoView == textField.superview) {
        [self hideBankNameView];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.superview == self.bankNoView) {
        return [UITextField numberFormatTextField:textField shouldChangeCharactersInRange:range replacementString:string textFieldType:kBankCardNumberTextFieldType];
    }
    if ([string isEqualToString:@""]) {
        return YES;
    } else {
        if (self.nameView == textField.superview && [string isEqualToString:@" "]) {
            return NO;
        }
        return [self limitNumberCount:textField.superview];
    }
}

#pragma mark - Helper
- (UIView *)viewTitle:(NSString *)title description:(NSString *)description {
    UIView *view = [UIView new];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = [NSString stringWithFormat:@"●  %@  ●", title];
    titleLabel.font = kHXBFont_30;
    titleLabel.textColor = UIColorFromRGB(0x003D7E);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:titleLabel];
    
    UILabel *descLabel = [UILabel new];
    descLabel.text = description;
    descLabel.font = kHXBFont_24;
    descLabel.textColor = kHXBColor_999999_100;
    descLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:descLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(view);
    }];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.left.right.bottom.equalTo(view);
    }];
    
    return view;
}

- (void)showBankNameView {
    self.bankNameView.alpha = 0;
    [self.bankNameView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bankNoView).offset(kInputHeight);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.bankNameView.alpha = 1;
        [self.view layoutIfNeeded];
    }];
}

- (void)hideBankNameView {
    self.bankNameView.alpha = 1;
    [self.bankNameView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bankNoView).offset(0);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.bankNameView.alpha = 0;
        [self.view layoutIfNeeded];
    }];
}

- (BOOL)limitNumberCount:(UIView *)textField
{
    if (self.idView.text.length > 17 && self.idView == textField) {
        return NO;
    }

    if (self.bankNoView.text.length > 31 && self.bankNoView == textField) {
        return NO;
    }

    return YES;
}

- (BOOL)judgeIsTure
{
    BOOL isNull = NO;
    if (!(self.nameView.text.length > 0)) {
        [HxbHUDProgress showMessageCenter:@"真实姓名不能为空" inView:self.view];
        isNull = YES;
        return isNull;
    }
    if (!(self.idView.text.length > 0)) {
        [HxbHUDProgress showMessageCenter:@"身份证号不能为空" inView:self.view];
        isNull = YES;
        return isNull;
    }
    if(self.idView.text.length != 18)
    {
        [HxbHUDProgress showMessageCenter:@"身份证号输入有误" inView:self.view];
        isNull = YES;
        return isNull;
    }
    
    if (!(self.bankNoView.text.length > 0)) {
        [HxbHUDProgress showMessageCenter:@"银行卡号不能为空" inView:self.view];
        isNull = YES;
        return isNull;
    }
    if (!(self.bankNoView.text.length >= 10 && self.bankNoView.text.length <= 31)) {
        [HxbHUDProgress showMessageCenter:@"银行卡号输入有误" inView:self.view];
        isNull = YES;
        return isNull;
    }
    return isNull;
}

- (void)openDepositRequestSuccess {
    [HxbHUDProgress showTextWithMessage:@"开户成功"];
    
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
        [self.navigationController pushViewController:modifyTransactionPasswordVC animated:YES];
    }
}

#pragma mark - Action
/// 开通恒丰银行存管账户
- (void)bottomBtnClick {
    if ([self judgeIsTure]) return;
    
    NSString *username = [self.nameView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *idNo = [self.idView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *bankNo = [self.bankNoView.text stringByReplacingOccurrencesOfString:@" " withString:@""];

    kWeakSelf
    [self.viewModel openDepositoryWithUsrname:username idNo:idNo bankNo:bankNo resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            HXBLazyCatAccountWebViewController *webVC = [HXBLazyCatAccountWebViewController new];
            webVC.requestModel = weakSelf.viewModel.lazyCatReqModel;
            [weakSelf.navigationController pushViewController:webVC animated:YES];
        }
    }];
}

/// 查看银行限额
- (void)checkBankLimit {
    kWeakSelf
    HXBBankCardListViewController *bankCardListVC = [[HXBBankCardListViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:bankCardListVC];
    [weakSelf presentViewController:nav animated:YES completion:nil];
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


/*
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
    [self.viewModel downLoadUserInfo:YES resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            if (weakSelf.viewModel.userInfoModel.userInfoModel.userInfo.isCreateEscrowAcc)
            {
                [weakSelf.mainView.bottomBtn setTitle:@"提交" forState:UIControlStateNormal];
            }else
            {
                [weakSelf.mainView.bottomBtn setTitle:@"开通恒丰银行存管账户" forState:UIControlStateNormal];
            }
            //设置用户信息
            [weakSelf.mainView setupUserIfoData:weakSelf.viewModel.userInfoModel];
            
            weakSelf.mainView.userModel = weakSelf.viewModel.userInfoModel;
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
            [weakSelf.viewModel checkCardBinResultRequestWithBankNumber:bankNumber andisToastTip:NO andCallBack:^(BOOL isSuccess) {
                if (isSuccess) {
                    [weakSelf checkCardBin:weakSelf.viewModel.cardBinModel];
                }
                else {
                    weakSelf.mainView.isCheckFailed = YES;
                }
            }];
        };
        
    }
    return _mainView;
}
*/

@end
