//
//  HXBUserMigrationResultViewController.m
//  hoomxb
//
//  Created by hxb on 2018/5/4.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBUserMigrationResultViewController.h"
#import "HXBLazyCatResponseDelegate.h"
#import "HXBLazyCatResponseModel.h"
#import "HxbMyAccountSecurityViewController.h"
#import "HXBCommonResultController.h"
#import "HXBAccountActivationManager.h"

@interface HXBUserMigrationResultViewController ()<HXBLazyCatResponseDelegate>
@property (nonatomic,strong) HXBCommonResultController *commonResultVC;
@property (nonatomic,strong) HXBLazyCatResponseModel *responseModel;
@end

@implementation HXBUserMigrationResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAction];
}
- (void)setAction {
    
    self.commonResultVC = [HXBCommonResultController new];
    HXBCommonResultContentModel *commonResultModel = nil;
    
    if ([self.responseModel.result isEqualToString:@"success"]) { //成功
        commonResultModel = [[HXBCommonResultContentModel alloc]initWithImageName:@"successful" titleString:self.responseModel.data.title descString:self.responseModel.data.content firstBtnTitle: @"完成"];
    } else if ([self.responseModel.result isEqualToString:@"error"]){ //失败
        commonResultModel = [[HXBCommonResultContentModel alloc]initWithImageName:@"failure" titleString:self.responseModel.data.title descString:self.responseModel.data.content firstBtnTitle: @"重新升级"];
    } else if ([self.responseModel.result isEqualToString:@"timeout"]) { //超时
        commonResultModel = [[HXBCommonResultContentModel alloc]initWithImageName:@"outOffTime" titleString:self.responseModel.data.title descString:self.responseModel.data.content firstBtnTitle: @"返回"];
    }
    
    kWeakSelf
    commonResultModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
        [[HXBAccountActivationManager sharedInstance] exitActiveAccountPage];
        //回首页
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBBotification_ShowHomeVC object:nil];
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
    [self dismissViewControllerAnimated:NO completion:nil];
    [[HXBAccountActivationManager sharedInstance] exitActiveAccountPage];
    //返回首页
    [[NSNotificationCenter defaultCenter] postNotificationName:kHXBBotification_ShowHomeVC object:nil];
}


@end
