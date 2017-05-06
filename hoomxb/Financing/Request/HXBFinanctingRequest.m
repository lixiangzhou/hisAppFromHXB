//
//  HXBFinanctingRequest.m
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinanctingRequest.h"
#import "HXBFinHomePageViewModel_PlanList.h"//红利计划的的ViewModel
#import "LoanListAPI.h"//散标列表api
#import "HXBFinancing_planListAPI.h"//红利计划列表api
#import "HXBFinHomePageModel_PlanList.h"//红利计划列表页的Model

@interface HXBFinanctingRequest ()
//红利计划列表的页数
@property (nonatomic,assign) BOOL isUPRefresh_Plan;
@property (nonatomic,assign) NSInteger planListPage;
//红利计划列表的数据数组
@property (nonatomic,strong) NSMutableArray <HXBFinHomePageViewModel_PlanList *>*planListViewModelArray;


@end

@implementation HXBFinanctingRequest
- (instancetype)init {
    if (self = [super init]){
        self.planListViewModelArray = [[NSMutableArray alloc]init];
    }
    return self;
}

#pragma mark - setter
- (void)setIsUPRefresh_Plan:(BOOL)isUPRefresh_Plan {
    _isUPRefresh_Plan = isUPRefresh_Plan;
    if (_isUPRefresh_Plan) {
        self.planListPage = 1;
        [self.planListViewModelArray removeAllObjects];
    }
}



#pragma mark - homePage reaquest
//MARK: 红利计划列表api
- (void)planBuyListWithIsUpData: (BOOL)isUPData andSuccessBlock: (void(^)(NSArray<HXBFinHomePageViewModel_PlanList *>* viewModelArray))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock {
    //是否为上拉刷新
    self.isUPRefresh_Plan = isUPData;
    
    HXBFinancing_planListAPI *planBuyListAPI = [[HXBFinancing_planListAPI alloc]init];
    
    //当前页
//    [planBuyListAPI.requestArgument setObject:@(self.planListPage) forKey:@"pageNumber"];
    
    [planBuyListAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSArray <NSDictionary *>* dataList = responseObject[@"data"][@"dataList"];
        if (!dataList.count) {
            NSLog(@"✘红利计划请求没有数据");
            return;
        }
        
        [dataList enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            HXBFinHomePageModel_PlanList *financtingPlanListModel = [[HXBFinHomePageModel_PlanList alloc]init];
            //创建viewModel
            HXBFinHomePageViewModel_PlanList *financtingPlanListViewModel = [[HXBFinHomePageViewModel_PlanList alloc]init];
            //字典转模型
            [financtingPlanListModel yy_modelSetWithDictionary:obj];
            //给viewModel赋值MODEL
            financtingPlanListViewModel.planListModel = financtingPlanListModel;
            [self.planListViewModelArray addObject:financtingPlanListViewModel];
        }];
        //回调
        if (successDateBlock) successDateBlock(self.planListViewModelArray);
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (error && failureBlock) {
            NSLog(@"✘红利计划请求没有数据");
            failureBlock(error);
        }
    }];
}

//MARK: 散标列表api
- (void)loanBuyListWithPage: (NSInteger)page andSuccessBlock: (void(^)(NSArray* viewModelArray))successDate andFailureBlock: (void(^)(NSError *error))failureBlock{
    LoanListAPI *loanListAPI = [[LoanListAPI alloc]init];
    [loanListAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        if (!responseObject) {
            NSLog(@"✘散标购买请求没有数据");
            return;
        }
        //字典转模型
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (error && failureBlock) {
            failureBlock(error);
        }
    }];
}

@end
