//
//  HXBModifyTransactionPasswordViewController.m
//  修改交易密码
//
//  Created by HXB-C on 2017/6/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBModifyTransactionPasswordViewController.h"
#import "HXBModifyTransactionPasswordHomeView.h"
#import "HXBTransactionPasswordConfirmationViewController.h"
#import "HXBModifyTransactionPasswordRequest.h"
@interface HXBModifyTransactionPasswordViewController ()

@property (nonatomic, strong) HXBModifyTransactionPasswordHomeView *homeView;

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
    self.title = @"修改交易密码";
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

/**
 验证身份证号码

 @param IDCard 身份证号码
 */
- (void)authenticationWithIDCard:(NSString *)IDCard
{
    kWeakSelf
    HXBModifyTransactionPasswordRequest *modifyTransactionPasswordRequest = [[HXBModifyTransactionPasswordRequest alloc] init];
    [modifyTransactionPasswordRequest myTransactionPasswordWithIDcard:IDCard andSuccessBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [weakSelf.homeView idcardWasSuccessfully];
        [weakSelf getValidationCode];
        
    } andFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


/**
 获取验证码
 */
- (void)getValidationCode
{
    kWeakSelf
    HXBModifyTransactionPasswordRequest *modifyTransactionPasswordRequest = [[HXBModifyTransactionPasswordRequest alloc] init];
    [modifyTransactionPasswordRequest myTransactionPasswordWithSuccessBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } andFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [weakSelf.homeView sendCodeFail];
    }];
}

/**
 同时验证身份证和验证码
 */
- (void)verifyWithIDCard:(NSString *)IDCard andCode:(NSString *)code
{
    kWeakSelf
    HXBModifyTransactionPasswordRequest *modifyTransactionPasswordRequest = [[HXBModifyTransactionPasswordRequest alloc] init];
    [modifyTransactionPasswordRequest myTransactionPasswordWithIDcard:IDCard andWithCode:code andSuccessBlock:^(id responseObject) {
        
        [weakSelf checkIdentitySmsSuccessWithIDCard:IDCard andCode:code];
        
    } andFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)checkIdentitySmsSuccessWithIDCard:(NSString *)IDCard andCode:(NSString *)code
{
    HXBTransactionPasswordConfirmationViewController *transactionPasswordVC = [[HXBTransactionPasswordConfirmationViewController alloc] init];
    transactionPasswordVC.idcard = IDCard;
    transactionPasswordVC.code = code;
    [self.navigationController pushViewController:transactionPasswordVC animated:YES];}


#pragma mark - Get方法
- (HXBModifyTransactionPasswordHomeView *)homeView
{
    if (!_homeView) {
        kWeakSelf
        _homeView = [[HXBModifyTransactionPasswordHomeView alloc] initWithFrame:self.view.bounds];
        
        _homeView.getValidationCodeButtonClickBlock = ^(NSString *IDCard){
            [weakSelf authenticationWithIDCard:IDCard];
        };
        //点击下一步回调
        _homeView.nextButtonClickBlock = ^(NSString *idCardNo,NSString *verificationCode){
            [weakSelf verifyWithIDCard:idCardNo andCode:verificationCode];
        };
        [self.view addSubview:_homeView];
    }
    return _homeView;
}



#pragma mark - set方法
- (void)setUserInfoModel:(HXBUserInfoModel *)userInfoModel
{
    _userInfoModel = userInfoModel;
    self.homeView.userInfoModel = userInfoModel;
}


@end
