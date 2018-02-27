//
//  HXBBankCardListViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/28.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBankCardListViewController.h"
#import "HXBBankCardListViewModel.h"
#import "HXBBankListCell.h"
#import "SVGKit/SVGKImage.h"
#import "HXBBankList.h"
@interface HXBBankCardListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) HXBBankCardListViewModel *viewModel;
//@property (nonatomic, strong) NSMutableArray *bankListModels;

@end

@implementation HXBBankCardListViewController

- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - HXBStatusBarAndNavigationBarHeight)];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.title = @"银行卡列表";
    [self.view addSubview:self.mainTableView];
    kWeakSelf
    self.viewModel = [[HXBBankCardListViewModel alloc] initWithBlock:^UIView *{
        return weakSelf.view;
    }];
    [self settupNav];
    [self setupNavLeftBtn];
    [self loadData];
}

- (void)settupNav
{
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:kHXBFont_PINGFANGSC_REGULAR(18)};
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_top_blue"] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)setupNavLeftBtn {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
    [button setImage:[SVGKImage imageNamed:@"back"].UIImage forState:UIControlStateNormal];
    // 让按钮内部的所有内容左对齐
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    // 修改导航栏左边的item
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadData
{
    kWeakSelf
    [self.viewModel bankCardListRequestWithResultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf.mainTableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDelegate和UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.bankListModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"bankCardList";
    HXBBankListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HXBBankListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.bankModel = self.viewModel.bankListModels[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.bankCardListBlock) {
        HXBBankList *bankModel  = self.viewModel.bankListModels[indexPath.row];
        self.bankCardListBlock(bankModel.bankCode,bankModel.name);
    }
//    [self back];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScrAdaptationH(70);
}
- (void)dealloc
{
    NSLog(@"被释放");
}
@end
