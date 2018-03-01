//
//  HXBMY_PlanViewModel_LoanRecordViewModel.h
//  hoomxb
//
//  Created by HXB on 2017/6/28.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBMY_PlanModel_LoanRecordModel.h"///投资记录 的model 我的 plan详情
@interface HXBMY_PlanViewModel_LoanRecordViewModel : NSObject
@property (nonatomic,strong) HXBMY_PlanModel_LoanRecordModel *planLoanRecordModel;
@property (nonatomic,assign) NSInteger totalCount;

/**
 投资金额
 */
@property (nonatomic,copy) NSString * amount;
/**
 
 */
@property (nonatomic,copy) NSString * ID;
/**
 投资时间
 */
@property (nonatomic,copy) NSString * lendTime;
/**
 散标id
 */
@property (nonatomic,copy) NSString * loanId;
/**
 状态
 */
@property (nonatomic,copy) NSString * status;
/**
 新状态（收益中，转出中，已结清）
 */
@property (nonatomic,copy) NSString *statusText;

@end
