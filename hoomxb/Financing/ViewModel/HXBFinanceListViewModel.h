//
//  HXBFinanceListViewModel.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/1/11.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBBaseViewModel.h"

#import "HXBFinHomePageViewModel_PlanList.h"                //红利计划列表Model
#import "HXBFinHomePageViewModel_LoanList.h"                //散标列表Model
#import "HXBFinHomePageViewModel_LoanTruansferViewModel.h"  //债转列表Model

@interface HXBFinanceListViewModel : HXBBaseViewModel
// 红利计划列表的数据数组
@property (nonatomic,strong) NSMutableArray <HXBFinHomePageViewModel_PlanList *> *planListViewModelArray;
// 散标列表的数据数组
@property (nonatomic,strong) NSMutableArray <HXBFinHomePageViewModel_LoanList *> *loanListViewModelArray;
// 债转列表的数据数组
@property (nonatomic,strong) NSMutableArray <HXBFinHomePageViewModel_LoanTruansferViewModel *> *loanTruansferViewModelArray;

// 红利计划列表请求
- (void)planBuyListWithIsUpData: (BOOL)isUPData
                resultBlock: (void(^)(NSArray<HXBFinHomePageViewModel_PlanList *>* viewModelArray, NSInteger totalCount, BOOL isSuccess))successDateBlock;


// 散标列表请求
- (void)loanBuyListWithIsUpData: (BOOL)isUPData
                andSuccessBlock: (void(^)(NSArray<HXBFinHomePageViewModel_LoanList *>* viewModelArray,NSInteger totalCount))successDateBlock
                andFailureBlock: (void(^)(NSError *error))failureBlock;

// 债权转让列表请求
- (void)loanTruansferListWithIsUPData: (BOOL)isUPData
                      andSuccessBlock: (void (^)(NSArray<HXBFinHomePageViewModel_LoanTruansferViewModel *>* viewModelArray,NSInteger totalCount))successDateBlock
                      andFailureBlock: (void(^)(NSError *error,id responsObject))failureBlock;



@end
