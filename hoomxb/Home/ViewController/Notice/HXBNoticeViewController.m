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
 页码
 */
@property (nonatomic, assign) int page;
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
    self.page = 1;
    [self loadData];
}


- (void)loadData
{
    kWeakSelf
    HXBVersionUpdateRequest *versionUpdateRequest = [[HXBVersionUpdateRequest alloc] init];
    //公告请求接口
    [versionUpdateRequest noticeRequestWithpage:self.page andSuccessBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *modelarr = [NSArray yy_modelArrayWithClass:[HXBNoticModel class] json:responseObject[@"data"][@"dataList"]];
        if (modelarr.count>0) {
            [weakSelf.modelArrs addObjectsFromArray:modelarr];
        }else
        {
            weakSelf.page--;
        }
        int totalCount = [responseObject[@"data"][@"totalCount"] intValue];
        if (weakSelf.modelArrs.count >= totalCount) {
            [self.mainTabelView.mj_footer endRefreshingWithNoMoreData];
        }else
        {
            [self.mainTabelView.mj_footer endRefreshing];
        }
        
        [weakSelf.mainTabelView reloadData];
        [self.mainTabelView.mj_header endRefreshing];
    } andFailureBlock:^(NSError *error) {
        weakSelf.page--;
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
            weakSelf.page = 1;
            [weakSelf.modelArrs removeAllObjects];
            [weakSelf loadData];
        } andSetUpGifHeaderBlock:^(MJRefreshGifHeader *gifHeader) {
            
        }];
        [_mainTabelView hxb_GifFooterWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
            weakSelf.page++;
            [weakSelf loadData];
        } andSetUpGifFooterBlock:^(MJRefreshBackGifFooter *footer) {
            
        }];
    }
    return _mainTabelView;
}



@end
