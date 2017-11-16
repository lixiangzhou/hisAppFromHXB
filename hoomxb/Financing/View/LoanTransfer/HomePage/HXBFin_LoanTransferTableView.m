//
//  HXBFin_LoanTransferTableView.m
//  hoomxb
//
//  Created by HXB on 2017/7/1.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
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

@property (nonatomic,strong) HXBNoDataView *nodataView;
@end

@implementation HXBFin_LoanTransferTableView
- (instancetype) initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self setUPViews];
        self.nodataView.hidden = false;
        self.backgroundColor = kHXBColor_BackGround;
    }
    return self;
}
- (void)setUPViews {
    self.delegate = self;
    self.dataSource = self;
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self registerClass:NSClassFromString(kcellClass) forCellReuseIdentifier:kcellClass];
    self.tableFooterView = [[UIView alloc]init];
    self.rowHeight = kScrAdaptationH(120);
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
        HXBFin_TableViewCell_LoanTransfer *cell = [tableView cellForRowAtIndexPath:indexPath];
        self.clickCellBlock(cell.LoanTruansferViewModel, indexPath);
    }
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

#pragma mark - tableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.loanTruansferViewModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXBFin_TableViewCell_LoanTransfer *cell = [tableView dequeueReusableCellWithIdentifier:kcellClass forIndexPath:indexPath];
    
    cell.LoanTruansferViewModel = self.loanTruansferViewModel[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.clickStutasButtonBlock = ^(id model) {
//        if (self.clickCellBlock) {
//            self.clickCellBlock(self.loanTruansferViewModel[indexPath.row], indexPath);
//        }
//    };
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
