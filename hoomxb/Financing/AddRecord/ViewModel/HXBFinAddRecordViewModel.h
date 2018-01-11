//
//  HXBFinAddRecordViewModel.h
//  hoomxb
//
//  Created by hxb on 2018/1/11.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
/// 计划、散标、债转投资记录viewmodel

#import "HXBBaseViewModel.h"

@interface HXBFinAddRecordViewModel : HXBBaseViewModel

/**
 计划-加入记录

 @param resultBlock resultBlock description
 */
- (void)requestPlanAddRecortdFinanceWithId:(NSString *)planId andResultBlock:(void (^)(id model))resultBlock;

/**
 散标-加入记录
 
 @param resultBlock resultBlock description
 */
- (void)requestLoanAddRecortdWithId:(NSString *)loanId andResultBlock:(void (^)(id model))resultBlock;

/**
 债转-加入记录
 
 @param resultBlock resultBlock description
 */
- (void)requestLoanTruaLnsferAddRecortdWithId:(NSString *)loanTruaLnsferId andResultBlock:(void (^)(id model))resultBlock;

@end
