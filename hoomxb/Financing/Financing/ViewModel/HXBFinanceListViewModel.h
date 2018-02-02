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

@interface HXBFinanceListViewModel : HXBBaseViewModel

// 红利计划列表的数据数组
@property (nonatomic,strong) NSMutableArray <HXBFinHomePageViewModel_PlanList *> *planListViewModelArray;

// 散标列表的数据数组
@property (nonatomic,strong) NSMutableArray <HXBFinHomePageViewModel_LoanList *> *loanListViewModelArray;

// 债转列表的数据数组
@property (nonatomic,strong) NSMutableArray <HXBFinHomePageViewModel_LoanTruansferViewModel *> *loanTruansferViewModelArray;

// 红利计划列表请求
- (void)planListWithIsUpData: (BOOL)isUpData
                 resultBlock: (void(^)(NSInteger totalCount, BOOL isSuccess))resultBlock;


// 散标列表请求
- (void)loanListWithIsUpData: (BOOL)isUpData
                 resultBlock: (void(^)(NSInteger totalCount, BOOL isSuccess))resultBlock;

// 债权转让列表请求
- (void)loanTruansferListWithIsUpData: (BOOL)isUPData
                          resultBlock: (void (^)(NSInteger totalCount, BOOL isSuccess))resultBlock;


/**
 红利计划转模型
 
 @param dataList 数据数组
 @return 模型数组
 */
- (NSMutableArray <HXBFinHomePageViewModel_PlanList *>*)plan_dataProcessingWitharr:(NSArray *)dataList;

@end
