//
//  HXBMY_Plan_Capital_ViewController.m
//  hoomxb
//
//  Created by HXB on 2017/6/28.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_Plan_Capital_ViewController.h"
#import "HXBMY_PlanViewModel_LoanRecordViewModel.h"
#import "HXBNoDataView.h"
#import "HXBMyPlanCapitalRecordViewModel.h"
#import "HXBBaseWKWebViewController.h"
#import "HXBFinancing_LoanDetailsViewController.h"

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
    UILabel *agreementLabel = [[UILabel alloc]init];
    
    [headView addSubview:planIDLabel];
    [headView addSubview:amountLabel];
    [headView addSubview:timeLabel];
    [headView addSubview:typeLabel];
    [headView addSubview:agreementLabel];
    
    [planIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(headView);
        make.left.equalTo(headView).offset(kScrAdaptationW750(29));
        make.width.offset(kScrAdaptationW750(84));
    }];
    [amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(headView);
        make.left.equalTo(planIDLabel.mas_right).offset(kScrAdaptationW(20.5));
        make.width.offset(kScrAdaptationW(82));
    }];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(headView);
        make.left.equalTo(amountLabel.mas_right).offset(kScrAdaptationW(41.3));
        make.width.offset(kScrAdaptationW(29));
    }];
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(headView);
        make.left.equalTo(timeLabel.mas_right).offset(kScrAdaptationW(52.5));
        make.width.offset(kScrAdaptationW(28));
    }];
    [agreementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(headView);
        make.left.equalTo(typeLabel.mas_right).offset(kScrAdaptationW(20.5));
        make.width.offset(kScrAdaptationW(28));
    }];
    
    
    planIDLabel.text =  @"标的ID";
    amountLabel.text =  @"出借金额(元)";
    timeLabel.text =  @"时间";
    typeLabel.text =  @"状态";
    agreementLabel.text = @"合同";
    planIDLabel.textAlignment = NSTextAlignmentCenter;
    amountLabel.textAlignment = planIDLabel.textAlignment;
    timeLabel.textAlignment = planIDLabel.textAlignment;
    typeLabel.textAlignment = planIDLabel.textAlignment;
    agreementLabel.textAlignment = planIDLabel.textAlignment;
    planIDLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
    amountLabel.font = planIDLabel.font;
    timeLabel.font = planIDLabel.font;
    typeLabel.font = planIDLabel.font;
    agreementLabel.font = planIDLabel.font;
    planIDLabel.textColor = COR10;
    amountLabel.textColor = planIDLabel.textColor;
    timeLabel.textColor = planIDLabel.textColor;
    typeLabel.textColor = planIDLabel.textColor;
    agreementLabel.textColor = planIDLabel.textColor;
    return headView;
}

- (void)downLoadData{
    kWeakSelf
    NSString *requestURL = @"";
    self.noDataView.noDataMassage = @"暂无数据";
    
    if (self.type == HXBInvestmentRecord) {
        self.title = @"出借记录";
        if(self.investmentType == HXBRequestType_MY_PlanRequestType_HOLD_PLAN) {//持有中
            self.noDataView.noDataMassage = @"正在为您努力匹配债权 ";
        }
        requestURL = kHXBFin_loanRecordURL(self.planID);
    }else if(self.type == HXBTransferRecord)
    {
        self.title = @"转让记录";
        requestURL = kHXBFin_CreditorRecordURL(self.planID);
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
    
    kWeakSelf
    cell.agreementAct = ^(NSString *pId) {
        [HXBBaseWKWebViewController pushWithPageUrl:[NSString splicingH5hostWithURL:kHXB_Negotiate_ServeLoan_AccountURL(pId)] fromController:weakSelf];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *loanId = _dataArray[indexPath.row].loanId;
    
    HXBFinancing_LoanDetailsViewController *vc = [[HXBFinancing_LoanDetailsViewController alloc] init];
    vc.loanID = loanId;
    vc.isHidebottomButton = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
/**
 合同查看按钮
 */
@property (nonatomic, strong) UIButton *agreementBtn;
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
    self.agreementBtn = [[UIButton alloc] init];
    [self.agreementBtn addTarget:self action:@selector(agreementButtonAct:) forControlEvents:UIControlEventTouchUpInside];
    [self.agreementBtn setTitle:@"合同" forState:UIControlStateNormal];
    
    self.planIDLabel.textAlignment = NSTextAlignmentCenter;
    self.amountLabel.textAlignment = NSTextAlignmentRight;
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.typeLabel.textAlignment = NSTextAlignmentRight;
    self.planIDLabel.textColor = self.amountLabel.textColor = self.timeLabel.textColor = self.typeLabel.textColor = COR6;
    [self.agreementBtn setTitleColor:kHXBColor_4D88FA_100 forState:UIControlStateNormal];
    
    self.planIDLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    self.amountLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    self.timeLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    self.typeLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    self.agreementBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    
    [self.contentView addSubview:self.planIDLabel];
    [self.contentView addSubview:self.amountLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.agreementBtn];
    [self.contentView addSubview:self.line];

    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView).offset(kScrAdaptationW750(30));
        make.right.equalTo(self.contentView).offset(kScrAdaptationW750(-30));
        make.height.offset(kHXBDivisionLineHeight);
    }];
    [self.planIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(kScrAdaptationW(15));
        make.width.offset(kScrAdaptationW(48));
    }];
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.planIDLabel.mas_right).offset(kScrAdaptationW(15));
        make.width.offset(kScrAdaptationW(81));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.amountLabel.mas_right).offset(kScrAdaptationW(20));
        make.width.offset(kScrAdaptationW(72));
    }];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.timeLabel.mas_right).offset(kScrAdaptationW(10));
        make.width.offset(kScrAdaptationW(49));
    }];
    [self.agreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.typeLabel.mas_right).offset(kScrAdaptationW(12));
        make.width.offset(kScrAdaptationW(48));
    }];
}

- (void)agreementButtonAct:(UIButton*)button {
    if(self.agreementAct) {
        self.agreementAct(self.ID);
    }
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

