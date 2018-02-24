//
//  HXBMY_CapitalRecordViewController.m
//  hoomxb
//
//  Created by HXB on 2017/5/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_CapitalRecordViewController.h"
#import "HXBMYCapitalRecord_TableView.h"
#import "HXBMYViewModel_MainCapitalRecordViewModel.h"

#import "HXBMY_Capital_Sift_ViewController.h"//筛选的控制器
#import "HXBMYCapitalRecordViewModel.h"
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

static NSInteger const defaultPageCount = 20;
@interface HXBMY_CapitalRecordViewController ()
@property (nonatomic,strong) HXBMYCapitalRecord_TableView *tableView;
@property (nonatomic,strong) HXBMYCapitalRecordViewModel *capitalRecordViewModel;
@property (nonatomic,copy) NSString *screenType;
@property (nonatomic, assign) NSInteger totalCount;

@end

@implementation HXBMY_CapitalRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易记录";
    self.automaticallyAdjustsScrollViewInsets = NO;
    kWeakSelf
    self.capitalRecordViewModel = [[HXBMYCapitalRecordViewModel alloc] initWithBlock:^UIView *{
        return weakSelf.view;
    }];
    self.screenType = @" ";
    [self downDataWithScreenType:@" "];
    [self setUP];
    self.isColourGradientNavigationBar = YES;
}

/**
 再次获取网络数据
 */
- (void)getNetworkAgain
{
    [self downDataWithScreenType:@" "];
}

- (void)setUP {
//    self.view.backgroundColor = kHXBColor_BackGround;
    self.tableView = [[HXBMYCapitalRecord_TableView alloc]init];
    self.tableView.showsVerticalScrollIndicator = NO;

    self.tableView.frame = CGRectMake(0, HXBStatusBarAndNavigationBarHeight, kScreenWidth, kScreenHeight - HXBStatusBarAndNavigationBarHeight);
    self.tableView.backgroundColor = kHXBColor_BackGround;
    [self refresh];
    [HXBMiddlekey AdaptationiOS11WithTableView:self.tableView];
    [self.view addSubview:self.tableView];
    [self setUPNAVItem];
}

- (void)refresh {
    kWeakSelf
    [self.tableView hxb_headerWithRefreshBlock:^{
        weakSelf.capitalRecordViewModel.capitalRecordPage = 1;
        [weakSelf downDataWithScreenType:weakSelf.screenType];
    }];
}

- (void)downDataWithScreenType: (NSString *)screenType{
    kWeakSelf
    [self.capitalRecordViewModel capitalRecord_requestWithScreenType:screenType resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.totalCount = [weakSelf.capitalRecordViewModel.totalCount integerValue];
            if (weakSelf.totalCount > defaultPageCount && weakSelf.capitalRecordViewModel.currentPageCount == defaultPageCount) {
                [weakSelf.tableView hxb_footerWithRefreshBlock:^{
                    weakSelf.capitalRecordViewModel.capitalRecordPage ++;
                    [weakSelf downDataWithScreenType:weakSelf.screenType];
                }];
            }
            weakSelf.tableView.capitalRecortdDetailViewModelArray = weakSelf.capitalRecordViewModel.capitalRecordViewModel_array;
            weakSelf.tableView.totalCount = weakSelf.totalCount;
            if (weakSelf.capitalRecordViewModel.capitalRecordViewModel_array.count == weakSelf.totalCount) {
                [weakSelf.tableView.mj_header endRefreshing];
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                [weakSelf.tableView endRefresh];
            }
        } else {
            [weakSelf.tableView endRefresh];
        }
    }];
//    [self.capitalRecordViewModel capitalRecord_requestWithScreenType:screenType andSuccessBlock:^(BOOL isSuccess) {
//        weakSelf.totalCount = [weakSelf.capitalRecordViewModel.totalCount integerValue];
//        if (weakSelf.totalCount > defaultPageCount && weakSelf.capitalRecordViewModel.currentPageCount == defaultPageCount) {
//            [weakSelf.tableView hxb_footerWithRefreshBlock:^{
//                weakSelf.capitalRecordViewModel.capitalRecordPage ++;
//                [weakSelf downDataWithScreenType:weakSelf.screenType];
//            }];
//        }
//        weakSelf.tableView.capitalRecortdDetailViewModelArray = weakSelf.capitalRecordViewModel.capitalRecordViewModel_array;
//        weakSelf.tableView.totalCount = weakSelf.totalCount;
//        if (weakSelf.capitalRecordViewModel.capitalRecordViewModel_array.count == weakSelf.totalCount) {
//            [weakSelf.tableView.mj_header endRefreshing];
//            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
//        } else {
//            [weakSelf.tableView endRefresh];
//        }
//    } andFailureBlock:^(NSError *error) {
//        [weakSelf.tableView endRefresh];
//    }];
}
- (void)setUPNAVItem {
//    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithTitle:kNAVRightTitle style:UIBarButtonItemStylePlain target:self action:@selector(clickRightItem)];
//    self.navigationItem.rightBarButtonItem = rightButtonItem;
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
        [weakSelf downDataWithScreenType:typeString];
    }];
    //跳转筛选
    [self presentViewController:siftVC animated:YES completion:nil];
}

@end
