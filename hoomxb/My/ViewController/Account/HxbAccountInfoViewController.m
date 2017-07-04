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
@interface HxbAccountInfoViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) HXBRequestUserInfoViewModel *userInfoViewModel;
@end

@implementation HxbAccountInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户信息";
    [self.view addSubview:self.tableView];
    self.hxb_automaticallyAdjustsScrollViewInsets = true;
//    [self loadData_userInfo];///加载用户数据
    
}

#pragma TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
    }else if(indexPath.section == 1){
        if ([self.userInfoViewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"]){
            if (indexPath.row == 0) {
                //银行卡
                HxbMyBankCardViewController *myBankCardViewVC = [[HxbMyBankCardViewController alloc]init];
                [self.navigationController pushViewController:myBankCardViewVC animated:YES];
            }else if (indexPath.row == 1){
                HxbMyAccountSecurityViewController *myAccountSecurityVC = [[HxbMyAccountSecurityViewController alloc]init];
                myAccountSecurityVC.userInfoViewModel = self.userInfoViewModel;
                [self.navigationController pushViewController:myAccountSecurityVC animated:YES];
            }else{
                NSLog(@"点击了风险评测");
                
                [self entryRiskAssessment];
            }
        }else
        {
            if (indexPath.row == 0) {
                HxbMyAccountSecurityViewController *myAccountSecurityVC = [[HxbMyAccountSecurityViewController alloc]init];
                myAccountSecurityVC.userInfoViewModel = self.userInfoViewModel;
                [self.navigationController pushViewController:myAccountSecurityVC animated:YES];
            }else if (indexPath.row == 1){
                NSLog(@"点击了风险评测");
                [self entryRiskAssessment];
            }
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
        if ([self.userInfoViewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"]) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"银行卡";
            }else if (indexPath.row == 1){
                cell.textLabel.text = @"账户安全";
            }else{
                cell.textLabel.text = @"风险评测";
                if ([self.userInfoViewModel.userInfoModel.userInfo.riskType isEqualToString:@"未评测"]) {
                    cell.detailTextLabel.text = @"立即评测";
                }else
                {
                    cell.detailTextLabel.text = self.userInfoViewModel.userInfoModel.userInfo.riskType;
                }
            }
        }else
        {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"账户安全";
            }else if (indexPath.row == 1){
                cell.textLabel.text = @"风险评测";
                if ([self.userInfoViewModel.userInfoModel.userInfo.riskType isEqualToString:@"未评测"]) {
                    cell.detailTextLabel.text = @"立即评测";
                }else
                {
                    cell.detailTextLabel.text = self.userInfoViewModel.userInfoModel.userInfo.riskType;
                }
            }
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
            if ([self.userInfoViewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"]) {
                return 3;
            }else
            {
                return 2;
            }
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
        _tableView = [[UITableView  alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark - 加载数据
//- (void)loadData_userInfo {
//    kWeakSelf
//    [HXBRequestUserInfo downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
//        weakSelf.userInfoViewModel = viewModel;
//    } andFailure:^(NSError *error) {
//        NSLog(@"%@",self);
//    }];
//}

@end
