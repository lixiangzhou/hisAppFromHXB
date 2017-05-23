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

static NSString * const CELLID = @"CELLID";

@interface HXBMYCapitalRecord_TableView ()
<
UITableViewDelegate,
UITableViewDataSource
>

@end

@implementation HXBMYCapitalRecord_TableView
- (void)setCapitalRecortdDetailViewModelArray:(NSArray<HXBMYViewModel_MainCapitalRecordViewModel *> *)capitalRecortdDetailViewModelArray {
    _capitalRecortdDetailViewModelArray = capitalRecortdDetailViewModelArray;
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
    self.rowHeight = kScrAdaptationH(80);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.capitalRecortdDetailViewModelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXBMYCapitalRecord_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID forIndexPath:indexPath];
    cell.capitalRecortdDetailViewModel = self.capitalRecortdDetailViewModelArray[indexPath.row];
    return cell;
}

@end
