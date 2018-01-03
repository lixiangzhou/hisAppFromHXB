//
//  HXBFinance_MouthType_tableView.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/1/2.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinance_MouthType_tableView.h"
#import "HXBFinancting_PlanListTableViewCell.h"
#import "HXBFinHomePageModel_PlanList.h"

@interface HXBFinance_MouthType_tableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation HXBFinance_MouthType_tableView


static NSString *CELLID = @"CELLID";


- (void)setPlanListViewModelArray:(NSArray<HXBFinHomePageRecommendListModel *> *)planListViewModelArray {
    _planListViewModelArray = planListViewModelArray;
    [self reloadData];
}


- (instancetype) initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
       [self setUI];
    }
    return self;
}

#pragma mark - UI

- (void)setUI {
    self.delegate = self;
    self.dataSource = self;
    self.backgroundColor = kHXBColor_BackGround;
    
    [self registerClass:[HXBFinancting_PlanListTableViewCell class] forCellReuseIdentifier:CELLID];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.backgroundColor = kHXBColor_BackGround;
}

#pragma mark - datesource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXBFinancting_PlanListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID forIndexPath:indexPath];
    cell.planType = @"HXB";
    cell.lockPeriodLabel_ConstStr = self.lockPeriodLabel_ConstStr;
    cell.expectedYearRateLable_ConstStr = self.expectedYearRateLable_ConstStr;
    return cell;
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //拿到cell的model
    HXBFinancting_PlanListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //点击后的block回调给了HomePageView
    if (self.block) {
        self.block(cell.finPlanListViewModel);
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScrAdaptationH750(279);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kScrAdaptationH750(20);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = BACKGROUNDCOLOR;
    return headView;
}

@end
