//
//  HXBUnBindCardResultViewController.m
//  hoomxb
//
//  Created by hxb on 2018/4/28.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//  解绑卡结果页

#import "HXBUnBindCardResultViewController.h"
#import "HXBLazyCatResponseDelegate.h"
#import "HXBLazyCatResponseModel.h"
#import "HxbWithdrawCardViewController.h"
#import "HxbAccountInfoViewController.h"
#import "HxbMyBankCardViewController.h"
#import "HXBCommonResultController.h"
@interface HXBUnBindCardResultViewController ()<HXBLazyCatResponseDelegate>
@property (nonatomic,strong) HXBCommonResultController *commonResultVC;
@property (nonatomic,strong) HXBLazyCatResponseModel *responseModel;
@end

@implementation HXBUnBindCardResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAction];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 禁用全屏滑动手势
    ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 恢复全屏滑动手势
    ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = YES;
}

- (void)setAction {
    kWeakSelf
    HXBCommonResultContentModel *commonResultModel = nil;
    self.commonResultVC = [HXBCommonResultController new];
    if ([self.responseModel.result isEqualToString:@"success"]) { //成功
        commonResultModel = [[HXBCommonResultContentModel alloc]initWithImageName:@"successful" titleString:self.responseModel.data.title descString:self.responseModel.data.content firstBtnTitle: @"绑定新银行卡"];
        
        commonResultModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
            //重新绑卡 进入绑卡界面
            //设置新的栈
            NSMutableArray *controllers = [NSMutableArray arrayWithArray:[weakSelf.navigationController.viewControllers subarrayWithRange:NSMakeRange(0, 2)]];
            HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc] init];
            withdrawCardViewController.title = @"绑卡";
            withdrawCardViewController.className = @"HxbAccountInfoViewController";
            withdrawCardViewController.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
            [controllers addObject:withdrawCardViewController];
            [weakSelf.navigationController setViewControllers:controllers animated:YES];
        };
        commonResultModel.secondBtnTitle = @"完成";
        commonResultModel.secondBtnBlock = ^(HXBCommonResultController *resultController) {
            //返回 账户信息列表页
            __block HxbAccountInfoViewController *accountVC = nil;
            [weakSelf.navigationController.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
        
    } else if ([self.responseModel.result isEqualToString:@"error"]){ //失败
        commonResultModel = [[HXBCommonResultContentModel alloc]initWithImageName:@"failure" titleString:self.responseModel.data.title descString:self.responseModel.data.content firstBtnTitle: @"重新解绑"];
        commonResultModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
            //返回解绑卡页面
            __block HxbMyBankCardViewController *myBankCardVC = nil;
            [weakSelf.navigationController.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
    }else if ([self.responseModel.result isEqualToString:@"timeout"]) { //超时
        commonResultModel = [[HXBCommonResultContentModel alloc]initWithImageName:@"outOffTime" titleString:self.responseModel.data.title descString:self.responseModel.data.content firstBtnTitle: @"返回"];
        commonResultModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
            //返回 账户信息列表页
            __block HxbAccountInfoViewController *accountVC = nil;
            [weakSelf.navigationController.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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

#pragma mark - HXBLazyCatResponseDelegate
- (void)setResultPageProperty:(HXBLazyCatResponseModel *)model {
    self.responseModel = model;
}

- (void)leftBackBtnClick {
    //返回解绑卡前一个界面
    int i = 0;
    for (; i<self.navigationController.viewControllers.count; i++) {
        if ([self.navigationController.viewControllers[i] isKindOfClass:NSClassFromString(@"HxbAccountInfoViewController")]) {
            break;
        }
    }
    [self.navigationController popToViewController:self.navigationController.viewControllers[i] animated:YES];
}

@end
