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



@interface HXBFinAddRecordVC_Plan ()
@property (nonatomic,strong) HXBFinAddRecortdTableView_Plan *addRecortdTableView;
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
    [self setUP];
    [self downDoadDataWithISUPLoad:YES];
}

- (void)setUP {
    self.isColourGradientNavigationBar = YES;
    self.addRecortdTableView = [[HXBFinAddRecortdTableView_Plan alloc]initWithFrame:CGRectMake(0, HXBStatusBarAndNavigationBarHeight, self.view.width, self.view.height - HXBStatusBarAndNavigationBarHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.addRecortdTableView];
}

- (void) footerRefresh {
    [self.addRecortdTableView hxb_GifFooterWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
        
    } andSetUpGifFooterBlock:^(MJRefreshBackGifFooter *footer) {
        
    }];
}

- (void)headerRefresh {
    [self.addRecortdTableView hxb_headerWithRefreshBlock:^{
        
    }];
}

- (void)downDoadDataWithISUPLoad: (BOOL)isUPLoad {
    [[HXBFinanctingRequest sharedFinanctingRequest] planAddRecortdWithISUPLoad:YES andFinancePlanId:self.planID andOrder:nil andSuccessBlock:^(HXBFinModel_AddRecortdModel_Plan *model) {
        self.addRecortdTableView.addRecortdModel_Plan = model;
    } andFailureBlock:^(NSError *error) {
        
    }];
}

@end
