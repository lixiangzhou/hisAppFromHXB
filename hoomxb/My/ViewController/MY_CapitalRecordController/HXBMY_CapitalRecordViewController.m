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

#import "HXBMY_Capital_Sift_ViewController.h"//筛选的控制器

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
@property (nonatomic,copy) NSString *screenType;
@end

@implementation HXBMY_CapitalRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUP];
    self.title = @"交易记录";
    self.hxb_automaticallyAdjustsScrollViewInsets = true;
    self.screenType = @" ";
    [self downDataWithScreenType:@" " andStartDate:nil andEndDate:nil andIsUPData:true];
}

- (void)setUP {
    self.view.backgroundColor = kHXBColor_BackGround;
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

- (void)downDataWithScreenType: (NSString *)screenType andStartDate:(NSString *)startData andEndDate:(NSString *)endData andIsUPData:(BOOL)isUPData {
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
///点击了 交易记录 筛选
- (void)clickRightItem {
    NSLog(@"点击了NAVRight");
    HXBMY_Capital_Sift_ViewController *siftVC = [[HXBMY_Capital_Sift_ViewController alloc]init];
    kWeakSelf
    ///点击了筛选
    [siftVC clickCapital_TitleWithBlock:^(NSString *typeStr, kHXBEnum_MY_CapitalRecord_Type type) {
//        筛选条件 0：充值，1：提现，2：散标债权，3：红利计划
        NSString *typeString = nil;
        switch (type) {
            case 0://全部
               typeString = @" ";
                break;
            case 1://充值
                typeString = @"0";
                break;
            case 2://提现
                typeString = @"1";
                break;
            case 3://散标债权
                typeString = @"2";
                break;
            case 4://红利计划
                typeString = @"3";
                break;
            default:
                break;
        }
        weakSelf.screenType = typeString;
        [weakSelf downDataWithScreenType:typeString andStartDate:nil andEndDate:nil andIsUPData:true];
    }];
    //跳转筛选
    [self presentViewController:siftVC animated:true completion:nil];
}
@end
