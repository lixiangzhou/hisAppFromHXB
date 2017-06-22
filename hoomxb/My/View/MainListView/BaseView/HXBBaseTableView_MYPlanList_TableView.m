//
//  HXBBaseTableView_MYPlanList_TableView.m
//  hoomxb
//
//  Created by HXB on 2017/5/16.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseTableView_MYPlanList_TableView.h"
#import "HXBBaseView_MYList_TableViewCell.h"
#import "HXBMYViewModel_MainLoanViewModel.h"// 我的界面的 loan list ViewModel
#import "HXBMYViewModel_MianPlanViewModel.h"//  我的界面的 plan list ViewModel

static NSString *const CELLID = @"CELLID";
@interface HXBBaseTableView_MYPlanList_TableView ()
<
UITableViewDelegate,
UITableViewDataSource
>
///cell的点击事件的传递
@property (nonatomic,copy) void(^clickLoanCellBlock)(HXBMYViewModel_MainLoanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex);
@property (nonatomic,copy) void(^clickPlanCellBlock)(HXBMYViewModel_MianPlanViewModel *planViewModel, NSIndexPath *clickPlanCellIndex);

@end


@implementation HXBBaseTableView_MYPlanList_TableView
@synthesize mainPlanViewModelArray = _mainPlanViewModelArray;

#pragma mark - setter 
- (void)setMainPlanViewModelArray:(NSArray<HXBMYViewModel_MianPlanViewModel *> *)mainPlanViewModelArray {
    _mainPlanViewModelArray = mainPlanViewModelArray;
    [self reloadData];
}
- (void)setMainLoanViewModelArray:(NSArray<HXBMYViewModel_MainLoanViewModel *> *)mainLoanViewModelArray {
    _mainLoanViewModelArray = mainLoanViewModelArray;
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
    [self registerClass:[HXBBaseView_MYList_TableViewCell class] forCellReuseIdentifier:CELLID];
    self.rowHeight = 130;
}


#pragma mark - delegate 

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mainPlanViewModelArray? self.mainPlanViewModelArray.count : self.mainLoanViewModelArray.count;

    //return self.mainPlanViewModelArray? 3 : 11;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXBBaseView_MYList_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID forIndexPath:indexPath];
    if (self.mainPlanViewModelArray) {
        cell.planViewMode = self.mainPlanViewModelArray[indexPath.row];
    }else {
        cell.loanViewModel = self.mainLoanViewModelArray[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HXBBaseView_MYList_TableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    id model = cell.planViewMode? cell.planViewMode : cell.loanViewModel;
    if (cell.planViewMode && self.clickPlanCellBlock) {
        self.clickPlanCellBlock(model, indexPath);
        return;
    }
    if (cell.loanViewModel && self.clickLoanCellBlock) {
        self.clickLoanCellBlock(model, indexPath);
        return;
    }
}
///点击了cell
- (void)clickLoanCellFuncWithBlock: (void(^)(HXBMYViewModel_MainLoanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex))clickLoanCellBlock{
    self.clickLoanCellBlock = clickLoanCellBlock;
}
- (void)clickPlanCellFuncWithBlock: (void(^)(HXBMYViewModel_MianPlanViewModel *planViewModel, NSIndexPath *clickPlanCellIndex))clickPlanCellBlock{
    self.clickPlanCellBlock = clickPlanCellBlock;
}
@end
