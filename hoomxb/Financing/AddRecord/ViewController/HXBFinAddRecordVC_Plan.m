//
//  HXBFinAddRecordVC_Plan.m
//  hoomxb
//
//  Created by HXB on 2017/5/11.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinAddRecordVC_Plan.h"
#import "HXBFinanctingRequest.h"
#import "HXBFinHomePageViewModel_PlanList.h"
#import "HXBFinHomePageModel_PlanList.h"
#import "HXBFinDetailViewModel_PlanDetail.h"
#import "HXBFinDetailModel_PlanDetail.h"//红利计划详情页Model
#import "HXBFinAddRecortdTableView_Plan.h"//红利计划的加入计划View,里面自定义了 cell
#import "HXBFinModel_AddRecortdModel_Plan.h"//红利计划 - 加入计划的Model，这个没有ViewModel的封装（数据太简单）
#import "HXBFinAddRecordViewModel.h"

@interface HXBFinAddRecordVC_Plan ()
@property (nonatomic,strong) HXBFinAddRecortdTableView_Plan *addRecortdTableView;
@property (nonatomic,strong) HXBFinAddRecordViewModel *planRecordViewModel;
@end
static NSString *CELLID = @"CELLID";
@implementation HXBFinAddRecordVC_Plan
- (void) setPlanListViewModel:(HXBFinHomePageViewModel_PlanList *)planListViewModel {
    _planListViewModel = planListViewModel;
    self.planID = planListViewModel.planListModel.ID;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"加入记录";
    kWeakSelf
    self.planRecordViewModel = [[HXBFinAddRecordViewModel alloc]initWithBlock:^UIView *{
        return weakSelf.view;
    }];
    [self setUP];
    [self downDoadDataWithISUPLoad:YES];
}

- (void)setUP {
    self.isColourGradientNavigationBar = YES;
    self.addRecortdTableView = [[HXBFinAddRecortdTableView_Plan alloc]initWithFrame:CGRectMake(0, HXBStatusBarAndNavigationBarHeight, self.view.width, self.view.height - HXBStatusBarAndNavigationBarHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.addRecortdTableView];
}

- (void)downDoadDataWithISUPLoad: (BOOL)isUPLoad {
    kWeakSelf
    [self.planRecordViewModel requestPlanAddRecortdFinanceWithId:self.planID planAddRecortdWithISUPLoad:YES andOrder:nil resultBlock:^(BOOL isSuccess, NSError *error) {
        if (isSuccess) {
            weakSelf.addRecortdTableView.addRecortdModel_Plan = weakSelf.planRecordViewModel.addRecortdModel_PlanModel;
        }
    }];

}

@end
