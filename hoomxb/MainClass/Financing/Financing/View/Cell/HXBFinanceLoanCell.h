//
//  HXBFinanceLoanCell.h
//  hoomxb
//
//  Created by lxz on 2018/7/4.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseTableViewCell.h"
#import "HXBFinHomePageViewModel_LoanList.h"

#define HXBFinanceLoanCellID @"HXBFinanceLoanCellID"

@interface HXBFinanceLoanCell : HXBBaseTableViewCell
@property (nonatomic, strong) HXBFinHomePageViewModel_LoanList *loanListViewModel;
@end
