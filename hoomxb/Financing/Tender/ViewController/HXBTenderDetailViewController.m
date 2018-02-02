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
#import "HXBBaseTableView.h"

@interface HXBTenderDetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) HXBBaseTableView *tableView;
@property (nonatomic, strong) HXBTenderDetailViewModel *viewModel;
@end

@implementation HXBTenderDetailViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kWeakSelf
    self.viewModel = [[HXBTenderDetailViewModel alloc] initWithBlock:^UIView *{
        return weakSelf.view;
    }];
    
    [self setUI];
    [self getData:YES];
}

#pragma mark - UI

- (void)setUI {
    self.isRedColorWithNavigationBar = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    HXBBaseTableView *tableView = [[HXBBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(@(-HXBBottomAdditionHeight));
    }];

    kWeakSelf
    [tableView hxb_headerWithRefreshBlock:^{
        [weakSelf getData:YES];
    }];

    [tableView hxb_footerWithRefreshBlock:^{
        [weakSelf getData:NO];
    }];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.tableView addSubview:self.noDataView];
    [self.noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.tableView);
    }];
}

#pragma mark - Network
- (void)getData:(BOOL)isNew {
    kWeakSelf
    [self.viewModel getData:isNew completion:^{
        [weakSelf.tableView endRefresh];
        [weakSelf.tableView reloadData];
        weakSelf.noDataView.hidden = weakSelf.viewModel.dataSource.count != 0;
    }];
}

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
