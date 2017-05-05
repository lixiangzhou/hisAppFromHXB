//
//  HxbFinanctingViewController.m
//  hoomxb
//
//  Created by HXB on 2017/4/22.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbFinanctingViewController.h"
#import "UIScrollView+HXBScrollView.h"//上拉刷新
#import "HXBFinanctingView_HomePage.h"//最主要的view
#import "HXBFinancing_PlanDetailsViewController.h"//红利计划详情页
#import "HXBFinancing_LoanDetailsViewController.h"//散标详情页
@interface HxbFinanctingViewController () <UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;//测试
@property (nonatomic,strong) HXBFinanctingView_HomePage *homePageView;//最主要的view
@end
static NSString *CELLID = @"CELLID";
@implementation HxbFinanctingViewController

- (void)viewDidLoad {
    
    /* 测试
     [super viewDidLoad];
     [self setupTableView];
     [self setupRefresh];
     */
    //rootView
    [self setup];
    //点击事件
    [self clickCell];
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    };
}

- (void)setup {
    self.homePageView = [[HXBFinanctingView_HomePage alloc]initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64- 49)];
    self.homePageView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.homePageView];
}

#pragma mark - 处理点击事件
- (void)clickCell {
    //点击了红利计划列表的cell，跳转了红利计划详情页
    [self clickPlanListCell];
    //点击了散标列表页测cell， 跳转详情页
    [self clickLoanListCell];
}
//MARK: - 点击了红利计划列表页的 cell
- (void) clickPlanListCell {
    __weak typeof(self) weakSelf = self;
    [self.homePageView setClickPlanListCellBlock:^(NSIndexPath *index, id model) {
        [weakSelf pushPlanDetailsViewControllerWithModel:model];
    }];
}
- (void)pushPlanDetailsViewControllerWithModel: (id)model {
    HXBFinancing_PlanDetailsViewController *planDetailsVC = [[HXBFinancing_PlanDetailsViewController alloc]init];
    [self.navigationController pushViewController:planDetailsVC animated:true];
}
//MARK: - 点击了散标列表页的 cell
- (void) clickLoanListCell {
    __weak typeof (self) weakSelf = self;
    [self.homePageView setClickLoanListCellBlock:^(NSIndexPath *index, id model) {
        [weakSelf pushLoanListCellViewControllerWithModel:model];
    }];
}
- (void)pushLoanListCellViewControllerWithModel: (id)model {
    HXBFinancing_LoanDetailsViewController *loanDetailsVC = [[HXBFinancing_LoanDetailsViewController alloc]init];
    [self.navigationController pushViewController:loanDetailsVC animated:true];
}
#pragma mark - 测试
/*
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
 */

@end
