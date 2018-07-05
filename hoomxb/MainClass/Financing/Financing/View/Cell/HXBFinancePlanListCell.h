//
//  HXBFinancting_PlanListTableViewCell.h
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXBFinHomePageViewModel_PlanList.h"

@interface HXBFinancePlanListCell : HXBBaseTableViewCell

@property (nonatomic,strong) HXBFinHomePageViewModel_PlanList *finPlanListViewModel;
///用于倒计时的string
@property (nonatomic,copy) NSString *countDownString;
// 标的类型
@property (nonatomic, assign) PlanType planType; // 按月计息 HXB, 普通 INVEST, 新手 NEWCOMER

@end
