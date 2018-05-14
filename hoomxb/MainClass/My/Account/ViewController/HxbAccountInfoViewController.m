//
//  HxbAccountInfoViewController.m
//  hoomxb
//  账户信息
//  Created by HXB-C on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbAccountInfoViewController.h"
#import "HxbMyBankCardViewController.h"
#import "HxbMyAccountSecurityViewController.h"
#import "HxbMyAboutMeViewController.h"
#import "HXBRequestUserInfoAgent.h"
#import "HXBRiskAssessmentViewController.h"
#import "HXBOpenDepositAccountViewController.h"
#import "HXBBaseTabBarController.h"
#import "HxbMyViewController.h"
#import "HxbWithdrawCardViewController.h"
#import "HXBMiddlekey.h"
#import "HXBBottomLineTableViewCell.h"
#import "HXBDepositoryAlertViewController.h"
#import "HxbFinancialAdvisorViewController.h"
#import "HXBAccountInfoViewModel.h"
// 是否展示理财顾问的开关
#define kIsDisplayAdvisor self.userInfoViewModel.userInfoModel.userInfo.isDisplayAdvisor

@interface HxbAccountInfoViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *signOutLabel;
@property (nonatomic, strong) NSArray *itemArray;
@property (nonatomic, strong) HXBAccountInfoViewModel *viewModel;
//@property (nonatomic, strong) UIButton *signOutButton;
//@property (nonatomic, strong) HXBRequestUserInfoViewModel *userInfoViewModel;
@end

@implementation HxbAccountInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户信息";
    kWeakSelf
    self.viewModel = [[HXBAccountInfoViewModel alloc] initWithBlock:^UIView *{
        return weakSelf.view;
    }];
    [self.view addSubview:self.tableView];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isColourGradientNavigationBar = YES;
    [self loadData_userInfo];///加载用户数据
}

/**
 再次获取网络数据
 */
- (void)getNetworkAgain
{
     [self loadData_userInfo];
}

#pragma TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
    }else if(indexPath.section == 1){
        kWeakSelf
        [self.viewModel downLoadUserInfo:YES resultBlock:^(BOOL isSuccess) {
            if (isSuccess) {
                weakSelf.userInfoViewModel = weakSelf.viewModel.userInfoModel;
                if (indexPath.row == 0) {
                    //进入存管账户
                    [weakSelf entryDepositoryAccount:NO];
                    
                }else if (indexPath.row == 1){
                    
                    if ([weakSelf.userInfoViewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"]) {
                        //进入银行卡
                        [weakSelf entryDepositoryAccount:YES];
                    }else{
                        //进入绑卡页面
                        [weakSelf bindBankCardClick];
                    }
                }
            }
        }];
    } else if(indexPath.section == 2){
        //账户安全
        HxbMyAccountSecurityViewController *myAccountSecurityVC = [[HxbMyAccountSecurityViewController alloc] init];
        HxbFinancialAdvisorViewController *financialAdvisorViewController = [[HxbFinancialAdvisorViewController alloc] init];
        HxbMyAboutMeViewController *myAboutMeViewController = [[HxbMyAboutMeViewController alloc] init];
        
        NSArray <HXBBaseViewController *> *clickClassNameArray = _isDisplayAdvisor ? @[myAccountSecurityVC, financialAdvisorViewController, myAboutMeViewController] : @[myAccountSecurityVC, myAboutMeViewController];
        
        if (indexPath.row == 0) {
            //风险评测
            NSLog(@"点击了风险评测");
            [self entryRiskAssessment];
        } else {
            if (indexPath.row == 1) {
                myAccountSecurityVC.userInfoViewModel = self.userInfoViewModel;
            }
            [self.navigationController pushViewController:clickClassNameArray[indexPath.row - 1] animated:YES];
        }

    } else if (indexPath.section == 3) {
        [self signOutButtonButtonClick];
    }
}
//进入绑卡界面
- (void)bindBankCardClick
{
    if (self.userInfoViewModel.userInfoModel.userInfo.isUnbundling) {
        [HXBAlertManager callupWithphoneNumber:kServiceMobile andWithTitle:@"温馨提示" Message:[NSString stringWithFormat:@"您的身份信息不完善，请联系客服 %@", kServiceMobile]];
        return;
    }
    
    HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc]init];
    withdrawCardViewController.title = @"绑卡";
    withdrawCardViewController.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
    [self.navigationController pushViewController:withdrawCardViewController animated:YES];
}

/**
 进入存管账户
 */
- (void)entryDepositoryAccount:(BOOL)isbankView
{
    if (self.userInfoViewModel.userInfoModel.userInfo.isUnbundling) {
        [HXBAlertManager callupWithphoneNumber:kServiceMobile andWithTitle:@"温馨提示" Message:[NSString stringWithFormat:@"您的身份信息不完善，请联系客服 %@", kServiceMobile]];
        return;
    }
    
    if (!self.userInfoViewModel.userInfoModel.userInfo.isCreateEscrowAcc) {
        HXBDepositoryAlertViewController *alertVC = [[HXBDepositoryAlertViewController alloc] init];
        alertVC.immediateOpenBlock = ^{
            [HXBUmengManagar HXB_clickEventWithEnevtId:kHXBUmeng_alertBtn];
            HXBOpenDepositAccountViewController *openDepositAccountVC = [[HXBOpenDepositAccountViewController alloc] init];
            openDepositAccountVC.title = @"开通存管账户";
            openDepositAccountVC.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
            [self.navigationController pushViewController:openDepositAccountVC animated:YES];
        };
        [self presentViewController:alertVC animated:NO completion:nil];
        
    }else if ([self.userInfoViewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"])
    {
        if (isbankView) {
            //已开通
            HxbMyBankCardViewController *myBankCardViewVC = [[HxbMyBankCardViewController alloc]init];
            myBankCardViewVC.isBank = isbankView;

            [self.navigationController pushViewController:myBankCardViewVC animated:YES];
        } else {
            HxbMyBankCardViewController *myBankCardViewVC = [[HxbMyBankCardViewController alloc]init];
            myBankCardViewVC.isBank = isbankView;
            [self.navigationController pushViewController:myBankCardViewVC animated:YES];
        }
    }else if ([self.userInfoViewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"0"])
    {
        HxbMyBankCardViewController *myBankCardViewVC = [[HxbMyBankCardViewController alloc]init];
        myBankCardViewVC.isBank = isbankView;
        [self.navigationController pushViewController:myBankCardViewVC animated:YES];
    }
}
/**
 进入风险评测
 */
- (void)entryRiskAssessment
{
    if (!self.userInfoViewModel.userInfoModel.userInfo.isCreateEscrowAcc) {
        HXBDepositoryAlertViewController *alertVC = [[HXBDepositoryAlertViewController alloc] init];
        kWeakSelf
        alertVC.immediateOpenBlock = ^{
            HXBOpenDepositAccountViewController *openDepositAccountVC = [[HXBOpenDepositAccountViewController alloc] init];
            openDepositAccountVC.title = @"开通存管账户";
            openDepositAccountVC.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
            [weakSelf.navigationController pushViewController:openDepositAccountVC animated:YES];
        };
        [self presentViewController:alertVC animated:NO completion:nil];
        return;
    }
    HXBRiskAssessmentViewController *riskAssessmentVC = [[HXBRiskAssessmentViewController alloc] init];
    [self.navigationController pushViewController:riskAssessmentVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return kScrAdaptationH(50);
            break;
        default:
            return kScrAdaptationH(45);
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kScrAdaptationH(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}

#pragma TableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *celledStr = @"celled";
    HXBBottomLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celledStr];
    if (cell == nil) {
        cell = [[HXBBottomLineTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:celledStr];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
        cell.textLabel.textColor = COR6;
        cell.detailTextLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
        cell.detailTextLabel.textColor = COR29;
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.textLabel.text = self.userInfoViewModel.userInfoModel.userInfo.username;
        cell.imageView.image = [UIImage imageNamed:@"default_avatar"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.hiddenLine = YES;
        if ([self.userInfoViewModel.userInfoModel.userInfo.gender isEqualToString:@"1"]) {
            cell.imageView.image = [UIImage imageNamed:@"woman"];
        }else if([self.userInfoViewModel.userInfoModel.userInfo.gender isEqualToString:@"0"]){
            cell.imageView.image = [UIImage imageNamed:@"man"];
        }
    }else if (indexPath.section == 1){
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 0) {
            cell.textLabel.text = @"恒丰银行存管账户";
            
            if (!self.userInfoViewModel.userInfoModel.userInfo.isCreateEscrowAcc) {
                //开通存管银行账户
                cell.detailTextLabel.text = @"未开户";
            }else if (![self.userInfoViewModel.userInfoModel.userInfo.isCashPasswordPassed isEqualToString:@"1"]) {
                //完善信息
                cell.detailTextLabel.text = @"完善信息";
            }else{
                //已开通
                cell.detailTextLabel.text = @"已开户";
                cell.detailTextLabel.textColor = COR30;
            }
            cell.hiddenLine = !self.userInfoViewModel.userInfoModel.userInfo.isCreateEscrowAcc;
            
        } else if (indexPath.row == 1){
            cell.textLabel.text = @"银行卡";
            cell.hiddenLine = YES;
            if ([self.userInfoViewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"]) {
                cell.detailTextLabel.text = @"已绑定";
                cell.detailTextLabel.textColor = COR30;
            }else{
                cell.detailTextLabel.text = @"未绑定";
                cell.detailTextLabel.textColor = COR29;
            }
        }else{
            cell.textLabel.text = @"风险评测";
            cell.detailTextLabel.text = self.userInfoViewModel.userInfoModel.userInfo.riskType;
        }
    } else if (indexPath.section == 2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        _itemArray = @[@"风险评测",@"账户安全",@"我的财富顾问",@"关于我们"];
        if (!_isDisplayAdvisor) {
            _itemArray = @[@"风险评测",@"账户安全",@"关于我们"];
        }
        cell.textLabel.text = _itemArray[indexPath.row];
        cell.hiddenLine = NO;
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = self.userInfoViewModel.userInfoModel.userInfo.riskType;
            cell.detailTextLabel.textColor = COR30;
            if ([cell.detailTextLabel.text isEqualToString:@"立即评测"]) {
                cell.detailTextLabel.textColor = COR29;
            }
        }else if(indexPath.row == _itemArray.count - 1){
            cell.hiddenLine = YES;
        }
    }else if (indexPath.section == 3){
        cell.textLabel.text = @"";
        cell.detailTextLabel.text = @"";
        self.signOutLabel.frame = cell.bounds;
        self.signOutLabel.width = kScreenWidth;
        [cell.contentView addSubview:self.signOutLabel];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.hiddenLine = YES;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return self.userInfoViewModel.userInfoModel.userInfo.isCreateEscrowAcc ? 2 : 1;
            break;
        case 2:
            return _isDisplayAdvisor ? 4 : 3;
            break;
        case 3:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView  alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
    }
    return _tableView;
}
//登出按钮事件
- (void)signOutButtonButtonClick{
    kWeakSelf
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//        NSLog(@"%@",action.title);
//    }];
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        [KeyChain signOut];
//        [(HXBBaseTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController setSelectedIndex:0];
//        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
//    }];
//    [alertController addAction:cancelAction];
//    [alertController addAction:okAction];
//
//    [self presentViewController:alertController animated:YES completion:nil];
    
    HXBGeneralAlertVC *alertVC = [[HXBGeneralAlertVC alloc] initWithMessageTitle:@"提示" andSubTitle:@"您确定要退出登录吗？" andLeftBtnName:@"取消" andRightBtnName:@"确定" isHideCancelBtn:YES isClickedBackgroundDiss:YES];
    alertVC.isCenterShow = YES;
    [self presentViewController:alertVC animated:NO completion:nil];
    [alertVC setRightBtnBlock:^{
        [KeyChain signOut];
        [(HXBBaseTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController setSelectedIndex:0];
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    }];
}

////登出按钮
//- (UIButton *)signOutButton{
//    if (!_signOutButton) {
//        _signOutButton = [UIButton btnwithTitle:@"退出当前账号" andTarget:self andAction:@selector(signOutButtonButtonClick:) andFrameByCategory:CGRectMake(20, SCREEN_HEIGHT - 64 - 44 - 20, SCREEN_WIDTH - 40, 44)];
//    }
//    return _signOutButton;
//}

- (UILabel *)signOutLabel
{
    if (!_signOutLabel) {
        _signOutLabel = [[UILabel alloc] init];
        _signOutLabel.text = @"退出当前账号";
        _signOutLabel.textColor = COR29;
        _signOutLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
        _signOutLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _signOutLabel;
}

#pragma mark - 加载数据
- (void)loadData_userInfo {
    kWeakSelf
    [self.viewModel downLoadUserInfo:YES resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.userInfoViewModel = weakSelf.viewModel.userInfoModel;
            _isDisplayAdvisor = weakSelf.userInfoViewModel.userInfoModel.userInfo.isDisplayAdvisor;
            [weakSelf.tableView reloadData];
        }
    }];
}

@end
