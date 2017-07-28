//
//  HxbAccountInfoViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbAccountInfoViewController.h"
#import "HxbMyBankCardViewController.h"
#import "HxbMyAccountSecurityViewController.h"
#import "HxbMyAboutMeViewController.h"
#import "HXBRequestUserInfo.h"
#import "HXBRiskAssessmentViewController.h"
#import "HXBOpenDepositAccountViewController.h"
#import "HXBBaseTabBarController.h"
#import "HxbMyViewController.h"
@interface HxbAccountInfoViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *signOutButton;
//@property (nonatomic, strong) HXBRequestUserInfoViewModel *userInfoViewModel;
@end

@implementation HxbAccountInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户信息";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.signOutButton];
    self.hxb_automaticallyAdjustsScrollViewInsets = true;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isColourGradientNavigationBar = YES;
    [self loadData_userInfo];///加载用户数据
}

#pragma TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            HXBOpenDepositAccountViewController *openDepositAccountVC = [[HXBOpenDepositAccountViewController alloc] init];
            
            
            
            if (!self.userInfoViewModel.userInfoModel.userInfo.isCreateEscrowAcc) {
                //开通存管银行账户
                openDepositAccountVC.title = @"开通存管账户";
                openDepositAccountVC.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
                [self.navigationController pushViewController:openDepositAccountVC animated:YES];
            }else if ([self.userInfoViewModel.userInfoModel.userInfo.isCashPasswordPassed isEqualToString:@"1"])
            {
                //已开通
                HxbMyBankCardViewController *myBankCardViewVC = [[HxbMyBankCardViewController alloc]init];
                [self.navigationController pushViewController:myBankCardViewVC animated:YES];
            }else{
                //完善信息
                openDepositAccountVC.title = @"完善信息";
                openDepositAccountVC.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
                [self.navigationController pushViewController:openDepositAccountVC animated:YES];
            }
            
        }else if (indexPath.row == 1){
            HxbMyAccountSecurityViewController *myAccountSecurityVC = [[HxbMyAccountSecurityViewController alloc]init];
            myAccountSecurityVC.userInfoViewModel = self.userInfoViewModel;
            [self.navigationController pushViewController:myAccountSecurityVC animated:YES];
        }else{
            NSLog(@"点击了风险评测");
            [self entryRiskAssessment];
        }
        
    }else{
        HxbMyAboutMeViewController *myAboutMeViewController = [[HxbMyAboutMeViewController alloc]init];
        [self.navigationController pushViewController:myAboutMeViewController animated:YES];
    }
}

- (void)entryRiskAssessment
{
    HXBRiskAssessmentViewController *riskAssessmentVC = [[HXBRiskAssessmentViewController alloc] init];
    [self.navigationController pushViewController:riskAssessmentVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (indexPath.section == 0)?64:(indexPath.section == 1)?44:44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 20;
    }else{
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}

#pragma TableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *celledStr = @"celled";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celledStr];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:celledStr];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.textLabel.text = self.userInfoViewModel.userInfoModel.userInfo.username;
        cell.imageView.image = [UIImage imageNamed:@"1"];

    }else if (indexPath.section == 1){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 0) {
            cell.textLabel.text = @"恒丰银行存管账户";
            if (!self.userInfoViewModel.userInfoModel.userInfo.isCreateEscrowAcc) {
                //开通存管银行账户
                cell.detailTextLabel.text = @"未开通";
            }else if ([self.userInfoViewModel.userInfoModel.userInfo.isCashPasswordPassed isEqualToString:@"1"])
            {
                //已开通
                 cell.detailTextLabel.text = @"已开通";
            }else{
                //完善信息
                 cell.detailTextLabel.text = @"完善信息";
            }
            
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"账户安全";
        }else{
            cell.textLabel.text = @"风险评测";
            cell.detailTextLabel.text = self.userInfoViewModel.userInfoModel.userInfo.riskType;
        }
    }else{
        cell.textLabel.text = @"关于我们";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return  (section == 0)? 1 : (section == 1)? 3:1;
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
        {
            return 3;
        }
            break;
        case 2:
            return 1;
            break;
 
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView  alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
//登出按钮事件
- (void)signOutButtonButtonClick:(UIButton *)sender{
    kWeakSelf
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"%@",action.title);
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [KeyChain signOut];
        [(HXBBaseTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController setSelectedIndex:0];
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    //    UIViewController *VC =[[UIViewController alloc]init];
    //    VC.view.backgroundColor = [UIColor redColor];
    //    [self.navigationController pushViewController:VC animated:true];
}

//登出按钮
- (UIButton *)signOutButton{
    if (!_signOutButton) {
        _signOutButton = [UIButton btnwithTitle:@"退出当前账号" andTarget:self andAction:@selector(signOutButtonButtonClick:) andFrameByCategory:CGRectMake(20, SCREEN_HEIGHT - 64 - 44 - 20, SCREEN_WIDTH - 40, 44)];
    }
    return _signOutButton;
}

#pragma mark - 加载数据
- (void)loadData_userInfo {
    kWeakSelf
    [HXBRequestUserInfo downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        weakSelf.userInfoViewModel = viewModel;
        [weakSelf.tableView reloadData];
    } andFailure:^(NSError *error) {
        NSLog(@"%@",self);
    }];
}

@end
