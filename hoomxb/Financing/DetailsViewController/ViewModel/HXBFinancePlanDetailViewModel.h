//
//  HXBFinancePlanDetailViewModel.h
//  hoomxb
//
//  Created by lxz on 2018/1/11.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBFinDetailModel_PlanDetail.h"
#import "HXBFinDetailViewModel_PlanDetail.h"

@interface HXBFinancePlanDetailViewModel : HXBBaseViewModel
- (void)requestPlanDetailWithPlanId:(NSString *)planId resultBlock:(void (^)(HXBFinDetailViewModel_PlanDetail *model, BOOL isSuccess))resultBlock;
@end
