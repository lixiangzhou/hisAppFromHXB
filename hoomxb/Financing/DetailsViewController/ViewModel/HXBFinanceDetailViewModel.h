//
//  HXBFinanceDetailViewModel.h
//  hoomxb
//
//  Created by lxz on 2018/1/11.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBFinDetailModel_PlanDetail.h"
#import "HXBFinDetailViewModel_PlanDetail.h"
#import "HXBFinDatailModel_LoanDetail.h"
#import "HXBFinDetailViewModel_LoanDetail.h"
#import "HXBFinDetailViewModel_LoanTruansferDetail.h"
#import "HXBFinDetailModel_LoanTruansferDetail.h"

@interface HXBFinanceDetailViewModel : HXBBaseViewModel
/// 红利计划详情页
- (void)requestPlanDetailWithPlanId:(NSString *)planId resultBlock:(void (^)(HXBFinDetailViewModel_PlanDetail *model, BOOL isSuccess))resultBlock;
/// 散标详情页
- (void)requestLoanDetailWithLoanId:(NSString *)loanId resultBlock:(void (^)(HXBFinDetailViewModel_LoanDetail *model, BOOL isSuccess))resultBlock;
/// 债权详情页
- (void)requestLoanDetailWithLoanTruansferId:(NSString *)loanId resultBlock:(void (^)(HXBFinDetailViewModel_LoanTruansferDetail *model, BOOL isSuccess))resultBlock;
@end
