//
//  HXBMainListView_Plan_TopView.h
//  hoomxb
//
//  Created by HXB on 2017/5/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "STHeaderView.h"
@class HXBMYModel_AssetStatistics_Plan;
@class HXBMainListView_Plan_TopViewManager;
///顶部的View
@interface HXBMainListView_Plan_TopView : STHeaderView
- (void)setUPValueWithManagerBlock: (HXBMainListView_Plan_TopViewManager *(^)(HXBMainListView_Plan_TopViewManager *manager))managerBlock;
@property (nonatomic,strong) HXBMainListView_Plan_TopViewManager *manager;
///资产统计
@property (nonatomic,strong) HXBRequestUserInfoViewModel *userInfoViewModel;
@end
@interface HXBMainListView_Plan_TopViewManager : NSObject
/**
 持有资产
 */
@property (nonatomic,copy) NSString * finance;
/**
 累计收益
 */
@property (nonatomic,copy) NSString * interest;
@end
