//
//  HXBMY_PlanList_DetailViewController.m
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_PlanList_DetailViewController.h"

#import "HXBMYReqest_DetailRequest.h"//请求的工具类

#import "HXBMYViewModel_MianPlanViewModel.h"//红利计划列表页的ViewModel
#import "HXBMYModel_MainPlanModel.h"//红利计划列表页的Model

#import "HXBMYViewModel_PlanDetailViewModel.h"//红利计划详情页的ViewModel
#import "HXBMYModel_PlanDetailModel.h"//红利计划详情的Model

#import "HXBMY_PlanDetailView.h"//详情页的View

@interface HXBMY_PlanList_DetailViewController ()
@property (nonatomic,strong) HXBMYReqest_DetailRequest *detailRequest;
@property (nonatomic,weak) HXBMY_PlanDetailView *planDetailView;
@end

@implementation HXBMY_PlanList_DetailViewController
#pragma mark - getter 
- (HXBMYReqest_DetailRequest *)detailRequest {
    if (!_detailRequest) {
        _detailRequest = [[HXBMYReqest_DetailRequest alloc]init];
    }
    return _detailRequest;
}

- (void)setPlanViewModel:(HXBMYViewModel_MianPlanViewModel *)planViewModel {
    _planViewModel = planViewModel;
    [self downData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hxb_automaticallyAdjustsScrollViewInsets = true;
    [self setUP];
}
- (void) setUP {
    HXBMY_PlanDetailView *planDetailView = [[HXBMY_PlanDetailView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.planDetailView = planDetailView;
    [self.view addSubview:planDetailView];
}

#pragma mark - 网络数据的请求
- (void)downData {
    __weak typeof (self)weakSelf = self;
    NSString *planID = self.planViewModel.planModelDataList.ID;
    [self.detailRequest planListDetails_requestWithFinancePlanID:planID andSuccessBlock:^(HXBMYViewModel_PlanDetailViewModel *viewModel) {
        weakSelf.planDetailView.planDetailViewModel = viewModel;
    } andFailureBlock:^(NSError *error) {
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
