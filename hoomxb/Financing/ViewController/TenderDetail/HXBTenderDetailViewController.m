//
//  HXBTenderDetailViewController.m
//  hoomxb
//
//  Created by lxz on 2018/1/19.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBTenderDetailViewController.h"
#import "HXBTenderDetailCell.h"
#import "HXBTenderDetailViewModel.h"
#import "HXBFinancing_LoanDetailsViewController.h"

@interface HXBTenderDetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) HXBTenderDetailViewModel *viewModel;
@end

@implementation HXBTenderDetailViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [HXBTenderDetailViewModel new];
    self.viewModel.view = self.view;
    
    [self setUI];
    kWeakSelf
    [self.viewModel getData:YES completion:^{
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark - UI

- (void)setUI {
    self.title = @"计划投标明细";
    self.isRedColorWithNavigationBar = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.sectionHeaderHeight = 10;
    tableView.sectionFooterHeight = 0.001;
    tableView.rowHeight = HXBTenderDetailCellHeight;
    [tableView registerClass:[HXBTenderDetailCell class] forCellReuseIdentifier:HXBTenderDetailCellIdentifier];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(HXBStatusBarAndNavigationBarHeight));
        make.bottom.left.right.equalTo(self.view);
    }];

    kWeakSelf
    [tableView hxb_headerWithRefreshBlock:^{
        [weakSelf.viewModel getData:YES completion:^{
            [weakSelf.tableView endRefresh];
            [weakSelf.tableView reloadData];
        }];
    }];

    [tableView hxb_footerWithRefreshBlock:^{
        [weakSelf.viewModel getData:NO completion:^{
            [weakSelf.tableView.mj_footer endRefreshing];
            [weakSelf.tableView reloadData];
        }];
    }];
}

#pragma mark - Network

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXBTenderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:HXBTenderDetailCellIdentifier forIndexPath:indexPath];
    cell.model = self.viewModel.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HXBTenderDetailModel *model = self.viewModel.dataSource[indexPath.row];
    HXBFinancing_LoanDetailsViewController *loanDetailsVC = [[HXBFinancing_LoanDetailsViewController alloc]init];
    loanDetailsVC.title = model.title;
    loanDetailsVC.loanID = model.loanId;
    [self.navigationController pushViewController:loanDetailsVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}


#pragma mark - Action


#pragma mark - Setter / Getter / Lazy


#pragma mark - Helper


#pragma mark - Other


#pragma mark - Public

@end
