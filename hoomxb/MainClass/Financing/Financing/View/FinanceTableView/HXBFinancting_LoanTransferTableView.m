//
//  HXBFin_LoanTransferTableView.m
//  hoomxb
//
//  Created by HXB on 2017/7/1.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinancting_LoanTransferTableView.h"
#import "HXBFinanceLoanTransferCell.h"

@interface HXBFinancting_LoanTransferTableView()<
UITableViewDelegate,UITableViewDataSource
>
/**
 点击了cell
 */
@property (nonatomic,copy) void(^clickCellBlock)(id cellModel, NSIndexPath *index);

@property (nonatomic,strong) HXBNoDataView *nodataView;
@end

@implementation HXBFinancting_LoanTransferTableView
- (instancetype) initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self setUPViews];
        self.nodataView.hidden = NO;
    }
    return self;
}
- (void)setUPViews {
    self.delegate = self;
    self.dataSource = self;
    self.backgroundColor = [UIColor whiteColor];
    [self registerClass:[HXBFinanceLoanTransferCell class] forCellReuseIdentifier:HXBFinanceLoanTransferCellID];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableFooterView = [[UIView alloc]init];
    self.rowHeight = kScrAdaptationH750(220);
}
- (void)setLoanTruansferViewModel:(NSArray<HXBFinHomePageViewModel_LoanTruansferViewModel *> *)loanTruansferViewModel {
    _loanTruansferViewModel = loanTruansferViewModel;
    self.nodataView.hidden = loanTruansferViewModel.count;
    [self reloadData];
}

- (void)clickCellWithBlock:(void (^)(HXBFinHomePageViewModel_LoanTruansferViewModel *model, NSIndexPath *index))clickCellBlock
{
    self.clickCellBlock = clickCellBlock;
}


#pragma mark - tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.clickCellBlock) {
        HXBFinanceLoanTransferCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        self.clickCellBlock(cell.loanTruansferViewModel, indexPath);
    }
}
#pragma mark - tableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.loanTruansferViewModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXBFinanceLoanTransferCell *cell = [tableView dequeueReusableCellWithIdentifier:HXBFinanceLoanTransferCellID forIndexPath:indexPath];
    cell.loanTruansferViewModel = self.loanTruansferViewModel[indexPath.row];
    return cell;
}
- (HXBNoDataView *)nodataView {
    if (!_nodataView) {
        _nodataView = [[HXBNoDataView alloc]initWithFrame:CGRectZero];
        [self addSubview: _nodataView];
        _nodataView.imageName = @"Fin_NotData";
        _nodataView.noDataMassage = @"暂无转让中的债权";
        [_nodataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(kScrAdaptationH(100));
            make.height.width.equalTo(@(kScrAdaptationH(184)));
            make.centerX.equalTo(self);
        }];
    }
    return _nodataView;
}

@end
