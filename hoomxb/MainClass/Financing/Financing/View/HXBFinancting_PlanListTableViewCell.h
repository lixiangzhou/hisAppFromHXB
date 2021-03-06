//
//  HXBFinancting_PlanListTableViewCell.h
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXBFinHomePageViewModel_PlanList.h"

@class HXBFinHomePageViewModel_LoanList;

@interface HXBFinancting_PlanListTableViewCell : HXBBaseTableViewCell

@property (nonatomic,strong) HXBFinHomePageViewModel_LoanList *loanListViewModel;

@property (nonatomic,strong) HXBFinHomePageViewModel_PlanList *finPlanListViewModel;
///用于倒计时的string
@property (nonatomic,copy) NSString *countDownString;
///年利率文字
@property (nonatomic,strong) NSString *expectedYearRateLable_ConstStr;
///期限——UI
@property (nonatomic,strong) NSString *lockPeriodLabel_ConstStr;
// 标的类型
@property (nonatomic, assign) PlanType planType; // 按月计息 HXB, 普通 INVEST, 新手 NEWCOMER

@end
