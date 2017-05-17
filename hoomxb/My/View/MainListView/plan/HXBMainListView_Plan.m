//
//  HXBMainListView_Plan.m
//  hoomxb
//
//  Created by HXB on 2017/5/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMainListView_Plan.h"
#import "HXBMainListView_Plan_TopView.h"
#import "HXBBaseToolBarView.h"
#import "HXBBaseScrollToolBarView.h"
#import "HXBBaseTableView_MYPlanList_TableView.h"

@interface HXBMainListView_Plan ()
@property (nonatomic,strong) HXBMainListView_Plan_TopView *topView;
@property (nonatomic,strong) HXBBaseToolBarView *toolBarView;
@property (nonatomic,strong) NSArray *toolBarOptionTitleArray;
@property (nonatomic,strong) HXBBaseScrollToolBarView *scorllToolBarView;
@property (nonatomic,strong) UIButton *exit_Plan_button;
@property (nonatomic,strong) UIButton *exiting_Plan_button;
@property (nonatomic,strong) UIButton *hold_Plan_Button;


@property (nonatomic,strong) HXBBaseTableView_MYPlanList_TableView *exit_Plan_TableView;///退出后
@property (nonatomic,strong) HXBBaseTableView_MYPlanList_TableView *exiting_Plan_TableView;///退出中
@property (nonatomic,strong) HXBBaseTableView_MYPlanList_TableView *hold_Plan_TableView;///持有中

///plan 的toolbarView的中间的点击
@property (nonatomic,copy) void(^changeMidSelectOptionBlock)(UIButton *button, NSString *title, NSInteger index, HXBRequestType_MY_PlanRequestType requestType);

///plan 上拉刷新与下拉加载的block
@property (nonatomic,copy) void(^hold_Plan_DownRefresh)();
@property (nonatomic,copy) void(^exiting_Plan_DownRefresh)();
@property (nonatomic,copy) void(^exit_Plan_DownRefresh)();

@property (nonatomic,copy) void(^hold_Plan_UPRefresh)();
@property (nonatomic,copy) void(^exiting_Plan_UPRefresh)();
@property (nonatomic,copy) void(^exit_Plan_UPRefresh)();
@end


@implementation HXBMainListView_Plan
//@synthesize hold_Plan_array = _hold_Plan_array;
//@synthesize exiting_Plan_array = _exiting_Plan_array;
//@synthesize exit_Plan_array = _exit_Plan_array;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUP];
    }
    return self;
}


#pragma mark - setter  数据源
- (void) setExit_Plan_array:(NSMutableArray<HXBMYViewModel_MianPlanViewModel *> *)exit_Plan_array {
    _exit_Plan_array = exit_Plan_array;
    self.exit_Plan_TableView.mainPlanViewModelArray = exit_Plan_array;
    [self.exit_Plan_button setTitle:[NSString stringWithFormat:@"已退出(%@)",@(exit_Plan_array.count)] forState:UIControlStateNormal];
}
- (void)setExiting_Plan_array:(NSMutableArray<HXBMYViewModel_MianPlanViewModel *> *)exiting_Plan_array {
    _exiting_Plan_array = exiting_Plan_array;
    self.exiting_Plan_TableView.mainPlanViewModelArray = exiting_Plan_array;
    [self.exiting_Plan_button setTitle:[NSString stringWithFormat:@"退出中(%@)",@(exiting_Plan_array.count)] forState:UIControlStateNormal];
}
- (void)setHold_Plan_array:(NSMutableArray<HXBMYViewModel_MianPlanViewModel *> *)hold_Plan_array {
    _hold_Plan_array = hold_Plan_array;
    self.hold_Plan_TableView.mainPlanViewModelArray = hold_Plan_array;
    [self.hold_Plan_Button setTitle:[NSString stringWithFormat:@"持有中(%@)",@(hold_Plan_array.count)] forState:UIControlStateNormal];
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
                                     @"持有中",
                                     @"退出中",
                                     @"已退出"
                                     ];
    [self setupSubView];
}

- (void)setupSubView {
    [self setupTopView];// 搭建顶部的View信息
    [self setupToolBarView];//搭建中部的toolBarView
    [self setupBottomScrollViewArray];//创建底部的ScrollView的集合
    [self setupScrollToolBarView];//搭建scrollToolBarView
}
// 搭建顶部的View信息
- (void)setupTopView {
    self.topView = [[HXBMainListView_Plan_TopView alloc]init];
}
//搭建中部的toolBarView
- (void)setupToolBarView {
    self.toolBarView = [HXBBaseToolBarView toolBarViewWithFrame:CGRectZero andOptionStrArray:self.toolBarOptionTitleArray];
    //把toolBarView的button记录下来
    
    //持有中
    self.hold_Plan_Button = self.toolBarView.optionItemInfo[0];
    //退出中
    self.exiting_Plan_button = self.toolBarView.optionItemInfo[1];
    //已退出
    self.exit_Plan_button = self.toolBarView.optionItemInfo[2];
    
    //开启动画
    self.toolBarView.isAnima_ItemBottomBarView = true;
}
//搭建底部的ScrollView
- (NSArray *)setupBottomScrollViewArray {
    self.hold_Plan_TableView = [[HXBBaseTableView_MYPlanList_TableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.exiting_Plan_TableView = [[HXBBaseTableView_MYPlanList_TableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.exit_Plan_TableView = [[HXBBaseTableView_MYPlanList_TableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    return @[self.hold_Plan_TableView,self.exit_Plan_TableView,self.exiting_Plan_TableView];
}

- (void)setupScrollToolBarView {
    
    NSArray *bottomViewSet = [self setupBottomScrollViewArray];
    CGRect frame = CGRectMake(0, 64, self.width, self.height - 64);
    HXBBaseScrollToolBarView *scrollToolBarView = [HXBBaseScrollToolBarView scrollToolBarViewWithFrame:frame andTopView:self.topView andTopViewH:kScrAdaptationH(60) andMidToolBarView:self.toolBarView andMidToolBarViewMargin:0 andMidToolBarViewH: kScrAdaptationH(30) andBottomViewSet:bottomViewSet];
    
    [self addSubview:scrollToolBarView];
    
    ///事件的传递
    kWeakSelf
    [scrollToolBarView midToolBarViewClickWithBlock:^(NSInteger index, NSString *title, UIButton *option) {
        if (weakSelf.changeMidSelectOptionBlock) {
            if (index >= weakSelf.toolBarOptionTitleArray.count) {
                index = weakSelf.toolBarOptionTitleArray.count - 1;
            }
            HXBRequestType_MY_PlanRequestType type = index;
            
            weakSelf.changeMidSelectOptionBlock(option, title, index, type);
        }
    }];
    
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
    [self.hold_Plan_TableView hxb_GifHeaderWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
         if (weakSelf.hold_Plan_UPRefresh) weakSelf.hold_Plan_UPRefresh();
    } andSetUpGifHeaderBlock:^(MJRefreshGifHeader *gifHeader) {}];
    
    [self.exiting_Plan_TableView hxb_GifHeaderWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
        if (weakSelf.exiting_Plan_DownRefresh) weakSelf.exiting_Plan_DownRefresh();
    } andSetUpGifHeaderBlock:^(MJRefreshGifHeader *gifHeader) {}];
    
    [self.exit_Plan_TableView hxb_GifHeaderWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
        if (weakSelf.exit_Plan_DownRefresh) weakSelf.exiting_Plan_DownRefresh();
    } andSetUpGifHeaderBlock:^(MJRefreshGifHeader *gifHeader) {}];
}
//上啦加载
- (void) upDataRefresh {
    __weak typeof(self) weakSelf = self;
    [self.hold_Plan_TableView hxb_GifFooterWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
        if (weakSelf.hold_Plan_DownRefresh) weakSelf.hold_Plan_DownRefresh();
    } andSetUpGifFooterBlock:^(MJRefreshBackGifFooter *footer) {}];
    
    [self.exiting_Plan_TableView hxb_GifFooterWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
        if(weakSelf.exiting_Plan_UPRefresh) weakSelf.exiting_Plan_UPRefresh();
    } andSetUpGifFooterBlock:^(MJRefreshBackGifFooter *footer) {}];
    
    [self.exit_Plan_TableView hxb_GifFooterWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
        if(weakSelf.exit_Plan_UPRefresh) weakSelf.exiting_Plan_UPRefresh();
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

//刷新的传递
- (void)exit_RefreashWithDownBlock:(void (^)())downBlock andUPBlock:(void (^)())UPBlock {
    self.exit_Plan_DownRefresh = downBlock;
    self.exit_Plan_UPRefresh = UPBlock;
}
- (void)exiting_RefreashWithDownBlock:(void (^)())downBlock andUPBlock:(void (^)())UPBlock {
    self.exiting_Plan_DownRefresh = downBlock;
    self.exiting_Plan_UPRefresh = UPBlock;
}
- (void)hold_RefreashWithDownBlock:(void (^)())downBlock andUPBlock:(void (^)())UPBlock {
    self.hold_Plan_UPRefresh = UPBlock;
    self.hold_Plan_DownRefresh = downBlock;
}

//MARK: 销毁
- (void) dealloc {
    NSLog(@"%@ - ✅被销毁",self.class);
}
@end
