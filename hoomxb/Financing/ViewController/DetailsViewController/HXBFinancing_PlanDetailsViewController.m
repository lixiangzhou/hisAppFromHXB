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
#import "HXBFinDetailModel_PlanDetail.h"//红利计划详情model

#import "HXBFinDetail_TableView.h"//详情页tableView的model
#import "HXBFinHomePageViewModel_PlanList.h"//红利计划的Viewmodel
#import "HXBFinHomePageModel_PlanList.h"//红利计划的Model

#import "HXBFinAddRecordVC_Plan.h"//红利计划的加入记录
#import "HXBFin_Detail_DetailsVC_Plan.h"//红利计划详情中的详情

#import "HXBFinPlanContract_contraceWebViewVC.h"//协议

@interface HXBFinancing_PlanDetailsViewController ()
@property(nonatomic,strong) HXBFin_DetailsView_PlanDetailsView *planDetailsView;
///底部点的cellModel
@property (nonatomic,strong) NSArray <HXBFinDetail_TableViewCellModel *>*tableViewModelArray;
///tableView的tatile
@property (nonatomic,strong) NSArray <NSString *>* tableViewTitleArray;
///详情底部的tableView的图片数组
@property (nonatomic,strong) NSArray <NSString *>* tableViewImageArray;
///详情页的ViewMode
@property (nonatomic,strong) HXBFinDetailViewModel_PlanDetail *planDetailViewModel;
@end

@implementation HXBFinancing_PlanDetailsViewController

- (void)setPlanListViewModel:(HXBFinHomePageViewModel_PlanList *)planListViewModel {
    _planListViewModel = planListViewModel;
    self.planID = planListViewModel.planListModel.ID;
    
}

- (void) setupTableViewArray {
    self.tableViewImageArray = @[
                                 @"1",
                                 @"1",
                                 @"1",
                                 ];
    self.tableViewTitleArray = @[
                                 @"计划详情",
                                 @"加入记录",
                                 @"红利计划服务协议"
                                 ];
}
- (NSArray<HXBFinDetail_TableViewCellModel *> *)tableViewModelArray {
    if (!_tableViewModelArray) {
        [self setupTableViewArray];
        NSMutableArray *tableViewModelArrayM = [[NSMutableArray alloc]init];
        for (int i = 0; i < self.tableViewImageArray.count; i++) {
            NSString *imageName = self.tableViewImageArray[i];
            NSString *title = self.tableViewTitleArray[i];
            HXBFinDetail_TableViewCellModel *model = [[HXBFinDetail_TableViewCellModel alloc]initWithImageName:imageName andOptionIitle:title];
            [tableViewModelArrayM addObject:model];
        }
        _tableViewModelArray = tableViewModelArrayM.copy;
    }
    return _tableViewModelArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHiddenNavigationBar = false;
    [self setup];
}

//MARK: ------ setup -------
- (void)setup {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.planDetailsView = [[HXBFin_DetailsView_PlanDetailsView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.planDetailsView];
    //是否为计划界面
    _planDetailsView.isPlan = true;
    _planDetailsView.isFlowChart = true;
    _planDetailsView.planListViewModel = self.planListViewModel;
    
    __weak typeof (self)weakSelf = self;
    [self.planDetailsView clickBottomTableViewCellBloakFunc:^(NSIndexPath *index, HXBFinDetail_TableViewCellModel *model) {
        //跳转相应的页面
        NSLog(@"%@",model.optionTitle);
        ///点击了计划详情
        if ([model.optionTitle isEqualToString:weakSelf.tableViewTitleArray[0]]) {
            HXBFin_Detail_DetailsVC_Plan *detail_DetailPlanVC = [[HXBFin_Detail_DetailsVC_Plan alloc]init];
            detail_DetailPlanVC.planDetailModel = weakSelf.planDetailViewModel;
            [weakSelf.navigationController pushViewController:detail_DetailPlanVC animated:true];
        }
        ///  加入记录
        if ([model.optionTitle isEqualToString:weakSelf.tableViewTitleArray[1]]) {
            HXBFinAddRecordVC_Plan *planAddRecordVC = [[HXBFinAddRecordVC_Plan alloc]init];
            planAddRecordVC.planListViewModel = weakSelf.planListViewModel;
            [weakSelf.navigationController pushViewController:planAddRecordVC animated:true];
        }
        ///红利计划服务
        if ([model.optionTitle isEqualToString:weakSelf.tableViewTitleArray[2]]) {
            //跳转一个webView
            HXBFinPlanContract_contraceWebViewVC * contractWebViewVC = [[HXBFinPlanContract_contraceWebViewVC alloc]init];
            contractWebViewVC.URL = weakSelf.planDetailViewModel.planDetailModel.principalBalanceContractNameUrl;
            [weakSelf.navigationController pushViewController:contractWebViewVC animated:true];
        }
    }];
     [self downLoadData];
//    [self.planDetailsView show];
   
}

//MARK: 网络数据请求
- (void)downLoadData {
    [[HXBFinanctingRequest sharedFinanctingRequest] planDetaileWithPlanID:self.planID andSuccessBlock:^(HXBFinDetailViewModel_PlanDetail *viewModel) {
        self.planDetailsView.planDetailViewModel = viewModel;
        self.planDetailViewModel = viewModel;
        self.planDetailsView.modelArray = self.tableViewModelArray;
    } andFailureBlock:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
