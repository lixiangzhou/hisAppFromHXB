//
//  HXBMY_AllFinanceViewController.m
//  hoomxb
//
//  Created by HXB on 2017/6/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_AllFinanceViewController.h"
#import "HXBMY_AllFinanceView.h"
@interface HXBMY_AllFinanceViewController ()
@property (nonatomic,strong) HXBMY_AllFinanceView *allFinanceView;
@end

@implementation HXBMY_AllFinanceViewController
- (HXBMY_AllFinanceView *)allFinanceView {
    if (!_allFinanceView) {
        _allFinanceView = [[HXBMY_AllFinanceView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScrAdaptationH(242))];
    }
    return _allFinanceView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isColourGradientNavigationBar = YES;
    self.title = @"资产总额";
    [self.hxbBaseVCScrollView addSubview:self.allFinanceView];
    [[KeyChainManage sharedInstance] downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        self.allFinanceView.viewModel = viewModel;
    } andFailure:^(NSError *error) {
        
    }];
}



@end
