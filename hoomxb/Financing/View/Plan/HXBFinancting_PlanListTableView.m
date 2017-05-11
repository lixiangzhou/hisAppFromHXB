//
//  HXBFinancting_PlanListVIew.m
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinancting_PlanListTableView.h"
#import "HXBFinancting_PlanListTableViewCell.h"
#import "HXBFinHomePageViewModel_PlanList.h"//viewmodel
#import "HXBFinHomePageViewModel_LoanList.h"
#import "HXBFinHomePageModel_PlanList.h"
#import "HXBFinHomePageModel_LoanList.h"
@interface HXBFinancting_PlanListTableView ()
<
UITableViewDelegate,
UITableViewDataSource
>
@end


@implementation HXBFinancting_PlanListTableView



static NSString *CELLID = @"CELLID";


- (void)setPlanListViewModelArray:(NSArray<HXBFinHomePageViewModel_PlanList *> *)planListViewModelArray {
    _planListViewModelArray = planListViewModelArray;
    [self reloadData];
}


- (instancetype) initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self setup];
    }
    return self;
}


- (void)setup {
    self.delegate = self;
    self.dataSource = self;
    
    [self registerClass:[HXBFinancting_PlanListTableViewCell class] forCellReuseIdentifier:CELLID];
    self.separatorInset = UIEdgeInsetsMake(0, -50, 0, 0);
    
    self.rowHeight = 200;
}

#pragma mark - datesource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 20;
    return self.planListViewModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXBFinancting_PlanListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID forIndexPath:indexPath];
    cell.finPlanListViewModel = self.planListViewModelArray[indexPath.row];
    cell.lockPeriodLabel_ConstStr = self.lockPeriodLabel_ConstStr;
    cell.expectedYearRateLable_ConstStr = self.expectedYearRateLable_ConstStr;
    return cell;
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //拿到cell的model
    HXBFinancting_PlanListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //点击后的block回调给了HomePageView
    if (self.clickPlanListCellBlock) {
        self.clickPlanListCellBlock(indexPath, cell.finPlanListViewModel);
    }
}

@end
