//
//  HXBMainListView_Plan_TopView.h
//  hoomxb
//
//  Created by HXB on 2017/5/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "STHeaderView.h"
@class HXBMYModel_AssetStatistics_Plan;
///顶部的View
@interface HXBMainListView_Plan_TopView : STHeaderView
///资产统计
@property (nonatomic,strong) HXBRequestUserInfoViewModel *userInfoViewModel;
@end
