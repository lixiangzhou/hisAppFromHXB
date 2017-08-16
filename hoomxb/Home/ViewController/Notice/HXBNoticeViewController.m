//
//  HXBNoticeViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//



#import "HXBNoticeViewController.h"
#import "HXBVersionUpdateRequest.h"
#import "HXBNoticModel.h"
#import "HXBFinAddTruastWebViewVC.h"
#import "HXBNoticeCell.h"
@interface HXBNoticeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTabelView;

@property (nonatomic, strong) NSMutableArray<HXBNoticModel *> *modelArrs;

/**
 请求
 */
@property (nonatomic, strong) HXBVersionUpdateRequest *versionUpdateRequest;

@property (nonatomic, strong) HXBNoDataView *nodataView;
@end

@implementation HXBNoticeViewController


- (NSMutableArray<HXBNoticModel *> *)modelArrs
{
    if (!_modelArrs) {
        _modelArrs = [NSMutableArray array];
    }
    return _modelArrs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公告";
    self.isColourGradientNavigationBar = YES;
    [self.view addSubview:self.mainTabelView];
    [self loadDataWithIsUPReloadData:YES];
    kWeakSelf
    baseNAV.getNetworkAgainBlock = ^{
        [weakSelf loadDataWithIsUPReloadData:YES];
    };
}


- (void)loadDataWithIsUPReloadData:(BOOL)isUPReloadData
{
    kWeakSelf
    //公告请求接口
    [self.versionUpdateRequest noticeRequestWithisUPReloadData:isUPReloadData andSuccessBlock:^(id responseObject) {
        weakSelf.modelArrs = responseObject;
        if (!weakSelf.modelArrs.count) {
            weakSelf.nodataView.hidden = NO;
        }else
        {
            weakSelf.nodataView.hidden = YES;
        }
        [weakSelf.mainTabelView reloadData];
        [weakSelf.mainTabelView.mj_footer endRefreshing];
        [self.mainTabelView.mj_header endRefreshing];
    } andFailureBlock:^(NSError *error) {
        [weakSelf.mainTabelView.mj_header endRefreshing];
        [weakSelf.mainTabelView.mj_footer endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArrs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"HXBNoticeViewControllerCell";
    HXBNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HXBNoticeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    HXBNoticModel *noticModel = self.modelArrs[indexPath.row];
    cell.textLabel.text = noticModel.title;
    cell.detailTextLabel.text = [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:noticModel.date andDateFormat:@"yyyy-MM-dd"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HXBNoticModel *noticModel = self.modelArrs[indexPath.row];
    NSString *str = [NSString stringWithFormat:@"%@/about/announcement/%@",kHXBH5_BaseURL,noticModel.ID];
    HXBFinAddTruastWebViewVC *finAddTruastWebViewVC = [[HXBFinAddTruastWebViewVC alloc] init];
    finAddTruastWebViewVC.URL = str;
    finAddTruastWebViewVC.title = @"公告详情";
    [self.navigationController pushViewController:finAddTruastWebViewVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
#pragma mark - 懒加载
- (UITableView *)mainTabelView
{
    if (!_mainTabelView) {
        kWeakSelf
        _mainTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
        _mainTabelView.delegate = self;
        _mainTabelView.dataSource = self;
        _mainTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mainTabelView hxb_GifHeaderWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
            [weakSelf loadDataWithIsUPReloadData:YES];
        } andSetUpGifHeaderBlock:^(MJRefreshGifHeader *gifHeader) {
            
        }];
        [_mainTabelView hxb_GifFooterWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
            [weakSelf loadDataWithIsUPReloadData:NO];
        } andSetUpGifFooterBlock:^(MJRefreshBackGifFooter *footer) {
            
        }];
    }
    return _mainTabelView;
}

- (HXBVersionUpdateRequest *)versionUpdateRequest
{
    if (!_versionUpdateRequest) {
        _versionUpdateRequest = [[HXBVersionUpdateRequest alloc] init];
    }
    return _versionUpdateRequest;
}
- (HXBNoDataView *)nodataView {
    if (!_nodataView) {
        _nodataView = [[HXBNoDataView alloc]initWithFrame:CGRectZero];
        _nodataView.imageName = @"Fin_NotData";
        _nodataView.noDataMassage = @"暂无数据";
        _nodataView.downPULLMassage = @"下拉进行刷新";
        [self.mainTabelView addSubview:_nodataView];
        [_nodataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mainTabelView).offset(kScrAdaptationH(139));
            make.height.width.equalTo(@(kScrAdaptationH(184)));
            make.centerX.equalTo(self.mainTabelView);
        }];
    }
    return _nodataView;
}
@end
