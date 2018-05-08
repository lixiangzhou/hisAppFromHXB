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
@property (nonatomic, strong) HXBLazyCatResponseModel *model;

@end

@implementation HXBAccountTransferBuyViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
    [self setUI];  
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = YES;
}


#pragma mark - UI

- (void)setUI {
    self.title = @"债权转让";
    self.view.backgroundColor = [UIColor whiteColor];
    self.isRedColorWithNavigationBar = YES;
    
    [self addChildViewController:self.commenResultVC];
    [self.view addSubview:self.commenResultVC.view];
}

- (void)setData {
    self.commenResultVC.contentModel.descHasMark = NO;
    self.commenResultVC.contentModel.descAlignment = NSTextAlignmentCenter;
    self.commenResultVC.contentModel.imageName = _model.imageName;
    self.commenResultVC.contentModel.titleString = _model.data.title;
    self.commenResultVC.contentModel.descString = _model.data.content;
    NSString *firstBtnTitle;
    if ([_model.result isEqualToString:@"success"]) {
        firstBtnTitle = @"完成";
    } else if ([_model.result isEqualToString:@"error"]) {
        firstBtnTitle = @"重新转让";
    } else if ([_model.result isEqualToString:@"timeout"]) {
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

#pragma mark - Action
- (void)setResultPageProperty:(HXBLazyCatResponseModel *)model {
    
    _model = model;
}

- (HXBCommonResultController *)commenResultVC {
    if (!_commenResultVC) {
        _commenResultVC = [[HXBCommonResultController alloc] init];
        _commenResultVC.contentModel = [[HXBCommonResultContentModel alloc] init];
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
