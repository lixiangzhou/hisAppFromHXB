//
//  HXBAccountTransferBuyViewController.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/5/4.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBAccountTransferBuyViewController.h"
#import "HXBCommonResultController.h"
#import "HXBLazyCatResponseDelegate.h"
#import "HXBLazyCatResponseModel.h"
#import "HXBMY_LoanListViewController.h"

@interface HXBAccountTransferBuyViewController ()<HXBLazyCatResponseDelegate>

@property (nonatomic, strong) HXBCommonResultController *commenResultVC;

@end

@implementation HXBAccountTransferBuyViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];  
}

#pragma mark - UI

- (void)setUI {
    self.title = @"债权转让";
    self.view.backgroundColor = [UIColor whiteColor];
    self.isRedColorWithNavigationBar = YES;
    
    [self addChildViewController:self.commenResultVC];
    [self.view addSubview:self.commenResultVC.view];
}

#pragma mark - Action
- (void)setResultPageProperty:(HXBLazyCatResponseModel *)model {
    
    self.commenResultVC.contentModel = [HXBCommonResultContentModel new];
    self.commenResultVC.contentModel.descHasMark = NO;
    self.commenResultVC.contentModel.descAlignment = NSTextAlignmentCenter;
    self.commenResultVC.contentModel.imageName = model.imageName;
    self.commenResultVC.contentModel.titleString = model.data.title;
    self.commenResultVC.contentModel.descString = model.data.content;
    NSString *firstBtnTitle;
    if ([model.result isEqualToString:@"success"]) {
        firstBtnTitle = @"完成";
    } else if ([model.result isEqualToString:@"error"]) {
        firstBtnTitle = @"重新转让";
    } else if ([model.result isEqualToString:@"timeout"]) {
        firstBtnTitle = @"返回";
    }
    self.commenResultVC.contentModel.firstBtnTitle = firstBtnTitle;
    self.commenResultVC.contentModel.secondBtnTitle = nil;
    
    kWeakSelf
    self.commenResultVC.contentModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
        for (UIViewController *VC in weakSelf.navigationController.viewControllers) {
            if ([VC isKindOfClass:[HXBMY_LoanListViewController class]]) {
                [weakSelf.navigationController popToViewController:VC animated:YES];
            }
        }
    };
    

}

- (HXBCommonResultController *)commenResultVC {
    if (!_commenResultVC) {
        _commenResultVC = [[HXBCommonResultController alloc] init];
    }
    return _commenResultVC;
}


- (void)leftBackBtnClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)dealloc {
    [self.commenResultVC removeFromParentViewController];
}

@end
