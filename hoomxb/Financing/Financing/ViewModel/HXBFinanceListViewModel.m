//
//  HXBFinanceListViewModel.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/1/11.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinanceListViewModel.h"

#import "HXBFinHomePageModel_PlanList.h"            // 计划列表的 model
#import "HXBFinHomePageModel_LoanList.h"            // 散标列表的 model
#import "HXBFinHomePageModel_LoanTruansferList.h"   // 债转列表的 model

@interface HXBFinanceListViewModel()
//plan的页数字段
@property (nonatomic,assign) NSInteger planPage;
//loan的页数字段
@property (nonatomic,assign) NSInteger loanPage;
//loanTransfer的页数字段
@property (nonatomic,assign) NSInteger loanTransferPage;
//是否正在加载计划数据
@property (nonatomic, assign) BOOL isLoadingPlanData;
//是否正在加载散标数据
@property (nonatomic, assign) BOOL isLoadingLoanData;
//是否正在加载债转数据
@property (nonatomic, assign) BOOL isLoadingLoanTransferData;
@end

@implementation HXBFinanceListViewModel

- (instancetype)initWithBlock:(HugViewBlock)hugViewBlock {
    if (self = [super initWithBlock:hugViewBlock]) {
        
        _planPage = 1;
        _loanPage = 1;
        _loanTransferPage = 1;
        
        _planListViewModelArray = [NSMutableArray array];
        _loanListViewModelArray = [NSMutableArray array];
        _loanTruansferViewModelArray = [NSMutableArray array];
    }
    return self;
}

// 红利计划列表请求
- (void)planListWithIsUpData: (BOOL)isUpData
                 financeType: (HXBFinanceType)financeType
                 resultBlock: (void(^)(BOOL isSuccess))resultBlock {
    //如果正在请求当前类型的数据，则放弃这次请求
    if ([self getStateByRequestType:financeType]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (resultBlock) resultBlock(NO);
        });
        return;
    } else {
        [self updateStateByRequestType:financeType requestState:YES];
    }
    
    NSInteger page = [self getPageNumberWithType:financeType andIsUpData:isUpData];
    
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestUrl = @"/plan";
    request.requestArgument = isUpData ? @{@"page": @(page).description,@"cashType":@"HXB"} : @{@"page": @(page).description};
    request.showHud = NO;
    kWeakSelf
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        [weakSelf updateStateByRequestType:financeType requestState:NO];
        [weakSelf distributeResponseDataWithType:financeType responseObject:responseObject];
        if (resultBlock) resultBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        [weakSelf updateStateByRequestType:financeType requestState:NO];
        if (resultBlock) resultBlock(NO);
    }];
}

// 散标列表请求
- (void)loanListWithIsUpData: (BOOL)isUpData
                 financeType: (HXBFinanceType)financeType
                 resultBlock: (void(^)(BOOL isSuccess))resultBlock {
    //如果正在请求当前类型的数据，则放弃这次请求
    if ([self getStateByRequestType:financeType]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (resultBlock) resultBlock(NO);
        });
        return;
    } else {
        [self updateStateByRequestType:financeType requestState:YES];
    }
    
    NSInteger page = [self getPageNumberWithType:financeType andIsUpData:isUpData];
    
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestUrl = @"/loan";
    request.requestArgument = @{@"page": @(page).description};
    request.showHud = NO;
    kWeakSelf
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        [weakSelf updateStateByRequestType:financeType requestState:NO];
        [weakSelf distributeResponseDataWithType:financeType responseObject:responseObject];
        if (resultBlock) resultBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        [weakSelf updateStateByRequestType:financeType requestState:NO];
        if (resultBlock) resultBlock(NO);
    }];
}

// 债权转让列表请求
- (void)loanTruansferListWithIsUpData: (BOOL)isUpData
                          financeType: (HXBFinanceType)financeType
                          resultBlock: (void (^)(BOOL isSuccess))resultBlock {
    //如果正在请求当前类型的数据，则放弃这次请求
    if ([self getStateByRequestType:financeType]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (resultBlock) resultBlock(NO);
        });
        return;
    } else {
        [self updateStateByRequestType:financeType requestState:YES];
    }
    
    NSInteger page = [self getPageNumberWithType:financeType andIsUpData:isUpData];
    
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestUrl = @"/transfer";
    request.requestArgument = @{@"page": @(page).description};
    request.showHud = NO;
    kWeakSelf
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        [weakSelf updateStateByRequestType:financeType requestState:NO];
        [weakSelf distributeResponseDataWithType:financeType responseObject:responseObject];
        if (resultBlock) resultBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        [weakSelf updateStateByRequestType:financeType requestState:NO];
        if (resultBlock) resultBlock(NO);
    }];
}

#pragma mark =============   辅助类    ===============

#pragma mark 获取page
- (NSInteger)getPageNumberWithType: (HXBFinanceType)type andIsUpData: (BOOL)isUpData {
    NSInteger page = 1;
    if(!isUpData) {
        switch (type) {
            case HXBFinance_Plan:
                page = self.planPage + 1;
                break;
            case HXBFinance_Loan:
                page = self.loanPage + 1;
                break;
            case HXBFinance_LoanTransfer:
                page = self.loanTransferPage + 1;
                break;
        }
    }
    return page;
}

#pragma mark 更新请求状态
- (void)updateStateByRequestType:(HXBFinanceType)type requestState:(BOOL)state {
    switch (type) {
        case HXBFinance_Plan:
            self.isLoadingPlanData = state;
            break;
        case HXBFinance_Loan:
            self.isLoadingLoanData = state;
            break;
        case HXBFinance_LoanTransfer:
            self.isLoadingLoanTransferData = state;
            break;
    }
}

#pragma mark 获取请求状态
- (BOOL)getStateByRequestType:(HXBFinanceType)type {
    BOOL state = NO;
    switch (type) {
        case HXBFinance_Plan:
            state = self.isLoadingPlanData;
            break;
        case HXBFinance_Loan:
            state = self.isLoadingLoanData;
            break;
        case HXBFinance_LoanTransfer:
            state = self.isLoadingLoanTransferData;
            break;
    }
    return state;
}

#pragma mark 更新页码信息
- (void)distributeResponseDataWithType:(HXBFinanceType)type responseObject:(id)responseObject{
    //页码信息处理
    NSInteger pageNumber = [responseObject[kResponseData][@"pageNumber"] integerValue];
    NSInteger pageSize = [responseObject[kResponseData][@"pageSize"] integerValue];
    NSInteger totalCount = [responseObject[kResponseData][@"totalCount"] integerValue];
    
    
    BOOL isLastPage = NO;
    if(pageNumber * pageSize >= totalCount) {
        isLastPage = YES;
    }
    
    BOOL isShowLoadMore = NO;
    if(totalCount > pageSize) {
        isShowLoadMore = YES;
    }
    
    switch (type) {
        case HXBFinance_Plan:
        {
            //页码处理
            self.planPage = pageNumber;
            self.isPlanLastPage = isLastPage;
            self.isPlanShowLoadMore = isShowLoadMore;
            //model更新
            NSMutableArray *dataViewModelArray = [self updatePlanListModelWithResponseObject:responseObject];
            if(1 == pageNumber) {
                [self.planListViewModelArray removeAllObjects];
            }
            [self.planListViewModelArray addObjectsFromArray:dataViewModelArray];
            self.plan_totalCount = totalCount;
            break;
        }
        case HXBFinance_Loan:
        {
            //页码处理
            self.loanPage = pageNumber;
            self.isLoanLastPage = isLastPage;
            self.isLoanShowLoadMore = isShowLoadMore;
            
            //model更新
            NSMutableArray *dataViewModelArray = [self updateLoanListModelWithResponseObject:responseObject];
            if(1 == pageNumber) {
                [self.loanListViewModelArray removeAllObjects];
            }
            [self.loanListViewModelArray addObjectsFromArray:dataViewModelArray];
            self.loan_totalCount = totalCount;
            break;
        }
        case HXBFinance_LoanTransfer:
        {
            //页码处理
            self.loanTransferPage = pageNumber;
            self.isLoanTruansferLastPage = isLastPage;
            self.isLoanTruansferShowLoadMore = isShowLoadMore;
            
            //model更新
            NSMutableArray *dataViewModelArray =  [self updateLoanTransferListModelWithResponseObject:responseObject];
            if(1 == pageNumber) {
                [self.loanTruansferViewModelArray removeAllObjects];
            }
            [self.loanTruansferViewModelArray addObjectsFromArray:dataViewModelArray];
            self.loanTransfer_totalCount = totalCount;
            break;
        }
    }
}

// 更新计划的model数组
- (NSMutableArray *)updatePlanListModelWithResponseObject:(id)responseObject {
    NSMutableArray <HXBFinHomePageViewModel_PlanList *> *planListViewModelArray = [[NSMutableArray alloc] init];
    NSMutableArray <NSDictionary *>* dataList = [NSMutableArray arrayWithArray:responseObject[kResponseData][kResponseDataList]];
    NSArray <NSDictionary *>* recommendList = responseObject[kResponseData][@"recommendList"];
    NSArray <NSDictionary *>* newbieProductList = responseObject[kResponseData][@"newbieProductList"];
    
    // 插入按月付息的数组
    if (recommendList.count > 0) {
        [dataList insertObjects:recommendList atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, recommendList.count)]];
    }
    if (newbieProductList.count > 0) {
        [dataList insertObjects:newbieProductList atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newbieProductList.count)]];
    }
    
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

// 更新散标的model数组
- (NSMutableArray *)updateLoanListModelWithResponseObject:(id)responseObject {
    NSMutableArray <HXBFinHomePageViewModel_LoanList *>*loanDataListModelArray = [[NSMutableArray alloc] init];
    NSMutableArray <NSDictionary *>* dataList = [NSMutableArray arrayWithArray:responseObject[kResponseData][kResponseDataList]];
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

// 更新债转的model数组
- (NSMutableArray *)updateLoanTransferListModelWithResponseObject:(id)responseObject {
    NSMutableArray <HXBFinHomePageViewModel_LoanTruansferViewModel *>*loanTruansferDataListModelArray = [[NSMutableArray alloc] init];
    NSMutableArray <NSDictionary *>* dataList = [NSMutableArray arrayWithArray:responseObject[kResponseData][kResponseDataList]];
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

@end
