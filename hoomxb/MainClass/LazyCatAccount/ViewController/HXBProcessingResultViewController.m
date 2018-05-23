//
//  HXBProcessingResultViewController.m
//  hoomxb
//
//  Created by HXB-C on 2018/5/23.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBProcessingResultViewController.h"
#import "HXBCommonResultController.h"
#import "HXBBaseTabBarController.h"
#import "HXBLazyCatResponseDelegate.h"
#import "HXBLazyCatResponseModel.h"
@interface HXBProcessingResultViewController ()<HXBLazyCatResponseDelegate>

@property (nonatomic, strong) HXBLazyCatResponseModel *responsemodel;
@end

@implementation HXBProcessingResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HXBCommonResultController *resultVC = [[HXBCommonResultController alloc] init];
    
    self.title = self.responsemodel.data.title;
    resultVC.contentModel.imageName = self.responsemodel.imageName;
    resultVC.contentModel.titleString = self.responsemodel.data.title;
    resultVC.contentModel.descString = self.responsemodel.data.content;
    resultVC.contentModel.firstBtnTitle = @"返回我的账户";
    
    [self addChildViewController:resultVC];
    [self.view addSubview:resultVC.view];
    
    kWeakSelf
    [resultVC.contentModel setFirstBtnBlock:^(HXBCommonResultController *resultController) {
        [weakSelf back];
    }];
    
}

- (void)leftBackBtnClick {
    [self back];
}

- (void)back {
    [self.navigationController popToRootViewControllerAnimated:NO];
    HXBBaseTabBarController *tabBarVC = (HXBBaseTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    tabBarVC.selectedIndex = 2;
}

#pragma mark - HXBLazyCatResponseDelegate
- (void)setResultPageProperty:(HXBLazyCatResponseModel *)model {
    self.responsemodel = model;
    
}


@end
