//
//  HxbSecurityCertificationViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbSecurityCertificationViewController.h"
#import "HxbSecurityCertificationView.h"
#import "HxbBindCardViewController.h"
#import "HXBSignUPAndLoginRequest.h"//网络请求
#import "HXBSecurityCertification_Request.h"
@interface HxbSecurityCertificationViewController ()
@end

@implementation HxbSecurityCertificationViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"安全认证";
    HxbSecurityCertificationView *securityCertificationView = [[HxbSecurityCertificationView alloc]initWithFrame:self.view.frame];
    securityCertificationView.userInfoViewModel = self.userInfoViewModel;
    [self.view addSubview:securityCertificationView];
    
    ///点击了next
    [securityCertificationView clickNextButtonFuncWithBlock:^(NSString *name, NSString *idCard, NSString *transactionPassword) {
        
        //安全认证请求
        [HXBSecurityCertification_Request securityCertification_RequestWithName:name andIdCardNo:idCard andTradpwd:transactionPassword andSuccessBlock:^(BOOL isExist) {
            //（获取用户信息）
            [HXBRequestUserInfo downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
                //是否绑卡
                if (!viewModel.userInfoModel.userInfo.hasBindCard.integerValue) {
                    HxbBindCardViewController *bindCardVC = [[HxbBindCardViewController alloc]init];
                    [self.navigationController pushViewController:bindCardVC animated:YES];
                }else {
                    [self dismissViewControllerAnimated:true completion:nil];
                }
            } andFailure:^(NSError *error) {
                
            }];

        } andFailureBlock:^(NSError *error, NSString *message) {
            
        }];
    }];
   
}

- (void)requestSecurityCertification {
}


- (void)didClickSecurityCertificationButton{
}

@end
