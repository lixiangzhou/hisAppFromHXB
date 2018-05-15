//
//  HxbMyAccountSecurityViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbMyAccountSecurityViewController.h"

#import "HXBAccount_AlterLoginPassword_ViewController.h"///注册

#import "HxbSignUpViewController.h"///注册
#import "HXBModifyTransactionPasswordViewController.h"//交易密码
//#import "HxbSecurityCertificationViewController.h"//安全认证
#import "HXBCheckLoginPasswordViewController.h"//验证登录密码
#import "HxbWithdrawCardViewController.h"
#import "HXBBottomLineTableViewCell.h"
#import "HXBDepositoryAlertViewController.h"
#import "HXBAccountSecureCell.h"
#import "HXBMyAccountSecurityViewModel.h"
#import "HXBLazyCatAccountWebViewController.h"
#import "HXBOpenDepositAccountViewController.h"

@interface HxbMyAccountSecurityViewController ()
<
UITableViewDataSource,UITableViewDelegate
>
@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic,copy) NSString *idPassedStr;
@property (nonatomic,copy) NSString *phonNumber;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) HXBMyAccountSecurityViewModel *viewModel;
@end

@implementation HxbMyAccountSecurityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    kWeakSelf
    self.viewModel = [[HXBMyAccountSecurityViewModel alloc] initWithBlock:^UIView *{
        return weakSelf.view;
    }];
    self.title = @"账户安全";
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self prepareData];
    [self.tableView reloadData];
    
    self.isColourGradientNavigationBar = YES;
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.viewModel hiddenHFBank];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HXBAccountSecureModel *model = self.dataSource[indexPath.row];
    kWeakSelf
    if (model.type == HXBAccountSecureTypeModifyPhone) {
        [self modifyPhone];
    }
    else if (model.type == HXBAccountSecureTypeLoginPwd) {
        [self.viewModel downLoadUserInfo:YES resultBlock:^(BOOL isSuccess) {
            if (isSuccess) {
                HXBAccount_AlterLoginPassword_ViewController *signUPVC = [[HXBAccount_AlterLoginPassword_ViewController alloc] init];
                signUPVC.type = HXBSignUPAndLoginRequest_sendSmscodeType_forgot;
                [weakSelf.navigationController pushViewController: signUPVC animated:YES];
            }
        }];
    }
    else if (model.type == HXBAccountSecureTypeTransactionPwd){
        [self modifyTransactionPwd];
    }
    else if (model.type == HXBAccountSecureTypeGesturePwdModify){
        HXBCheckLoginPasswordViewController *checkLoginPasswordVC = [[HXBCheckLoginPasswordViewController alloc] init];
        checkLoginPasswordVC.switchType = HXBAccountSecureSwitchTypeChange;
        [self.navigationController pushViewController:checkLoginPasswordVC animated:YES];
    }
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

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HXBAccountSecureCell *cell = [tableView dequeueReusableCellWithIdentifier:HXBAccountSecureCellID forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    cell.hiddenLine = self.dataSource.count == indexPath.row + 1;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataSource.count;
}

#pragma mark - Helper
- (void)prepareData {
    NSMutableArray *data = [NSMutableArray new];
    [data addObject:@{@"type":@(HXBAccountSecureTypeModifyPhone), @"title": @"修改手机号"}];
    [data addObject:@{@"type":@(HXBAccountSecureTypeLoginPwd), @"title": @"登录密码"}];
    [data addObject:@{@"type":@(HXBAccountSecureTypeTransactionPwd), @"title": @"交易密码"}];
    [data addObject:@{@"type":@(HXBAccountSecureTypeGesturePwdSwitch), @"title": @"手势密码"}];
    
    if ([KeyChain.skipGesture isEqual:kHXBGesturePwdSkipeNO]) {
        [data addObject:@{@"type":@(HXBAccountSecureTypeGesturePwdModify), @"title": @"修改手势密码"}];
    }
    
    self.dataSource = [NSMutableArray arrayWithCapacity:data.count];
    for (NSInteger i = 0; i < data.count; i++) {
        NSDictionary *dict = data[i];
        
        HXBAccountSecureModel *model = [HXBAccountSecureModel yy_modelWithJSON:dict];
        if (model.type == HXBAccountSecureTypeGesturePwdSwitch) {
            model.switchBlock = ^(BOOL isOn) {
                HXBCheckLoginPasswordViewController *checkLoginPasswordVC = [[HXBCheckLoginPasswordViewController alloc] init];
                checkLoginPasswordVC.switchType = isOn ? HXBAccountSecureSwitchTypeOn : HXBAccountSecureSwitchTypeOff;
                [self.navigationController pushViewController:checkLoginPasswordVC animated:YES];
            };
        }
        
        [self.dataSource addObject:model];
    }
}

- (void)modifyTransactionPwd {

    // TODO: 跳转到恒丰存管修改交易密码
    kWeakSelf
    [self.viewModel downLoadUserInfo:YES resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            if (!weakSelf.userInfoViewModel.userInfoModel.userInfo.isCreateEscrowAcc) {
                HXBDepositoryAlertViewController *alertVC = [[HXBDepositoryAlertViewController alloc] init];
                alertVC.immediateOpenBlock = ^{
                    HXBOpenDepositAccountViewController *openDepositAccountVC = [[HXBOpenDepositAccountViewController alloc] init];
                    openDepositAccountVC.title = @"开通存管账户";
                    openDepositAccountVC.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
                    [weakSelf.navigationController pushViewController:openDepositAccountVC animated:YES];
                };
                [self presentViewController:alertVC animated:NO completion:nil];
            }
            else{
                [self.viewModel modifyTransactionPasswordResultBlock:^(BOOL isSuccess) {
                    if(isSuccess) {
                        HXBLazyCatAccountWebViewController* vc = [[HXBLazyCatAccountWebViewController alloc] init];
                        vc.requestModel = weakSelf.viewModel.lazyCatRequestModel;
                        [weakSelf.navigationController pushViewController:vc animated:YES];
                    }
                }];
            }
        }
    }];
}

- (void)modifyPhone
{
    kWeakSelf
    [self.viewModel downLoadUserInfo:YES resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.userInfoViewModel = weakSelf.viewModel.userInfoModel;
            if ([weakSelf.userInfoViewModel.userInfoModel.userInfo.isMobilePassed isEqualToString:@"1"]) {
                [weakSelf getintoModifyPhone];
            }
        }
    }];
}

- (void)getintoModifyPhone
{
    HXBModifyTransactionPasswordViewController *modifyTransactionPasswordVC = [[HXBModifyTransactionPasswordViewController alloc] init];
    modifyTransactionPasswordVC.title = @"解绑原手机号";
    modifyTransactionPasswordVC.userInfoModel = self.userInfoViewModel.userInfoModel;
    [self.navigationController pushViewController:modifyTransactionPasswordVC animated:YES];
}

#pragma mark - Setter、Lazy
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

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView  alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[HXBAccountSecureCell class] forCellReuseIdentifier:HXBAccountSecureCellID];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
    }
    return _tableView;
}

@end
