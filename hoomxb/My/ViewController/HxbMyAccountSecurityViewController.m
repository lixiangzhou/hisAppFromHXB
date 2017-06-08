//
//  HxbMyAccountSecurityViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbMyAccountSecurityViewController.h"
#import "HXBAccount_AlterLoginPassword_ViewController.h"///注册
@interface HxbMyAccountSecurityViewController ()
<
UITableViewDataSource,UITableViewDelegate
>
@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic,copy) NSString *idPassedStr;
@property (nonatomic,copy) NSString *phonNumber;
@end

@implementation HxbMyAccountSecurityViewController
#pragma mark - setter
- (void)setUserInfoViewModel:(HXBRequestUserInfoViewModel *)userInfoViewModel {
    _userInfoViewModel = userInfoViewModel;
    ///是否安全认证
    HXBUserInfoModel *model = self.userInfoViewModel.userInfoModel;
    if (model.userInfo.isIdPassed) {
        self.idPassedStr = [NSString stringWithFormat:@"%@%@",model.userInfo.realName,model.userInfo.idNo];
    }else {
        self.idPassedStr = @"去认证";
    }
    self.phonNumber = [model.userInfo.mobile hxb_hiddenPhonNumberWithMid];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户安全";
    [self.view addSubview:self.tableView];
    self.hxb_automaticallyAdjustsScrollViewInsets = true;
}

#pragma TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {//表示安全认证
        }
        if (indexPath.row == 1) {//点击绑定手机号
            NSLog(@"click 绑定手机号");
            
        }
    }else if(indexPath.section == 1){
        
        if (indexPath.row == 0) {
            NSLog(@"click 设置登录密码");
            HXBAccount_AlterLoginPassword_ViewController *signUPVC = [[HXBAccount_AlterLoginPassword_ViewController alloc] init];
            signUPVC.type = HXBSignUPAndLoginRequest_sendSmscodeType_forgot;
            [self.navigationController pushViewController: signUPVC animated:true];
        }else if (indexPath.row == 1){
            NSLog(@"click 设置交易密码");
        }else{
            NSLog(@"click 设置手势密码");
        }
        
    }else{

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
       if (indexPath.section == 0){

        if (indexPath.row == 0) {
            cell.textLabel.text = @"安全认证";
            cell.detailTextLabel.text = self.idPassedStr;
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"绑定手机号";
            cell.detailTextLabel.text = self.phonNumber;
        }
    }else{
        if (indexPath.row == 0) {
            cell.textLabel.text = @"登录密码";
            cell.detailTextLabel.text = @"修改";
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"交易密码";
            cell.detailTextLabel.text = @"修改";
        }else{
            cell.textLabel.text = @"手势密码";
            cell.detailTextLabel.text = @"修改";
        }

    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  (section == 0)? 2 : 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView  alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


@end
