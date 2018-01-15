//
//  HXBFinancingLoanDetailViewModel.h
//  hoomxb
//
//  Created by lxz on 2018/1/15.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBFinDatailModel_LoanDetail.h"
#import "HXBFinDetailViewModel_LoanDetail.h"
#import "HXBFinDetail_TableView.h"
#import "HXBFin_DetailsView_LoanDetailsView.h"
#import "HXBFin_Loan_Buy_ViewController.h"

@interface HXBFinancingLoanDetailViewModel : HXBBaseViewModel
/// 散标详情页
@property (nonatomic, strong) HXBFinDetailViewModel_LoanDetail *loanDetailModel;
///
@property (nonatomic,strong) NSArray <HXBFinDetail_TableViewCellModel *>*tableViewModelArray;
///tableView的tatile
@property (nonatomic,strong) NSArray <NSString *>* tableViewTitleArray;

- (void)setLoanDetailViewModel:(HXBFin_DetailsView_LoanDetailsView_ViewModelVM *)viewModelVM;

- (HXBFin_Loan_Buy_ViewController *)getALoanBuyController;
/// 散标详情页
- (void)requestLoanDetailWithLoanId:(NSString *)loanId resultBlock:(void (^)(BOOL isSuccess))resultBlock;

@end
