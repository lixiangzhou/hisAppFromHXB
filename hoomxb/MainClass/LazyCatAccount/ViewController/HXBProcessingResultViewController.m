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

@property (nonatomic, strong) HXBCommonResultController *resultVC;

@end

@implementation HXBProcessingResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.resultVC = [[HXBCommonResultController alloc] init];
    [self addChildViewController:self.resultVC];
    [self.view addSubview:self.resultVC.view];
    
    kWeakSelf
    [self.resultVC.contentModel setFirstBtnBlock:^(HXBCommonResultController *resultController) {
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
    self.title = model.data.title;
    self.resultVC.contentModel.imageName = model.imageName;
    self.resultVC.contentModel.titleString = model.data.title;
    self.resultVC.contentModel.descString = model.data.content;
    self.resultVC.contentModel.firstBtnTitle = @"返回我的账户";
}


@end
