//
//  HXBBankCardListViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/28.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBankCardListViewController.h"

@interface HXBBankCardListViewController ()

@property (nonatomic, strong) UITableView *mainTableView;
@end

@implementation HXBBankCardListViewController

- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    }
    return _mainTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupNavLeftBtn];
    [self loadData];
}

- (void)setupNavLeftBtn {
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    // 让按钮内部的所有内容左对齐
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    // 修改导航栏左边的item
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
- (void)back
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)loadData
{
    
}

@end
