//
//  HXBFinanctingRequest.m
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinanctingRequest.h"
#import "HXBFinHomePageViewModel_PlanList.h"//红利计划的的ViewModel
#import "HXBFinHomePageViewModel_LoanList.h"//散标列表的ViewModel
#import "HXBFinancing_LoanListAPI.h"//散标列表api
#import "HXBFinancing_planListAPI.h"//红利计划列表api
#import "HXBFinHomePageModel_PlanList.h"//红利计划列表页的Model
#import "HXBFinHomePageModel_LoanList.h"//散标列表的model


//MARK: - 详情页
#import "HXBFinancing_PlanDetaileAPI.h"//红利计划详情页
#import "HXBFinDetailViewModel_PlanDetail.h"//红利计划详情的ViewModel
#import "HXBFinDetailModel_PlanDetail.h"//红利计划详情页Model

#import "HXBFinancing_LoanDetileAPI.h"//散标详情API
#import "HXBFinDetailViewModel_LoanDetail.h"//散标详情ViewModel
#import "HXBFinDatailModel_LoanDetail.h"//散标Model

//MARK: - 加入记录
#import "HXBFinancing_PlanAddRecortdAPI.h"//加入记录API
#import "HXBFinModel_AddRecortdModel_Plan.h"//加入记录的model


@interface HXBFinanctingRequest ()
//红利计划列表的页数
@property (nonatomic,assign) BOOL isUPRefresh_Plan;
@property (nonatomic,assign) NSInteger planListPage;

@property (nonatomic,assign) BOOL isUPRefresh_Loan;
@property (nonatomic,assign) NSInteger loanListPage;

//红利计划 加入记录
@property (nonatomic,assign) BOOL isUPLoadAddRecortd_Plan;
@property (nonatomic,assign) NSInteger addRecortdPage_Plan;

//红利计划列表的数据数组
@property (nonatomic,strong) NSMutableArray <HXBFinHomePageViewModel_PlanList *>*planListViewModelArray;
@property (nonatomic,strong) NSMutableArray <HXBFinHomePageViewModel_LoanList *>*loanListViewModelArray;
@end

@implementation HXBFinanctingRequest

- (instancetype)init {
    if (self = [super init]){
        self.planListViewModelArray = [[NSMutableArray alloc]init];
        self.loanListViewModelArray = [[NSMutableArray alloc]init];
    }
    return self;
}

+ (instancetype)sharedFinanctingRequest {
    static dispatch_once_t onceToken;
    static id _instanceType;
    dispatch_once(&onceToken, ^{
        _instanceType = [[self alloc]init];
    });
    return _instanceType;
}


#pragma mark - setter
- (void)setIsUPRefresh_Plan:(BOOL)isUPRefresh_Plan {
    _isUPRefresh_Plan = isUPRefresh_Plan;
    if (_isUPRefresh_Plan) {
        self.planListPage = 1;
        [self.planListViewModelArray removeAllObjects];
    }
}
- (void)setIsUPRefresh_Loan:(BOOL)isUPRefresh_Loan {
    _isUPRefresh_Loan = isUPRefresh_Loan;
    if (_isUPRefresh_Loan) {
        self.loanListPage = 1;
        [self.loanListViewModelArray removeAllObjects];
    }
}

- (void)setIsUPLoadAddRecortd_Plan:(BOOL)isUPLoadAddRecortd_Plan{
    _isUPLoadAddRecortd_Plan = isUPLoadAddRecortd_Plan;
    if (isUPLoadAddRecortd_Plan) {
        self.addRecortdPage_Plan = 1;
    }
}

#pragma mark - homePage reaquest
//MARK: 红利计划列表api
- (void)planBuyListWithIsUpData: (BOOL)isUPData andSuccessBlock: (void(^)(NSArray<HXBFinHomePageViewModel_PlanList *>* viewModelArray))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock {
    //是否为上拉刷新
    self.isUPRefresh_Plan = isUPData;
    
    HXBFinancing_planListAPI *planBuyListAPI = [[HXBFinancing_planListAPI alloc]init];
    planBuyListAPI.requestArgument = @{
                                       @"version" : @"1.0",
                                       @"userId" : @"1",
                                       @"start" : @(1),
                                       @"num" : @"20",
                                       @"pageNumber" : @(self.planListPage),
                                       @"pageSize" : @(20)//每页的个数
                                       };

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
        self.planListPage ++;
        if (successDateBlock) successDateBlock(self.planListViewModelArray);
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (error && failureBlock) {
            NSLog(@"%@ === ✘红利计划请求没有数据 ===",error);
            failureBlock(error);
        }
    }];
}

//MARK: 散标列表api
- (void)loanBuyListWithIsUpData: (BOOL)isUPData andSuccessBlock: (void(^)(NSArray<HXBFinHomePageViewModel_LoanList *>* viewModelArray))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock{
    self.isUPRefresh_Loan = isUPData;
    HXBFinancing_LoanListAPI *loanListAPI = [[HXBFinancing_LoanListAPI alloc]init];
    loanListAPI.requestArgument = @{
                                       @"version" : @"1.0",
                                       @"userId" : @"1",
                                       @"start" : @(1),
                                       @"num" : @"20",
                                       @"pageNumber" : @(self.loanListPage),
                                       @"pageSize" : @(20)//每页的个数
                                       };
    [loanListAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        //数据
        NSArray <NSDictionary *>* dataList = responseObject[@"data"][@"dataList"];
        
        if (!responseObject || !dataList.count) {
            NSLog(@"✘散标购买请求没有数据");
            return;
        }
        
        [dataList enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            HXBFinHomePageModel_LoanList *financtingLoanListModel = [[HXBFinHomePageModel_LoanList alloc]init];
            //创建viewModel
            HXBFinHomePageViewModel_LoanList *financtingLoanListViewModel = [[HXBFinHomePageViewModel_LoanList alloc]init];
            //字典转模型
            [financtingLoanListModel yy_modelSetWithDictionary:obj];
            //给viewModel赋值MODEL
            financtingLoanListViewModel.loanListModel = financtingLoanListModel;
            [self.loanListViewModelArray addObject:financtingLoanListViewModel];
        }];
        //回调
        self.loanListPage ++;
        if (successDateBlock) successDateBlock(self.loanListViewModelArray);
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (error && failureBlock) {
             NSLog(@"✘散标购买请求没有数据");
            failureBlock(error);
        }
    }];
}


#pragma mark - 详情页 数据请求
- (void)planDetaileWithPlanID: (NSString *)financePlanId andSuccessBlock: (void(^)(HXBFinDetailViewModel_PlanDetail* viewModel))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock{
    HXBFinancing_PlanDetaileAPI *planDetaileAPI = [[HXBFinancing_PlanDetaileAPI alloc]init];
     planDetaileAPI.requestArgument = @{
                                       @"version" : @"1.0",
                                       @"userId" : @"1",
                                       @"financePlanId" : financePlanId,
                                       @"platform" : @"IOS"
                                       };

    
    [planDetaileAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSDictionary *planDetaileDic = [responseObject valueForKey:@"data"];
        HXBFinDetailModel_PlanDetail *planDetaileModel = [[HXBFinDetailModel_PlanDetail alloc]init];
        [planDetaileModel yy_modelSetWithDictionary:planDetaileDic];
        HXBFinDetailViewModel_PlanDetail *planDetailViewModel = [[HXBFinDetailViewModel_PlanDetail alloc]init];
        planDetailViewModel.planDetailModel = planDetaileModel;
        if (successDateBlock) {
            successDateBlock(planDetailViewModel);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (error && failureBlock) {
            NSLog(@"✘红利计划详情 - 请求没有数据");
            failureBlock(error);
        }
    }];
}

- (void)loanDetaileWithLoanID: (NSString *)financeLoanId andSuccessBlock: (void(^)(HXBFinDetailViewModel_LoanDetail* viewModel))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock{
    HXBFinancing_LoanDetileAPI *loanDetaileAPI = [[HXBFinancing_LoanDetileAPI alloc]init];
    loanDetaileAPI.requestArgument = @{
                                       @"loanId" : @"761133",//loanID
                                       @"version" : @"1.0" //版本号
                                       };
    [loanDetaileAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSDictionary *planDetaileDic = [responseObject valueForKey:@"data"];
        HXBFinDatailModel_LoanDetail *loanDetaileModel = [[HXBFinDatailModel_LoanDetail alloc]init];
        [loanDetaileModel yy_modelSetWithDictionary:planDetaileDic];
        HXBFinDetailViewModel_LoanDetail *loanDetailViewModel = [[HXBFinDetailViewModel_LoanDetail alloc]init];
        loanDetailViewModel.loanDetailModel = loanDetaileModel;
        if (successDateBlock) {
            successDateBlock(loanDetailViewModel);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (error && failureBlock) {
            NSLog(@"✘红利计划详情 - 请求没有数据");
            failureBlock(error);
        }
    }];
}



#pragma mark - 红利计划详情页 - 加入记录
- (void)planAddRecortdWithISUPLoad: (BOOL)isUPLoad andFinancePlanId: (NSString *)financePlanId andOrder: (NSString *)order andSuccessBlock: (void(^)(HXBFinModel_AddRecortdModel_Plan * model))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock {
    //order 排序：AMOUNT-按加入金额排序，其他值-按加入时间排序
    //version string 响应结果版本号：1.0-默认值
    HXBFinancing_PlanAddRecortdAPI *planAddRecortdAPI = [[HXBFinancing_PlanAddRecortdAPI alloc]init];
    self.isUPLoadAddRecortd_Plan = isUPLoad;
    if (!order) order = @"TIME";
    if (!financePlanId) financePlanId = @"2";
    planAddRecortdAPI.requestArgument = @{
                                          @"userId" : @"7", // int 用户ID
                                          @"financePlanId" : @2, // 红利计划ID
                                          @"order" :  order, // string 排序
                                          @"version" : @"1.0" //响应结果版本号：1.0-默认值
                                          };
    [planAddRecortdAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        HXBFinModel_AddRecortdModel_Plan *planAddRecortdModel = [[HXBFinModel_AddRecortdModel_Plan alloc]init];
        if (!responseObject) {
            NSLog(@"✘ 红利计划的详情页 - 加入计划无数据");
        }
        NSDictionary *dataDic = [responseObject valueForKey:@"data"];
        [planAddRecortdModel yy_modelSetWithDictionary:dataDic];
        if (successDateBlock) {
            successDateBlock(planAddRecortdModel);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        NSLog(@"✘ 红利计划的详情页 - 加入计划 - 网络请求失败");
        if (error) {
            failureBlock(error);
        }
    }];
}
@end
