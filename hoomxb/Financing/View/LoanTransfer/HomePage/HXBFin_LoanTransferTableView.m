//
//  HXBFin_LoanTransferTableView.m
//  hoomxb
//
//  Created by HXB on 2017/7/1.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_LoanTransferTableView.h"
#import "HXBFinHomePageViewModel_LoanTruansferViewModel.h"
#import "HXBFin_TableViewCell_LoanTransfer.h"
static NSString *const kcellClass = @"HXBFin_TableViewCell_LoanTransfer";


@interface HXBFin_LoanTransferTableView()<
UITableViewDelegate,UITableViewDataSource
>
/**
 点击了cell
 */
@property (nonatomic,copy) void(^clickCellBlock)(id cellModel, NSIndexPath *index);
@end

@implementation HXBFin_LoanTransferTableView
- (void)setLoanTruansferViewModel:(NSArray<HXBFinHomePageViewModel_LoanTruansferViewModel *> *)loanTruansferViewModel {
    _loanTruansferViewModel = loanTruansferViewModel;
    if (!loanTruansferViewModel.count) {
        NSLog(@"没有数据");
    }
    [self reloadData];
}

- (void)clickCellWithBlock:(void (^)(HXBFinHomePageViewModel_LoanTruansferViewModel *model, NSIndexPath *index))clickCellBlock
{
    self.clickCellBlock = clickCellBlock;
}
- (instancetype) initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self setUPViews];
    }
    return self;
}
- (void)setUPViews {
    self.delegate = self;
    self.dataSource = self;
    
    [self registerClass:NSClassFromString(kcellClass) forCellReuseIdentifier:kcellClass];
    self.tableFooterView = [[UIView alloc]init];
    self.rowHeight = 80;
}

#pragma mark - tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.clickCellBlock) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        self.clickCellBlock(cell.cellModel, indexPath);
    }
}


#pragma mark - tableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"🌶，测试数据");
//    return 100;
    return self.loanTruansferViewModel.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXBFin_TableViewCell_LoanTransfer *cell = [tableView dequeueReusableCellWithIdentifier:kcellClass forIndexPath:indexPath];
    
    cell.LoanTruansferViewModel = self.loanTruansferViewModel[indexPath.row];
    return cell;
}

@end
