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

@interface HXBInviteListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) HXBHeadView *headView;
@property (nonatomic, strong) HXBBaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) HXBNoDataView *nodataView;
@property (nonatomic, strong) HXBInviteModel *model;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger totalCount;
@end

@implementation HXBInviteListViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isRedColorWithNavigationBar = YES;
    self.title = @"邀请记录";
    self.view.backgroundColor =BACKGROUNDCOLOR;
    [self setUI];
    _page = 1;
    [self setUpDataForInviteOverView];
    [self setUpDataForInviteList];
}

#pragma mark - UI

- (void)setUI {
    [self.view addSubview:self.headView];
    [self.view addSubview:self.tableView];
}

#pragma mark - Network


#pragma mark - Delegate Internal

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXBInviteListTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:HXBInviteListTableViewCellIdentifier forIndexPath:indexPath];
    cell.separatorInset = UIEdgeInsetsMake(0, kScrAdaptationW(20), 0, kScrAdaptationW(20));
    if (self.dataArray.count) {
        cell.model = self.dataArray[indexPath.row];
    }
    cell.isHiddenLine = (indexPath.row == self.dataArray.count - 1) ? YES : NO; // 最后一行隐藏横线
    return cell;
}

- (UIView *)tableHeader {
    UIView *sectionHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH(45))];
    sectionHeadView.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kScrAdaptationW(9), kScrAdaptationH(16.5), kScrAdaptationW(2), kScrAdaptationH(12))];
    lineView.backgroundColor = COR29;
    lineView.layer.cornerRadius = kScrAdaptationW(1);
    [sectionHeadView addSubview:lineView];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(kScrAdaptationW(20), kScrAdaptationH(15), kScreenWidth - kScrAdaptationW(35), kScrAdaptationH(15))];
    titleLable.text = @"我的好友";
    titleLable.font = kHXBFont_PINGFANGSC_REGULAR(15);
    titleLable.textColor = COR6;
    [sectionHeadView addSubview:titleLable];
    
    UIView *separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, kScrAdaptationH(44.5), kScreenWidth, kHXBDivisionLineHeight)];
    separatorLineView.backgroundColor = COR12;
    [sectionHeadView addSubview:separatorLineView];
    
    return sectionHeadView;
}

#pragma mark -


#pragma mark - Delegate External

#pragma mark -


#pragma mark - Action
- (void)setUpDataForInviteList {
    NSDictionary *dic_post = @{
                               @"page": [NSString stringWithFormat:@"%ld", _page]
                               };
    [HXBInviteViewModel requestForInviteListWithParams:dic_post andSuccessBlock:^(HXBInviteListModel *model) {
        for (HXBInviteModel *inviteModel in model.dataList) {
            [self.dataArray addObject:inviteModel];
        }
        if (self.dataArray.count) {
            _tableView.hidden = NO;
            self.nodataView.hidden = YES;
            [self.tableView.tableHeaderView setHidden:NO];
            [_tableView endRefresh];
            
            if (model.dataList.count >= kPageCount) {
                // 上拉加载
                [_tableView hxb_GifFooterWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
                    _page++;
                    [self setUpDataForInviteList];
                } andSetUpGifFooterBlock:nil];
                
            } else if (model.totalCount == self.dataArray.count) {
                [_tableView.mj_footer endRefreshingWithNoMoreData];
            }
        } else {
            [self.tableView.tableHeaderView setHidden:YES];
            _tableView.hidden = NO;
            self.nodataView.hidden = NO;
            [_tableView endRefresh];
        }
        [_tableView reloadData];
    } andFailureBlock:^(NSError *error) {
        [_tableView endRefresh];
    }];
}

- (void)setUpDataForInviteOverView {
    NSString *noDataText = @"--";
    [HXBInviteViewModel requestForInviteOverViewWithParams:nil andSuccessBlock:^(HXBInviteOverViewModel *model) {
        if (model.cashBackAmount) {
            self.headView.dataDic = [self dataDicWithCashBackAmount:model.cashBackAmount couponNumber:[NSString stringWithFormat:@"%ld", model.couponNumber] inviteNumber:[NSString stringWithFormat:@"%ld", model.inviteNumber]];
        } else {
            self.headView.dataDic = [self dataDicWithCashBackAmount:noDataText couponNumber:noDataText inviteNumber:noDataText];
        }
    } andFailureBlock:^(NSError *error) {
        self.headView.dataDic = [self dataDicWithCashBackAmount:noDataText couponNumber:noDataText inviteNumber:noDataText];
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
        _headView = [[HXBHeadView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScrAdaptationH(258) - 64)];
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
        
        // 下拉刷新
        [_tableView hxb_GifHeaderWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
            _page = 1;
            [self.dataArray removeAllObjects];
            [self setUpDataForInviteList];
            [self setUpDataForInviteOverView];
        } andSetUpGifHeaderBlock:^(MJRefreshGifHeader *gifHeader) {
            
        }];
        _tableView.rowHeight = kScrAdaptationH(60);
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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

#pragma mark - Helper


#pragma mark - Other


#pragma mark - Public

@end
