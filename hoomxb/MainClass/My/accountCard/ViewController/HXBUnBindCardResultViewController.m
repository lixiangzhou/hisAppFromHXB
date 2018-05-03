//
//  HXBUnBindCardResultViewController.m
//  hoomxb
//
//  Created by hxb on 2018/4/28.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//  解绑卡结果页

#import "HXBUnBindCardResultViewController.h"
#import "HXBCommonResultController.h"
#import "HXBLazyCatResponseDelegate.h"
#import "HXBLazyCatResponseModel.h"
#import "HxbWithdrawCardViewController.h"
#import "HxbAccountInfoViewController.h"
#import "HxbMyBankCardViewController.h"

@interface HXBUnBindCardResultViewController ()<HXBLazyCatResponseDelegate>
@property (nonatomic,strong) HXBCommonResultController *commonResultVC;
@end

@implementation HXBUnBindCardResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - HXBLazyCatResponseDelegate
- (void)setResultPageProperty:(HXBLazyCatResponseModel *)model {
    kWeakSelf
    self.commonResultVC = [[HXBCommonResultController alloc]init];
    HXBCommonResultContentModel *commonResultModel = nil;
    
    if ([model.result isEqualToString:@"success"]) { //成功
        commonResultModel = [[HXBCommonResultContentModel alloc]initWithImageName:@"successful" titleString:model.data.title descString:model.data.content firstBtnTitle: @"绑定新银行卡"];
        
        commonResultModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
            //重新绑卡 进入绑卡界面
            HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc] init];
            withdrawCardViewController.title = @"绑卡";
            withdrawCardViewController.className = @"HxbAccountInfoViewController";
            withdrawCardViewController.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
            [weakSelf.navigationController pushViewController:withdrawCardViewController animated:YES];
        };
        commonResultModel.secondBtnTitle = @"完成";
        commonResultModel.secondBtnBlock = ^(HXBCommonResultController *resultController) {
            //返回 账户信息列表页
            __block HxbAccountInfoViewController *accountVC = nil;
            [self.navigationController.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[HxbAccountInfoViewController class]]) {
                    accountVC = obj;
                }
                if (accountVC) {
                    *stop = YES;
                }
            }];
            
            if (accountVC) {
                [weakSelf.navigationController popToViewController:accountVC animated:YES];
            }
        };
        
    } else if ([model.result isEqualToString:@"error"]){ //失败
        commonResultModel = [[HXBCommonResultContentModel alloc]initWithImageName:@"failure" titleString:model.data.title descString:model.data.content firstBtnTitle: @"重新解绑"];
        commonResultModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
            //返回解绑卡页面
            __block HxbMyBankCardViewController *myBankCardVC = nil;
            [self.navigationController.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[HxbMyBankCardViewController class]]) {
                    myBankCardVC = obj;
                }
                if (myBankCardVC) {
                    *stop = YES;
                }
            }];
            
            if (myBankCardVC) {
                [weakSelf.navigationController popToViewController:myBankCardVC animated:YES];
            }
        };
    }else if ([model.result isEqualToString:@"timeout"]) { //超时
        commonResultModel = [[HXBCommonResultContentModel alloc]initWithImageName:@"outOffTime" titleString:model.data.title descString:model.data.content firstBtnTitle: @"返回"];
        commonResultModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
            //返回 账户信息列表页
            __block HxbAccountInfoViewController *accountVC = nil;
            [self.navigationController.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[HxbAccountInfoViewController class]]) {
                    accountVC = obj;
                }
                if (accountVC) {
                    *stop = YES;
                }
            }];
            
            if (accountVC) {
                [weakSelf.navigationController popToViewController:accountVC animated:YES];
            }
        };
    }
    
    self.commonResultVC.contentModel = commonResultModel;
    [self.view addSubview: self.commonResultVC.view];
}

- (void)leftBackBtnClick {
    //返回解绑卡前一个界面
    int i = 0;
    for (; i<self.navigationController.viewControllers.count; i++) {
        if ([self.navigationController.viewControllers[i] isKindOfClass:NSClassFromString(@"HxbAccountInfoViewController")]) {
            break;
        }
    }
    if (i>0) {
        [self.navigationController popToViewController:self.navigationController.viewControllers[i-1] animated:YES];
    }
}

@end
