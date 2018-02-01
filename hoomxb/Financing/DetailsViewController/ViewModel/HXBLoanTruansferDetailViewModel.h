//
//  HXBLoanTruansferDetailViewModel.h
//  hoomxb
//
//  Created by lxz on 2018/1/15.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBFinDetailViewModel_LoanTruansferDetail.h"
#import "HXBFinDetailModel_LoanTruansferDetail.h"
#import "HXBFin_creditorChange_buy_ViewController.h"

@interface HXBLoanTruansferDetailViewModel : HXBBaseViewModel
/// 债权详情页
@property (nonatomic, strong) HXBFinDetailViewModel_LoanTruansferDetail *loanTruansferDetailModel;
///tableView的tatile
@property (nonatomic,strong) NSArray *tableViewTitleArray;

- (HXBFin_creditorChange_buy_ViewController *)getACreditorChangeBuyController:(NSString *)hasBindCard userInfo:(HXBRequestUserInfoViewModel *)viewModel;
/// 债权详情页
- (void)requestLoanDetailWithLoanTruansferId:(NSString *)loanId resultBlock:(void (^)(BOOL isSuccess))resultBlock;

@end
