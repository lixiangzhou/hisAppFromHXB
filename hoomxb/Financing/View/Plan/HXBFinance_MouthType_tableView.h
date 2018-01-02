//
//  HXBFinance_MouthType_tableView.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/1/2.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseTableView.h"
@class HXBFinHomePageRecommendListModel;

typedef void(^clickFirstPlanListCellBlock)(id model);

@interface HXBFinance_MouthType_tableView : HXBBaseTableView

@property (nonatomic,strong) NSArray <HXBFinHomePageRecommendListModel *>* planListViewModelArray;

@property (nonatomic, copy) clickFirstPlanListCellBlock block;
///年利率文字
@property (nonatomic,strong) NSString *expectedYearRateLable_ConstStr;
///期限
@property (nonatomic,strong) NSString *lockPeriodLabel_ConstStr;

@end
