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
@property (nonatomic, strong) HXBFinDetailViewModel_PlanDetail *planDetailModel;
/// 散标详情页
@property (nonatomic, strong) HXBFinDetailViewModel_LoanDetail *loanDetailModel;
/// 债权详情页
@property (nonatomic, strong) HXBFinDetailViewModel_LoanTruansferDetail *loanTruansferDetailModel;

/// 红利计划详情页
- (void)requestPlanDetailWithPlanId:(NSString *)planId resultBlock:(void (^)(BOOL isSuccess))resultBlock;
/// 散标详情页
- (void)requestLoanDetailWithLoanId:(NSString *)loanId resultBlock:(void (^)(BOOL isSuccess))resultBlock;
/// 债权详情页
- (void)requestLoanDetailWithLoanTruansferId:(NSString *)loanId resultBlock:(void (^)(BOOL isSuccess))resultBlock;
@end
