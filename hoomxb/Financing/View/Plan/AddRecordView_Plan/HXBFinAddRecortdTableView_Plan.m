//
//  HXBFinAddRecortdTableView_Plan.m
//  hoomxb
//
//  Created by HXB on 2017/5/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinAddRecortdTableView_Plan.h"
///红利计划加入记录的model
#import "HXBFinModel_AddRecortdModel_Plan.h"
static NSString *CELLID = @"CELLID";
@interface HXBFinAddRecortdTableView_Plan ()
<
UITableViewDelegate,
UITableViewDataSource
>

@end

@implementation HXBFinAddRecortdTableView_Plan

- (void)setAddRecortdModel_Plan:(HXBFinModel_AddRecortdModel_Plan *)addRecortdModel_Plan {
    _addRecortdModel_Plan = addRecortdModel_Plan;
    [self reloadData];
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self setUP];
    }
    return self;
}

- (void)setUP {
    self.delegate = self;
    self.dataSource = self;
    [self registerClass:[HXBFinAddRecortdTableViewCell_Plan class] forCellReuseIdentifier:CELLID];
    self.rowHeight = 60;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.addRecortdModel_Plan.dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXBFinAddRecortdTableViewCell_Plan *planCell = [tableView dequeueReusableCellWithIdentifier:CELLID forIndexPath:indexPath];
    planCell.addRecortdModel_plan_dataList = self.addRecortdModel_Plan.dataList[indexPath.row];
    return planCell;
}
@end




@implementation HXBFinAddRecortdTableViewCell_Plan {
    UILabel *_numberLabel;
    UILabel *_IDLabel;
    UILabel *_dateLabel;
    UILabel *_YUANLable;
}

- (void)setAddRecortdModel_plan_dataList:(HXBFinModel_AddRecortdModel_Plan_dataList *)addRecortdModel_plan_dataList {
    _addRecortdModel_plan_dataList = addRecortdModel_plan_dataList;
    
    _numberLabel.text = addRecortdModel_plan_dataList.index;
    _IDLabel.text = @"测试的字段";
    _dateLabel.text = addRecortdModel_plan_dataList.joinTime;
    _YUANLable.text = addRecortdModel_plan_dataList.amount;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUP];
    }
    return self;
}
- (void)setUP {
    //创建subView
    [self creatSubView];
    //布局子控件
    [self setUPSubViewFrame];
}


- (void)creatSubView {
    _numberLabel = [[UILabel alloc]init];
    _IDLabel = [[UILabel alloc]init];
    _dateLabel = [[UILabel alloc]init];
    _YUANLable = [[UILabel alloc]init];
    [self.contentView addSubview:_numberLabel];
    [self.contentView addSubview:_IDLabel];
    [self.contentView addSubview:_dateLabel];
    [self.contentView addSubview:_YUANLable];
}


- (void)setUPSubViewFrame {
    kWeakSelf
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.contentView).offset(20);
    }];
    [_IDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(10);
        make.left.equalTo(_numberLabel.mas_right).offset(20);
    }];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_IDLabel);
        make.top.equalTo(_IDLabel.mas_bottom).offset(10);
    }];
    [_YUANLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.right.equalTo(weakSelf.contentView).offset(-10);
    }];
}
@end
