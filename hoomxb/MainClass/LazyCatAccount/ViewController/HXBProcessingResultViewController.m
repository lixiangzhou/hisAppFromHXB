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
@interface HXBProcessingResultViewController ()

@end

@implementation HXBProcessingResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请求超时";
    HXBCommonResultController *resultVC = [[HXBCommonResultController alloc] init];
    resultVC.contentModel = [[HXBCommonResultContentModel alloc] initWithImageName:@"outOffTime" titleString:@"请求超时" descString:@"请求超时，请返回至账户内查看结果" firstBtnTitle:@"返回我的账户"];
    [self addChildViewController:resultVC];
    [self.view addSubview:resultVC.view];
    
    kWeakSelf
    [resultVC.contentModel setFirstBtnBlock:^(HXBCommonResultController *resultController) {
        [weakSelf back];
    }];
    
}

- (void)back {
    [self.navigationController popToRootViewControllerAnimated:NO];
    HXBBaseTabBarController *tabBarVC = (HXBBaseTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    tabBarVC.selectedIndex = 2;
}

- (void)leftBackBtnClick {
    [self back];
}


@end
