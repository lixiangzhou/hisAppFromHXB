//
//  HXBMy_Loan_Swipe.m
//  hoomxb
//
//  Created by HXB on 2017/6/30.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMy_Loan_Swipe.h"
#import "CustomSegmentControl.h"
#import "HXBMainListView_Loan_TopView.h"
#import "HXBBaseTableView_MYPlanList_TableView.h"
#import "HXBMainListView_Plan_TopView.h"
#import "HXBMainListView_Loan.h"
#import "HXBMYModel_Loan_LoanRequestModel.h"

#define RGBColorAlpha(r,g,b,f)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:f]
#define RGBColor(r,g,b)          RGBColorAlpha(r,g,b,1)
///收益中
static NSString *REPAYING_Title = @"收益中";
///投标中
static NSString *BID_Title = @"投标中";

@interface HXBMy_Loan_Swipe ()<SwipeTableViewDataSource,SwipeTableViewDelegate,UIGestureRecognizerDelegate,UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) SwipeTableView * scrollToolBarView;
//MARK: --------------------------- topView -------------------
@property (nonatomic,strong) HXBMainListView_Plan_TopView *loanTopView;

//MARK: --------------------------- toolBarView -------------------
@property (nonatomic,strong) CustomSegmentControl *toolBarView;
//@property (nonatomic,strong) HXBBaseToolBarView *toolBarView;
//toolBarView中的title的集合
@property (nonatomic,strong) NSArray <NSString *>*toolBarViewOptionTitleStrArray;
///收益中的label
@property (nonatomic,strong) UIButton *REPAYING_Lable;
///投标中的label
@property (nonatomic,strong) UIButton *BID_Lable;
///loan 的toolbarView的中间的点击
@property (nonatomic,copy) void(^changeMidSelectOptionBlock)(UIButton *button, NSString *title, NSInteger index, HXBRequestType_MY_LoanRequestType requestType);



//MARK: -------------------------- toolBarScrollView ----------------
//@property (nonatomic,strong) HXBBaseScrollToolBarView *scrollToolBarView;
///scrollViewToolBarView的 底部的TableView
@property (nonatomic,strong) NSMutableArray <HXBBaseTableView_MYPlanList_TableView*> *tableViewArray;
///收益中
@property (nonatomic,strong) HXBBaseTableView_MYPlanList_TableView *erpaying_Loan_TableView;
///投标中
@property (nonatomic,strong) HXBBaseTableView_MYPlanList_TableView *bid_Loan_TableView;
///投标中是否第一次加载

//MARK: ------------------------- 刷新 ----------------------------
///plan 上拉刷新与下拉加载的block
@property (nonatomic,copy) void(^repaying_Loan_DownRefresh)();
@property (nonatomic,copy) void(^bid_Loan_DownRefresh)();

@property (nonatomic,copy) void(^repaying_Loan_UPRefresh)();
@property (nonatomic,copy) void(^bid_Loan_UPRefresh)();
///将要切换底部视图的时候调用
@property (nonatomic,copy) void(^switchBottomScrollViewBlock)(NSInteger index, NSString *title, UIButton *option);

//MARK: - cell的点击
///cell的点击事件的传递
@property (nonatomic,copy) void(^clickLoan_BIDCellBlock)(HXBMYViewModel_MainLoanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex);
@property (nonatomic,copy) void(^clickLoan_RepayingCellBlock)(HXBMYViewModel_MainLoanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex);

///资产统计的事件注册
@property (nonatomic,copy) void (^assetStatisticsWithBlock)();
@end



@implementation HXBMy_Loan_Swipe
//MARK: 销毁
kDealloc

#pragma mark - setter
- (void)setLoanAccountModel:(HXBMYModel_Loan_LoanRequestModel *)loanAccountModel {
    _loanAccountModel = loanAccountModel;
    NSString *REPAYING_LableStr =  [self  formatStrWithTypeStr:REPAYING_Title andCountStr:loanAccountModel.rePayingTotalCount.integerValue];
    [self.toolBarView.itemSet[REPAYING_Title] setTitle:REPAYING_LableStr forState:UIControlStateNormal];
    NSString *BID_LableStr = [self  formatStrWithTypeStr:BID_Title andCountStr:loanAccountModel.BIDTotalCount.integerValue];
    [self.toolBarView.itemSet[BID_Title] setTitle:BID_LableStr forState:UIControlStateNormal];
}
- (void)setUserInfoViewModel:(HXBRequestUserInfoViewModel *)userInfoViewModel {
    _userInfoViewModel = userInfoViewModel;
    [_loanTopView setUPValueWithManagerBlock:^HXBMainListView_Plan_TopViewManager *(HXBMainListView_Plan_TopViewManager *manager) {
        manager.interest = userInfoViewModel.lenderEarned;
        manager.finance = userInfoViewModel.lenderPrincipal;
        return manager;
    }];
}
- (void)setRepaying_ViewModelArray:(NSArray<HXBMYViewModel_MainLoanViewModel *> *)repaying_ViewModelArray {
    _repaying_ViewModelArray = repaying_ViewModelArray;
    self.erpaying_Loan_TableView.mainLoanViewModelArray = repaying_ViewModelArray;
    //    self.REPAYING_Lable.text = [self  formatStrWithTypeStr:REPAYING_Title andCountStr:repaying_ViewModelArray.count];
}
- (void)setBid_ViewModelArray:(NSArray<HXBMYViewModel_MainLoanViewModel *> *)bid_ViewModelArray {
    _bid_ViewModelArray = bid_ViewModelArray;
    self.bid_Loan_TableView.mainLoanViewModelArray = bid_ViewModelArray;
    //    self.BID_Lable.text = [self formatStrWithTypeStr:BID_Title andCountStr:bid_ViewModelArray.count];
}

- (NSString *)formatStrWithTypeStr: (NSString *)typeStr andCountStr: (NSInteger)count {
    if (count) {
        NSString *countStr = @(count).description;
        return [NSString stringWithFormat:@"%@(%@)",typeStr,countStr];
    }
    return typeStr;
}

#pragma mark - gtter 方法
///topView
- (HXBMainListView_Plan_TopView *)loanTopView {
    if (!_loanTopView) {
        // swipe header
        _loanTopView = [[HXBMainListView_Plan_TopView alloc]init];
        _loanTopView.frame = CGRectMake(0, 0, kScreenWidth, 120);
        _loanTopView.backgroundColor = [UIColor whiteColor];
        _loanTopView.layer.masksToBounds = YES;
      
    }
    return _loanTopView;
}
///创建中间的toolBarView
- (CustomSegmentControl * )toolBarView {
    if (!_toolBarView) {
        _toolBarView = [[CustomSegmentControl alloc]initWithItems:@[
                                                                    REPAYING_Title,
                                                                    BID_Title
                                                                    ]];
        _BID_Lable = _toolBarView.itemSet[BID_Title];
        _REPAYING_Lable = _toolBarView.itemSet[REPAYING_Title];
        
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
- (void)changeSwipeViewIndex:(UISegmentedControl *)seg {
    [_scrollToolBarView scrollToItemAtIndex:seg.selectedSegmentIndex animated:NO];
    // request data at current index
    switch (seg.selectedSegmentIndex) {
        case 0:
            if (self.repaying_Loan_UPRefresh) self.repaying_Loan_UPRefresh();
            break;
        case 1:
            if (self.bid_Loan_UPRefresh) self.bid_Loan_UPRefresh();
            break;
        default:
            break;
    }
    NSLog(@"||-> request data at current index %ld",seg.selectedSegmentIndex);
}
//- (HXBBaseToolBarView *)toolBarView {
//    if (!_toolBarView) {
//        kWeakSelf
//        _toolBarView = [[HXBBaseToolBarView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) andOptionStrArray:self.toolBarViewOptionTitleStrArray];
//        _toolBarView.itemTextColor_Normal = [UIColor whiteColor];
//        _toolBarView.itemTextColor_Select = [UIColor whiteColor];
//        _toolBarView.itemTextColor_Select = [UIColor whiteColor];
//        
//        _toolBarView.isAnima_ItemBottomBarView = YES;
//        
////        // 对item 进行自定义
////        [_toolBarView setUpsetUpBarViewItemBlockFuncWithBlcok:^(UIButton *button, UIView *buttonBottomView) {
////            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
////            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
////            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
////            if ([button.titleLabel.text isEqualToString: REPAYING_Title]) {
////                [weakSelf addLableWithButton:button andLable:weakSelf.REPAYING_Lable];
////            }
////            if ([button.titleLabel.text isEqualToString:BID_Title]) {
////                [weakSelf addLableWithButton:button andLable:weakSelf.BID_Lable];
////            }
////            
////        }];
//    }
//    return _toolBarView;
//}
///Bottom scroll views
- (HXBBaseTableView_MYPlanList_TableView *) bid_Loan_TableView {
    if (!_bid_Loan_TableView) {
        _bid_Loan_TableView = [[HXBBaseTableView_MYPlanList_TableView alloc]initWithFrame:self.scrollToolBarView.bounds style:UITableViewStylePlain];
    }
    return _bid_Loan_TableView;
}
- (HXBBaseTableView_MYPlanList_TableView *) erpaying_Loan_TableView {
    if (!_erpaying_Loan_TableView) {
        _erpaying_Loan_TableView = [[HXBBaseTableView_MYPlanList_TableView alloc]initWithFrame:self.scrollToolBarView.bounds style:UITableViewStylePlain];
    }
    return _erpaying_Loan_TableView;
}
//scrollToolBarView
- (SwipeTableView *)scrollToolBarView {
    if (!_scrollToolBarView) {
        _scrollToolBarView = [[SwipeTableView alloc]initWithFrame:self.bounds];
        _scrollToolBarView.delegate = self;
        _scrollToolBarView.dataSource = self;
        _scrollToolBarView.shouldAdjustContentSize = YES;
        _scrollToolBarView.swipeHeaderView = self.loanTopView;
        _scrollToolBarView.swipeHeaderBar = self.toolBarView;
        _scrollToolBarView.swipeHeaderBarScrollDisabled = YES;
    }
    return _scrollToolBarView;
}

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUP];
    }
    return self;
}

///设置
- (void)setUP {
    [self createProperty];///创建属性
    [self addSubview:self.scrollToolBarView];
    [self refresh];///刷新
    [self registerClickCellEvent];///注册cell的点击事件
}


///创建属性
- (void)createProperty {
    self.toolBarViewOptionTitleStrArray = @[
                                            REPAYING_Title,
                                            BID_Title
                                            ];
    
    self.REPAYING_Lable = [self creatLableWithTitle:REPAYING_Title];
    self.BID_Lable = [self creatLableWithTitle:BID_Title];
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


#pragma mark - SwipeTableView M

- (NSInteger)numberOfItemsInSwipeTableView:(SwipeTableView *)swipeView {
    return 2;
}

- (UIScrollView *)swipeTableView:(SwipeTableView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIScrollView *)view {
    // 混合的itemview只有同类型的item采用重用
    if (index == 0) {
        
        // 懒加载保证同样类型的item只创建一次，以达到重用
        HXBBaseTableView_MYPlanList_TableView * tableView = self.erpaying_Loan_TableView;
        
        // 获取当前index下item的数据，进行数据刷新
        //                id data = _dataDic[@(index)];
        //                [tableView refreshWithData:data atIndex:index];
        
        view = tableView;
    }else if (index == 1) {
        
        HXBBaseTableView_MYPlanList_TableView * collectionView = self.bid_Loan_TableView;
        
        // 获取当前index下item的数据，进行数据刷新
        //                id data = _dataDic[@(index)];
        //                [collectionView refreshWithData:data atIndex:index];
        
        view = collectionView;
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
    switch (index) {
        case 0:
            if (self.repaying_Loan_UPRefresh) self.repaying_Loan_UPRefresh();
            break;
        case 1:
            if (self.bid_Loan_UPRefresh) self.bid_Loan_UPRefresh();
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
    //    STRefreshHeader * header = itemView.header;
    //    header.st_y = - (header.st_height + (_segmentBar.st_height + _headerImageView.st_height));
#endif
}

#pragma mark - 事件的传递
///中间的toolBarView 的 select将要改变的时候
- (void)changeMidSelectOptionFuncWithBlock:(void (^)(UIButton *button, NSString *title, NSInteger index, HXBRequestType_MY_LoanRequestType requestType))changeMidSelectOptionBlock {
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
    [self.bid_Loan_TableView hxb_headerWithRefreshBlock:^{
        if (weakSelf.bid_Loan_UPRefresh) weakSelf.bid_Loan_UPRefresh();
    }];
    
    [self.erpaying_Loan_TableView hxb_headerWithRefreshBlock:^{
        if (weakSelf.repaying_Loan_UPRefresh) weakSelf.repaying_Loan_UPRefresh();
    }];
}

//上啦加载
- (void) upDataRefresh {
    __weak typeof(self) weakSelf = self;
    [self.bid_Loan_TableView hxb_footerWithRefreshBlock:^{
        if (weakSelf.bid_Loan_DownRefresh) weakSelf.bid_Loan_DownRefresh();
    }];
    
    [self.erpaying_Loan_TableView hxb_footerWithRefreshBlock:^{
        if(weakSelf.repaying_Loan_DownRefresh) weakSelf.repaying_Loan_DownRefresh();
    }];
}

//停止刷新
- (void)endRefresh {
    [self.erpaying_Loan_TableView.mj_header endRefreshing];
    [self.erpaying_Loan_TableView.mj_footer endRefreshing];
    [self.bid_Loan_TableView.mj_header endRefreshing];
    [self.bid_Loan_TableView.mj_footer endRefreshing];
}

//MARK: 刷新的传递
- (void)erpaying_RefreashWithDownBlock:(void (^)())downBlock andUPBlock:(void (^)())UPBlock {
    self.repaying_Loan_UPRefresh = UPBlock;
    self.repaying_Loan_DownRefresh = downBlock;
}
- (void)bid_RefreashWithDownBlock:(void (^)())downBlock andUPBlock:(void (^)())UPBlock {
    self.bid_Loan_UPRefresh = UPBlock;
    self.bid_Loan_DownRefresh = downBlock;
}

//MARK: cell的点击
- (void)registerClickCellEvent {
    __weak typeof (self)weakSelf = self;
    [self.bid_Loan_TableView clickLoanCellFuncWithBlock:^(HXBMYViewModel_MainLoanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex) {
        if (weakSelf.clickLoan_BIDCellBlock) {
            weakSelf.clickLoan_BIDCellBlock(loanViewModel, clickLoanCellIndex);
        }
    }];
    [self.erpaying_Loan_TableView clickLoanCellFuncWithBlock:^(HXBMYViewModel_MainLoanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex) {
        if (weakSelf.clickLoan_RepayingCellBlock) {
            weakSelf.clickLoan_RepayingCellBlock(loanViewModel, clickLoanCellIndex);
        }
    }];
}
- (void)clickLoan_bid_CellFuncWithBlock:(void (^)(HXBMYViewModel_MainLoanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex))clickLoanCellBlock {
    self.clickLoan_BIDCellBlock = clickLoanCellBlock;
}
- (void)clickLoan_repaying_CellFuncWithBlock:(void (^)(HXBMYViewModel_MainLoanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex))clickLoanCellBlock {
    self.clickLoan_RepayingCellBlock = clickLoanCellBlock;
}

- (void)switchBottomScrollViewCallBackFunc:(void (^)(NSInteger, NSString *, UIButton *))switchBottomScrollViewBlock {
    self.switchBottomScrollViewBlock = switchBottomScrollViewBlock;
}

///MARK: 开始刷新资产统计
- (void)requestAssetStatisticsWithBlockFunc:(void (^)())assetStatisticsWithBlock {
    self.assetStatisticsWithBlock = assetStatisticsWithBlock;
}
@end








