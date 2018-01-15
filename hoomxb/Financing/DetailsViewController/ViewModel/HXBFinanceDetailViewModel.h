//
//  HXBFinanceDetailViewModel.h
//  hoomxb
//
//  Created by lxz on 2018/1/11.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBFinDetailViewModel_LoanTruansferDetail.h"
#import "HXBFinDetailModel_LoanTruansferDetail.h"

@interface HXBFinanceDetailViewModel : HXBBaseViewModel

/// 债权详情页
@property (nonatomic, strong) HXBFinDetailViewModel_LoanTruansferDetail *loanTruansferDetailModel;

/// 债权详情页
- (void)requestLoanDetailWithLoanTruansferId:(NSString *)loanId resultBlock:(void (^)(BOOL isSuccess))resultBlock;
@end
