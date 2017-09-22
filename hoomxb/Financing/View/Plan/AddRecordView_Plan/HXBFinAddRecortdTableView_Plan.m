//
//  HXBFinAddRecortdTableView_Plan.m
//  hoomxb
//
//  Created by HXB on 2017/5/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinAddRecortdTableView_Plan.h"
#import "FinModel_AddRecortdModel_Loan.h"
///红利计划加入记录的model
#import "HXBFinModel_AddRecortdModel_LoanTruansfer.h"
#import "HXBFinModel_AddRecortdModel_Plan.h" 

static NSString *CELLID = @"CELLID";
@interface HXBFinAddRecortdTableView_Plan ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) HXBNoDataView *nodataView;

@end

@implementation HXBFinAddRecortdTableView_Plan

- (void)setAddRecortdModel_Plan:(HXBFinModel_AddRecortdModel_Plan *)addRecortdModel_Plan {
    _addRecortdModel_Plan = addRecortdModel_Plan;
    self.nodataView.hidden = addRecortdModel_Plan.dataList.count;
    [self reloadData];
}

- (void)setLoanModel:(FinModel_AddRecortdModel_Loan *)loanModel {
    _loanModel = loanModel;
    self.nodataView.hidden = loanModel.loanLenderRecord_list.count;
    [self reloadData];
}

- (void)setLoanTruansferModelArray:(NSArray<HXBFinModel_AddRecortdModel_LoanTruansfer *> *)loanTruansferModelArray{
    _loanTruansferModelArray = loanTruansferModelArray;
    self.nodataView.hidden = loanTruansferModelArray.count;
    NSLog(@"_____________%ld", loanTruansferModelArray.count);
    [self reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self setUP];
//        self.backgroundColor = kHXBColor_BackGround;
    }
    return self;
}

- (void)setUP {
    self.delegate = self;
    self.dataSource = self;
    self.separatorInset = UIEdgeInsetsMake(0, kScrAdaptationW(15), 0, kScrAdaptationW(15));
    [self registerClass:[HXBFinAddRecortdTableViewCell_Plan class] forCellReuseIdentifier:CELLID];
    self.rowHeight = kScrAdaptationH(60);
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.addRecortdModel_Plan.dataList.count) {
        return self.addRecortdModel_Plan.dataList.count;
    }
    if (self.loanTruansferModelArray.count) return self.loanTruansferModelArray.count;
    
    return self.loanModel.loanLenderRecord_list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXBFinAddRecortdTableViewCell_Plan *planCell = [tableView dequeueReusableCellWithIdentifier:CELLID forIndexPath:indexPath];
    planCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.addRecortdModel_Plan.dataList.count) {
        planCell.addRecortdModel_plan_dataList = self.addRecortdModel_Plan.dataList[indexPath.row];
    }
    if (self.loanModel.loanLenderRecord_list.count) {
        planCell.loanModel = self.loanModel.loanLenderRecord_list[indexPath.row];
    }
    if (self.loanTruansferModelArray.count) {
        HXBFinModel_AddRecortdModel_LoanTruansfer *loanTruansferModel = self.loanTruansferModelArray[indexPath.row];
        [planCell showWithNumber:loanTruansferModel.index andID:loanTruansferModel.toUserId andDate:loanTruansferModel.createTime andAmount:loanTruansferModel.amount];
    }
    return planCell;
}

- (HXBNoDataView *)nodataView {
    if (!_nodataView) {
        _nodataView = [[HXBNoDataView alloc]initWithFrame:CGRectZero];
        [self addSubview: _nodataView];
        _nodataView.imageName = @"Fin_NotData";
        _nodataView.noDataMassage = @"暂无记录";
        _nodataView.hidden = YES;
        [_nodataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(kScrAdaptationH(100));
            make.height.width.equalTo(@(kScrAdaptationH(184)));
            make.centerX.equalTo(self);
        }];
    }
    return _nodataView;
}
@end




@implementation HXBFinAddRecortdTableViewCell_Plan {
    UILabel *_numberLabel;
    UILabel *_IDLabel;
    UILabel *_dateLabel;
    UILabel *_YUANLable;
}
- (void)showWithNumber: (NSString *)number andID:(NSString *)ID andDate:(NSString *)date andAmount:(NSString *)amount {
    _numberLabel.text   = number;
    _IDLabel.text       = ID;
    _dateLabel.text     = date;
    _YUANLable.text     = amount;
}
- (void)setAddRecortdModel_plan_dataList:(HXBFinModel_AddRecortdModel_Plan_dataList *)addRecortdModel_plan_dataList {
    _addRecortdModel_plan_dataList = addRecortdModel_plan_dataList;

    _numberLabel.text   = addRecortdModel_plan_dataList.index;
    _IDLabel.text       = addRecortdModel_plan_dataList.nickName;
    _dateLabel.text     = addRecortdModel_plan_dataList.hxb_joinTime;
    _YUANLable.text     = addRecortdModel_plan_dataList.amount_YUAN;
}

- (void)setLoanModel:(HXBFinModel_AddRecortdModel_loanLenderRecord_list_Loan *)loanModel {
    _loanModel = loanModel;
    _numberLabel.text   = loanModel.index;
    _IDLabel.text       = loanModel.username;
    _dateLabel.text     = loanModel.lendTime;
    _YUANLable.text     = loanModel.amount;
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
        make.left.equalTo(weakSelf.contentView).offset(kScrAdaptationW(15));
    }];
    _numberLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
    _numberLabel.textColor = kHXBColor_HeightGrey_Font0_4;
    
    [_IDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView.mas_centerY).offset(kScrAdaptationH(-1.5));
        make.left.equalTo(_numberLabel.mas_right).offset(20);
    }];
    _IDLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
    _IDLabel.textColor = kHXBColor_Grey_Font0_2;
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_IDLabel);
        make.top.equalTo(_IDLabel.mas_bottom).offset(3);
    }];
    _dateLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    _dateLabel.textColor = kHXBColor_Font0_6;
    
    [_YUANLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.right.equalTo(weakSelf.contentView).offset(-15);
    }];
    _YUANLable.font = kHXBFont_PINGFANGSC_REGULAR(14);
    _YUANLable.textColor = kHXBColor_HeightGrey_Font0_4;
}



@end
