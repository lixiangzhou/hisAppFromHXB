//
//  HXBFinanceLoanTransferCell.h
//  hoomxb
//
//  Created by lxz on 2018/7/5.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseTableViewCell.h"
#import "HXBFinHomePageViewModel_LoanTruansferViewModel.h"

#define HXBFinanceLoanTransferCellID @"HXBFinanceLoanTransferCellID"
@interface HXBFinanceLoanTransferCell : HXBBaseTableViewCell
@property (nonatomic,strong) HXBFinHomePageViewModel_LoanTruansferViewModel *loanTruansferViewModel;
@end
