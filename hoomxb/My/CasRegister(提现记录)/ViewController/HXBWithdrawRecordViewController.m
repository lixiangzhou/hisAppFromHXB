//
//  HXBWithdrawRecordViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/10/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBWithdrawRecordViewController.h"
#import "HXBWithdrawRecordViewModel.h"
#import "HXBWithdrawRecordListModel.h"
#import "HXBWithdrawRecordCell.h"
@interface HXBWithdrawRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

/**
 提现记录的ViewModel
 */
@property (nonatomic, strong) HXBWithdrawRecordViewModel *withdrawRecordViewModel;
/**
 提现进度列表
 */
@property (nonatomic, strong) UITableView *withdrawRecordTableView;

/**
 暂无数据接口
 */
@property (nonatomic, strong) HXBNoDataView *nodataView;

/**
 页码
 */
@property (nonatomic, assign) NSInteger page;

@end

@implementation HXBWithdrawRecordViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 0;
    self.title = @"提现进度";
    self.isRedColorWithNavigationBar = YES;
    [self loadCashRegisterDataNeeedShowLoading:YES];
    [self.view addSubview:self.withdrawRecordTableView];
    [self nodataView];
    
}
#pragma mark - Events
///无网状态的网络连接
- (void)getNetworkAgain {
    [self loadCashRegisterDataNeeedShowLoading:YES];
}
#pragma mark - Private
//加载数据
- (void)loadCashRegisterDataNeeedShowLoading:(BOOL)isShowLoading {
    kWeakSelf
    self.page++;
    [self.withdrawRecordViewModel withdrawRecordProgressRequestWithLoading:isShowLoading andPage:self.page andSuccessBlock:^(HXBWithdrawRecordListModel *withdrawRecordListModel) {
        [weakSelf isHaveData];
        [weakSelf.withdrawRecordTableView reloadData];
        [weakSelf endRefreshing];
        if (withdrawRecordListModel.isNoMoreData) {
             [weakSelf.withdrawRecordTableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [weakSelf.withdrawRecordTableView hxb_GifFooterWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
                [self loadCashRegisterDataNeeedShowLoading:NO];
            } andSetUpGifFooterBlock:^(MJRefreshBackGifFooter *footer) {
            }];
        }
    } andFailureBlock:^(NSError *error) {
        [weakSelf.withdrawRecordTableView reloadData];
        [weakSelf endRefreshing];
        weakSelf.page--;
    }];
}
//结束刷新
- (void)endRefreshing {
    [self.withdrawRecordTableView.mj_header endRefreshing];
    [self.withdrawRecordTableView.mj_footer endRefreshing];
}
//判断是否有数据
- (void)isHaveData {
    self.nodataView.hidden = self.withdrawRecordViewModel.withdrawRecordListModel.dataList.count;
}

#pragma mark - UITableViewDataSource
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *identifier = @"HXBNoticeViewControllerCell";
    HXBWithdrawRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HXBWithdrawRecordCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.withdrawRecordModel = self.withdrawRecordViewModel.withdrawRecordListModel.dataList[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.withdrawRecordViewModel.withdrawRecordListModel.dataList.count;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScrAdaptationH750(200);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kScrAdaptationH750(20);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = BACKGROUNDCOLOR;
    return headView;
}

#pragma mark - Getters and Setters
- (UITableView *)withdrawRecordTableView {
    if (!_withdrawRecordTableView) {
        _withdrawRecordTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, HxbNavigationBarY, kScreenWidth, kScreenHeight - HxbNavigationBarY) style:(UITableViewStyleGrouped)];
        [HXBMiddlekey AdaptationiOS11WithTableView:_withdrawRecordTableView];
        _withdrawRecordTableView.backgroundColor = BACKGROUNDCOLOR;
        _withdrawRecordTableView.delegate = self;
        _withdrawRecordTableView.dataSource = self;
        _withdrawRecordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        kWeakSelf
        [_withdrawRecordTableView hxb_GifHeaderWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
            weakSelf.page = 0;
            [weakSelf loadCashRegisterDataNeeedShowLoading:NO];
        } andSetUpGifHeaderBlock:^(MJRefreshGifHeader *gifHeader) {
            
        }];
        
    }
    return _withdrawRecordTableView;
}
- (HXBWithdrawRecordViewModel *)withdrawRecordViewModel {
    if (!_withdrawRecordViewModel) {
        _withdrawRecordViewModel = [[HXBWithdrawRecordViewModel alloc] init];
    }
    return _withdrawRecordViewModel;
}

- (HXBNoDataView *)nodataView {
    if (!_nodataView) {
        _nodataView = [[HXBNoDataView alloc]initWithFrame:CGRectZero];
        _nodataView.imageName = @"Fin_NotData";
        _nodataView.noDataMassage = @"暂无数据";
        _nodataView.userInteractionEnabled = NO;
        _nodataView.hidden = YES;
        [self.withdrawRecordTableView addSubview:_nodataView];
        //        _nodataView.downPULLMassage = @"下拉进行刷新";
        [_nodataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.withdrawRecordTableView).offset(kScrAdaptationH(100));
            make.height.width.equalTo(@(kScrAdaptationH(184)));
            make.centerX.equalTo(self.withdrawRecordTableView);
        }];
    }
    return _nodataView;
}
@end
