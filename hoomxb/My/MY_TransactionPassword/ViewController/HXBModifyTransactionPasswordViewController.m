//
//  HXBModifyTransactionPasswordViewController.m
//  修改交易密码
//
//  Created by HXB-C on 2017/6/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBModifyTransactionPasswordViewController.h"
#import "HXBModifyTransactionPasswordHomeView.h"
#import "HXBTransactionPasswordConfirmationViewController.h"
#import "HXBModifyTransactionPasswordRequest.h"
#import "HXBModifyPhoneViewController.h"
#import "HXBCallPhone_BottomView.h"
#import "HXBSignUPAndLoginRequest_EnumManager.h"

@interface HXBModifyTransactionPasswordViewController ()

@property (nonatomic, strong) HXBModifyTransactionPasswordHomeView *homeView;

@property (nonatomic, strong) HXBCallPhone_BottomView *callPhoneView;

@end

@implementation HXBModifyTransactionPasswordViewController

#pragma mark - VC的生命周期

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.homeView sendCodeFail];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.isColourGradientNavigationBar = YES;
    [KeyChain downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        self.userInfoModel = viewModel.userInfoModel;
        self.homeView.userInfoModel = viewModel.userInfoModel;
        [self.homeView addSubview:self.callPhoneView];
        [self setupSubViewFrame];
    } andFailure:^(NSError *error) {
        
    }];
    
}

- (void)setupSubViewFrame
{
    [self.callPhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.homeView);
        make.bottom.equalTo(self.homeView).offset(kScrAdaptationH750(-100));
    }];
}

/**
 验证身份证号码

 @param IDCard 身份证号码
 */
- (void)authenticationWithIDCard:(NSString *)IDCard
{
    kWeakSelf
    if ([self.userInfoModel.userInfo.isIdPassed isEqualToString:@"1"]) {
        HXBModifyTransactionPasswordRequest *modifyTransactionPasswordRequest = [[HXBModifyTransactionPasswordRequest alloc] init];
        [modifyTransactionPasswordRequest myTransactionPasswordWithIDcard:IDCard andSuccessBlock:^(id responseObject) {
            NSLog(@"%@",responseObject);
            [weakSelf.homeView idcardWasSuccessfully];
            [weakSelf getValidationCode];
        } andFailureBlock:^(NSError *error) {
            NSLog(@"%@",error);
//            [HxbHUDProgress showTextWithMessage:@"请输入正确的身份证号"];
        }];
    } else {
        [weakSelf.homeView idcardWasSuccessfully];
        [weakSelf getValidationCode];
    }
    
}


/**
 获取验证码
 */
- (void)getValidationCode {
    HXBModifyTransactionPasswordRequest *modifyTransactionPasswordRequest = [[HXBModifyTransactionPasswordRequest alloc] init];
    NSString *action = @"";
    if ([self.title isEqualToString:@"修改交易密码"]){
        action = kTypeKey_tradpwd;
    }else if ([self.title isEqualToString:@"解绑原手机号"]){
        action = kTypeKey_oldmobile;
    }
    [modifyTransactionPasswordRequest myTransactionPasswordWithAction:action andSuccessBlock:^(id responseObject) {
        NSLog(@"获取验证码成功%@",responseObject);
    } andFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        //失败之后立即不去修改获取验证码的状态
        kWeakSelf
        [weakSelf.homeView sendCodeFail];
    }];
    
}

/**
 同时验证身份证和验证码
 */
- (void)verifyWithIDCard:(NSString *)IDCard andCode:(NSString *)code
{
    if (code.length == 0) {
        [HxbHUDProgress showTextWithMessage:@"短信验证码不能为空"];
    } else {
        kWeakSelf
        HXBModifyTransactionPasswordRequest *modifyTransactionPasswordRequest = [[HXBModifyTransactionPasswordRequest alloc] init];
        [modifyTransactionPasswordRequest myTransactionPasswordWithIDcard:IDCard andWithCode:code andSuccessBlock:^(id responseObject) {
            
            [weakSelf checkIdentitySmsSuccessWithIDCard:IDCard andCode:code];
            
        } andFailureBlock:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}

- (void)checkIdentitySmsSuccessWithIDCard:(NSString *)IDCard andCode:(NSString *)code
{
    if ([self.title isEqualToString:@"修改交易密码"]) {
        HXBTransactionPasswordConfirmationViewController *transactionPasswordVC = [[HXBTransactionPasswordConfirmationViewController alloc] init];
        transactionPasswordVC.idcard = IDCard;
        transactionPasswordVC.code = code;
        [self.navigationController pushViewController:transactionPasswordVC animated:YES];
    }else if ([self.title isEqualToString:@"解绑原手机号"]){
        HXBModifyPhoneViewController *modifyPhoneVC = [[HXBModifyPhoneViewController alloc] init];
        [self.navigationController pushViewController:modifyPhoneVC animated:YES];
    }
    
}


#pragma mark - Get方法
- (HXBModifyTransactionPasswordHomeView *)homeView
{
    if (!_homeView) {
        kWeakSelf
        _homeView = [[HXBModifyTransactionPasswordHomeView alloc] initWithFrame:CGRectMake(0, HXBStatusBarAndNavigationBarHeight, kScreenWidth, kScreenHeight - HXBStatusBarAndNavigationBarHeight)];
        
        _homeView.getValidationCodeButtonClickBlock = ^(NSString *IDCard){
            [weakSelf authenticationWithIDCard:IDCard];
//            [weakSelf getValidationCode];
        };
        //点击下一步回调
        _homeView.nextButtonClickBlock = ^(NSString *idCardNo,NSString *verificationCode){
            [weakSelf verifyWithIDCard:idCardNo andCode:verificationCode];
        };
        [self.view addSubview:_homeView];
    }
    return _homeView;
}

- (HXBCallPhone_BottomView *)callPhoneView
{
    if (!_callPhoneView) {
        _callPhoneView = [[HXBCallPhone_BottomView alloc] init];
        _callPhoneView.leftTitle = @"如有疑问，请联系客服";
        _callPhoneView.phoneNumber = kServiceMobile;
//        _callPhoneView.supplementText = @"(周一至周五 9:00-19:00)";
    }
    return _callPhoneView;
}

#pragma mark - set方法
- (void)setUserInfoModel:(HXBUserInfoModel *)userInfoModel
{
    _userInfoModel = userInfoModel;
    self.homeView.userInfoModel = userInfoModel;
}


@end
