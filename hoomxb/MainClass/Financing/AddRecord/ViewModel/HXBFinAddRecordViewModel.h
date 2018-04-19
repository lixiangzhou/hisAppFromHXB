//
//  HXBFinAddRecordViewModel.h
//  hoomxb
//
//  Created by hxb on 2018/1/11.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
/// 计划、散标、债转投资记录viewmodel

#import "HXBBaseViewModel.h"
#import "HXBFinModel_AddRecortdModel_Plan.h"
#import "FinModel_AddRecortdModel_Loan.h"
#import "HXBFinModel_AddRecortdModel_LoanTruansfer.h"

@interface HXBFinAddRecordViewModel : HXBBaseViewModel

@property (nonatomic,strong) HXBFinModel_AddRecortdModel_Plan *addRecortdModel_PlanModel;
@property (nonatomic,strong) FinModel_AddRecortdModel_Loan *addRecortdModel_LoanModel;
@property (nonatomic,strong) NSArray<HXBFinModel_AddRecortdModel_LoanTruansfer *> *loanTruansferRecortdModelArray;


/// 计划-加入记录
- (void)requestPlanAddRecortdFinanceWithId:(NSString *)planId resultBlock: (void(^)(BOOL isSuccess,NSError *error))resultBlock;


/// 散标-加入记录
- (void)requestLoanAddRecortdWithId:(NSString *)loanId resultBlock: (void(^)(BOOL isSuccess,NSError *error))resultBlock;


/// 债转-加入记录
- (void)requestLoanTruaLnsferAddRecortdWithId:(NSString *)loanTruaLnsferId resultBlock: (void(^)(BOOL isSuccess,NSError *error))resultBlock;


@end
