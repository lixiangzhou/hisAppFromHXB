//
//  HXBMY_Plan_Capital_ViewController.m
//  hoomxb
//
//  Created by HXB on 2017/6/28.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_Plan_Capital_ViewController.h"
#import "HXBFinanctingRequest.h"
#import "HXBMY_PlanViewModel_LoanRecordViewModel.h"
#import "HXBNoDataView.h"
#import "HXBMyPlanCapitalRecordViewModel.h"

static NSString *const cellID = @"cellID";

@interface HXBMY_Plan_Capital_ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *planCapitalTableView;

@property (nonatomic,strong) NSArray<HXBMY_PlanViewModel_LoanRecordViewModel *> *dataArray;
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) HXBMyPlanCapitalRecordViewModel *planCapitalRecordViewModel;
/**
 没有数据
 */
//@property (nonatomic, strong) HXBNoDataView *noDataView;
@end



@implementation HXBMY_Plan_Capital_ViewController

@synthesize dataArray = _dataArray;
- (void)setDataArray:(NSMutableArray <HXBMY_PlanViewModel_LoanRecordViewModel *>*)dataArray {
    _dataArray = dataArray;
    [self.planCapitalTableView reloadData];
}

- (NSArray<HXBMY_PlanViewModel_LoanRecordViewModel *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSArray alloc]init];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    kWeakSelf
    self.isColourGradientNavigationBar = YES;
    self.topView = [self headView];
    [self.view addSubview: self.topView];

    self.planCapitalRecordViewModel = [[HXBMyPlanCapitalRecordViewModel alloc] initWithBlock:^UIView *{
        return weakSelf.view;
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.top.equalTo(weakSelf.view.mas_top).offset(HXBStatusBarAndNavigationBarHeight);
        make.height.offset(kScrAdaptationH750(100));
    }];
    
    self.planCapitalTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.planCapitalTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [HXBMiddlekey AdaptationiOS11WithTableView:self.planCapitalTableView];
    [self.view addSubview:self.planCapitalTableView];

    [self.planCapitalTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.topView.mas_bottom);
    }];
    
    [self.planCapitalTableView hxb_footerWithRefreshBlock:^{
        if ([weakSelf.planCapitalRecordViewModel.totalCount integerValue] > defaultPageCount && weakSelf.planCapitalRecordViewModel.currentPageCount >= defaultPageCount) {
            weakSelf.planCapitalRecordViewModel.planLoanRecordPage++;
            [weakSelf downLoadData];
        }
    }];
    [self.planCapitalTableView hxb_headerWithRefreshBlock:^{
        weakSelf.planCapitalRecordViewModel.planLoanRecordPage = 1;
        [weakSelf downLoadData];
    }];
    
    self.planCapitalTableView.delegate = self;
    self.planCapitalTableView.dataSource = self;
    
    [self.planCapitalTableView registerClass:[HXBMY_Plan_Capital_Cell class] forCellReuseIdentifier:cellID];
    [self downLoadData];
    
    
    [self.view addSubview:self.noDataView];
    [self.noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.centerY.equalTo(weakSelf.view).offset(-50);
    }];
}

- (UIView *)headView{
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = BACKGROUNDCOLOR;
    UILabel *planIDLabel = [[UILabel alloc]init];
    UILabel *amountLabel = [[UILabel alloc]init];
    UILabel *timeLabel = [[UILabel alloc]init];
    UILabel *typeLabel = [[UILabel alloc]init];
    
    
    [headView addSubview:planIDLabel];
    [headView addSubview:amountLabel];
    [headView addSubview:timeLabel];
    [headView addSubview:typeLabel];
    
    [planIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(headView);
        make.left.equalTo(headView).offset(kScrAdaptationH750(30));
        make.width.offset(kScrAdaptationW750(84));
    }];
    [amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(headView);
        make.right.equalTo(headView).offset(-kScrAdaptationW750(413));
    }];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(headView);
        make.left.equalTo(amountLabel.mas_right).offset(kScrAdaptationW750(128));
//        make.right.equalTo(typeLabel.mas_left);
    }];
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(headView);
        make.right.equalTo(headView).offset(-kScrAdaptationH750(30));
        make.width.offset(kScrAdaptationW750(57));
    }];
    
    
    planIDLabel.text =  @"标的ID";
    amountLabel.text =  @"出借金额(元)";
    timeLabel.text =  @"时间";
    typeLabel.text =  @"状态";
    planIDLabel.textAlignment = NSTextAlignmentCenter;
    amountLabel.textAlignment = planIDLabel.textAlignment;
    timeLabel.textAlignment = planIDLabel.textAlignment;
    typeLabel.textAlignment = planIDLabel.textAlignment;
    planIDLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
    amountLabel.font = planIDLabel.font;
    timeLabel.font = planIDLabel.font;
    typeLabel.font = planIDLabel.font;
    planIDLabel.textColor = COR10;
    amountLabel.textColor = planIDLabel.textColor;
    timeLabel.textColor = planIDLabel.textColor;
    typeLabel.textColor = planIDLabel.textColor;
    return headView;
}

- (void)downLoadData{
    kWeakSelf
    NSString *requestURL = @"";
    if (self.type == HXBInvestmentRecord) {
        self.title = @"出借记录";
        self.noDataView.noDataMassage = @"正在为您努力匹配债权";
        requestURL = kHXBFin_loanRecordURL(self.planID);
    }else if(self.type == HXBTransferRecord)
    {
        self.title = @"转让记录";
        requestURL = kHXBFin_CreditorRecordURL(self.planID);
        self.noDataView.noDataMassage = @"暂无数据";
    }
    
    [self.planCapitalRecordViewModel loanRecord_my_Plan_WithRequestUrl:requestURL resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.dataArray= weakSelf.planCapitalRecordViewModel.planLoanRecordViewModel_array;
            if ([weakSelf.planCapitalRecordViewModel.totalCount integerValue] == weakSelf.dataArray.count) {
                [weakSelf.planCapitalTableView.mj_header endRefreshing];
                [weakSelf.planCapitalTableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                [weakSelf.planCapitalTableView endRefresh];
            }
            
            if (weakSelf.dataArray.count>0) {
                weakSelf.topView.hidden = NO;
                weakSelf.planCapitalTableView.hidden = NO;
                weakSelf.noDataView.hidden = YES;
            } else {
                weakSelf.noDataView.hidden = NO;
                weakSelf.planCapitalTableView.hidden = YES;
                weakSelf.topView.hidden = YES;
            }
        } else {
            [weakSelf.planCapitalTableView endRefresh];
        }
    }];
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXBMY_Plan_Capital_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[HXBMY_Plan_Capital_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.ID = _dataArray[indexPath.row].loanId;
    cell.loanAoumt = _dataArray[indexPath.row].amount;
    cell.time = _dataArray[indexPath.row].lendTime;
    
    if (self.type == HXBInvestmentRecord) {
        cell.type = _dataArray[indexPath.row].statusText;

    }else{
        cell.type = _dataArray[indexPath.row].status;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScrAdaptationH750(HXBStatusBarAndNavigationBarHeight);
}

@end
@interface HXBMY_Plan_Capital_Cell ()
/**
 标的id
 */
@property (nonatomic,strong) UILabel *planIDLabel;
/**
 投资金额（元）
 */
@property (nonatomic,strong) UILabel *amountLabel;
/**
 时间
 */
@property (nonatomic,strong) UILabel *timeLabel;
/**
 状态
 */
@property (nonatomic,strong) UILabel *typeLabel;
//line
@property (nonatomic, strong) UIView *line;
@end

@implementation HXBMY_Plan_Capital_Cell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:cellID]) {
        [self setUPViews];
    }
    return self;
}
- (void)setUPViews {
    self.planIDLabel = [[UILabel alloc]init];
    self.amountLabel = [[UILabel alloc]init];
    self.timeLabel = [[UILabel alloc]init];
    self.typeLabel = [[UILabel alloc]init];
    
    self.planIDLabel.textAlignment = NSTextAlignmentCenter;
    self.amountLabel.textAlignment = NSTextAlignmentRight;
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.typeLabel.textAlignment = NSTextAlignmentCenter;
    self.planIDLabel.textColor = self.amountLabel.textColor = self.timeLabel.textColor = self.typeLabel.textColor = COR6;
    
    self.planIDLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    self.amountLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    self.timeLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    self.typeLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    
    [self.contentView addSubview:self.planIDLabel];
    [self.contentView addSubview:self.amountLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.line];

    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView).offset(kScrAdaptationW750(30));
        make.right.equalTo(self.contentView).offset(kScrAdaptationW750(-30));
        make.height.offset(kHXBDivisionLineHeight);
    }];
    [self.planIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(kScrAdaptationH750(30));
    }];
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-kScrAdaptationW750(413));
    }];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-kScrAdaptationH750(30));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self.contentView);
        make.left.equalTo(self.amountLabel.mas_right);
        make.right.equalTo(self.typeLabel.mas_left);
    }];
   
}

- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = COR12;
    }
    return _line;
}

- (void) setTime:(NSString *)time {
    _time = time;
    self.timeLabel.text = time;
}
- (void) setType:(NSString *)type {
    _type = type;
    self.typeLabel.text = type;
}
- (void)setLoanAoumt:(NSString *)loanAoumt {
    _loanAoumt = loanAoumt;
    self.amountLabel.text = loanAoumt;
}
- (void)setID:(NSString *)ID {
    _ID = ID;
    self.planIDLabel.text = ID;
}
@end

