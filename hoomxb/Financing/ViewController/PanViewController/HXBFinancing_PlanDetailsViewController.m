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
#import "HXBFinDetail_TableView.h"//详情页tableView的model
@interface HXBFinancing_PlanDetailsViewController ()
@property(nonatomic,strong) HXBFin_DetailsView_PlanDetailsView *planDetailsView;
@property (nonatomic,strong) NSArray <HXBFinDetail_TableViewCellModel *>*tableViewModelArray;
///tableView的tatile
@property (nonatomic,strong) NSArray <NSString *>* tableViewTitleArray;
///详情底部的tableView的图片数组
@property (nonatomic,strong) NSArray <NSString *>* tableViewImageArray;
@end

@implementation HXBFinancing_PlanDetailsViewController
- (void) setupTableViewArray {
    self.tableViewImageArray = @[
                                 @"1",
                                 @"1",
                                 @"1",
                                 ];
    self.tableViewTitleArray = @[
                                 @"计划详情",
                                 @"加入记录",
                                 @"红利计划服务"
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
     [self downLoadData];
//    [self.planDetailsView show];
   
}

//MARK: 网络数据请求
- (void)downLoadData {
    [[HXBFinanctingRequest sharedFinanctingRequest] planDetaileWithPlanID:self.planID andSuccessBlock:^(HXBFinDetailViewModel_PlanDetail *viewModel) {
        self.planDetailsView.planDetailViewModel = viewModel;
        self.planDetailsView.modelArray = self.tableViewModelArray;
    } andFailureBlock:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
