//
//  HXBFinanctingView_HomePage.h
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBFinanctingModel_HomePage;
@class HXBFinanctingViewModel_HomePage;
@interface HXBFinanctingView_HomePage : UIView
///model的数组 （数据源）
@property (nonatomic,strong) NSArray <HXBFinanctingViewModel_HomePage *> *homePageViewModeArray;
///点击红利计划列表后回调，跳转详情页
@property (nonatomic,copy) void(^clickPlanListCellBlock)(NSIndexPath *indexPath, id model);
///点击散标列表后回调，跳转详情页
@property (nonatomic,copy) void (^clickLoanListCellBlock)(NSIndexPath *index, id model);

//MARK: - --------- 关于刷新 -----------------
///红利计划上拉加载
@property (nonatomic,copy) void (^planRefreshFooterBlock)();
///红利计划下拉刷新
@property (nonatomic,copy) void (^planRefreshHeaderBlock)();
///散标上拉加载
@property (nonatomic,copy) void (^loanRefreshFooterBlock)();
///散标下拉刷新
@property (nonatomic,copy) void (^loanRefreshHeaderBlock)();
@end
