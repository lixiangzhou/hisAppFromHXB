//
//  HXBFinanceListViewModel.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/1/11.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBBaseViewModel.h"

#import "HXBFinHomePageViewModel_PlanList.h"                // 红利计划列表Model
#import "HXBFinHomePageViewModel_LoanList.h"                // 散标列表Model
#import "HXBFinHomePageViewModel_LoanTruansferViewModel.h"  // 债转列表Model

typedef enum : NSUInteger {
    HXBFinance_Plan,
    HXBFinance_Loan,
    HXBFinance_LoanTransfer,
} HXBFinanceType;

@interface HXBFinanceListViewModel : HXBBaseViewModel


// 红利计划列表的数据数组
@property (nonatomic,strong) NSMutableArray <HXBFinHomePageViewModel_PlanList *> *planListViewModelArray;
@property (nonatomic, assign) NSInteger plan_totalCount;//计划总个数
@property (nonatomic, assign) BOOL isPlanLastPage;      //计划是否最后一页
@property (nonatomic, assign) BOOL isPlanShowLoadMore;  //计划是否显示加载更多

// 散标列表的数据数组
@property (nonatomic,strong) NSMutableArray <HXBFinHomePageViewModel_LoanList *> *loanListViewModelArray;
@property (nonatomic, assign) NSInteger loan_totalCount;//散标总个数
@property (nonatomic, assign) BOOL isLoanLastPage;      //计划是否最后一页
@property (nonatomic, assign) BOOL isLoanShowLoadMore;  //计划是否显示加载更多

// 债转列表的数据数组
@property (nonatomic,strong) NSMutableArray <HXBFinHomePageViewModel_LoanTruansferViewModel *> *loanTruansferViewModelArray;
@property (nonatomic, assign) NSInteger loanTransfer_totalCount;    //债转总个数
@property (nonatomic, assign) BOOL isLoanTruansferLastPage;         //计划是否最后一页
@property (nonatomic, assign) BOOL isLoanTruansferShowLoadMore;     //计划是否显示加载更多

// 红利计划列表请求
- (void)planListWithIsUpData: (BOOL)isUpData
                 financeType: (HXBFinanceType)financeType
                 resultBlock: (void(^)(BOOL isSuccess))resultBlock;


// 散标列表请求
- (void)loanListWithIsUpData: (BOOL)isUpData
                 financeType: (HXBFinanceType)financeType
                 resultBlock: (void(^)(BOOL isSuccess))resultBlock;

// 债权转让列表请求
- (void)loanTruansferListWithIsUpData: (BOOL)isUpData
                          financeType: (HXBFinanceType)financeType
                          resultBlock: (void (^)(BOOL isSuccess))resultBlock;




@end
