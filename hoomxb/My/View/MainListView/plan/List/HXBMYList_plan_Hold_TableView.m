//
//  HXBMYList_plan_ Hold_TableView.m
//  hoomxb
//
//  Created by HXB on 2017/8/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMYList_plan_Hold_TableView.h"
#import "HXBBaseViewCell_MYListCellTableViewCell.h"
#import "HXBMYViewModel_MianPlanViewModel.h"//  我的界面的 plan list ViewModel
#import "HXBMYModel_MainPlanModel.h"//红利计划model
static NSString *const CELLID = @"CELLID";
@interface HXBMYList_plan_Hold_TableView ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) HXBNoDataView *nodataView;

///cell的点击事件的传递
@property (nonatomic,copy) void(^clickLoanCellBlock)(HXBMYViewModel_MainLoanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex);
@property (nonatomic,copy) void(^clickPlanCellBlock)(HXBMYViewModel_MianPlanViewModel *planViewModel, NSIndexPath *clickPlanCellIndex);

@end
@implementation HXBMYList_plan_Hold_TableView

#pragma mark - setter
- (void)setMainPlanViewModelArray:(NSArray<HXBMYViewModel_MianPlanViewModel *> *)mainPlanViewModelArray {
    _mainPlanViewModelArray = mainPlanViewModelArray;
    if (mainPlanViewModelArray.count) {
        self.nodataView.hidden = YES;
    }else
    {
        self.nodataView.hidden = NO;
    }
    [self reloadData];
}

- (instancetype) initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self setup];
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    }
    return self;
}

- (void)setup {
    self.delegate = self;
    self.dataSource = self;
    self.nodataView.hidden = NO;
    [self registerClass:[HXBBaseViewCell_MYListCellTableViewCell class] forCellReuseIdentifier:CELLID];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rowHeight = kScrAdaptationH(140);
    self.backgroundColor = kHXBColor_BackGround;
}

static NSString *const holdTitle = @"持有中";
static NSString *const exitTingTitle = @"退出中";
static NSString *const exitTitle = @"已退出";
#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.mainPlanViewModelArray.count;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
    //return self.mainPlanViewModelArray? 3 : 11;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXBBaseViewCell_MYListCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    kWeakSelf;
    HXBMYViewModel_MianPlanViewModel *viewModel = weakSelf.mainPlanViewModelArray[indexPath.section];
    NSArray *titleArray = @[
                            @"",
                            @"",
                            @""
                            ];
    NSString *exiTingImageViewName;
    NSString *lanTruansferImageName;
    switch (viewModel.requestType) {
        case HXBRequestType_MY_PlanRequestType_HOLD_PLAN:
            titleArray = @[
                           @"加入金额(元)",
                           @"已获收益(元)",
                           @"平均历史年化收益"
                           ];
            break;
        case HXBRequestType_MY_PlanRequestType_EXITING_PLAN:
            titleArray = @[
                           @"加入金额(元)",
                           @"已获收益(元)",
                           @"待转出金额(元)"
                           ];
            exiTingImageViewName = @"explain.svg";
            break;
        case HXBRequestType_MY_PlanRequestType_EXIT_PLAN:
            titleArray = @[
                           @"加入金额(元)",
                           @"已获收益(元)",
                           @"平均历史年化收益"
                           ];
            lanTruansferImageName = @"LoanTruansfer";
            break;
        default:
            break;
    }
    [cell setUPValueWithListCellManager:^HXBBaseViewCell_MYListCellTableViewCellManager *(HXBBaseViewCell_MYListCellTableViewCellManager *manager) {
        manager.title_LeftLabelStr = viewModel.planModelDataList.name;
        manager.title_RightLabelStr = viewModel.status;
        manager.bottomViewManager.leftStrArray = titleArray;
        if (viewModel.requestType == HXBRequestType_MY_PlanRequestType_EXITING_PLAN) {
            manager.bottomViewManager.rightStrArray = @[
                                                        viewModel.finalAmount_NOTYUAN,
                                                        viewModel.earnAmount_NOTYUAN,
                                                        [NSString GetPerMilWithDouble:viewModel.planModelDataList.redProgressLeft.doubleValue]
                                                        ];
        } else {
            manager.bottomViewManager.rightStrArray = @[
                                                        viewModel.finalAmount_NOTYUAN,
                                                        viewModel.earnAmount_NOTYUAN,
                                                        viewModel.expectedRate
                                                        ];
        }
        manager.wenHaoImageName = exiTingImageViewName;
        manager.title_ImageName = lanTruansferImageName;
        return manager;
    }];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.clickPlanCellBlock(self.mainPlanViewModelArray[indexPath.section], indexPath);
}


- (void)clickPlanCellFuncWithBlock: (void(^)(HXBMYViewModel_MianPlanViewModel *planViewModel, NSIndexPath *clickPlanCellIndex))clickPlanCellBlock{
    self.clickPlanCellBlock = clickPlanCellBlock;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kScrAdaptationH(10);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (HXBNoDataView *)nodataView {
    if (!_nodataView) {
        _nodataView = [[HXBNoDataView alloc]initWithFrame:CGRectZero];
        _nodataView.imageName = @"Fin_NotData";
        _nodataView.noDataMassage = @"暂无数据";
//        _nodataView.downPULLMassage = @"下拉进行刷新";
        [self addSubview:_nodataView];
        [_nodataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(kScrAdaptationH(100));
            make.height.width.equalTo(@(kScrAdaptationH(184)));
            make.centerX.equalTo(self);
        }];
    }
    return _nodataView;
}
@end
