//
//  HXBExtensionMethodTool.m
//  hoomxb
//
//  Created by HXB-C on 2018/6/13.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBExtensionMethodTool.h"
#import "BannerModel.h"
#import "HXBNoticeViewController.h"
#import "HXBFinancing_PlanDetailsViewController.h"
#import "HXBBaseViewController.h"
#import "HXBFinancing_LoanDetailsViewController.h"
#import "HXBFin_DetailLoanTruansfer_ViewController.h"
#import "HXBRootVCManager.h"
#import "HXBBannerWebViewController.h"
#import "HXBBannerViewModel.h"
@implementation HXBExtensionMethodTool

// 点击benner跳转的方法(公告列表，详情，计划列表) H5
+ (void)pushToViewControllerWithModel:(BannerModel *)model andWithFromVC:(HXBBaseViewController *)comeFromVC{
    
    __block HXBBaseViewController *vc;
    if ([model.type isEqualToString:@"native"]) {
        [model.link parseUrlParam:^(NSString *path, NSDictionary *paramDic) {
            if ([path isEqualToString:kNoticeVC]) { // 公告列表页
                HXBNoticeViewController *noticeVC = [HXBNoticeViewController new];
                vc = noticeVC;
            } else if ([path isEqualToString:kPlanDetailVC]) { // 计划详情
                HXBFinancing_PlanDetailsViewController *planVC = [HXBFinancing_PlanDetailsViewController new];
                planVC.planID = paramDic[@"productId"];
                planVC.isPlan = YES;
                planVC.isFlowChart = YES;
                vc = planVC;
            } else if ([path isEqualToString:kLoanDetailVC]) { // 散标详情
                HXBFinancing_LoanDetailsViewController *loadVC = [HXBFinancing_LoanDetailsViewController new];
                loadVC.loanID = paramDic[@"productId"];
                loadVC.isFlowChart = YES;
                vc = loadVC;
            } else if ([path isEqualToString:kLoanTransferDetailVC]) { // 债权详情
                HXBFin_DetailLoanTruansfer_ViewController *loanTruansferVC = [HXBFin_DetailLoanTruansfer_ViewController new];
                loanTruansferVC.loanID = paramDic[@"productId"];
                loanTruansferVC.isFlowChart = YES;
                vc = loanTruansferVC;
            } else if ([path isEqualToString:kPlan_fragment]) { // 计划列表
                [HXBRootVCManager manager].mainTabbarVC.selectedIndex = 1;
            } else if ([path isEqualToString:kRegisterVC]) { //跳转登录注册
                [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowSignUpVC object:nil];
            } else if ([path isEqualToString:kLoginVC]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
            }
        }];
        
    } else if ([model.type isEqualToString:@"h5"]){
        if (model.link.length) {
            HXBBannerWebViewController *webViewVC = [[HXBBannerWebViewController alloc] init];
            webViewVC.pageUrl = model.link;
            webViewVC.model = model;
            vc = webViewVC;
        }
        
    } else if ([model.type isEqualToString:@"broswer"]) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:model.link]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.link]];
        }
    }
    [comeFromVC.navigationController pushViewController:vc animated:YES];
}


@end
