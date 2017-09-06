//
//  HxbMyAccountSecurityViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbMyAccountSecurityViewController.h"

#import "HXBAccount_AlterLoginPassword_ViewController.h"///注册

#import "HxbSignUpViewController.h"///注册
#import "HXBModifyTransactionPasswordViewController.h"//交易密码
#import "HXBModifyGesturePasswordController.h"//修改手势密码
//#import "HxbSecurityCertificationViewController.h"//安全认证
#import "HXBCheckLoginPasswordViewController.h"//验证登录密码
#import "HXBOpenDepositAccountViewController.h"
#import "HxbWithdrawCardViewController.h"
#import "HXBBottomLineTableViewCell.h"
#import "HXBDepositoryAlertViewController.h"
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
        self.idPassedStr = [NSString stringWithFormat:@"%@%@",[model.userInfo.realName replaceStringWithStartLocation:0 lenght:model.userInfo.realName.length - 1],[model.userInfo.idNo replaceStringWithStartLocation:1 lenght:model.userInfo.idNo.length - 2]];
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    self.isColourGradientNavigationBar = YES;
}

#pragma TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    kWeakSelf
    if (indexPath.row == 0) {
        [self modifyPhone];
        
        NSLog(@"click 绑定手机号");
    }else if (indexPath.row == 1) {
        NSLog(@"click 设置登录密码");
        HXBAccount_AlterLoginPassword_ViewController *signUPVC = [[HXBAccount_AlterLoginPassword_ViewController alloc] init];
        signUPVC.type = HXBSignUPAndLoginRequest_sendSmscodeType_forgot;
        [self.navigationController pushViewController: signUPVC animated:true];
    }else if (indexPath.row == 2){
        NSLog(@"click 设置交易密码");
        
        [KeyChain downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
            
            if (viewModel.userInfoModel.userInfo.isUnbundling) {
                [HXBAlertManager callupWithphoneNumber:kServiceMobile andWithMessage:kHXBCallPhone_title];
                return;
            }
            
            if ([viewModel.userInfoModel.userInfo.isCashPasswordPassed isEqualToString:@"1"]) {
                HXBModifyTransactionPasswordViewController *modifyTransactionPasswordVC = [[HXBModifyTransactionPasswordViewController alloc] init];
                modifyTransactionPasswordVC.title = @"修改交易密码";
                modifyTransactionPasswordVC.userInfoModel = self.userInfoViewModel.userInfoModel;
                [weakSelf.navigationController pushViewController:modifyTransactionPasswordVC animated:YES];
            }else
            {
                if (!viewModel.userInfoModel.userInfo.isCreateEscrowAcc) {
                    HXBDepositoryAlertViewController *alertVC = [[HXBDepositoryAlertViewController alloc] init];
                    kWeakSelf
                    alertVC.immediateOpenBlock = ^{
                        HXBOpenDepositAccountViewController *openDepositAccountVC = [[HXBOpenDepositAccountViewController alloc] init];
                        openDepositAccountVC.title = @"开通存管账户";
//                        openDepositAccountVC.userModel = viewModel;
                        openDepositAccountVC.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
                        [weakSelf.navigationController pushViewController:openDepositAccountVC animated:YES];
                    };
                    [weakSelf presentViewController:alertVC animated:NO completion:nil];
                }else
                {
                    HXBOpenDepositAccountViewController *openDepositAccountVC = [[HXBOpenDepositAccountViewController alloc] init];
                    openDepositAccountVC.title = @"完善信息";
                    openDepositAccountVC.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
                    [weakSelf.navigationController pushViewController:openDepositAccountVC animated:YES];
                }
            }
        } andFailure:^(NSError *error) {
            
        }];
        
    }else if (indexPath.row == 3){
        HXBCheckLoginPasswordViewController *checkLoginPasswordVC = [[HXBCheckLoginPasswordViewController alloc] init];
        [self.navigationController pushViewController:checkLoginPasswordVC animated:YES];
        NSLog(@"click 设置手势密码");
    }
    
}

- (void)modifyPhone
{
    kWeakSelf
    [KeyChain downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        weakSelf.userInfoViewModel = viewModel;
        if (!viewModel.userInfoModel.userInfo.isCreateEscrowAcc) {
            if ([viewModel.userInfoModel.userInfo.isMobilePassed isEqualToString:@"1"]) {
                [weakSelf getintoModifyPhone];
            }
        } else {
            if (viewModel.userInfoModel.userInfo.isUnbundling) {
                [HXBAlertManager callupWithphoneNumber:kServiceMobile andWithMessage:kHXBCallPhone_title];
                return;
            }
            if ([viewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"]) {
                if ([viewModel.userInfoModel.userInfo.isMobilePassed isEqualToString:@"1"]) {
                    [weakSelf getintoModifyPhone];
                }
            } else {
                if ([viewModel.userInfoModel.userInfo.isCashPasswordPassed isEqualToString:@"1"]) {
                    HXBXYAlertViewController *alertVC = [[HXBXYAlertViewController alloc] initWithTitle:@"温馨提示" Massage:@"修改手机号，需先绑定银行卡。" force:2 andLeftButtonMassage:@"暂不绑定" andRightButtonMassage:@"立即绑定"];
                    alertVC.messageHeight = 40;
                    [alertVC setClickXYRightButtonBlock:^{
                        //进入绑卡界面
                        HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc]init];
                        withdrawCardViewController.title = @"绑卡";
                        withdrawCardViewController.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
                        [weakSelf.navigationController pushViewController:withdrawCardViewController animated:YES];
                    }];
                    [alertVC setClickXYLeftButtonBlock:^{
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }];
                    [self presentViewController:alertVC animated:YES completion:nil];
                } else {
                    HXBXYAlertViewController *alertVC = [[HXBXYAlertViewController alloc] initWithTitle:@"温馨提示" Massage:@"信息不完善" force:2 andLeftButtonMassage:@"暂不完善" andRightButtonMassage:@"去完善信息"];
                    alertVC.messageHeight = 40;
                    [alertVC setClickXYRightButtonBlock:^{
                    //完善信息
                    HXBOpenDepositAccountViewController *openDepositAccountVC = [[HXBOpenDepositAccountViewController alloc] init];
                    openDepositAccountVC.title = @"完善信息";
                    openDepositAccountVC.type = HXBChangePhone;
//                    openDepositAccountVC.userModel = self.userInfoViewModel;
                    [weakSelf.navigationController pushViewController:openDepositAccountVC animated:YES];
                    }];
                    [alertVC setClickXYLeftButtonBlock:^{
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }];
                    [self presentViewController:alertVC animated:YES completion:nil];
                }
                
            }
        }
        
    } andFailure:^(NSError *error) {
    }];
    
}

- (void)getintoModifyPhone
{
    HXBModifyTransactionPasswordViewController *modifyTransactionPasswordVC = [[HXBModifyTransactionPasswordViewController alloc] init];
    modifyTransactionPasswordVC.title = @"解绑原手机号";
    modifyTransactionPasswordVC.userInfoModel = self.userInfoViewModel.userInfoModel;
    [self.navigationController pushViewController:modifyTransactionPasswordVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScrAdaptationH(45);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kScrAdaptationH(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001;
}

#pragma TableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *celledStr = @"celled";
    HXBBottomLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celledStr ];
    if (cell == nil) {
        cell = [[HXBBottomLineTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:celledStr];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
        cell.textLabel.textColor = COR6;
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"修改手机号";
    }else if (indexPath.row == 1) {
        cell.textLabel.text = @"登录密码";
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"交易密码";
    }else if(indexPath.row == 3){
        cell.textLabel.text = @"手势密码";
        cell.hiddenLine = YES;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView  alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


@end
