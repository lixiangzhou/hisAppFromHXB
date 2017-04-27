//
//  HxbFinanctingViewController.m
//  hoomxb
//
//  Created by HXB on 2017/4/22.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbFinanctingViewController.h"
#import "UIScrollView+HXBScrollView.h"
@interface HxbFinanctingViewController () <UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;

@end
static NSString *CELLID = @"CELLID";
@implementation HxbFinanctingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
        [self setupRefresh];
 
}
- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CELLID];
    self.tableView.dataSource = self;
    [self setupRefresh];
}
- (void)setupRefresh {
       //默认的下拉刷新
    [self.tableView hxb_HeaderWithHeaderRefreshCallBack:^{
        [self refresh];
    } andSetUpGifHeaderBlock:^(MJRefreshNormalHeader *header) {
        header.accessibilityActivationPoint = CGPointMake(2011, 2011);
//        header.stateLabel.hidden = true;//隐藏所有的label
//        header.lastUpdatedTimeLabel.hidden = true;// 隐藏时间label
    }];
    //图片的上啦加载
    UIImage *image = [UIImage imageNamed:@"1"];
    UIImage *image2 = [UIImage imageNamed:@"11"];
    
    [self.tableView hxb_GifFooterWithIdleImages:@[image,image2] andPullingImages:@[image2,image] andFreshingImages:@[image2,image] andRefreshDurations:@[@1,@1,@1] andRefreshBlock:^{
        [self refresh];
    } andSetUpGifFooterBlock:^(MJRefreshBackGifFooter *footer) {
        // 隐藏时间
    }];
}
- (void) refresh {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID forIndexPath:indexPath];
    cell.textLabel.text = indexPath.description;
    return cell;
}

@end
