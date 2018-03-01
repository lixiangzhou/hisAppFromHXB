//
//  HXBMY_LoanListViewModel.m
//  hoomxb
//
//  Created by caihongji on 2018/1/30.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_LoanListViewModel.h"
#import "HXBMYModel_Loan_LoanRequestModel.h"
#import "HXBMYViewModel_MainLoanViewModel.h"

@interface HXBMY_LoanListViewModel()

///loan 收益中 页码
@property (nonatomic, assign) NSInteger repayingPage;
/// loan 投标中 页码
@property (nonatomic, assign) NSInteger bidPage;
///转让中 页码
@property (nonatomic, assign) NSInteger truansferPage;

///是否正在加载收益中数据
@property (nonatomic, assign) BOOL isLoadingRepayingData;
///是否正在加载投标中 数据
@property (nonatomic, assign) BOOL isLoadingBigData;
///是否正在加载转让中数据
@property (nonatomic, assign) BOOL isLoadingTruansferData;

@end

@implementation HXBMY_LoanListViewModel

- (instancetype)initWithBlock:(HugViewBlock)hugViewBlock
{
    if(self = [super initWithBlock:hugViewBlock]) {
        _repayingPage = 1;
        _bidPage = 1;
        _truansferPage = 1;
        _repaying_Loan_array = [NSMutableArray array];
        _bid_Loan_array = [NSMutableArray array];
        _loanTruanfserViewModelArray = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark loan  账户内散标资产

- (void)loanAssets_AccountRequestSuccessBlock:(BOOL)isShowHug andResultBlock: (void(^)(BOOL isSuccess))resultBlock{
    
    NYBaseRequest *account_LoanRequest = [[NYBaseRequest alloc] initWithDelegate:self];
    account_LoanRequest.requestUrl = kHXBMY_LoanAccountRequestURL;
    account_LoanRequest.requestMethod = NYRequestMethodGet;
    account_LoanRequest.showHud = isShowHug;
    
    kWeakSelf
    [account_LoanRequest loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        HXBMYModel_Loan_LoanRequestModel *loanAcccountModel = [[HXBMYModel_Loan_LoanRequestModel alloc]init];
        NSDictionary *dataDic = responseObject[kResponseData];
        [loanAcccountModel yy_modelSetWithDictionary:dataDic];
        weakSelf.loanAcccountModel = loanAcccountModel;
        
        if (resultBlock) {
            resultBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) {
            resultBlock(NO);
        }
    }];
    
}

#pragma mark 散标列表的 请求
- (void)myLoan_requestWithLoanType:(HXBRequestType_MY_LoanRequestType)loanRequestType
                         andUpData: (BOOL)isUPData
                    andResultBlock: (void(^)(BOOL isSuccess))resultBlock{
    
    //如果正在请求当前类型的数据，则放弃这次请求
    if([self getStateByRequestType:loanRequestType]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(resultBlock) {
                resultBlock(NO);
            }
        });
        return;
    }
    else{
        [self updateStateByRequestType:loanRequestType requestState:YES];
    }
    
    NSString *pageNumberStr = @(loanRequestType).description;
    NSInteger page = [self getPageNumberWithType:loanRequestType andIsUPData:isUPData];
    
    NYBaseRequest* request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestUrl = kHXBMY_LoanListURL;
    request.requestMethod = NYRequestMethodGet;
    request.requestArgument = @{@"filter" : pageNumberStr, @"page" : @(page).description};
    
    kWeakSelf
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        [weakSelf updateStateByRequestType:loanRequestType requestState:NO];
        
        NSMutableArray <HXBMYViewModel_MainLoanViewModel*> *loanViewModelArray = [[NSMutableArray alloc]init];
        NSDictionary* dataDic = [responseObject valueForKey:@"data"];
        NSArray <NSDictionary *>*dataArray = [dataDic valueForKey:@"dataList"];
        
        [dataArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
            HXBMYViewModel_MainLoanViewModel *viewModel = [[HXBMYViewModel_MainLoanViewModel alloc]init];
            viewModel.status = pageNumberStr;
            HXBMyModel_MainLoanModel *loanModel = [[HXBMyModel_MainLoanModel alloc]init];
            [loanModel yy_modelSetWithDictionary:dic];
            viewModel.loanModel = loanModel;
            viewModel.requestType = loanRequestType;
            [loanViewModelArray addObject:viewModel];
        }];
        
        [weakSelf distributeResponseDataWithType:loanRequestType pageNumber:page responseDataList:loanViewModelArray responseDataDic:dataDic];
        
        //向外回调
        if (resultBlock) {
            resultBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        [weakSelf updateStateByRequestType:loanRequestType requestState:NO];
        if (resultBlock) {
            kNetWorkError(@"我的 界面 红利计划列表")
            resultBlock (NO);
        }
    }];
}

#pragma mark  根据type 区分page

- (NSInteger)getPageNumberWithType: (HXBRequestType_MY_LoanRequestType)type andIsUPData: (BOOL)isUPData {
    NSInteger page = 1;
    if(!isUPData) {
        switch (type) {
            case HXBRequestType_MY_LoanRequestType_REPAYING_LOAN:
                page = self.repayingPage+1;
                break;
            case HXBRequestType_MY_LoanRequestType_BID_LOAN:
                page = self.bidPage+1;
                break;
            case HXBRequestType_MY_LoanRequestType_Truansfer:
                page = self.truansferPage+1;
                break;
        }
    }
    return page;
}

#pragma mark 分发散标数据

- (void)distributeResponseDataWithType:(HXBRequestType_MY_LoanRequestType)type pageNumber:(NSInteger)pageNumber responseDataList:(NSArray*)modelList responseDataDic:(NSDictionary*)dataDic{
    //页码信息处理
    BOOL isLastPage = NO;
    BOOL isShowLoadMore = NO;
    if(modelList.count > 0) {
        NSInteger totalCount = [dataDic stringAtPath:@"totalCount"].integerValue;
        NSInteger pageSize = [dataDic stringAtPath:@"pageSize"].integerValue;
        if(pageNumber*pageSize >= totalCount) {
            isLastPage = YES;
        }
        if(totalCount > pageSize) {
            isShowLoadMore = YES;
        }
    }
    else {
        if(pageNumber > 1) {
            isShowLoadMore = YES;
        }
        isLastPage = YES;
    }
    
    switch (type) {
        case HXBRequestType_MY_LoanRequestType_REPAYING_LOAN:
        {
            //页码处理
            self.repayingPage = pageNumber;
            self.isRepayingLastPage = isLastPage;
            self.isRepayingShowLoadMore = isShowLoadMore;
            
            //model更新
            if(1 == pageNumber) {
                [self.repaying_Loan_array removeAllObjects];
            }
            [self.repaying_Loan_array addObjectsFromArray:modelList];
            
            break;
        }
        case HXBRequestType_MY_LoanRequestType_BID_LOAN:
        {
            //页码处理
            self.bidPage = pageNumber;
            self.isBidLastPage = isLastPage;
            self.isBidShowLoadMore = isShowLoadMore;
            
            //model更新
            if(1 == pageNumber) {
                [self.bid_Loan_array removeAllObjects];
            }
            [self.bid_Loan_array addObjectsFromArray:modelList];
            
            break;
        }
        default:
            break;
    }
}

#pragma mark 获取指定债转类型的请求状态

- (BOOL)getStateByRequestType:(HXBRequestType_MY_LoanRequestType)type {
    BOOL state = NO;
    switch (type) {
        case HXBRequestType_MY_LoanRequestType_REPAYING_LOAN:
            state = self.isLoadingRepayingData;
            break;
        case HXBRequestType_MY_LoanRequestType_BID_LOAN:
            state = self.isLoadingBigData;
            break;
        case HXBRequestType_MY_LoanRequestType_Truansfer:
            state = self.isLoadingTruansferData;
            break;
    }
    return state;
}

#pragma mark 更新指定债转类型的请求状态

- (void)updateStateByRequestType:(HXBRequestType_MY_LoanRequestType)type requestState:(BOOL)state {
    switch (type) {
        case HXBRequestType_MY_LoanRequestType_REPAYING_LOAN:
            self.isLoadingRepayingData = state;
            break;
        case HXBRequestType_MY_LoanRequestType_BID_LOAN:
            self.isLoadingBigData = state;
            break;
        case HXBRequestType_MY_LoanRequestType_Truansfer:
            self.isLoadingTruansferData = state;
            break;
    }
}

#pragma mark 转让中 列表的网络数据的请求

- (void)myLoanTruansfer_requestWithLoanTruansferWithIsUPData: (BOOL)isUPData
                                             andResultBlock: (void(^)(BOOL isSuccess))resultBlock{
    
    //如果正在请求当前类型的数据，则放弃这次请求
    if([self getStateByRequestType:HXBRequestType_MY_LoanRequestType_Truansfer]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(resultBlock) {
                resultBlock(NO);
            }
        });
        return;
    }
    else{
        [self updateStateByRequestType:HXBRequestType_MY_LoanRequestType_Truansfer requestState:YES];
    }
    
    NSInteger page = [self getPageNumberWithType:HXBRequestType_MY_LoanRequestType_Truansfer andIsUPData:isUPData];
    
    NYBaseRequest* request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestUrl = kHXBMY_LoanTruansferListURL;
    request.requestMethod = NYRequestMethodGet;
    request.requestArgument = @{
                                @"page": @(page).description,
                                @"type": @"TRANSFERING_LOAN"
                                };
    
    kWeakSelf
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        [weakSelf updateStateByRequestType:HXBRequestType_MY_LoanRequestType_Truansfer requestState:NO];
        
        NSMutableArray <HXBMY_LoanTruansferViewModel*> *truansferViewModelArray = [[NSMutableArray alloc]init];
        NSDictionary* dataDic = [responseObject valueForKey:@"data"];
        NSArray <NSDictionary *>*dataArray = [dataDic valueForKey:@"dataList"];
        
        [dataArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HXBMY_LoanTruansferModel *model = [[HXBMY_LoanTruansferModel alloc] init];
            [model yy_modelSetWithDictionary:obj];
            HXBMY_LoanTruansferViewModel *viewModel = [[HXBMY_LoanTruansferViewModel alloc]init];
            viewModel.my_truanfserModel = model;
            [truansferViewModelArray addObject:viewModel];
        }];
        
        [weakSelf distributeTruansferResponseData:page responseDataList:truansferViewModelArray responseDataDic:dataDic];
        
        //向外回调
        if (resultBlock) {
            resultBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        [weakSelf updateStateByRequestType:HXBRequestType_MY_LoanRequestType_Truansfer requestState:NO];
        if (resultBlock) {
            kNetWorkError(@"我的 界面 红利计划列表")
            resultBlock (NO);
        }
    }];
}

- (void)distributeTruansferResponseData:(NSInteger)pageNumber responseDataList:(NSArray*)modelList responseDataDic:(NSDictionary*)dataDic{
    //页码信息处理
    BOOL isLastPage = NO;
    BOOL isShowLoadMore = NO;
    NSInteger totalCount = [dataDic stringAtPath:@"totalCount"].integerValue;
    NSInteger pageSize = [dataDic stringAtPath:@"pageSize"].integerValue;
    if(pageNumber*pageSize >= totalCount) {
        isLastPage = YES;
    }
    if(totalCount > pageSize) {
        isShowLoadMore = YES;
    }
    
    //页码处理
    self.truansferPage = pageNumber;
    self.isTruanfserLastPage = isLastPage;
    self.isTruanfserShowLoadMore = isShowLoadMore;
    
    //model更新
    if(1 == pageNumber) {
        [self.loanTruanfserViewModelArray removeAllObjects];
    }
    [self.loanTruanfserViewModelArray addObjectsFromArray:modelList];

}

@end
