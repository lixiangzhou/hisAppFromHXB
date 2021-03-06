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
//@property (nonatomic, strong) UITableView *mainTableView;
//@property (nonatomic,strong) HXBNoDataView *nodataView;

@end

@implementation HXBMyCouponListView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBA(244, 243, 248, 1);
        [self addSubview:self.mainTableView];
        self.nodataView.hidden = YES;
        kWeakSelf
        [_nodataView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mainTableView).offset(kScrAdaptationH(100));
            make.height.width.equalTo(@(kScrAdaptationH(184)));
            make.centerX.equalTo(weakSelf.mainTableView);
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

-(void)setMyCouponListModelArray:(NSMutableArray<HXBMyCouponListModel *> *)myCouponListModelArray{

    _myCouponListModelArray = myCouponListModelArray;
    self.nodataView.hidden = myCouponListModelArray.count > 0 ? YES:NO;
    if (_myCouponListModelArray.count > 0) {
        [self.mainTableView reloadData];
    }
}

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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (self.myCouponListModelArray.count > 0) {
        cell.myCouponListModel = self.myCouponListModelArray[indexPath.row];
    }
    
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
        [_mainTableView hxb_headerWithRefreshBlock:^{
            if (weakSelf.homeRefreshHeaderBlock)
                weakSelf.homeRefreshHeaderBlock();
        }];
    }
    return _mainTableView;
}

- (HXBNoDataView *)nodataView {
    if (!_nodataView) {
        _nodataView = [[HXBNoDataView alloc]initWithFrame:CGRectZero];
        [self addSubview:_nodataView];
        _nodataView.imageName = @"my_couponList_NotData";
        kWeakSelf
        _nodataView.clickBlock = ^{
            if (weakSelf.block) {
                weakSelf.block();
            }
        };
        [_nodataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf).offset(kScrAdaptationH(100));
            make.height.width.equalTo(@(kScrAdaptationH(184)));
            make.centerX.equalTo(weakSelf);
        }];
    }
    return _nodataView;
}

- (void)setIsDisplayInvite:(BOOL)isDisplayInvite {
    _isDisplayInvite = isDisplayInvite;
    self.nodataView.noDataMassage = _isDisplayInvite ? @"暂无优惠券，立即获取" : @"暂无优惠券";;
}

@end
