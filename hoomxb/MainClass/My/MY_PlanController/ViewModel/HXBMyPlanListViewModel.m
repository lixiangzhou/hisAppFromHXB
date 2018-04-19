//
//  HXBMyPlanListViewModel.m
//  hoomxb
//
//  Created by caihongji on 2018/1/26.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyPlanListViewModel.h"
#import "HXBMYModel_MainPlanModel.h"

@interface HXBMyPlanListViewModel()
///plan 持有中
@property (nonatomic,assign) NSInteger holdPlanPage;//用于记录页数的字段

///plan 推出中
@property (nonatomic,assign) NSInteger exitingPage;//记录了退出中的页数字段
///plan 已退出
@property (nonatomic,assign) NSInteger exitPage;//记录了推出的页数字段

///是否正在加载持有中数据
@property (nonatomic, assign) BOOL isLoadingHoldPlanData;
///是否正在加载推出中数据
@property (nonatomic, assign) BOOL isLoadingExitingData;
///是否正在加载已退出数据
@property (nonatomic, assign) BOOL isLoadingExitedData;

@end

@implementation HXBMyPlanListViewModel

- (instancetype)initWithBlock:(HugViewBlock)hugViewBlock
{
    self = [super initWithBlock:hugViewBlock];
    if(self) {
        _holdPlanPage = 1;
        _exitingPage = 1;
        _exitPage = 1;
        _hold_Plan_array = [NSMutableArray array];
        _exiting_Plan_array = [NSMutableArray array];
        _exit_Plan_array = [NSMutableArray array];
    }
    return self;
}

- (BOOL)erroStateCodeDeal:(NYBaseRequest *)request {
    if([request.requestUrl isEqualToString:kHXBMY_PlanAccountRequestURL]) {
        return NO;
    }
    return [super erroStateCodeDeal:request];
}

#pragma mark plan 账户内计划资产

- (void)myPlanAssetStatistics_requestWithSuccessBlock:(BOOL)isShowHug andResultBlock: (void(^)(BOOL isSuccess))resultBlock{
    
    NYBaseRequest *account_PlanRequest = [[NYBaseRequest alloc] initWithDelegate:self];
    account_PlanRequest.requestUrl = kHXBMY_PlanAccountRequestURL;
    account_PlanRequest.requestMethod = NYRequestMethodGet;
    account_PlanRequest.showHud = isShowHug;
    
    kWeakSelf
    [account_PlanRequest loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        //解析
        HXBMYModel_Plan_planRequestModel *planAcccountModel = [[HXBMYModel_Plan_planRequestModel alloc]init];
        NSDictionary *dataDic = responseObject[kResponseData];
        [planAcccountModel yy_modelSetWithDictionary:dataDic];
        weakSelf.planAcccountModel = planAcccountModel;
        
        if (resultBlock) {
            resultBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if(request.responseObject) {
            if(resultBlock) {
                weakSelf.planAcccountModel = [[HXBMYModel_Plan_planRequestModel alloc]init];
                resultBlock(YES);
                return;
            }
        }
        if (resultBlock) {
            resultBlock(NO);
        }
    }];
}

#pragma mark  ========= 红利计划 主界面的网络数据请求 =========

- (void)myPlan_requestWithPlanType: (HXBRequestType_MY_PlanRequestType)planRequestType
                         andUpData: (BOOL)isUPData
                    andResultBlock: (void(^)(BOOL isSuccess))resultBlock {
    
    //如果正在请求当前类型的数据，则放弃这次请求
    if([self getStateByRequestType:planRequestType]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(resultBlock) {
                resultBlock(NO);
            }
        });
        return;
    }
    else{
        [self updateStateByRequestType:planRequestType requestState:YES];
    }
    
    NSString *pageNumberStr = @(planRequestType).description;
    NSInteger page = [self getPageNumberWithType:planRequestType andIsUPData:isUPData];
    
    NYBaseRequest* request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestUrl = kHXBMY_PlanListURL;
    request.requestArgument = @{@"filter" : pageNumberStr, @"page" : @(page).description};
    
    kWeakSelf
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        [weakSelf updateStateByRequestType:planRequestType requestState:NO];
        
        NSDictionary *responseDic = responseObject[@"data"];
        HXBMYModel_MainPlanModel *planModel = [[HXBMYModel_MainPlanModel alloc]init];
        [planModel yy_modelSetWithDictionary:responseDic];
        [weakSelf distributeResponseDataWithType:planRequestType responseData:planModel];
        
        //向外回调
        if (resultBlock) {
            resultBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        [weakSelf updateStateByRequestType:planRequestType requestState:NO];
        if (resultBlock) {
            kNetWorkError(@"我的 界面 红利计划列表")
            resultBlock (NO);
        }
    }];
}

#pragma mark  根据type 区分page

- (NSInteger)getPageNumberWithType: (HXBRequestType_MY_PlanRequestType)type andIsUPData: (BOOL)isUPData {
    NSInteger page = 1;
    if(!isUPData) {
        switch (type) {
            case HXBRequestType_MY_PlanRequestType_EXIT_PLAN:
                page = self.exitPage+1;
                break;
            case HXBRequestType_MY_PlanRequestType_HOLD_PLAN:
                page = self.holdPlanPage+1;
                break;
            case HXBRequestType_MY_PlanRequestType_EXITING_PLAN:
                page = self.exitingPage+1;
                break;
        }
    }
    return page;
}

#pragma mark 获取指定债转类型的请求状态

- (BOOL)getStateByRequestType:(HXBRequestType_MY_PlanRequestType)type {
    BOOL state = NO;
    switch (type) {
        case HXBRequestType_MY_PlanRequestType_EXIT_PLAN:
            state = self.isLoadingExitedData;
            break;
        case HXBRequestType_MY_PlanRequestType_HOLD_PLAN:
            state = self.isLoadingHoldPlanData;
            break;
        case HXBRequestType_MY_PlanRequestType_EXITING_PLAN:
            state = self.isLoadingExitingData;
            break;
    }
    return state;
}

#pragma mark 更新指定债转类型的请求状态

- (void)updateStateByRequestType:(HXBRequestType_MY_PlanRequestType)type requestState:(BOOL)state {
    switch (type) {
        case HXBRequestType_MY_PlanRequestType_EXIT_PLAN:
            self.isLoadingExitedData = state;
            break;
        case HXBRequestType_MY_PlanRequestType_HOLD_PLAN:
            self.isLoadingHoldPlanData = state;
            break;
        case HXBRequestType_MY_PlanRequestType_EXITING_PLAN:
            self.isLoadingExitingData = state;
            break;
    }
}

#pragma mark 更新页码信息

- (void)distributeResponseDataWithType:(HXBRequestType_MY_PlanRequestType)type responseData:(HXBMYModel_MainPlanModel*)model {
    //页码信息处理
    NSInteger pageNumber = model.pageNumber.integerValue;
    NSInteger pageSize = model.pageSize.integerValue;
    NSInteger totalCount = model.totalCount.integerValue;
    
    BOOL isLastPage = NO;
    if(pageNumber*pageSize >= totalCount) {
        isLastPage = YES;
    }
    
    BOOL isShowLoadMore = NO;
    if(totalCount > pageSize) {
        isShowLoadMore = YES;
    }
    //生成新的model
    NSMutableArray <HXBMYViewModel_MianPlanViewModel *> *planViewModelArray = [[NSMutableArray alloc]init];
    [model.dataList enumerateObjectsUsingBlock:^(HXBMYModel_MainPlanModel_DataList * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HXBMYViewModel_MianPlanViewModel *viewModel = [[HXBMYViewModel_MianPlanViewModel alloc]init];
        viewModel.planModelDataList = obj;
        [planViewModelArray addObject:viewModel];
    }];
    
    switch (type) {
        case HXBRequestType_MY_PlanRequestType_EXIT_PLAN:
        {
            //页码处理
            self.exitPage = pageNumber;
            self.isExitedLastPage = isLastPage;
            self.isExitedShowLoadMore = isShowLoadMore;
            
            //model更新
            if(1 == pageNumber) {
                [self.exit_Plan_array removeAllObjects];
            }
            [self.exit_Plan_array addObjectsFromArray:planViewModelArray];
            
            break;
        }
        case HXBRequestType_MY_PlanRequestType_HOLD_PLAN:
        {
            //页码处理
            self.holdPlanPage = pageNumber;
            self.isHoldPlanLastPage = isLastPage;
            self.isHoldPlanShowLoadMore = isShowLoadMore;
            
            //model更新
            if(1 == pageNumber) {
                [self.hold_Plan_array removeAllObjects];
            }
            [self.hold_Plan_array addObjectsFromArray:planViewModelArray];
            
            break;
        }
        case HXBRequestType_MY_PlanRequestType_EXITING_PLAN:
        {
            //页码处理
            self.exitingPage = pageNumber;
            self.isExitingLastPage = isLastPage;
            self.isExitedShowLoadMore = isShowLoadMore;
            
            //model更新
            if(1 == pageNumber) {
                [self.exiting_Plan_array removeAllObjects];
            }
            [self.exiting_Plan_array addObjectsFromArray:planViewModelArray];
            
            break;
        }
    }
}
@end
