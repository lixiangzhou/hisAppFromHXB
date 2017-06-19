//
//  HXBFinAddRecortdTableView_Plan.h
//  hoomxb
//
//  Created by HXB on 2017/5/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseTableView.h"
@class FinModel_AddRecortdModel_Loan;
@class HXBFinModel_AddRecortdModel_Plan;
@class HXBFinModel_AddRecortdModel_loanLenderRecord_list_Loan;
@interface HXBFinAddRecortdTableView_Plan : HXBBaseTableView
@property (nonatomic,strong) HXBFinModel_AddRecortdModel_Plan *addRecortdModel_Plan;
@property (nonatomic,strong) FinModel_AddRecortdModel_Loan *loanModel;
@end

@class HXBFinModel_AddRecortdModel_Plan_dataList;
@interface HXBFinAddRecortdTableViewCell_Plan : HXBBaseTableViewCell
@property (nonatomic,strong) HXBFinModel_AddRecortdModel_Plan_dataList *addRecortdModel_plan_dataList;
@property (nonatomic,strong) HXBFinModel_AddRecortdModel_loanLenderRecord_list_Loan *loanModel;
@end
