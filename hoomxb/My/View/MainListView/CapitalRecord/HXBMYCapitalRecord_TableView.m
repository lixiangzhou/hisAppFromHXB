//
//  HXBMYCapitalRecord_TableView.m
//  hoomxb
//
//  Created by HXB on 2017/5/23.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMYCapitalRecord_TableView.h"
#import "HXBMYModel_CapitalRecordDetailModel.h"///资金记录的MOdel
#import "HXBMYViewModel_MainCapitalRecordViewModel.h"///资金记录的ViewModel
#import "HXBMYCapitalRecord_TableViewCell.h"///资产记录的TableViewCell
#import "HXBMYCapitalRecord_TableViewHeaderView.h"///
static NSString * const CELLID = @"CELLID";
static NSString * const HeaderID = @"HeaderID";
@interface HXBMYCapitalRecord_TableView ()<UITableViewDelegate,UITableViewDataSource>
/**
 按月份组
 */
@property (nonatomic, strong) NSMutableArray *tagArr;

@end

@implementation HXBMYCapitalRecord_TableView

- (void)setCapitalRecortdDetailViewModelArray:(NSArray<HXBMYViewModel_MainCapitalRecordViewModel *> *)capitalRecortdDetailViewModelArray {
    _capitalRecortdDetailViewModelArray = capitalRecortdDetailViewModelArray;
    
    for (int i = 0; i < capitalRecortdDetailViewModelArray.count; i++) {
        HXBMYViewModel_MainCapitalRecordViewModel *mainCapitalRecordViewModel = capitalRecortdDetailViewModelArray[i];
        if (![[self.tagArr lastObject] isEqualToString:mainCapitalRecordViewModel.capitalRecordModel.tag]) {
            [self.tagArr addObject:mainCapitalRecordViewModel.capitalRecordModel.tag];
        }
    }
    [self reloadData];
    self.tableFooterView = [[UIView alloc]init];
}

- (instancetype) initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self setUP];
    }
    return self;
}

- (void)setUP {
    self.delegate = self;
    self.dataSource = self;
    [self registerClass:[HXBMYCapitalRecord_TableViewCell class] forCellReuseIdentifier:CELLID];
    [self registerClass:[HXBMYCapitalRecord_TableViewHeaderView class] forHeaderFooterViewReuseIdentifier:HeaderID];
    self.separatorInset = UIEdgeInsetsMake(0, kScrAdaptationW750(30), 0, kScrAdaptationW750(30));
    self.rowHeight = kScrAdaptationH750(132);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.capitalRecortdDetailViewModelArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tagArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXBMYCapitalRecord_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID forIndexPath:indexPath];
    cell.capitalRecortdDetailViewModel = self.capitalRecortdDetailViewModelArray[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HXBMYCapitalRecord_TableViewHeaderView *header = (HXBMYCapitalRecord_TableViewHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderID ];
    // 覆盖文字
     header.title = self.tagArr[section];
    return header;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kScrAdaptationH750(60);
}

- (NSMutableArray *)tagArr
{
    if (!_tagArr) {
        _tagArr = [NSMutableArray array];
    }
    return _tagArr;
}
@end
