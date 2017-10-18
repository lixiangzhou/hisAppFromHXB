//
//  HXBFinAddRecortdTableView_Plan.h
//  hoomxb
//
//  Created by HXB on 2017/5/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseTableView.h"
@class HXBFinModel_AddRecortdModel_LoanTruansfer;
@class FinModel_AddRecortdModel_Loan;
@class HXBFinModel_AddRecortdModel_Plan;
@class HXBFinModel_AddRecortdModel_loanLenderRecord_list_Loan;
@interface HXBFinAddRecortdTableView_Plan : HXBBaseTableView
@property (nonatomic,strong) HXBFinModel_AddRecortdModel_Plan *addRecortdModel_Plan;
@property (nonatomic,strong) FinModel_AddRecortdModel_Loan *loanModel;
@property (nonatomic,strong) NSArray <HXBFinModel_AddRecortdModel_LoanTruansfer*> *loanTruansferModelArray;
@end

@class HXBFinModel_AddRecortdModel_Plan_dataList;
@interface HXBFinAddRecortdTableViewCell_Plan : HXBBaseTableViewCell
///**
// 序号
// */
//@property (nonatomic,copy) NSString * numberStr;
///**
// id
// */
//@property (nonatomic,copy) NSString * IDStr;
///**
// 时间
// */
//@property (nonatomic,copy) NSString * dateStr;
///**
// 金额
// */
//@property (nonatomic,copy) NSString * amountStr;
- (void)showWithNumber: (NSString *)number andID:(NSString *)ID andDate:(NSString *)date andAmount:(NSString *)amount;
@property (nonatomic,strong) HXBFinModel_AddRecortdModel_Plan_dataList *addRecortdModel_plan_dataList;
@property (nonatomic,strong) HXBFinModel_AddRecortdModel_loanLenderRecord_list_Loan *loanModel;
@end

