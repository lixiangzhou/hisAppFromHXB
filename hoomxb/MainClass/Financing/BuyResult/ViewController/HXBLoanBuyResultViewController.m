//
//  HXBLoanBuyResultViewController.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/4/27.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBLoanBuyResultViewController.h"
#import "HXBCommonResultController.h"
#import "HXBLazyCatResponseDelegate.h"
#import "HXBLazyCatResponseModel.h"

@interface HXBLoanBuyResultViewController() <HXBLazyCatResponseDelegate>

@property (nonatomic, strong) HXBCommonResultController *commenResultVC;

@end

@implementation HXBLoanBuyResultViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];  
}

#pragma mark - UI

- (void)setUI {
    self.title = @"购买成功";
    self.view.backgroundColor = [UIColor whiteColor];
    self.isRedColorWithNavigationBar = YES;
    
    self.commenResultVC = [[HXBCommonResultController alloc] init];
    self.commenResultVC.contentModel.descHasMark = YES;
    self.commenResultVC.contentModel.descAlignment = NSTextAlignmentLeft;
    
    [self addChildViewController:self.commenResultVC];
    [self.view addSubview:self.commenResultVC.view];
}

#pragma mark - Action
- (void)setResultPageProperty:(HXBLazyCatResponseModel *)model {
    self.commenResultVC.contentModel = [[HXBCommonResultContentModel alloc] initWithImageName:@""
                                                                                  titleString:model.data.title
                                                                                   descString:model.data.content
                                                                                firstBtnTitle:@"查看我的出借"];
    self.commenResultVC.contentModel.secondBtnTitle = @"";
    kWeakSelf
    self.commenResultVC.contentModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowMYVC_LoanList object:nil];
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    };
    if (self.commenResultVC.contentModel.secondBtnTitle) {
        self.commenResultVC.contentModel.secondBtnBlock = ^(HXBCommonResultController *resultController) {
            
        };
    }
}

- (void)dealloc {
    [self.commenResultVC removeFromParentViewController];
}
@end

