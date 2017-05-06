//
//  HXBFinancting_PlanListTableViewCell.h
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBFinHomePageViewModel_PlanList;
@interface HXBFinancting_PlanListTableViewCell : HXBBaseTableViewCell
@property (nonatomic,strong) HXBFinHomePageViewModel_PlanList *finPlanListViewModel;
///用于倒计时的string
@property (nonatomic,copy) NSString *countDownString;
@end
