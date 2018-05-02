//
//  HXBOpenDepositoryResultController.m
//  hoomxb
//
//  Created by lxz on 2018/5/2.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBOpenDepositoryResultController.h"
#import "HXBLazyCatResponseDelegate.h"
#import "HXBLazyCatResponseModel.h"
#import "HxbMyTopUpViewController.h"
#import "HXBRootVCManager.h"
#import "HxbAccountInfoViewController.h"

@interface HXBOpenDepositoryResultController () <HXBLazyCatResponseDelegate>
@property (nonatomic, weak) UIViewController *popVC;
@end

@implementation HXBOpenDepositoryResultController

- (void)setResultPageProperty:(HXBLazyCatResponseModel *)model {
    self.contentModel = [HXBCommonResultContentModel new];
    self.contentModel.titleString = model.data.title;
    self.contentModel.descString = model.data.content;
    
    if ([model.result isEqualToString:@"success"]) {
        self.contentModel.imageName = @"";
        
        self.contentModel.firstBtnTitle = @"去充值";
        self.contentModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
            HxbMyTopUpViewController *VC = [HxbMyTopUpViewController new];
            [resultController.navigationController pushViewController:VC animated:YES];
        };
        
        self.contentModel.secondBtnTitle = @"先逛逛";
        self.contentModel.secondBtnBlock = ^(HXBCommonResultController *resultController) {
            [HXBRootVCManager manager].mainTabbarVC.selectedIndex = 0;
            [resultController.navigationController popToRootViewControllerAnimated:NO];
        };
    } else if ([model.result isEqualToString:@"error"]) {
        self.contentModel.imageName = @"";
        
        self.contentModel.firstBtnTitle = @"返回";
        self.contentModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
            [resultController.navigationController popToViewController:self.popVC animated:YES];
        };
    } else if ([model.result isEqualToString:@"timeout"]) {
        self.contentModel.imageName = @"";
        
        self.contentModel.firstBtnTitle = @"我的账户";
        self.contentModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
            [KeyChain downLoadUserInfoWithRequestBlock:^(NYBaseRequest *request) {
                request.showHud = YES;
                [HXBRootVCManager manager].mainTabbarVC.selectedIndex = 0;
                [resultController.navigationController popToRootViewControllerAnimated:NO];
            } resultBlock:^(HXBRequestUserInfoViewModel *viewModel, NSError *error) {
                if (error == nil) {
                    HxbAccountInfoViewController *accountInfoVC = [[HxbAccountInfoViewController alloc]init];
                    accountInfoVC.userInfoViewModel = viewModel;
                    accountInfoVC.isDisplayAdvisor = viewModel.userInfoModel.userInfo.isDisplayAdvisor;
                    [resultController.navigationController pushViewController:accountInfoVC animated:YES];
                }
            }];
        };
    }
}

- (void)leftBackBtnClick {
    [self.navigationController popToViewController:self.popVC animated:YES];
}

- (void)setResultPageWithPopViewControllers:(NSArray *)vcArray {
    self.popVC = vcArray.firstObject;
}
@end
