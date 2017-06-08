//
//  HXBMY_CapitalRecordViewController.m
//  hoomxb
//
//  Created by HXB on 2017/5/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_CapitalRecordViewController.h"
#import "HXBMYRequest.h"
#import "HXBMYCapitalRecord_TableView.h"
#import "HXBMYViewModel_MainCapitalRecordViewModel.h"

static NSString *const kNAVRightTitle_UI = @"筛选";
static NSString *const kNAVRightTitle = @"筛选";


static NSString *const kScreen_All_UI = @"全部";
static NSString *const kScreen_All = @"CHECKOUT";

static NSString *const kScreen_Recharge_UI = @"充值";
static NSString *const kScreen_Recharge = @"RECHARGE";

static NSString *const kScreen_Withdrawals_UI = @"提现";
static NSString *const kScreen_Withdrawals = @"CASH_DRAW";

static NSString *const kScreen_Plan_UI = @"红利计划";
static NSString *const kScreen_Plan = @"FINANCEPLAN";

static NSString *const kScreen_Loan_UI = @"散标";
static NSString *const kScreen_Loan = @"LOAN_AND_TRANSFER";

@interface HXBMY_CapitalRecordViewController ()
@property (nonatomic,strong) HXBMYCapitalRecord_TableView *tableView;
@property (nonatomic,assign) HXBRequestType_MY_tradlist screenType;
@end

@implementation HXBMY_CapitalRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUP];
    self.hxb_automaticallyAdjustsScrollViewInsets = true;
    self.screenType = HXBRequestType_MY_tradlist_Loan;
    [self downDataWithScreenType:HXBRequestType_MY_tradlist_Loan andStartDate:nil andEndDate:nil andIsUPData:true];
}

- (void)setUP {
    self.tableView = [[HXBMYCapitalRecord_TableView alloc]init];
    self.tableView.frame = self.view.frame;
    [self refresh];
    [self.view addSubview:self.tableView];
    
    [self setUPNAVItem];
}

- (void)refresh {
    kWeakSelf
    [self.tableView hxb_GifFooterWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
        [weakSelf downDataWithScreenType:weakSelf.screenType andStartDate:nil andEndDate:nil andIsUPData:false];
    } andSetUpGifFooterBlock:^(MJRefreshBackGifFooter *footer) {
    }];
    
    
    [self.tableView hxb_GifHeaderWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
        [weakSelf downDataWithScreenType:weakSelf.screenType andStartDate:nil andEndDate:nil andIsUPData:true];
    } andSetUpGifHeaderBlock:^(MJRefreshGifHeader *gifHeader) {
    }];
}

- (void)downDataWithScreenType: (HXBRequestType_MY_tradlist)screenType andStartDate:(NSString *)startData andEndDate:(NSString *)endData andIsUPData:(BOOL)isUPData {
    [[HXBMYRequest sharedMYRequest] capitalRecord_requestWithScreenType:screenType
                                                           andStartDate:startData
                                                             andEndDate:endData
                                                            andIsUPData:isUPData
                                                        andSuccessBlock:^(NSArray<HXBMYViewModel_MainCapitalRecordViewModel *> *viewModelArray)
    {
        self.tableView.capitalRecortdDetailViewModelArray = viewModelArray;
        [self.tableView endRefresh];
    } andFailureBlock:^(NSError *error) {
        [self.tableView endRefresh];
    }];
}
- (void)setUPNAVItem {
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithTitle:kNAVRightTitle style:UIBarButtonItemStylePlain target:self action:@selector(clickRightItem)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}
- (void)clickRightItem {
    NSLog(@"点击了NAVRight");
}
@end
