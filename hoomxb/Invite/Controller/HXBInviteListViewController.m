//
//  HXBInviteListViewController.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2017/11/8.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBInviteListViewController.h"
#import "HXBHeadView.h"
#import "HXBInviteListTableViewCell.h"
#import "HXBInviteViewModel.h"
#import "HXBInviteModel.h"
#import "HXBInviteListViewModel.h"

@interface HXBInviteListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) HXBHeadView *headView;
@property (nonatomic, strong) HXBNoDataView *nodataView;
@property (nonatomic, strong) HXBBaseTableView *tableView;

@property (nonatomic, strong) UIView *sectionHeadView;
@property (nonatomic, assign) BOOL isUpData;
@property (nonatomic, strong) HXBInviteListViewModel *viewModel;

@end

@implementation HXBInviteListViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isRedColorWithNavigationBar = YES;
    self.title = @"邀请记录";
    self.view.backgroundColor = BACKGROUNDCOLOR;
    kWeakSelf
    _viewModel = [[HXBInviteListViewModel alloc] initWithBlock:^UIView *{
        return weakSelf.view;
    }];
    [self setUI];
    [self setUpDataForInviteOverView];
    [self setUpDataForInviteListWithIsUpData:YES];
    
}

#pragma mark - UI

- (void)setUI {
    [self.view addSubview:self.headView];
    [self.view addSubview:self.tableView];
    // 下拉刷新
    kWeakSelf
    [self.tableView hxb_headerWithRefreshBlock:^{
        [weakSelf setUpDataForInviteListWithIsUpData:YES];
        [weakSelf setUpDataForInviteOverView];
    }];
}

#pragma mark - Network
- (void)getNetworkAgain {
    [self setUpDataForInviteOverView];
    [self setUpDataForInviteListWithIsUpData:YES];
}

#pragma mark - Delegate Internal

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.investListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXBInviteListTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:HXBInviteListTableViewCellIdentifier forIndexPath:indexPath];
    cell.separatorInset = UIEdgeInsetsMake(0, kScrAdaptationW(20), 0, kScrAdaptationW(20));
    if (_viewModel.investListArray.count) {
        cell.model = self.viewModel.investListArray[indexPath.row];
    }
    cell.isHiddenLine = (indexPath.row == self.viewModel.investListArray.count - 1) ? YES : NO; // 最后一行隐藏横线
    return cell;
}

- (UIView *)tableHeader {
    _sectionHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH(45))];
    _sectionHeadView.hidden = YES;
    _sectionHeadView.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kScrAdaptationW(9), kScrAdaptationH(16.5), kScrAdaptationW(2), kScrAdaptationH(12))];
    lineView.backgroundColor = COR29;
    lineView.layer.cornerRadius = kScrAdaptationW(1);
    [_sectionHeadView addSubview:lineView];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(kScrAdaptationW(20), kScrAdaptationH(15), kScreenWidth - kScrAdaptationW(35), kScrAdaptationH(15))];
    titleLable.text = @"我的好友";
    titleLable.font = kHXBFont_PINGFANGSC_REGULAR(15);
    titleLable.textColor = COR6;
    [_sectionHeadView addSubview:titleLable];
    
    UIView *separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, kScrAdaptationH(44.5), kScreenWidth, kHXBDivisionLineHeight)];
    separatorLineView.backgroundColor = COR13;
    [_sectionHeadView addSubview:separatorLineView];
    
    return _sectionHeadView;
}

#pragma mark - Action
- (void)setUpDataForInviteListWithIsUpData:(BOOL)isUpData {
    kWeakSelf
    [_viewModel inviteListWithIsUpData:isUpData resultBlock:^(BOOL isSuccess) {
        [weakSelf.tableView endRefresh];
        if (isSuccess) {
            [weakSelf displayInvestListView];
        }
    }];
}

- (void)displayInvestListView {
    [self.tableView endRefresh];
    self.tableView.hidden = NO;
    // 如果需要展示更多
    if (self.viewModel.isShowLoadMore) {
        [self.tableView hxb_footerWithRefreshBlock:^{
            kWeakSelf
            [weakSelf setUpDataForInviteListWithIsUpData: NO];
        }];
    } else {
        self.tableView.mj_footer = nil;
    }
    
    // 如果是最后一页
    if (self.viewModel.isLastPage) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.tableView.mj_footer endRefreshing];
    }
    
    if (self.viewModel.investListArray.count) {
        self.sectionHeadView.hidden = NO;
        [self.tableView.tableHeaderView setHidden:NO];
        self.nodataView.hidden = YES;
    } else {
        [self.tableView.tableHeaderView setHidden:YES];
        self.sectionHeadView.hidden = YES;
        self.nodataView.hidden = NO;
    }
    [self.tableView reloadData];
}

- (void)setUpDataForInviteOverView {
    NSString *noDataText = @"--";
    kWeakSelf
    [_viewModel inviteOverViewWithParams:nil resultBlock:^(BOOL isSuccess) {
        weakSelf.headView.hidden = NO;
        if (isSuccess) {
            if (weakSelf.viewModel.overViewModel.cashBackAmount) {
                weakSelf.headView.dataDic = [weakSelf dataDicWithCashBackAmount:weakSelf.viewModel.overViewModel.cashBackAmount couponNumber:[NSString stringWithFormat:@"%ld", weakSelf.viewModel.overViewModel.couponNumber] inviteNumber:[NSString stringWithFormat:@"%ld", weakSelf.viewModel.overViewModel.inviteNumber]];
            } else {
                weakSelf.headView.dataDic = [weakSelf dataDicWithCashBackAmount:noDataText couponNumber:noDataText inviteNumber:noDataText];
            }
        }
    }];
}

- (NSDictionary *)dataDicWithCashBackAmount:(NSString *)cashBackAmount couponNumber:(NSString *)couponNumber inviteNumber:(NSString *)inviteNumber {
    NSDictionary *data = @{
                           @"topLabel": cashBackAmount,
                           @"topItemLabel": @"现金奖励(元)",
                           @"leftLabel": couponNumber,
                           @"leftItemLabel": @"优惠券(张)",
                           @"rightLabel": inviteNumber,
                           @"rightItemLabel": @"邀请人数(人)"
                           };
    return data;
}


#pragma mark - Setter / Getter / Lazy
- (HXBHeadView *)headView {
    if (!_headView) {
        _headView = [[HXBHeadView alloc] initWithFrame:CGRectMake(0, HXBStatusBarAndNavigationBarHeight, kScreenWidth, kScrAdaptationH(258) - HXBStatusBarAndNavigationBarHeight)];
        _headView.hidden = YES;
    }
    return _headView;
}

- (HXBBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[HXBBaseTableView alloc] initWithFrame:CGRectMake(0, kScrAdaptationH(258), kScreenWidth, kScreenHeight - kScrAdaptationH(258)) style:(UITableViewStylePlain)];
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        [_tableView registerClass:[HXBInviteListTableViewCell class] forCellReuseIdentifier:HXBInviteListTableViewCellIdentifier];
        _tableView.hidden = YES;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = NO;
        _tableView.tableHeaderView = [self tableHeader];
        _tableView.rowHeight = kScrAdaptationH(60);
    }
    return _tableView;
}

- (HXBNoDataView *)nodataView {
    if (!_nodataView) {
        _nodataView = [[HXBNoDataView alloc]initWithFrame:CGRectZero];
        _nodataView.imageName = @"noCoupons";
        _nodataView.noDataMassage = @"暂无邀请数据";
        [self.tableView addSubview:_nodataView];
        _nodataView.hidden = YES;
        [_nodataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tableView).offset(kScrAdaptationH(90));
            make.height.width.equalTo(@(kScrAdaptationH(184)));
            make.centerX.equalTo(self.view);
        }];
    }
    return _nodataView;
}

@end
