//
//  HXBFinancing_PlanViewController.m
//  hoomxb
//
//  Created by HXB on 2017/5/4.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinancing_PlanDetailsViewController.h"

#import "HXBFin_DetailsView_PlanDetailsView.h"///红利计划详情页的主视图
#import "HXBFinanctingRequest.h"//请求类
#import "HXBFinDetailViewModel_PlanDetail.h"//红利计划详情页Viewmodel

@interface HXBFinancing_PlanDetailsViewController ()
@property(nonatomic,strong) HXBFin_DetailsView_PlanDetailsView *planDetailsView;
@end

@implementation HXBFinancing_PlanDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

//MARK: ------ setup -------
- (void)setup {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.planDetailsView = [[HXBFin_DetailsView_PlanDetailsView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.planDetailsView];
    //是否为计划界面
    _planDetailsView.isPlan = self.isPlan;
    _planDetailsView.isFlowChart = true;
    [self.planDetailsView show];
    [self downLoadData];
}

//MARK: 网络数据请求
- (void)downLoadData {
    [[HXBFinanctingRequest sharedFinanctingRequest] planDetaileWithSuccessBlock:^(NSArray<HXBFinDetailViewModel_PlanDetail *> *viewModelArray) {
        
    } andFailureBlock:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
