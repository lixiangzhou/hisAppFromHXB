//
//  HxbSecurityCertificationViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbSecurityCertificationViewController.h"
#import "HxbSecurityCertificationView.h"
#import "HxbWithdrawCardViewController.h"//绑卡
#import "HXBSecurityCertificationViewModel.h"
@interface HxbSecurityCertificationViewController ()
@property (nonatomic, strong)HXBSecurityCertificationViewModel *viewModel;
@end

@implementation HxbSecurityCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    kWeakSelf
    self.viewModel = [[HXBSecurityCertificationViewModel alloc] initWithBlock:^UIView *{
        return weakSelf.view;
    }];
    self.title = @"安全认证";
    HxbSecurityCertificationView *securityCertificationView = [[HxbSecurityCertificationView alloc]initWithFrame:self.view.frame];
    securityCertificationView.userInfoViewModel = self.userInfoViewModel;
    [self.view addSubview:securityCertificationView];
    
    ///点击了next
    [securityCertificationView clickNextButtonFuncWithBlock:^(NSString *name, NSString *idCard, NSString *transactionPassword,NSString *url) {
        
        //安全认证请求
        [weakSelf.viewModel securityCertification_RequestWithName:name andIdCardNo:idCard andTradpwd:transactionPassword andURL:url andSuccessBlock:^(BOOL isExist) {
            //（获取用户信息）
            [weakSelf.viewModel downLoadUserInfo:YES resultBlock:^(BOOL isSuccess) {
                if (isSuccess) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    //                //是否绑卡
                    //                if (!viewModel.userInfoModel.userInfo.hasBindCard.integerValue) {
                    ////                    HxbBindCardViewController *bindCardVC = [[HxbBindCardViewController alloc]init];
                    ////                    [self.navigationController pushViewController:bindCardVC animated:YES];
                    //
                    //                    HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc]init];
                    //                    withdrawCardViewController.title = @"绑定银行卡";
                    ////                    withdrawCardViewController.amount = self.amountTextField.text;
                    ////                    withdrawCardViewController.userInfoModel = weakSelf.userInfoViewModel.userInfoModel;
                    //                    [self.navigationController pushViewController:withdrawCardViewController animated:YES];
                    //                }else {
                    //                    __block UIViewController *viewController = nil;
                    //                    [self.navigationController.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull VC, NSUInteger idx, BOOL * _Nonnull stop) {
                    //                        if ([VC isKindOfClass:NSClassFromString(self.popToClass)]) {
                    //                            viewController = VC;
                    //                            * stop = YES;
                    //                        }
                    //                    }];
                    //                    [self.navigationController popToViewController:viewController animated:YES];
                    //                }
                }
            }];
        } andFailureBlock:^(NSError *error, NSString *message) {
            
        }];
    }];
}




- (void)didClickSecurityCertificationButton{
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
