//
//  HXBMy_Loan_Swipe.m
//  hoomxb
//
//  Created by HXB on 2017/6/30.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMy_Loan_Swipe.h"
#import "CustomSegmentControl.h"
#import "HXBMainListView_Loan_TopView.h"
#import "HXBBaseTableView_MYPlanList_TableView.h"
#import "HXBBaseTableView_MYPlanList_TableView.h"

#define RGBColorAlpha(r,g,b,f)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:f]
#define RGBColor(r,g,b)          RGBColorAlpha(r,g,b,1)

@interface HXBMy_Loan_Swipe ()<SwipeTableViewDataSource,SwipeTableViewDelegate,UIGestureRecognizerDelegate,UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) SwipeTableView * swipeTableView;
@property (nonatomic, strong) CustomSegmentControl *segmentBar;
///收益中
@property (nonatomic,strong) HXBBaseTableView_MYPlanList_TableView *erpaying_Loan_TableView;
///投标中
@property (nonatomic,strong) HXBBaseTableView_MYPlanList_TableView *bid_Loan_TableView;

@end
@implementation HXBMy_Loan_Swipe
- (HXBBaseTableView_MYPlanList_TableView *)erpaying_Loan_TableView {
    if (!_erpaying_Loan_TableView) {
        _erpaying_Loan_TableView = [[HXBBaseTableView_MYPlanList_TableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _erpaying_Loan_TableView;
}

- (HXBBaseTableView_MYPlanList_TableView *)bid_Loan_TableView {
    if (!_bid_Loan_TableView) {
        _bid_Loan_TableView = [[HXBBaseTableView_MYPlanList_TableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _bid_Loan_TableView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUPView];
    }
    return self;
}

- (void)setUPView {
    // init swipetableview
    self.swipeTableView = [[SwipeTableView alloc]initWithFrame:self.bounds];
    _swipeTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _swipeTableView.delegate = self;
    _swipeTableView.dataSource = self;
    _swipeTableView.shouldAdjustContentSize = YES;
    _swipeTableView.swipeHeaderView = [[HXBMainListView_Loan_TopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    _swipeTableView.swipeHeaderBar = self.segmentBar;
    _swipeTableView.swipeHeaderBarScrollDisabled = true;
}
- (CustomSegmentControl * )segmentBar {
    if (nil == _segmentBar) {
        self.segmentBar = [[CustomSegmentControl alloc]initWithItems:@[@"Item0",@"Item1",@"Item2",@"Item3"]];
        _segmentBar.size = CGSizeMake(kScreenWidth, 40);
        _segmentBar.font = [UIFont systemFontOfSize:15];
        _segmentBar.textColor = RGBColor(100, 100, 100);
        _segmentBar.selectedTextColor = RGBColor(0, 0, 0);
        _segmentBar.backgroundColor = RGBColor(249, 251, 198);
        _segmentBar.selectionIndicatorColor = RGBColor(249, 104, 92);
        _segmentBar.selectedSegmentIndex = _swipeTableView.currentItemIndex;
        [_segmentBar addTarget:self action:@selector(changeSwipeViewIndex:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentBar;
}

- (void)changeSwipeViewIndex:(UISegmentedControl *)seg {
    [_swipeTableView scrollToItemAtIndex:seg.selectedSegmentIndex animated:NO];
    // request data at current index
    [self getDataAtIndex:seg.selectedSegmentIndex];
    
}
#pragma mark - Data Reuqest

// 请求数据（根据视图滚动到相应的index后再请求数据）
- (void)getDataAtIndex:(NSInteger)index {
  
//    // 请求数据后刷新相应的item
//    ((void (*)(void *, SEL, NSNumber *, NSInteger))objc_msgSend)((__bridge void *)(self.swipeTableView.currentItemView),@selector(refreshWithData:atIndex:), @(0),index);
//    // 保存数据
//    [_dataDic setObject:@(numberOfRows) forKey:@(index)];
}

- (NSInteger)numberOfItemsInSwipeTableView:(SwipeTableView *)swipeView {
    return 4;
}

- (UIScrollView *)swipeTableView:(SwipeTableView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIScrollView *)view {

    switch (index) {
        case 0:
            
            // 获取当前index下item的数据，进行数据刷新
            //刷新数据
            
            [self.erpaying_Loan_TableView setMainLoanViewModelArray:<#(NSArray<HXBMYViewModel_MainLoanViewModel *> *)#>
            ///收益中
             view = HXBBaseTableView_MYPlanList_TableView
            ///投标中
            @property (nonatomic,strong) HXBBaseTableView_MYPlanList_TableView *bid_Loan_TableView;
            break;
            
        default:
            break;
    }
    
    
    
    // 在没有设定下拉刷新宏的条件下，自定义的下拉刷新需要做 refreshheader 的 frame 处理
    [self configRefreshHeaderForItem:view];
    
    return view;
}


@end








