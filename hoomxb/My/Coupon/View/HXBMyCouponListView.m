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
//@property (nonatomic,strong) HXBNoDataView *nodataView;

@end

@implementation HXBMyCouponListView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBA(244, 243, 248, 1);
        [self addSubview:self.mainTableView];
        self.nodataView.hidden = false;
        [_nodataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mainTableView).offset(kScrAdaptationH(100));
            make.height.width.equalTo(@(kScrAdaptationH(184)));
            make.centerX.equalTo(self.mainTableView);
        }];
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kScrAdaptationH(19);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return kScrAdaptationH(0.0001);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HXBMyCouponListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celled"];
    if (!cell) {
        cell = [[HXBMyCouponListTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"celled"];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.myCouponListModel = self.myCouponListModelArray[indexPath.row];
    kWeakSelf
    cell.actionButtonClickBlock = ^(){
        weakSelf.actionButtonClickBlock();
    };
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.myCouponListModelArray.count;//model个数
}

#pragma mark - 懒加载
- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-44) style:UITableViewStyleGrouped];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.tableHeaderView.userInteractionEnabled = YES;
        _mainTableView.backgroundColor = RGBA(244, 243, 248, 1);
        _mainTableView.rowHeight = kScrAdaptationH750(270);
        [_mainTableView addSubview:self.nodataView];
        [HXBMiddlekey AdaptationiOS11WithTableView:_mainTableView];
        kWeakSelf
        [_mainTableView hxb_GifHeaderWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
            if (weakSelf.homeRefreshHeaderBlock)
                weakSelf.homeRefreshHeaderBlock();
        } andSetUpGifHeaderBlock:^(MJRefreshGifHeader *gifHeader) {
            
        }];
    }
    return _mainTableView;
}

- (HXBNoDataView *)nodataView {
    if (!_nodataView) {
        _nodataView = [[HXBNoDataView alloc]initWithFrame:CGRectZero];
        _nodataView.userInteractionEnabled = NO;
        _nodataView.imageName = @"my_couponList_NotData";
        _nodataView.noDataMassage = @"暂时还没有优惠券";
        //        _nodataView.downPULLMassage = @"下拉进行刷新";
    }
    return _nodataView;
}

@end
