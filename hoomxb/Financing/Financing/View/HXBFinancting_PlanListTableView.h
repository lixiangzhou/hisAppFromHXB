//
//  HXBFinancting_PlanListVIew.h
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXBFinHomePageViewModel_PlanList;

@interface HXBFinancting_PlanListTableView : HXBBaseTableView

// 计划列表数据源
@property (nonatomic,strong) NSArray <HXBFinHomePageViewModel_PlanList *>* planListViewModelArray;
// 点击cell回调方法
@property (nonatomic,copy) void (^clickPlanListCellBlock)(NSIndexPath *index, id model);
///年利率文字
@property (nonatomic,strong) NSString *expectedYearRateLable_ConstStr;
///期限
@property (nonatomic,strong) NSString *lockPeriodLabel_ConstStr;

@end
