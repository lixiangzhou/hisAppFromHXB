//
//  HXBMainListView_Plan.m
//  hoomxb
//
//  Created by HXB on 2017/5/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMainListView_Plan.h"
#import "HXBMainListView_Plan_TopView.h"
#import "HXBBaseToolBarView.h"
#import "HXBBaseScrollToolBarView.h"
#import "HXBBaseTableView_MYPlanList_TableView.h"
#import "HXBMYModel_Plan_planRequestModel.h"

#import "HXBMYList_plan_Hold_TableView.h"
static NSString *const holdTitle = @"持有中";
static NSString *const exitTingTitle = @"退出中";
static NSString *const exitTitle = @"已退出";

@interface HXBMainListView_Plan ()
@property (nonatomic,strong) HXBMainListView_Plan_TopView *topView;
@property (nonatomic,strong) HXBBaseToolBarView *toolBarView;
@property (nonatomic,strong) NSMutableArray <NSString *>*toolBarOptionTitleArray;
@property (nonatomic,strong) HXBBaseScrollToolBarView *scorllToolBarView;

@property (nonatomic,strong) NSArray *toolBarTitleArray;
@property (nonatomic,strong) UILabel *exitLabel;
@property (nonatomic,strong) UILabel *exitingLabel;
@property (nonatomic,strong) UILabel *holdLabel;

@property (nonatomic,strong) HXBMYList_plan_Hold_TableView *exit_Plan_TableView;///退出后
@property (nonatomic,strong) HXBMYList_plan_Hold_TableView *exiting_Plan_TableView;///退出中
@property (nonatomic,strong) HXBMYList_plan_Hold_TableView *hold_Plan_TableView;///持有中

///plan 的toolbarView的中间的点击
@property (nonatomic,copy) void(^changeMidSelectOptionBlock)(UIButton *button, NSString *title, NSInteger index, HXBRequestType_MY_PlanRequestType requestType);

///plan 上拉刷新与下拉加载的block
@property (nonatomic,copy) void(^hold_Plan_DownRefresh)();
@property (nonatomic,copy) void(^exiting_Plan_DownRefresh)();
@property (nonatomic,copy) void(^exit_Plan_DownRefresh)();

@property (nonatomic,copy) void(^hold_Plan_UPRefresh)();
@property (nonatomic,copy) void(^exiting_Plan_UPRefresh)();
@property (nonatomic,copy) void(^exit_Plan_UPRefresh)();

//MARK: - cell的点击
///cell的点击事件的传递
@property (nonatomic,copy) void(^clickPlan_HoldCellBlock)(HXBMYViewModel_MianPlanViewModel *viewModel, NSIndexPath *clickLoanCellIndex);
@property (nonatomic,copy) void(^clickPlan_exitingCellBlock)(HXBMYViewModel_MianPlanViewModel *viewModel, NSIndexPath *clickLoanCellIndex);
@property (nonatomic,copy) void(^clickPlan_exitCellBlock)(HXBMYViewModel_MianPlanViewModel *viewModel, NSIndexPath *clickLoanCellIndex);

///资产统计的事件注册
@property (nonatomic,copy) void (^assetStatisticsWithBlock)();
@end


@implementation HXBMainListView_Plan
//MARK: 销毁
kDealloc


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUP];
    }
    return self;
}


#pragma mark - setter  数据源
- (void)setPlanAccountModel:(HXBMYModel_Plan_planRequestModel *)planAccountModel {
    _planAccountModel = planAccountModel;
    self.exitLabel.text = [self formatStrWithTypeStr:exitTitle andCountStr:planAccountModel.exitCount.integerValue];
    self.exitingLabel.text = [self formatStrWithTypeStr:exitTingTitle andCountStr:planAccountModel.exitingCount.integerValue];
    self.holdLabel.text = [self formatStrWithTypeStr:holdTitle andCountStr:planAccountModel.currentPlanCount.integerValue];
}

- (void) setUserInfoViewModel:(HXBRequestUserInfoViewModel *)userInfoViewModel {
    _userInfoViewModel = userInfoViewModel;
    self.topView.userInfoViewModel = userInfoViewModel;
}
- (void) setExit_Plan_array:(NSMutableArray<HXBMYViewModel_MianPlanViewModel *> *)exit_Plan_array {
    _exit_Plan_array = exit_Plan_array;
    self.exit_Plan_TableView.mainPlanViewModelArray = exit_Plan_array;
//    self.exitLabel.text = [self formatStrWithTypeStr:exitTitle andCountStr:exit_Plan_array.count];

}
- (void)setExiting_Plan_array:(NSMutableArray<HXBMYViewModel_MianPlanViewModel *> *)exiting_Plan_array {
    _exiting_Plan_array = exiting_Plan_array;
    self.exiting_Plan_TableView.mainPlanViewModelArray = exiting_Plan_array;
//    self.exitingLabel.text = [self formatStrWithTypeStr:exitTingTitle andCountStr:exiting_Plan_array.count];
}
- (void)setHold_Plan_array:(NSMutableArray<HXBMYViewModel_MianPlanViewModel *> *)hold_Plan_array {
    
    _hold_Plan_array = hold_Plan_array;
    self.hold_Plan_TableView.mainPlanViewModelArray = hold_Plan_array;
//    self.holdLabel.text = [self formatStrWithTypeStr:holdTitle andCountStr:hold_Plan_array.count];
}
- (NSString *)formatStrWithTypeStr: (NSString *)typeStr andCountStr: (NSInteger)count {
    NSString *countStr = @(count).description;
    return [NSString stringWithFormat:@"%@(%@)",typeStr,countStr];
//    return typeStr;
}
#pragma mark - getter 
- (NSArray *)exit_Plan_arrayAtIndexes:(NSIndexSet *)indexes {
    if (!_exit_Plan_array) {
        _exit_Plan_array = [[NSArray alloc]init];
    }
    return _exit_Plan_array;
}
- (NSArray *)exiting_Plan_arrayAtIndexes:(NSIndexSet *)indexes {
    if (!_exiting_Plan_array) {
        _exiting_Plan_array = [[NSArray alloc]init];
    }
    return _exiting_Plan_array;
}
- (NSArray *)hold_Plan_arrayAtIndexes:(NSIndexSet *)indexes {
    if (!_hold_Plan_array) {
        _hold_Plan_array = [[NSArray alloc]init];
    }
    return _hold_Plan_array;
}

#pragma mark - 搭建UI
- (void)setUP {
    self.toolBarOptionTitleArray = @[
                                     holdTitle,
                                     exitTingTitle,
                                     exitTitle
                                     ].mutableCopy;
    self.holdLabel = [self creatLableWithTitle:holdTitle];
    self.exitingLabel = [self creatLableWithTitle:exitTingTitle];
    self.exitLabel = [self creatLableWithTitle:exitTitle];
    self.toolBarTitleArray = @[
                               self.holdLabel,
                               self.exitingLabel,
                               self.exitLabel
                               ];
    [self setupSubView];
}

- (void)setupSubView {
    [self setupTopView];// 搭建顶部的View信息
    [self setupToolBarView];//搭建中部的toolBarView
    [self setupBottomScrollViewArray];//创建底部的ScrollView的集合
    [self setupScrollToolBarView];//搭建scrollToolBarView
    [self refresh];//刷新的搭建
    [self registerClickCellEvent];//注册cell的点击事件
}
// 搭建顶部的View信息
- (void)setupTopView {
    self.topView = [[HXBMainListView_Plan_TopView alloc]init];
    [self downLoadTopViewData];
}
- (void)downLoadTopViewData {
    kWeakSelf
    [[KeyChainManage sharedInstance] downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        weakSelf.topView.userInfoViewModel = viewModel;
    } andFailure:^(NSError *error) {
        
    }];
}
//搭建中部的toolBarView
- (void)setupToolBarView {
    kWeakSelf
    self.toolBarView = [HXBBaseToolBarView toolBarViewWithFrame:CGRectZero andOptionStrArray:self.toolBarOptionTitleArray];
    //开启动画
    self.toolBarView.isAnima_ItemBottomBarView = true;
    self.toolBarView.animaTime_ItemBottomBarView = 0.5;
    
    ///改变底部的提示线条颜色' && '高度
    self.toolBarView.itemBarAnimaViewColor = kHXBColor_Red_255_64_79;
    self.toolBarView.barAnimaViewH = 2;
    self.toolBarView.isHiddenLien = true;

    // 对item 进行自定义
    [self.toolBarView setUpsetUpBarViewItemBlockFuncWithBlcok:^(UIButton *button, UIView *buttonBottomView) {
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        if ([button.titleLabel.text isEqualToString:holdTitle]) {
            [weakSelf addLableWithButton:button andLable:weakSelf.holdLabel];
        }
        if ([button.titleLabel.text isEqualToString:exitTingTitle]) {
            [weakSelf addLableWithButton:button andLable:weakSelf.exitingLabel];
        }
        if ([button.titleLabel.text isEqualToString:exitTitle]) {
            [weakSelf addLableWithButton:button andLable:weakSelf.exitLabel];
        }
    }];
}
- (UILabel *)creatLableWithTitle: (NSString *)title {
    UILabel *label = [[UILabel alloc] init];
     label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    return label;
}
- (void)addLableWithButton: (UIButton *)button andLable: (UILabel *)label{
    [button addSubview:label];
    label.tag = 10086111;
    label.font = kHXBFont_PINGFANGSC_REGULAR(15);
    label.frame = button.bounds;
    button.titleLabel.text = @"";
}

//搭建底部的ScrollView
- (NSArray *)setupBottomScrollViewArray {
    self.hold_Plan_TableView = [[HXBMYList_plan_Hold_TableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.exiting_Plan_TableView = [[HXBMYList_plan_Hold_TableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.exit_Plan_TableView = [[HXBMYList_plan_Hold_TableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    return @[
             self.hold_Plan_TableView,
             self.exiting_Plan_TableView,
             self.exit_Plan_TableView
             ];
}

//上 中下 view
- (void)setupScrollToolBarView {
    
    NSArray *bottomViewSet = [self setupBottomScrollViewArray];
    CGRect frame = CGRectMake(0, 0, self.width, self.height);
    HXBBaseScrollToolBarView *scrollToolBarView = [HXBBaseScrollToolBarView scrollToolBarViewWithFrame:frame andTopView:self.topView andTopViewH:kScrAdaptationH(200) - 64 andMidToolBarView:self.toolBarView andMidToolBarViewMargin:0 andMidToolBarViewH: kScrAdaptationH(45) andBottomViewSet:bottomViewSet];
    
    [self addSubview:scrollToolBarView];
    [self setColorWithLabel:self.holdLabel];
    ///事件的传递
    kWeakSelf
    [scrollToolBarView switchBottomScrollViewCallBack:^(NSInteger index, NSString *title, UIButton *option) {
        if (weakSelf.changeMidSelectOptionBlock) {
            if (index >= weakSelf.toolBarOptionTitleArray.count) {
                index = weakSelf.toolBarOptionTitleArray.count - 1;
            }
            UILabel *label = [option viewWithTag:10086111];
            [weakSelf setColorWithLabel:label];
            HXBRequestType_MY_PlanRequestType type = index + 1;
            weakSelf.changeMidSelectOptionBlock(option, title, index, type);
        }
    }];
    
}
- (void)setColorWithLabel:(UILabel *)label {
  [self.toolBarTitleArray enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      if ([label isEqual:obj]) {
          obj.textColor = kHXBColor_Red_255_64_79;
      }else {
          obj.textColor = kHXBColor_Font0_6;
      }
  }];
}

#pragma mark - 事件的传递
///中间的toolBarView 的 select将要改变的时候 左右滑动的时候
- (void)changeMidSelectOptionFuncWithBlock:(void (^)(UIButton *button, NSString *title, NSInteger index, HXBRequestType_MY_PlanRequestType requestType))changeMidSelectOptionBlock {
    self.changeMidSelectOptionBlock = changeMidSelectOptionBlock;
}

///上啦刷新下拉加载
- (void)refresh {
    [self downLoadRefresh];
    if (self.totalCount > 20) {
        [self upDataRefresh];
    }
}

///下拉刷新
- (void)downLoadRefresh {
    __weak typeof (self)weakSelf = self;
    [self.hold_Plan_TableView hxb_GifHeaderWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
         if (weakSelf.hold_Plan_UPRefresh) weakSelf.hold_Plan_UPRefresh();
    } andSetUpGifHeaderBlock:^(MJRefreshGifHeader *gifHeader) {}];
    
    [self.exiting_Plan_TableView hxb_GifHeaderWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
        if (weakSelf.exiting_Plan_DownRefresh) weakSelf.exiting_Plan_UPRefresh();
    } andSetUpGifHeaderBlock:^(MJRefreshGifHeader *gifHeader) {}];
    
    [self.exit_Plan_TableView hxb_GifHeaderWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
        if (weakSelf.exit_Plan_DownRefresh) weakSelf.exiting_Plan_UPRefresh();
    } andSetUpGifHeaderBlock:^(MJRefreshGifHeader *gifHeader) {}];
}

//上啦加载
- (void) upDataRefresh {
    __weak typeof(self) weakSelf = self;
    [self.hold_Plan_TableView hxb_GifFooterWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
        if (weakSelf.hold_Plan_DownRefresh) weakSelf.hold_Plan_DownRefresh();
    } andSetUpGifFooterBlock:^(MJRefreshBackGifFooter *footer) {}];
    
    [self.exiting_Plan_TableView hxb_GifFooterWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
        if(weakSelf.exiting_Plan_UPRefresh) weakSelf.exiting_Plan_DownRefresh();
    } andSetUpGifFooterBlock:^(MJRefreshBackGifFooter *footer) {}];
    
    [self.exit_Plan_TableView hxb_GifFooterWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
        if(weakSelf.exit_Plan_UPRefresh) weakSelf.exit_Plan_DownRefresh();
    } andSetUpGifFooterBlock:^(MJRefreshBackGifFooter *footer) {}];
}

//停止刷新
- (void)endRefresh {
    [self.hold_Plan_TableView.mj_header endRefreshing];
    [self.hold_Plan_TableView.mj_footer endRefreshing];
    [self.exit_Plan_TableView.mj_footer endRefreshing];
    [self.exit_Plan_TableView.mj_header endRefreshing];
    [self.exiting_Plan_TableView.mj_header endRefreshing];
    [self.exiting_Plan_TableView.mj_footer endRefreshing];
}

//MARK: 刷新的传递
- (void)hold_RefreashWithDownBlock:(void (^)())downBlock andUPBlock:(void (^)())UPBlock {
    self.hold_Plan_UPRefresh = UPBlock;
    self.hold_Plan_DownRefresh = downBlock;
}
- (void)exiting_RefreashWithDownBlock:(void (^)())downBlock andUPBlock:(void (^)())UPBlock {
    self.exiting_Plan_DownRefresh = downBlock;
    self.exiting_Plan_UPRefresh = UPBlock;
}
- (void)exit_RefreashWithDownBlock:(void (^)())downBlock andUPBlock:(void (^)())UPBlock {
    self.exit_Plan_DownRefresh = downBlock;
    self.exit_Plan_UPRefresh = UPBlock;
}

//MARK: cell的点击
- (void)registerClickCellEvent {
    kWeakSelf
    [self.hold_Plan_TableView clickPlanCellFuncWithBlock:^(HXBMYViewModel_MianPlanViewModel *viewModel, NSIndexPath *clickCellIndex) {
        if (weakSelf.clickPlan_HoldCellBlock) {
            weakSelf.clickPlan_HoldCellBlock(viewModel, clickCellIndex);
        }
    }];
    [self.exiting_Plan_TableView clickPlanCellFuncWithBlock:^(HXBMYViewModel_MianPlanViewModel *viewModel, NSIndexPath *clickCellIndex) {
        if (weakSelf.clickPlan_exitingCellBlock) {
            weakSelf.clickPlan_exitingCellBlock(viewModel, clickCellIndex);
        }
    }];
    [self.exit_Plan_TableView clickPlanCellFuncWithBlock:^(HXBMYViewModel_MianPlanViewModel *viewModel, NSIndexPath *clickCellIndex) {
        if (weakSelf.clickPlan_exitCellBlock) {
            weakSelf.clickPlan_exitCellBlock(viewModel, clickCellIndex);
        }
    }];
}
- (void)clickLoan_hold_CellFuncWithBlock:(void (^)(HXBMYViewModel_MianPlanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex))clickPlanCellBlock {
    self.clickPlan_HoldCellBlock = clickPlanCellBlock;
}
- (void)clickLoan_exiting_CellFuncWithBlock:(void (^)(HXBMYViewModel_MianPlanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex))clickPlanCellBlock {
    self.clickPlan_exitingCellBlock = clickPlanCellBlock;
}
- (void)clickLoan_exit_CellFuncWithBlock:(void (^)(HXBMYViewModel_MianPlanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex))clickPlanCellBlock {
    self.clickPlan_exitCellBlock = clickPlanCellBlock;
}

///MARK: 开始刷新资产统计
- (void)requestAssetStatisticsWithBlockFunc:(void (^)())assetStatisticsWithBlock {
    self.assetStatisticsWithBlock = assetStatisticsWithBlock;
}
@end
