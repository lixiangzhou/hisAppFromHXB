//
//  HXBFinancting_LoanListTableView.m
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinancting_LoanListTableView.h"

#import "HXBFinancting_PlanListTableViewCell.h"
#import "HXBFinHomePageViewModel_LoanList.h"
#import "HXBFinHomePageViewModel_LoanList.h"


@interface HXBFinancting_LoanListTableView ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic,strong) HXBNoDataView *nodataView;
@end


@implementation HXBFinancting_LoanListTableView

static NSString *CELLID = @"CELLID";

#pragma mark - setter
- (void)setLoanListViewModelArray:(NSArray<HXBFinHomePageViewModel_LoanList *> *)loanListViewModelArray {
    _loanListViewModelArray = loanListViewModelArray;
    self.nodataView.hidden = loanListViewModelArray.count;
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
    self.rowHeight = kScrAdaptationH(121);
}

#pragma mark - datesource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.loanListViewModelArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXBFinancting_PlanListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID forIndexPath:indexPath];
    cell.loanListViewModel = self.loanListViewModelArray[indexPath.row];
    
    cell.lockPeriodLabel_ConstStr = self.lockPeriodLabel_ConstStr;
    cell.expectedYearRateLable_ConstStr = self.expectedYearRateLable_ConstStr;
    return cell;
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //拿到cell的model
    HXBFinancting_PlanListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  
    //点击后的block回调给了HomePageView
    if (self.clickLoanListCellBlock) {
        self.clickLoanListCellBlock(indexPath, cell.loanListViewModel);
    }
}
- (HXBNoDataView *)nodataView {
    if (!_nodataView) {
        _nodataView = [[HXBNoDataView alloc]initWithFrame:CGRectZero];
        _nodataView.imageName = @"Fin_NotData";
        _nodataView.noDataMassage = @"暂无数据";
        _nodataView.downPULLMassage = @"下拉进行刷新";
        [self addSubview:_nodataView];
        [_nodataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(kScrAdaptationH(139));
            make.height.width.equalTo(@(kScrAdaptationH(184)));
            make.centerX.equalTo(self);
        }];
    }
    return _nodataView;
}
@end
