//
//  HXBMY_Plan_Capital_ViewController.m
//  hoomxb
//
//  Created by HXB on 2017/6/28.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_Plan_Capital_ViewController.h"
#import "HXBFinanctingRequest.h"
#import "HXBMYRequest.h"
#import "HXBMY_PlanViewModel_LoanRecordViewModel.h"
#import "HXBNoDataView.h"

static NSString *const cellID = @"cellID";
@interface HXBMY_Plan_Capital_ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *planCapitalTableView;

@property (nonatomic,strong) NSArray<HXBMY_PlanViewModel_LoanRecordViewModel *> *dataArray;
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) HXBMYRequest *request;
/**
 没有数据
 */
@property (nonatomic, strong) HXBNoDataView *noDataView;
@end



@implementation HXBMY_Plan_Capital_ViewController

@synthesize dataArray = _dataArray;
- (void)setDataArray:(NSMutableArray <HXBMY_PlanViewModel_LoanRecordViewModel *>*)dataArray {
    _dataArray = dataArray;
    [self.planCapitalTableView reloadData];
}

- (HXBMYRequest *)request {
    if (!_request) {
        _request = [[HXBMYRequest alloc]init];
    }
    return _request;
}
- (NSArray<HXBMY_PlanViewModel_LoanRecordViewModel *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSArray alloc]init];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     
    self.title = @"投资记录";
    self.isColourGradientNavigationBar = YES;
    self.topView = [self headView];
    [self.view addSubview: self.topView];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(64);
        make.height.equalTo(@44);
    }];
    
    self.planCapitalTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.planCapitalTableView];
    
    [self.planCapitalTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.topView.mas_bottom);
    }];
    kWeakSelf
    [self.planCapitalTableView hxb_FooterWithRefreshBlock:^{
        [weakSelf downLoadWithIsUPLoad:false];
    } andSetUpGifFooterBlock:^(MJRefreshBackNormalFooter *footer) {
    }];
    [self.planCapitalTableView hxb_HeaderWithHeaderRefreshCallBack:^{
        [weakSelf downLoadWithIsUPLoad:true];
    } andSetUpGifHeaderBlock:^(MJRefreshNormalHeader *header) {
    }];
    
    self.planCapitalTableView.delegate = self;
    self.planCapitalTableView.dataSource = self;
    
    [self.planCapitalTableView registerClass:[HXBMY_Plan_Capital_Cell class] forCellReuseIdentifier:cellID];
    [self downLoadWithIsUPLoad:true];
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
    NSArray *viewArray = @[
                           planIDLabel,amountLabel,timeLabel,typeLabel
                           ];
    
    [viewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [viewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(headView);
    }];
    planIDLabel.text =  @"标的ID";
    amountLabel.text =  @"投资金额(元)";
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

- (void)downLoadWithIsUPLoad: (BOOL)isUPLoad {
    kWeakSelf
    [self.request loanRecord_my_Plan_WithIsUPData: isUPLoad andPlanID:self.planID andSuccessBlock:^(NSArray<HXBMY_PlanViewModel_LoanRecordViewModel *> *viewModelArray) {
        weakSelf.dataArray= viewModelArray;
        if (weakSelf.dataArray.count) {
             [self.planCapitalTableView reloadData];
        }else
        {
            self.noDataView.hidden = NO;
        }
    } andFailureBlock:^(NSError *error) {
        [weakSelf.planCapitalTableView endRefresh];
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
    cell.ID = _dataArray[indexPath.row].loanId;
    cell.loanAoumt = _dataArray[indexPath.row].amount;
    cell.time = _dataArray[indexPath.row].lendTime;
    cell.type = _dataArray[indexPath.row].status;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (HXBNoDataView *)noDataView
{
    if (!_noDataView) {
         _noDataView = [[HXBNoDataView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
        _noDataView.imageName = @"Fin_NotData";
        _noDataView.noDataMassage = @"暂无投资记录";
        _noDataView.hidden = YES;
        _noDataView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_noDataView];
    }
    return _noDataView;
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
    
    
    [self.contentView addSubview:self.planIDLabel];
    [self.contentView addSubview:self.amountLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.typeLabel];
    NSArray *viewArray = @[
                          self.planIDLabel,self.amountLabel,self.timeLabel,self.typeLabel
                           ];
    
    [viewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [viewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
    }];
//    [self.planIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.top.equalTo(self.contentView);
//        make.left.equalTo(self.contentView);
//        make.width.equalTo(self).multipliedBy(1 / 4);
//    }];
//    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.top.equalTo(self.contentView);
//        make.left.equalTo(self.planIDLabel.mas_right);
//        make.width.equalTo(self).multipliedBy(1 / 4);
//    }];
//    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.top.equalTo(self.contentView);
//        make.left.equalTo(self.amountLabel.mas_right);
//        make.width.equalTo(self).multipliedBy(1 / 4);
//    }];
//    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.top.equalTo(self.contentView);
//        make.left.equalTo(self.timeLabel.mas_right);
//        make.width.equalTo(self).multipliedBy(1 / 4);
//    }];
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

