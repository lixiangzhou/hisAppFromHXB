//
//  HXBMyCouponListView.m
//  hoomxb
//
//  Created by hxb on 2017/10/31.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyCouponListView.h"
#import "HXBMyCouponListTableViewCell.h"
#import "HXBMyCouponListModel.h"

@interface HXBMyCouponListView ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic,strong) HXBNoDataView *nodataView;

@end

@implementation HXBMyCouponListView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBA(244, 243, 248, 1);
        [self addSubview:self.mainTableView];
        self.nodataView.hidden = false;
    }
    return self;
}

- (void)setIsStopRefresh_Home:(BOOL)isStopRefresh_Home{
    _isStopRefresh_Home = isStopRefresh_Home;
    if (isStopRefresh_Home) {
        [self.mainTableView.mj_footer endRefreshing];
        [self.mainTableView.mj_header endRefreshing];
    }
}

-(void)setMyCouponListModelArray:(NSArray<HXBMyCouponListModel *> *)myCouponListModelArray{
    _myCouponListModelArray = myCouponListModelArray;
    self.nodataView.hidden = myCouponListModelArray.count;
    [self.mainTableView reloadData];
}

//-(void)setMyCouponListModel:(HXBMyCouponListModel *)myCouponListModel{
//    _myCouponListModel = myCouponListModel;
//    [self.mainTableView reloadData];
//}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScrAdaptationH750(270);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 13.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

- (void)clickImmediateUseBtn:(UIButton *)sender{
    NSLog(@"点击立即使用按钮");
//    HXBFinancing_PlanDetailsViewController *planDetailsVC = [[HXBFinancing_PlanDetailsViewController alloc]init];
//    planDetailsVC.title = model.planListModel.name;
//    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"红利计划##" style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.backBarButtonItem = leftBarButtonItem;
//    planDetailsVC.planID = model.planListModel.ID;
//    planDetailsVC.isPlan = true;
//    planDetailsVC.isFlowChart = true;
//    planDetailsVC.hidesBottomBarWhenPushed = true;
//    planDetailsVC.planListViewModel = model;
//
//    [self.navigationController pushViewController:planDetailsVC animated:true];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *celledStr = @"celled";
    HXBMyCouponListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celledStr];
    if (cell == nil) {
        cell = [[HXBMyCouponListTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:celledStr];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.myCouponListModel = self.myCouponListModelArray[indexPath.row];
    //按钮使能 事件处理？
    cell.actionBtn.userInteractionEnabled = YES;
    [cell.actionBtn addTarget:self action:@selector(clickImmediateUseBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //区别两种cell
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.myCouponListModelArray.count;//model个数
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark - 懒加载
- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.tableHeaderView.userInteractionEnabled = YES;
        _mainTableView.backgroundColor = RGBA(244, 243, 248, 1);
        [HXBMiddlekey AdaptationiOS11WithTableView:_mainTableView];
        kWeakSelf
        [_mainTableView hxb_GifHeaderWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
            if (weakSelf.homeRefreshHeaderBlock) weakSelf.homeRefreshHeaderBlock();
        } andSetUpGifHeaderBlock:^(MJRefreshGifHeader *gifHeader) {
            
        }];
    }
    return _mainTableView;
}

- (HXBNoDataView *)nodataView {
    if (!_nodataView) {
        _nodataView = [[HXBNoDataView alloc]initWithFrame:CGRectZero];
        [self addSubview:_nodataView];
        _nodataView.imageName = @"my_couponList_NotData";
        _nodataView.noDataMassage = @"暂时还没有优惠券";
        //        _nodataView.downPULLMassage = @"下拉进行刷新";
        [_nodataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(kScrAdaptationH(100));
            make.height.width.equalTo(@(kScrAdaptationH(184)));
            make.centerX.equalTo(self);
        }];
    }
    return _nodataView;
}

@end
