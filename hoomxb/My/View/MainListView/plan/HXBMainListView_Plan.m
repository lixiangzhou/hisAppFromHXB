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
@interface HXBMainListView_Plan ()
@property (nonatomic,strong) HXBMainListView_Plan_TopView *topView;
@property (nonatomic,strong) HXBBaseToolBarView *toolBarView;
@property (nonatomic,strong) NSArray *toolBarOptionTitleArray;
@property (nonatomic,strong) HXBBaseScrollToolBarView *scorllToolBarView;
@property (nonatomic,strong) UIButton *exit_Plan_button;
@property (nonatomic,strong) UIButton *exiting_Plan_button;
@property (nonatomic,strong) UIButton *hold_Plan_Button;
@end


@implementation HXBMainListView_Plan
@synthesize hold_Plan_array = _hold_Plan_array;
@synthesize exiting_Plan_array = _exiting_Plan_array;
@synthesize exit_Plan_array = _exit_Plan_array;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUP];
    }
    return self;
}


#pragma mark - setter 
- (void) setExit_Plan_array:(NSMutableArray<HXBMYViewModel_MianPlanViewModel *> *)exit_Plan_array {
    _exit_Plan_array = exit_Plan_array;
}
- (void)setExiting_Plan_array:(NSMutableArray<HXBMYViewModel_MianPlanViewModel *> *)exiting_Plan_array {
    _exiting_Plan_array = exiting_Plan_array;
}
- (void)setHold_Plan_array:(NSMutableArray<HXBMYViewModel_MianPlanViewModel *> *)hold_Plan_array {
    _hold_Plan_array = hold_Plan_array;
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
- (void)setupBottomScrollViewArray {
    
}

- (void)setupScrollToolBarView {
    
}
@end
