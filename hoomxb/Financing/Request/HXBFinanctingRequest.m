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
@property (nonatomic,assign) NSInteger planListPage;

@property (nonatomic,assign) NSInteger loanListPage;

//红利计划 加入记录
@property (nonatomic,assign) NSInteger addRecortdPage_Plan;

//红利计划列表的数据数组
@property (nonatomic,strong) NSMutableArray <HXBFinHomePageViewModel_PlanList *>*planListViewModelArray;
@property (nonatomic,strong) NSMutableArray <HXBFinHomePageViewModel_LoanList *>*loanListViewModelArray;
@end

@implementation HXBFinanctingRequest
- (NSInteger)planListPage {
    if (_planListPage < 1) {
        _planListPage = 1;
    }
    return _planListPage;
}
- (NSInteger)loanListPage {
    if (_loanListPage < 1) {
        _loanListPage = 1;
    }
    return _loanListPage;
}
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

#pragma mark - homePage reaquest
//MARK: 红利计划列表api
- (void)planBuyListWithIsUpData: (BOOL)isUPData andSuccessBlock: (void(^)(NSArray<HXBFinHomePageViewModel_PlanList *>* viewModelArray))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock {
    //是否为上拉刷新
    if (isUPData) {
        self.planListPage = 1;
    }
    HXBFinancing_planListAPI *planBuyListAPI = [[HXBFinancing_planListAPI alloc]init];
    planBuyListAPI.requestArgument = @{
                                       @"version" : @"1.0",
                                       @"userId" : @"1",
                                       @"start" : @(self.planListPage),
                                       @"num" : @"20",
                                       @"pageNumber" : @(self.planListPage),
                                       @"pageSize" : @(20)//每页的个数
                                       };
    
     planBuyListAPI.isUPData = isUPData;
    [planBuyListAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSArray <NSDictionary *>* dataList = responseObject[@"data"][@"dataList"];
        if (!dataList.count) {
            NSLog(@"✘红利计划请求没有数据");
            return;
        }
        
        NSMutableArray <HXBFinHomePageViewModel_PlanList *>*planListViewModelArray = [[NSMutableArray alloc]init];
        
        [dataList enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HXBFinHomePageModel_PlanList *financtingPlanListModel = [[HXBFinHomePageModel_PlanList alloc]init];
            //创建viewModel
            HXBFinHomePageViewModel_PlanList *financtingPlanListViewModel = [[HXBFinHomePageViewModel_PlanList alloc]init];
            //字典转模型
            [financtingPlanListModel yy_modelSetWithDictionary:obj];
            
            NSLog(@"--- obj%@  - %d --- ",[obj valueForKey:@"expectedRate"],idx);
            NSLog(@"---expectedRate- %@--",financtingPlanListModel.expectedRate);
            //给viewModel赋值MODEL
            financtingPlanListViewModel.planListModel = financtingPlanListModel;
            [planListViewModelArray addObject:financtingPlanListViewModel];
        }];
        //回调
        HXBFinancing_planListAPI *planListAPI = (HXBFinancing_planListAPI *)request;
        //数据的处理
        [self plan_handleDataWithIsUPData:planListAPI.isUPData andData:planListViewModelArray];
        
        if (successDateBlock) successDateBlock(self.planListViewModelArray);
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (error && failureBlock) {
            kNetWorkError(@"");
            failureBlock(error);
        }
    }];
}
///数据的处理
- (void)plan_handleDataWithIsUPData: (BOOL)isUPData andData: (NSArray<HXBFinHomePageViewModel_PlanList *>*)viewModelArray {
    if (isUPData) {
        [self.planListViewModelArray removeAllObjects];
        _planListPage = 1;
    }
    //是否为重复数据
    __block BOOL isErrorData = false;
    //遍历，看是请求的数据为一样的数据
    [self.planListViewModelArray enumerateObjectsUsingBlock:^(HXBFinHomePageViewModel_PlanList * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([viewModelArray.firstObject.planListModel.ID isEqualToString:obj.planListModel.ID]) {
            kNetWorkError(@"红利计划列表页的 追加数据出现重复数据, 已经返回");
            isErrorData = true;
            *stop = true;
        }
    }];
    //如果是重复数据，那么就return
    if (isErrorData) return;
    //否则加一
    self.planListPage ++;
    [self.planListViewModelArray addObjectsFromArray:viewModelArray];
}
//MARK: 散标列表api
- (void)loanBuyListWithIsUpData: (BOOL)isUPData andSuccessBlock: (void(^)(NSArray<HXBFinHomePageViewModel_LoanList *>* viewModelArray))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock{
    HXBFinancing_LoanListAPI *loanListAPI = [[HXBFinancing_LoanListAPI alloc]init];
    if (isUPData) {
        self.loanListPage = 1;
    }
    loanListAPI.requestArgument = @{
                                       @"version" : @"1.0",
                                       @"userId" : @"1",
                                       @"start" : @(self.loanListPage),
                                       @"num" : @"20",
                                       @"pageNumber" : @(self.loanListPage),
                                       @"pageSize" : @(20)//每页的个数
                                       };
    loanListAPI.isUPData = isUPData;
    [loanListAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        //数据
        NSArray <NSDictionary *>* dataList = responseObject[@"data"][@"dataList"];
        
        if (!responseObject || !dataList.count) {
            
            NSLog(@"✘散标购买请求没有数据");
        }
        NSMutableArray <HXBFinHomePageViewModel_LoanList *>*loanDataListModelArray = [[NSMutableArray alloc]init];
        
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
        //回调
        HXBFinancing_LoanListAPI *loanListApi = (HXBFinancing_LoanListAPI *)request;
        [self loan_handleDataWithIsUPData:loanListApi.isUPData andViewModel:loanDataListModelArray];
        if (successDateBlock) successDateBlock(self.loanListViewModelArray);
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (error && failureBlock) {
             NSLog(@"✘散标购买请求没有数据");
            failureBlock(error);
        }
    }];
}
- (void)loan_handleDataWithIsUPData: (BOOL)isUPData andViewModel: (NSArray <HXBFinHomePageViewModel_LoanList *>*)loan_viewModelArray {
    if (isUPData) {
        self.loanListPage = 1;
        [self.loanListViewModelArray removeAllObjects];
    }
    
    __block BOOL isErrorData = false;
    [self.loanListViewModelArray enumerateObjectsUsingBlock:^(HXBFinHomePageViewModel_LoanList * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([loan_viewModelArray.firstObject.loanListModel.loanId isEqualToString:obj.loanListModel.loanId]) {
            kNetWorkError(@"理财 - loan列表页的 追加数据出现重复数据, 已经返回");
            isErrorData = true;
            *stop = true;
        }
    }];
    if(isErrorData) return;
    if (loan_viewModelArray.count) {
        self.loanListPage ++;
        [self.loanListViewModelArray addObjectsFromArray:loan_viewModelArray];
    }
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
            NSLog(@"✘散标计划详情 - 请求没有数据");
            failureBlock(error);
        }
    }];
}



#pragma mark - 红利计划详情页 - 加入记录
- (void)planAddRecortdWithISUPLoad: (BOOL)isUPLoad andFinancePlanId: (NSString *)financePlanId andOrder: (NSString *)order andSuccessBlock: (void(^)(HXBFinModel_AddRecortdModel_Plan * model))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock {
    //order 排序：AMOUNT-按加入金额排序，其他值-按加入时间排序
    //version string 响应结果版本号：1.0-默认值
    HXBFinancing_PlanAddRecortdAPI *planAddRecortdAPI = [[HXBFinancing_PlanAddRecortdAPI alloc]init];
//    self.isUPLoadAddRecortd_Plan = isUPLoad;
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
