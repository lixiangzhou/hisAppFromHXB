//
//  HXBMY_AllFinanceViewController.m
//  hoomxb
//
//  Created by HXB on 2017/6/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_AllFinanceViewController.h"
#import "HXBMY_AllFinanceView.h"
#import "HXBAccumulatedIncomeView.h"
@interface HXBMY_AllFinanceViewController ()
@property (nonatomic,strong) HXBMY_AllFinanceView *allFinanceView;
@property (nonatomic, strong) HXBAccumulatedIncomeView *accumulatedIncomeView;
@end

@implementation HXBMY_AllFinanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isColourGradientNavigationBar = YES;
    self.title = @"资产统计";
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self.view addSubview:self.allFinanceView];
    [self.view addSubview:self.accumulatedIncomeView];
    [self loadData_userInfo];
}
/**
 再次获取网络数据
 */
- (void)getNetworkAgain
{
    [self loadData_userInfo];
}

- (void)loadData_userInfo
{
    kWeakSelf
    [KeyChain downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        weakSelf.allFinanceView.viewModel = viewModel;
        weakSelf.accumulatedIncomeView.viewModel = viewModel;
    } andFailure:^(NSError *error) {
        
    }];
}

#pragma mark - 懒加载

- (HXBAccumulatedIncomeView *)accumulatedIncomeView
{
    if (!_accumulatedIncomeView) {
        // 高度改为屏幕高度减去上半部分的高度
        _accumulatedIncomeView = [[HXBAccumulatedIncomeView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.allFinanceView.frame) + kScrAdaptationH(10), kScreenWidth, kScrAdaptationH(291))];
    }
    return _accumulatedIncomeView;
}

- (HXBMY_AllFinanceView *)allFinanceView {
    if (!_allFinanceView) {
        _allFinanceView = [[HXBMY_AllFinanceView alloc]initWithFrame:CGRectMake(0, HXBStatusBarAndNavigationBarHeight + kScrAdaptationH(10), kScreenWidth, kScrAdaptationH(242))];
    }
    return _allFinanceView;
}

@end
