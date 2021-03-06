//
//  HXBModifyTransactionPasswordResultViewController.m
//  hoomxb
//
//  Created by hxb on 2018/4/28.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
// 设置交易密码结果页

#import "HXBModifyTransactionPasswordResultViewController.h"

#import "HXBLazyCatResponseDelegate.h"
#import "HXBLazyCatResponseModel.h"
#import "HxbMyAccountSecurityViewController.h"
#import "HXBCommonResultController.h"
@interface HXBModifyTransactionPasswordResultViewController ()<HXBLazyCatResponseDelegate>
@property (nonatomic,strong) HXBCommonResultController *commonResultVC;
@property (nonatomic,strong) HXBLazyCatResponseModel *responseModel;
@end

@implementation HXBModifyTransactionPasswordResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易密码";
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
    self.commonResultVC = [HXBCommonResultController new];
    HXBCommonResultContentModel *commonResultModel = nil;
    
    if ([self.responseModel.result isEqualToString:@"success"]) { //成功
        commonResultModel = [[HXBCommonResultContentModel alloc]initWithImageName:@"successful" titleString:self.responseModel.data.title descString:self.responseModel.data.content firstBtnTitle: @"完成"];
    } else if ([self.responseModel.result isEqualToString:@"error"]){ //失败
        commonResultModel = [[HXBCommonResultContentModel alloc]initWithImageName:@"failure" titleString:self.responseModel.data.title descString:self.responseModel.data.content firstBtnTitle: @"重新设置交易密码"];
    } else if ([self.responseModel.result isEqualToString:@"timeout"]) { //超时
        commonResultModel = [[HXBCommonResultContentModel alloc]initWithImageName:@"outOffTime" titleString:self.responseModel.data.title descString:self.responseModel.data.content firstBtnTitle: @"返回"];
    }
    // 第一个按钮都回 账户安全列表页，提出来
    commonResultModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
        __block HxbMyAccountSecurityViewController *myAccountSecurityVC = nil;
        [weakSelf.navigationController.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[HxbMyAccountSecurityViewController class]]) {
                myAccountSecurityVC = obj;
            }
            if (myAccountSecurityVC) {
                *stop = YES;
            }
        }];
        
        if (myAccountSecurityVC) {
            [weakSelf.navigationController popToViewController:myAccountSecurityVC animated:YES];
        }
    };
    
    self.commonResultVC.contentModel = commonResultModel;
    [self.view addSubview: self.commonResultVC.view];
}

#pragma mark - HXBLazyCatResponseDelegate
- (void)setResultPageProperty:(HXBLazyCatResponseModel *)model {
    self.responseModel = model;
}

- (void)leftBackBtnClick
{
    //返回前一个界面
    int i;
    for (i = 0; i<self.navigationController.viewControllers.count; i++) {
        if ([self.navigationController.viewControllers[i] isKindOfClass:NSClassFromString(@"HxbMyAccountSecurityViewController")]) {
            break;
        }
    }
    
    if (i>0 && i<self.navigationController.viewControllers.count) {
        [self.navigationController popToViewController:self.navigationController.viewControllers[i] animated:YES];
    }
    else{
        //没有找到,出现异常了, 直接回到根控制器
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
@end
