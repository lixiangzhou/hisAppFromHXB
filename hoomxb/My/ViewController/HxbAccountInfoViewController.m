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
@interface HxbAccountInfoViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HXBRequestUserInfoViewModel *userInfoViewModel;
@end

@implementation HxbAccountInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户信息";
    [self.view addSubview:self.tableView];
    self.hxb_automaticallyAdjustsScrollViewInsets = true;
}

#pragma TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
    }else if(indexPath.section == 1){
        
        if (indexPath.row == 0) {
            //账户安全
            HxbMyBankCardViewController *myBankCardViewVC = [[HxbMyBankCardViewController alloc]init];
            [self.navigationController pushViewController:myBankCardViewVC animated:YES];
        }else if (indexPath.row == 1){
            HxbMyAccountSecurityViewController *myAccountSecurityVC = [[HxbMyAccountSecurityViewController alloc]init];
             myAccountSecurityVC.userInfoViewModel = self.userInfoViewModel;
            [self.navigationController pushViewController:myAccountSecurityVC animated:YES];
        }else{

        }
        
    }else{
        HxbMyAboutMeViewController *myAboutMeViewController = [[HxbMyAboutMeViewController alloc]init];
        [self.navigationController pushViewController:myAboutMeViewController animated:YES];
    }
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celledStr ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:celledStr];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.textLabel.text = @"Hxb00001";
        cell.imageView.image = [UIImage imageNamed:@"1"];

    }else if (indexPath.section == 1){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 0) {
           cell.textLabel.text = @"银行卡";
        }else if (indexPath.row == 1){
           cell.textLabel.text = @"账户安全";
        }else{
           cell.textLabel.text = @"风险评测";
        }
    }else{
        cell.textLabel.text = @"关于我们";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  (section == 0)? 1 : (section == 1)? 3:1;;
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
- (void)loadData_userInfo {
    [HXBRequestUserInfo downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        self.userInfoViewModel = viewModel;
    } andFailure:^(NSError *error) {
        NSLog(@"%@",self);
    }];
}

@end
