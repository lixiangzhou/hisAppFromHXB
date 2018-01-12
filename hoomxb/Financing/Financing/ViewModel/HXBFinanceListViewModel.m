//
//  HXBFinanceListViewModel.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/1/11.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinanceListViewModel.h"
#import "HXBBaseRequest.h"

#import "HXBFinHomePageModel_PlanList.h"            // 计划列表的 model
#import "HXBFinHomePageModel_LoanList.h"            // 散标列表的 model
#import "HXBFinHomePageModel_LoanTruansferList.h"   // 债转列表的 model

@implementation HXBFinanceListViewModel

// 红利计划列表请求
- (void)planListWithIsUpData: (BOOL)isUpData
                    resultBlock: (void(^)(NSInteger totalCount, BOOL isSuccess))resultBlock {
    
    HXBBaseRequest *planListRequest = [[HXBBaseRequest alloc] initWithDelegate:self];
    planListRequest.isUPReloadData = isUpData; //是否为下拉刷新这里一定要 在前面  否则 api的page不会++ 或变为1
    NSString *planListUrl = isUpData ? @"/plan?page=1&cashType=HXB": [NSString stringWithFormat:@"/plan?page=%ld", planListRequest.dataPage];
    planListRequest.requestUrl = planListUrl;
    planListRequest.requestMethod = NYRequestMethodGet;
    planListRequest.showHud = NO;
    [planListRequest loadDataWithSuccess:^(HXBBaseRequest *request, id responseObject) {
        ///计划列表数据是否出错
        kHXBBuyErrorResponsShowHUD
        NSMutableArray <NSDictionary *>* dataList = [NSMutableArray arrayWithArray:responseObject[@"data"][@"dataList"]];
        NSArray <NSDictionary *>* recommendList = responseObject[@"data"][@"recommendList"];
        
        // 插入按月付息的数组
        if (recommendList.count > 0) {
            [dataList insertObjects:recommendList atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, recommendList.count)]];
        }
        
        NSMutableArray <HXBFinHomePageViewModel_PlanList *>*planListViewModelArray = [self plan_dataProcessingWitharr:dataList];
        
        //数据的处理
        [self plan_handleDataWithIsUPData:request.isUPReloadData andData:planListViewModelArray];
        
        if (resultBlock) {
            ///数据的存储
            if (isUpData) {
                [PPNetworkCache setHttpCache:responseObject URL:@"/plan" parameters:nil];
            }
            NSString *totalCountStr = responseObject[@"data"][@"totalCount"];
            resultBlock(totalCountStr.integerValue, YES);
            [HXBDataManager setFin_PlanListViewModelArrayWithArray:self.planListViewModelArray];// 缓存数据
        }
    } failure:^(HXBBaseRequest *request, NSError *error) {
        resultBlock(0, NO);
    }];
}

// 散标列表请求
- (void)loanListWithIsUpData: (BOOL)isUpData
                    resultBlock: (void(^)(NSInteger totalCount, BOOL isSuccess))resultBlock {
    
    HXBBaseRequest *loanListRequest = [[HXBBaseRequest alloc] initWithDelegate:self];
    loanListRequest.isUPReloadData = isUpData;
    loanListRequest.showHud = NO;
    loanListRequest.requestUrl =  kHXBFinanc_LoanListURL(loanListRequest.dataPage);
    loanListRequest.requestMethod = NYRequestMethodGet;
    [loanListRequest loadDataWithSuccess:^(HXBBaseRequest *request, id responseObject) {
        kHXBBuyErrorResponsShowHUD
        NSArray <NSDictionary *>* dataList = responseObject[@"data"][@"dataList"];
        NSMutableArray <HXBFinHomePageViewModel_LoanList *>*loanDataListModelArray = [self loan_dataProcessingWithArr:dataList];
        [self loan_handleDataWithIsUPData:loanListRequest.isUPReloadData andViewModel:loanDataListModelArray];
        // 请求成功
        if (resultBlock) {
            NSString *totalCountStr = responseObject[@"data"][@"totalCount"];
            resultBlock(totalCountStr.integerValue, YES);
        }
        [PPNetworkCache setHttpCache:responseObject URL:@"/loan" parameters:nil];
    } failure:^(HXBBaseRequest *request, NSError *error) {
        resultBlock(0, NO);
    }];
}

// 债权转让列表请求
- (void)loanTruansferListWithIsUpData: (BOOL)isUPData
                          resultBlock: (void (^)(NSInteger totalCount, BOOL isSuccess))resultBlock {
    
    HXBBaseRequest *loanTruansferListRequest = [[HXBBaseRequest alloc] initWithDelegate:self];
    loanTruansferListRequest.isUPReloadData = isUPData;
    loanTruansferListRequest.requestMethod = NYRequestMethodGet;
    loanTruansferListRequest.showHud = NO;
    loanTruansferListRequest.requestUrl = kHXBFin_LoanTruansferURL;
    loanTruansferListRequest.requestArgument = @{
                                              @"page":@(loanTruansferListRequest.dataPage),//int    当前页
                                              @"pageSize":@kPageCount
                                              };
    [loanTruansferListRequest loadDataWithSuccess:^(HXBBaseRequest *request, id responseObject) {
        NSArray *data = responseObject[kResponseData][kResponseDataList];
        
        if (resultBlock) {
            if (request.isUPReloadData) {
                [self.loanTruansferViewModelArray removeAllObjects];
            }
            self.loanTruansferViewModelArray = [self loanTruansfer_dataProcessingWithArr:data];
            NSString *totalCountStr = responseObject[@"data"][@"totalCount"];
            resultBlock(totalCountStr.integerValue, YES);
        }
    } failure:^(HXBBaseRequest *request, NSError *error) {
        if (resultBlock) {
            resultBlock(0, NO);
        }
    }];
}


/**
    红利计划转模型
 
 @param dataList 数据数组
 @return 模型数组
 */
- (NSMutableArray <HXBFinHomePageViewModel_PlanList *>*)plan_dataProcessingWitharr:(NSArray *)dataList {
    
    NSMutableArray <HXBFinHomePageViewModel_PlanList *>*planListViewModelArray = [[NSMutableArray alloc] init];
    [dataList enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HXBFinHomePageModel_PlanList *financtingPlanListModel = [[HXBFinHomePageModel_PlanList alloc] init];
        //创建viewModel
        HXBFinHomePageViewModel_PlanList *financtingPlanListViewModel = [[HXBFinHomePageViewModel_PlanList alloc] init];
        //字典转模型
        [financtingPlanListModel yy_modelSetWithDictionary:obj];
        //给viewModel赋值MODEL
        financtingPlanListViewModel.planListModel = financtingPlanListModel;
        [planListViewModelArray addObject:financtingPlanListViewModel];
    }];
    return planListViewModelArray;
}
- (void)plan_handleDataWithIsUPData: (BOOL)isUPData
                            andData: (NSArray<HXBFinHomePageViewModel_PlanList *>*)viewModelArray {
    if (isUPData) {
        [self.planListViewModelArray removeAllObjects];
    }
    // 是否为重复数据
    __block BOOL isErrorData = NO;
    // 遍历，看是请求的数据为一样的数据
    [self.planListViewModelArray enumerateObjectsUsingBlock:^(HXBFinHomePageViewModel_PlanList * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([viewModelArray.firstObject.planListModel.ID isEqualToString:obj.planListModel.ID]) {
            kNetWorkError(@"红利计划列表页的 追加数据出现重复数据, 已经返回");
            isErrorData = YES;
            *stop = YES;
        }
    }];
    // 如果是重复数据，那么就return
    if (isErrorData) return;
    [self.planListViewModelArray addObjectsFromArray:viewModelArray];
}

/**
    散标转模型
 
 @param dataList 数据数组
 @return 模型数组
 */
- (NSMutableArray <HXBFinHomePageViewModel_LoanList *>*)loan_dataProcessingWithArr:(NSArray *)dataList {
    
    NSMutableArray <HXBFinHomePageViewModel_LoanList *>*loanDataListModelArray = [[NSMutableArray alloc] init];
    [dataList enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        HXBFinHomePageModel_LoanList *financtingLoanListModel = [[HXBFinHomePageModel_LoanList alloc]init];
        //创建viewModel
        HXBFinHomePageViewModel_LoanList *financtingLoanListViewModel = [[HXBFinHomePageViewModel_LoanList alloc]init];
        //字典转模型
        [financtingLoanListModel yy_modelSetWithDictionary:obj];
        //给viewModel赋值MODEL
        financtingLoanListViewModel.loanListModel = financtingLoanListModel;
        [loanDataListModelArray addObject:financtingLoanListViewModel];
    }];
    return loanDataListModelArray;
}
- (void)loan_handleDataWithIsUPData: (BOOL)isUPData andViewModel: (NSArray <HXBFinHomePageViewModel_LoanList *>*)loan_viewModelArray {
    if (isUPData) {
        [self.loanListViewModelArray removeAllObjects];
    }
    __block BOOL isErrorData = NO;
    [self.loanListViewModelArray enumerateObjectsUsingBlock:^(HXBFinHomePageViewModel_LoanList * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([loan_viewModelArray.firstObject.loanListModel.loanId isEqualToString:obj.loanListModel.loanId]) {
            kNetWorkError(@"理财 - loan列表页的 追加数据出现重复数据, 已经返回");
            isErrorData = YES;
            *stop = YES;
        }
    }];
    if(isErrorData) return;
    if (loan_viewModelArray.count) {
        [self.loanListViewModelArray addObjectsFromArray:loan_viewModelArray];
    }
}

/**
    债转转模型
 
 @param dataList 数据数组
 @return 模型数组
 */
- (NSMutableArray <HXBFinHomePageViewModel_LoanTruansferViewModel *>*)loanTruansfer_dataProcessingWithArr:(NSArray *)dataList {
    
    NSMutableArray <HXBFinHomePageViewModel_LoanTruansferViewModel *>*loanTruansferDataListModelArray = [[NSMutableArray alloc] init];
    [dataList enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HXBFinHomePageModel_LoanTruansferList *loanTruansferListModel = [[HXBFinHomePageModel_LoanTruansferList alloc] init];
        //创建viewModel
        HXBFinHomePageViewModel_LoanTruansferViewModel *financtingLoanListViewModel = [[HXBFinHomePageViewModel_LoanTruansferViewModel alloc] init];
        //字典转模型
        [loanTruansferListModel yy_modelSetWithDictionary:obj];
        //给viewModel赋值MODEL
        financtingLoanListViewModel.loanTruansferListModel = loanTruansferListModel;
        [loanTruansferDataListModelArray addObject:financtingLoanListViewModel];
    }];
    return loanTruansferDataListModelArray;
}

// 计划数组
- (NSMutableArray *)planListViewModelArray {
    if (!_planListViewModelArray) {
        _planListViewModelArray = [NSMutableArray array];
    }
    return _planListViewModelArray;
}

// 散标数组
- (NSMutableArray *)loanListViewModelArray {
    if (!_loanListViewModelArray) {
        _loanListViewModelArray = [NSMutableArray array];
    }
    return _loanListViewModelArray;
}

// 债转数组
- (NSMutableArray *)loanTruansferViewModelArray {
    if (!_loanTruansferViewModelArray) {
        _loanTruansferViewModelArray = [NSMutableArray array];
    }
    return _loanTruansferViewModelArray;
}

@end
