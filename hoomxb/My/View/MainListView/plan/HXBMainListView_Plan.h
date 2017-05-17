//
//  HXBMainListView_Plan.h
//  hoomxb
//
//  Created by HXB on 2017/5/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBMYViewModel_MianPlanViewModel;
#import "HXBRequestType_MYManager.h"

/// 我的 plan listView
@interface HXBMainListView_Plan : UIView
//MARK: - 数据源
///持有中
@property (nonatomic,strong) NSArray <HXBMYViewModel_MianPlanViewModel *>*hold_Plan_array;
///plan 推出中
@property (nonatomic,strong) NSArray <HXBMYViewModel_MianPlanViewModel *>*exiting_Plan_array;
///plan 已退出
@property (nonatomic,strong) NSArray <HXBMYViewModel_MianPlanViewModel *>*exit_Plan_array;

///plan 的toolbarView的中间的点击
- (void)changeMidSelectOptionFuncWithBlock:(void (^)(UIButton *button, NSString *title, NSInteger index, HXBRequestType_MY_PlanRequestType requestType))changeMidSelectOptionBlock;
///停止刷新
- (void)endRefresh;

///上拉下拉刷新 hold
- (void) hold_RefreashWithDownBlock:(void(^)())downBlock andUPBlock: (void(^)())UPBlock;
///上拉下拉刷新 exiting
- (void) exiting_RefreashWithDownBlock:(void(^)())downBlock andUPBlock: (void(^)())UPBlock;
///上拉下拉刷新 exit
- (void) exit_RefreashWithDownBlock:(void(^)())downBlock andUPBlock: (void(^)())UPBlock;

@end
