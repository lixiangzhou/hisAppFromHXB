//
//  HXBChooseDiscountCouponViewController.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2017/10/25.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBChooseDiscountCouponViewController.h"
#import "HXBChooseDiscountTableViewCell.h"
#import "HXBMy_Withdraw_notifitionView.h"
#import "HXBChooseDiscountCouponViewModel.h"

@interface HXBChooseDiscountCouponViewController ()<UITableViewDelegate, UITableViewDataSource>
// 表视图
@property (nonatomic, strong) HXBBaseTableView *tableView;
// 提示Label
@property (nonatomic, strong) HXBMy_Withdraw_notifitionView *notifitionView;
// 无数据
@property (nonatomic, strong) HXBNoDataView *nodataView;
// 是否选中
@property (nonatomic, assign) BOOL hasSelect;
//判断第几个是选择的优惠券
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, strong) HXBChooseDiscountCouponViewModel *viewModel;
@end

@implementation HXBChooseDiscountCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择优惠券";
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.isRedColorWithNavigationBar = YES;
    kWeakSelf
    _viewModel = [[HXBChooseDiscountCouponViewModel alloc] initWithBlock:^UIView *{
        return weakSelf.view;
    }];
    _num = 0;
    [self buildUI];
    [self setUpDate];
}

- (void)buildUI {
    _tableView = [[HXBBaseTableView alloc] initWithFrame:CGRectMake(0, HXBStatusBarAndNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - HXBStatusBarAndNavigationBarHeight) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.hidden = YES;
    _tableView.backgroundColor = BACKGROUNDCOLOR;
    _tableView.rowHeight = kScrAdaptationH750(126);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    [self.view addSubview:self.notifitionView];
    
    if (_investMoney.floatValue > 0) {
        _notifitionView.hidden = YES;
        _tableView.tableHeaderView = [self tableViewHeadView];
    } else {
        _notifitionView.hidden = NO;
        _tableView.tableHeaderView.hidden = YES;
        _tableView.frame = CGRectMake(0, HXBStatusBarAndNavigationBarHeight + kScrAdaptationH(40), kScreenWidth, kScreenHeight - HXBStatusBarAndNavigationBarHeight - kScrAdaptationH(40));
    }
}

- (void)getNetworkAgain {
    [self setUpDate];
}

- (UIView *)tableViewHeadView {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH750(120))];
    headView.backgroundColor = BACKGROUNDCOLOR;
    
    UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, kScrAdaptationH750(20), kScreenWidth, kScrAdaptationH750(100))];
    selectView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:selectView];
    
    UIImageView *selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScrAdaptationW750(30), kScrAdaptationH750(34), kScrAdaptationW750(32), kScrAdaptationH750(32))];
    [selectView addSubview:selectImageView];
    
    if ([_couponid isEqualToString:@"不使用优惠券"]) {
        selectImageView.image = [UIImage imageNamed:@"chooseCoupon"];
    } else {
        selectImageView.image = [UIImage imageNamed:@"unselectCoupon"];
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScrAdaptationW750(92), 0, kScreenWidth, kScrAdaptationH750(100))];
    label.text = @"不使用优惠券";
    label.font = kHXBFont_PINGFANGSC_REGULAR(15);
    label.textColor = COR6;
    [selectView addSubview:label];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToPop:)];
    [headView addGestureRecognizer:tap];
    
    return headView;
}

- (void)tapToPop:(UITapGestureRecognizer *)tap {
    // 点击回调参数
    if ([self.delegate respondsToSelector:@selector(chooseDiscountCouponViewController:didSendModel:)]) {
        if (self.viewModel.chooseCouponModel.dataList.count > 0 || self.viewModel.chooseCouponModel.unusableList.count > 0) {
            [self.delegate chooseDiscountCouponViewController:self didSendModel:nil];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.viewModel.chooseCouponModel.dataList.count && self.viewModel.chooseCouponModel.unusableList.count) {
        return 2;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (self.viewModel.chooseCouponModel.dataList.count) {
            return self.viewModel.chooseCouponModel.dataList.count;
        } else if (self.viewModel.chooseCouponModel.unusableList.count) {
            return self.viewModel.chooseCouponModel.unusableList.count;
        } else {
            return 0;
        }
    } else {
        return self.viewModel.chooseCouponModel.unusableList.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kScrAdaptationH750(90);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH750(90))];
    sectionView.backgroundColor = BACKGROUNDCOLOR;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScrAdaptationW750(30), kScrAdaptationH750(40), kScreenWidth, kScrAdaptationH750(30))];
    label.backgroundColor = BACKGROUNDCOLOR;
    // 第一个section，如果可用的有展示可用的，可用的没有，展示不可用的
    if (section == 0) {
        if (self.viewModel.chooseCouponModel.dataList.count) {
            label.text = @"可用优惠券";
        } else {
            label.text = @"不可用优惠券";
        }
    } else {
        label.text = @"不可用优惠券";
    }
    
    label.font = kHXBFont_PINGFANGSC_REGULAR(15);
    label.textColor = COR10;
    [sectionView addSubview:label];
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"identifier";
    HXBChooseDiscountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HXBChooseDiscountTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    if (_num > 0) {
        if (indexPath.section == 0 && indexPath.row == _num - 1) {
            cell.hasSelect = YES;
        } else {
            cell.hasSelect = NO;
        }
    }
    if (self.viewModel.chooseCouponModel.dataList.count) {
        if (indexPath.section) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.couponModel = self.viewModel.chooseCouponModel.unusableList[indexPath.row];
            cell.isAvalible = NO;
            if (indexPath.row == self.viewModel.chooseCouponModel.unusableList.count - 1) {
                cell.isHiddenLine = YES;
            } else {
                cell.isHiddenLine = NO;
            }
        } else {
            cell.isAvalible = YES;
            cell.couponModel = self.viewModel.chooseCouponModel.dataList[indexPath.row];
            if (indexPath.row == self.viewModel.chooseCouponModel.dataList.count - 1) {
                cell.isHiddenLine = YES;
            } else {
                cell.isHiddenLine = NO;
            }
        }
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isAvalible = NO;
        cell.couponModel = self.viewModel.chooseCouponModel.unusableList[indexPath.row];
        if (indexPath.row == self.viewModel.chooseCouponModel.unusableList.count - 1) {
            cell.isHiddenLine = YES;
        } else {
            cell.isHiddenLine = NO;
        }
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && self.viewModel.chooseCouponModel.dataList.count > 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        // 点击回调参数
        if ([self.delegate respondsToSelector:@selector(chooseDiscountCouponViewController:didSendModel:)]) {
            if (self.viewModel.chooseCouponModel.dataList.count > 0 || self.viewModel.chooseCouponModel.unusableList.count > 0) {
                [self.delegate chooseDiscountCouponViewController:self didSendModel:self.viewModel.chooseCouponModel.dataList[indexPath.row]];
            }
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setUpDate {
    NSDictionary *dic_post = @{
                          @"id": _planid,
                          @"amount": _investMoney,
                          @"type": _type
                          };
    kWeakSelf
    [_viewModel chooseCouponListWithParams:dic_post resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf displaySuccessData];
        } else {
            self.noDataView.hidden = NO;
        }
    }];
}

- (void)displaySuccessData {
    NSInteger num = 0;
    for (HXBCouponModel *couponModel in self.viewModel.chooseCouponModel.dataList) {
        num++;
        if ([couponModel.ID isEqualToString:_couponid]) {
            _num = num;
        }
    }
    if (self.viewModel.chooseCouponModel.dataList.count == 0 && self.viewModel.chooseCouponModel.unusableList.count == 0) {
        self.nodataView.hidden = NO;
        self.notifitionView.hidden = YES;
    } else {
        self.tableView.hidden = NO;
        self.nodataView.hidden = YES;
    }
    [self.tableView reloadData];
}

- (HXBNoDataView *)nodataView {
    if (!_nodataView) {
        _nodataView = [[HXBNoDataView alloc]initWithFrame:CGRectZero];
        _nodataView.imageName = @"noCoupons";
        _nodataView.noDataMassage = @"暂无优惠券";
        [self.view addSubview:_nodataView];
        _nodataView.hidden = YES;
        [_nodataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(kScrAdaptationH(140));
            make.height.width.equalTo(@(kScrAdaptationH(184)));
            make.centerX.equalTo(self.view);
        }];
    }
    return _nodataView;
}

- (HXBMy_Withdraw_notifitionView *)notifitionView {
    if (!_notifitionView) {
        _notifitionView = [[HXBMy_Withdraw_notifitionView alloc] initWithFrame:CGRectMake(0, HXBStatusBarAndNavigationBarHeight, kScreenWidth, kScrAdaptationH(40))];
    }
    _notifitionView.messageCount = @"请输入金额后使用";
    _notifitionView.imageName = @"couponTips_red";
    _notifitionView.hidden = YES;
    _notifitionView.block = ^{
        NSLog(@"点击了消息");
    };
    return _notifitionView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
