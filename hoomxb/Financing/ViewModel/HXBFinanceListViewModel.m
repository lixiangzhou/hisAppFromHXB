//
//  HXBFinanceListViewModel.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/1/11.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinanceListViewModel.h"
#import "HXBBaseRequest.h"

#import "HXBFinHomePageModel_PlanList.h"



@implementation HXBFinanceListViewModel

// 红利计划列表请求
- (void)planBuyListWithIsUpData: (BOOL)isUpData
                    resultBlock: (void(^)(NSArray<HXBFinHomePageViewModel_PlanList *>* viewModelArray, NSInteger totalCount, BOOL isSuccess))successDateBlock {
    
    HXBBaseRequest *planListRequest = [[HXBBaseRequest alloc] initWithDelegate:self];
    //是否为下拉刷新
    planListRequest.isUPReloadData = isUpData;// 这里一定要 在前面  否则 api的page不会++ 或变为1
    NSString *planListUrl = isUpData ? @"/plan?page=1&cashType=HXB": [NSString stringWithFormat:@"/plan?page=%ld", planListRequest.dataPage];
    planListRequest.requestUrl = planListUrl;
    planListRequest.requestMethod = NYRequestMethodGet;
    [planListRequest loadDataWithSuccess:^(HXBBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
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
        
        if (successDateBlock) {
            ///数据的存储
            if (isUpData) {
                [PPNetworkCache setHttpCache:responseObject URL:@"/plan" parameters:nil];
            }
            NSString *totalCountStr = responseObject[@"data"][@"totalCount"];
            successDateBlock(self.planListViewModelArray, totalCountStr.integerValue, YES);
            [HXBDataManager setFin_PlanListViewModelArrayWithArray:self.planListViewModelArray];///缓存数据
        }
    } failure:nil];
}

// 散标列表请求
- (void)loanBuyListWithIsUpData: (BOOL)isUPData
                andSuccessBlock: (void(^)(NSArray<HXBFinHomePageViewModel_LoanList *>* viewModelArray,NSInteger totalCount))successDateBlock
                andFailureBlock: (void(^)(NSError *error))failureBlock {
    
}

// 债权转让列表请求
- (void)loanTruansferListWithIsUPData: (BOOL)isUPData
                      andSuccessBlock: (void (^)(NSArray<HXBFinHomePageViewModel_LoanTruansferViewModel *>* viewModelArray,NSInteger totalCount))successDateBlock
                      andFailureBlock: (void(^)(NSError *error,id responsObject))failureBlock {
    
}


/**
 将数据转为模型
 
 @param dataList 数据数组
 @return 模型数组
 */
- (NSMutableArray <HXBFinHomePageViewModel_PlanList *>*)plan_dataProcessingWitharr:(NSArray *)dataList
{
    NSMutableArray <HXBFinHomePageViewModel_PlanList *>*planListViewModelArray = [[NSMutableArray alloc]init];
    
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

// 数据的处理
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


@end
