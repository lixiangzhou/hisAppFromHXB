//
//  HXBMy_Plan_Swipe.m
//  hoomxb
//
//  Created by HXB on 2017/7/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMy_Plan_Swipe.h"
#import "CustomSegmentControl.h"
#import "HXBMainListView_Plan_TopView.h"
#import "HXBBaseToolBarView.h"
#import "HXBBaseScrollToolBarView.h"
#import "HXBBaseTableView_MYPlanList_TableView.h"
#import "HXBMYModel_Plan_planRequestModel.h"
static NSString *const holdTitle = @"持有中";
static NSString *const exitTingTitle = @"退出中";
static NSString *const exitTitle = @"已退出";
#define RGBColorAlpha(r,g,b,f)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:f]
#define RGBColor(r,g,b)          RGBColorAlpha(r,g,b,1)


@interface HXBMy_Plan_Swipe ()
<
SwipeTableViewDataSource,
SwipeTableViewDelegate,
UIGestureRecognizerDelegate,
UIViewControllerTransitioningDelegate
>

@property (nonatomic,strong) HXBMainListView_Plan_TopView *topView;
//@property (nonatomic,strong) HXBBaseToolBarView *toolBarView;
@property (nonatomic,strong) NSMutableArray <NSString *>*toolBarOptionTitleArray;
//@property (nonatomic,strong) HXBBaseScrollToolBarView *scorllToolBarView;

@property (nonatomic,strong) SwipeTableView *scrollToolBarView;
@property (nonatomic,strong) CustomSegmentControl *toolBarView;

@property (nonatomic,strong) HXBBaseTableView_MYPlanList_TableView *exit_Plan_TableView;///退出后
@property (nonatomic,strong) HXBBaseTableView_MYPlanList_TableView *exiting_Plan_TableView;///退出中
@property (nonatomic,strong) HXBBaseTableView_MYPlanList_TableView *hold_Plan_TableView;///持有中

@property (nonatomic,strong) UILabel *exitLabel;
@property (nonatomic,strong) UILabel *exitingLabel;
@property (nonatomic,strong) UILabel *holdLabel;


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

@implementation HXBMy_Plan_Swipe
//MARK: 销毁
kDealloc

#pragma mark - gtter
///top view
- (HXBMainListView_Plan_TopView *)topView {
    if (!_topView) {
        // swipe header
        _topView = [[HXBMainListView_Plan_TopView alloc]init];
        _topView.frame = CGRectMake(0, 0, kScreenWidth, 120);
        _topView.backgroundColor = [UIColor whiteColor];
        _topView.layer.masksToBounds = YES;
    }
    return _topView;
}
///Bottom scroll views
- (HXBBaseTableView_MYPlanList_TableView *)exit_Plan_TableView {
    if (!_exit_Plan_TableView) {
        _exit_Plan_TableView = [[HXBBaseTableView_MYPlanList_TableView alloc]initWithFrame:self.scrollToolBarView.bounds style:UITableViewStylePlain];
    }
    return _exit_Plan_TableView;
}
- (HXBBaseTableView_MYPlanList_TableView *)exiting_Plan_TableView{
    if (!_exiting_Plan_TableView) {
        _exiting_Plan_TableView = [[HXBBaseTableView_MYPlanList_TableView alloc]initWithFrame:self.scrollToolBarView.bounds style:UITableViewStylePlain];
    }
    return _exit_Plan_TableView;
}
- (HXBBaseTableView_MYPlanList_TableView *)hold_Plan_TableView{
    if (!_hold_Plan_TableView) {
        _hold_Plan_TableView = [[HXBBaseTableView_MYPlanList_TableView alloc]initWithFrame:self.scrollToolBarView.bounds style:UITableViewStylePlain];
    }
    return _hold_Plan_TableView;
}

///mid tool bar View
///创建中间的toolBarView
- (CustomSegmentControl * )toolBarView {
    if (!_toolBarView) {
        _toolBarView = [[CustomSegmentControl alloc]initWithItems:@[
                                                                    holdTitle,// = @"持有中";
                                                                    exitTingTitle,// = @"退出中";
                                                                    exitTitle// = @"已退出";
                                                                    ]];
        
        _toolBarView.size = CGSizeMake(kScreenWidth, 40);
        _toolBarView.font = [UIFont systemFontOfSize:15];
        _toolBarView.textColor = RGBColor(100, 100, 100);
        _toolBarView.selectedTextColor = RGBColor(0, 0, 0);
        _toolBarView.backgroundColor = RGBColor(249, 251, 198);
        _toolBarView.selectionIndicatorColor = RGBColor(249, 104, 92);
        _toolBarView.selectedSegmentIndex = _scrollToolBarView.currentItemIndex;
        [_toolBarView addTarget:self action:@selector(changeSwipeViewIndex:) forControlEvents:UIControlEventValueChanged];
    }
    return _toolBarView;
}

///
- (void)changeSwipeViewIndex:(UISegmentedControl *)seg {
    [_scrollToolBarView scrollToItemAtIndex:seg.selectedSegmentIndex animated:NO];
    // request data at current index
    switch (seg.selectedSegmentIndex) {
        case 0:
            if (self.hold_Plan_DownRefresh) self.hold_Plan_DownRefresh();
           
            break;
        case 1:
            if(self.exiting_Plan_UPRefresh) self.exiting_Plan_DownRefresh();
            break;
        case 2:
            if(self.exit_Plan_UPRefresh) self.exit_Plan_DownRefresh();
            break;
        default:
            break;
    }
    NSLog(@"||-> request data at current index %ld",seg.selectedSegmentIndex);
}

//scrollToolBarView
- (SwipeTableView *)scrollToolBarView {
    if (!_scrollToolBarView) {
        _scrollToolBarView = [[SwipeTableView alloc]initWithFrame:self.bounds];
        _scrollToolBarView.delegate = self;
        _scrollToolBarView.dataSource = self;
        _scrollToolBarView.shouldAdjustContentSize = YES;
        _scrollToolBarView.swipeHeaderView = self.topView;
        _scrollToolBarView.swipeHeaderBar = self.toolBarView;
        _scrollToolBarView.swipeHeaderBarScrollDisabled = YES;
    }
    return _scrollToolBarView;
}

#pragma mark - SwipeTableView M

- (NSInteger)numberOfItemsInSwipeTableView:(SwipeTableView *)swipeView {
    return 3;
}

- (UIScrollView *)swipeTableView:(SwipeTableView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIScrollView *)view {
    // 混合的itemview只有同类型的item采用重用
    if (index == 0) {
        
        // 懒加载保证同样类型的item只创建一次，以达到重用
        HXBBaseTableView_MYPlanList_TableView * tableView = self.hold_Plan_TableView;
        
        // 获取当前index下item的数据，进行数据刷新
        //                id data = _dataDic[@(index)];
        //                [tableView refreshWithData:data atIndex:index];
        
        view = tableView;
    }else if (index == 1) {
        
        HXBBaseTableView_MYPlanList_TableView * tableView = self.exiting_Plan_TableView;
        
        // 获取当前index下item的数据，进行数据刷新
        //                id data = _dataDic[@(index)];
        //                [collectionView refreshWithData:data atIndex:index];
        
        view = tableView;
    }else if (index == 2) {
         HXBBaseTableView_MYPlanList_TableView * tableView = self.exit_Plan_TableView;
        view = tableView;
    }
    
    
    // 在没有设定下拉刷新宏的条件下，自定义的下拉刷新需要做 refreshheader 的 frame 处理
    //    [self configRefreshHeaderForItem:view];
    return view;
}

// swipetableView index变化，改变seg的index
- (void)swipeTableViewCurrentItemIndexDidChange:(SwipeTableView *)swipeView {
    _toolBarView.selectedSegmentIndex = swipeView.currentItemIndex;
    //    _toolBarView.selectItemIndex = swipeView.currentItemIndex;
}


// 滚动结束请求数据
- (void)swipeTableViewDidEndDecelerating:(SwipeTableView *)swipeView {
    [self getDataAtIndex:swipeView.currentItemIndex];
}


#pragma mark - Request data

// 请求数据（根据视图滚动到相应的index后再请求数据）
- (void)getDataAtIndex:(NSInteger)index {
    // request data at current index
    switch (index) {
        case 0:
            if (self.hold_Plan_DownRefresh) self.hold_Plan_DownRefresh();
            break;
        case 2:
            if(self.exiting_Plan_UPRefresh) self.exiting_Plan_DownRefresh();
            break;
        case 1:
            if(self.exit_Plan_UPRefresh) self.exit_Plan_DownRefresh();
            break;
        default:
            break;
    }

    // 请求数据后刷新相应的item
    
    //    ((void (*)(void *, SEL, NSNumber *, NSInteger))objc_msgSend)((__bridge void *)(self.scrollToolBarView.currentItemView),@selector(setData:), );
    // 保存数据
    //    [_dataDic setObject:@(numberOfRows) forKey:@(index)];
}

/**
 *  以下两个代理，在未定义宏 #define ST_PULLTOREFRESH_HEADER_HEIGHT，并自定义下拉刷新的时候，必须实现
 *  如果设置了下拉刷新的宏，以下代理可根据需要实现即可
 */
- (BOOL)swipeTableView:(SwipeTableView *)swipeTableView shouldPullToRefreshAtIndex:(NSInteger)index {
    return YES;
}

- (CGFloat)swipeTableView:(SwipeTableView *)swipeTableView heightForRefreshHeaderAtIndex:(NSInteger)index {
    return 160;
}

/**
 *  采用自定义修改下拉刷新，此时不会定义宏 #define ST_PULLTOREFRESH_HEADER_HEIGHT
 *  对于一些下拉刷新控件，可能会在`layouSubViews`中设置RefreshHeader的frame。所以，需要在itemView有效的方法中改变RefreshHeader的frame，如 `scrollViewDidScroll:`
 */
- (void)configRefreshHeaderForItem:(UIScrollView *)itemView {
#if !defined(ST_PULLTOREFRESH_HEADER_HEIGHT)
        STRefreshHeader * header = itemView.header;
        header.y = - (header.height + _toolBarView.height);
#endif
}


#pragma mark - init func
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
    NSString *exitLabelStr = [self formatStrWithTypeStr:exitTitle andCountStr:planAccountModel.exitCount.integerValue];
    NSString *exitingLabelStr = [self formatStrWithTypeStr:exitTingTitle andCountStr:planAccountModel.exitingCount.integerValue];
    NSString *holdLabelStr = [self formatStrWithTypeStr:holdTitle andCountStr:planAccountModel.currentPlanCount.integerValue];
    [self.toolBarView.itemSet[exitTitle] setTitle:exitLabelStr forState:UIControlStateNormal];
    [self.toolBarView.itemSet[exitTingTitle] setTitle:exitingLabelStr forState:UIControlStateNormal];
    [self.toolBarView.itemSet[holdTitle] setTitle:holdLabelStr forState:UIControlStateNormal];
}

- (void) setUserInfoViewModel:(HXBRequestUserInfoViewModel *)userInfoViewModel {
    _userInfoViewModel = userInfoViewModel;
    self.topView.userInfoViewModel = userInfoViewModel;
}
- (void) setExit_Plan_array:(NSMutableArray<HXBMYViewModel_MianPlanViewModel *> *)exit_Plan_array {
    _exit_Plan_array = exit_Plan_array;
    [self.exit_Plan_TableView.header endRefreshing];
    self.exit_Plan_TableView.mainPlanViewModelArray = exit_Plan_array;
    //    self.exitLabel.text = [self formatStrWithTypeStr:exitTitle andCountStr:exit_Plan_array.count];
    
}
- (void)setExiting_Plan_array:(NSMutableArray<HXBMYViewModel_MianPlanViewModel *> *)exiting_Plan_array {
    _exiting_Plan_array = exiting_Plan_array;
    [self.exiting_Plan_TableView.header endRefreshing];
    self.exiting_Plan_TableView.mainPlanViewModelArray = exiting_Plan_array;
    //    self.exitingLabel.text = [self formatStrWithTypeStr:exitTingTitle andCountStr:exiting_Plan_array.count];
}
- (void)setHold_Plan_array:(NSMutableArray<HXBMYViewModel_MianPlanViewModel *> *)hold_Plan_array {
    _hold_Plan_array = hold_Plan_array;
    [self.hold_Plan_TableView.header endRefreshing];
    self.hold_Plan_TableView.mainPlanViewModelArray = hold_Plan_array;
    //    self.holdLabel.text = [self formatStrWithTypeStr:holdTitle andCountStr:hold_Plan_array.count];
}
- (NSString *)formatStrWithTypeStr: (NSString *)typeStr andCountStr: (NSInteger)count {
    if (count) {
        NSString *countStr = @(count).description;
        return [NSString stringWithFormat:@"%@(%@)",typeStr,countStr];
    }
    return typeStr;
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
    [self setupSubView];
}

- (void)setupSubView {
//    [self setupTopView];// 搭建顶部的View信息
    
    [self addSubview: self.scrollToolBarView];
    [self refresh];//刷新的搭建
    [self registerClickCellEvent];//注册cell的点击事件
}
// 搭建顶部的View信息
//- (void)setupTopView {
//    self.topView = [[HXBMainListView_Plan_TopView alloc]init];
//    [self downLoadTopViewData];
//}
- (void)downLoadTopViewData {
    kWeakSelf
    [KeyChain downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        weakSelf.topView.userInfoViewModel = viewModel;
    } andFailure:^(NSError *error) {
        
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
    label.frame = button.bounds;
    button.titleLabel.text = @"";
}


#pragma mark - 事件的传递
///中间的toolBarView 的 select将要改变的时候
- (void)changeMidSelectOptionFuncWithBlock:(void (^)(UIButton *button, NSString *title, NSInteger index, HXBRequestType_MY_PlanRequestType requestType))changeMidSelectOptionBlock {
    self.changeMidSelectOptionBlock = changeMidSelectOptionBlock;
}

///上啦刷新下拉加载
- (void)refresh {
    [self downLoadRefresh];
    [self upDataRefresh];
}

///下拉刷新
- (void)downLoadRefresh {
    __weak typeof (self)weakSelf = self;

    self.hold_Plan_TableView.header = [STRefreshHeader headerWithRefreshingBlock:^(STRefreshHeader *header) {
     if (weakSelf.hold_Plan_UPRefresh) weakSelf.hold_Plan_UPRefresh();
    }];
    self.exiting_Plan_TableView.header = [STRefreshHeader headerWithRefreshingBlock:^(STRefreshHeader *header) {
        if (weakSelf.exiting_Plan_DownRefresh) weakSelf.exiting_Plan_UPRefresh();
    }];
    self.exit_Plan_TableView.header = [STRefreshHeader headerWithRefreshingBlock:^(STRefreshHeader *header) {
       if (weakSelf.exit_Plan_DownRefresh) weakSelf.exit_Plan_UPRefresh();
    }];
}

//上啦加载
- (void) upDataRefresh {
    __weak typeof(self) weakSelf = self;
    [self.hold_Plan_TableView hxb_footerWithRefreshBlock:^{
        if (weakSelf.hold_Plan_DownRefresh) weakSelf.hold_Plan_DownRefresh();
    }];
    
    [self.exiting_Plan_TableView hxb_footerWithRefreshBlock:^{
        if(weakSelf.exiting_Plan_UPRefresh) weakSelf.exiting_Plan_DownRefresh();
    }];
    
    [self.exit_Plan_TableView hxb_footerWithRefreshBlock:^{
        if(weakSelf.exit_Plan_UPRefresh) weakSelf.exit_Plan_DownRefresh();
    }];
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
