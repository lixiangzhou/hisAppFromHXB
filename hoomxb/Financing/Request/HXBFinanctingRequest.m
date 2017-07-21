//
//  HXBFinanctingRequest.m
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinanctingRequest.h"
#import "HXBBaseRequest.h"///网络数据请求

//MARK: - 列表页
#import "HXBFinHomePageViewModel_PlanList.h"//红利计划的的ViewModel
#import "HXBFinHomePageViewModel_LoanList.h"//散标列表的ViewModel
#import "HXBFinHomePageViewModel_LoanTruansferViewModel.h"///债转列表

#import "HXBFinHomePageModel_PlanList.h"//红利计划列表页的Model
#import "HXBFinHomePageModel_LoanList.h"//散标列表的model


//MARK: - 详情页
#import "HXBFinDetailViewModel_PlanDetail.h"//红利计划详情的ViewModel
#import "HXBFinDetailModel_PlanDetail.h"//红利计划详情页Model

#import "HXBFinDetailViewModel_LoanDetail.h"//散标详情ViewModel
#import "HXBFinDatailModel_LoanDetail.h"//散标Model

#import "HXBFinDetailViewModel_LoanTruansferDetail.h"//债转的viewModel

//MARK: - 加入记录
#import "HXBFinModel_AddRecortdModel_Plan.h"//加入记录的model
#import "FinModel_AddRecortdModel_Loan.h"//加入记录的model loan
#import "HXBFinModel_AddRecortdModel_LoanTruansfer.h"

//MARK: - 购买
#import "HXBFin_Plan_BuyViewModel.h"

#import "HXBFinModel_Buy_Plan.h"///购买
#import "HXBFinModel_BuyResoult_PlanModel.h"///购买结果
#import "HXBFinModel_Buy_LoanModel.h"//购买
#import "HXBFinModel_BuyResoult_LoanModel.h"///购买结果
#import "HXBFin_LoanTruansfer_BuyResoutViewModel.h"//债转的购买结果

@interface HXBFinanctingRequest ()
#pragma mark - Plan
///红利计划 列表API
@property (nonatomic,strong) HXBBaseRequest *planListAPI;
///红利计划 详情API
@property (nonatomic,strong) HXBBaseRequest *planDetaileAPI;
///红利计划 加入记录API
@property (nonatomic,strong) HXBBaseRequest *planAddRecortdAPI;



#pragma mark - Loan
///散标 列表的API
@property (nonatomic,strong) HXBBaseRequest *loanListAPI;
///散标 详情的API
@property (nonatomic,strong) HXBBaseRequest *loanDetaileAPI;
///散标 加入记录API
@property (nonatomic,strong) HXBBaseRequest *loanAddRecortdAPI;
///债转 加入记录
@property (nonatomic,strong) HXBBaseRequest *loanTruansferAddRecortdAPI;

#pragma mark - loanTruansfer
@property (nonatomic,strong) HXBBaseRequest *loanTruansferAPI;

//红利计划列表的数据数组
@property (nonatomic,strong) NSMutableArray <HXBFinHomePageViewModel_PlanList *>*planListViewModelArray;
@property (nonatomic,strong) NSMutableArray <HXBFinHomePageViewModel_LoanList *>*loanListViewModelArray;

//
@property (nonatomic,strong) NSMutableArray <HXBFinHomePageViewModel_LoanTruansferViewModel *>*loanTruansferViewModel;
//加入记录的数组
@property (nonatomic,strong) NSMutableArray <HXBFinModel_AddRecortdModel_LoanTruansfer *>*loanTruansferAddRecortdModelArray;
@end


@implementation HXBFinanctingRequest


//
- (HXBBaseRequest *) planListAPI {
    if (!_planListAPI) {
        _planListAPI = [[HXBBaseRequest alloc]init];
    }
    return _planListAPI;
}
- (HXBBaseRequest *) planDetaileAPI {
    if (!_planDetaileAPI) {
        _planDetaileAPI = [[HXBBaseRequest alloc]init];
    }
    return _planDetaileAPI;
}

- (HXBBaseRequest *) planAddRecortdAPI {
    if (!_planAddRecortdAPI) {
        _planAddRecortdAPI = [[HXBBaseRequest alloc]init];
    }
    return _planAddRecortdAPI;
}

- (HXBBaseRequest *) loanListAPI {
    if (!_loanListAPI) {
        _loanListAPI = [[HXBBaseRequest alloc]init];
    }
    return _loanListAPI;
}
- (HXBBaseRequest *) loanDetaileAPI {
    if (!_loanDetaileAPI) {
        _loanDetaileAPI = [[HXBBaseRequest alloc]init];
    }
    return _loanDetaileAPI;
}
- (HXBBaseRequest *)loanAddRecortdAPI {
    if (!_loanAddRecortdAPI) {
        _loanAddRecortdAPI = [[HXBBaseRequest alloc]init];
    }
    return _loanAddRecortdAPI;
}

- (HXBBaseRequest *)loanTruansferAddRecortdAPI {
    if (!_loanTruansferAddRecortdAPI) {
        _loanTruansferAddRecortdAPI = [[HXBBaseRequest alloc]init];
    }
    return _loanTruansferAddRecortdAPI;
}

- (HXBBaseRequest *)loanTruansferAPI {
    if (!_loanTruansferAPI) {
        _loanTruansferAPI = [[HXBBaseRequest alloc]init];
    }
    return _loanTruansferAPI;
}

- (instancetype)init {
    if (self = [super init]){
        self.planListViewModelArray = [[NSMutableArray alloc]init];
        self.loanListViewModelArray = [[NSMutableArray alloc]init];
        self.loanTruansferViewModel = [[NSMutableArray alloc]init];
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
    self.planListAPI.isUPReloadData = isUPData;///这里一定要 在前面  否则
    
    self.planListAPI.requestUrl = kHXBFinanc_PlanLisetURL(self.planListAPI.dataPage);
    self.planListAPI.requestMethod = NYRequestMethodGet;
    [self.planListAPI startWithSuccess:^(HXBBaseRequest *request, id responseObject) {
        ///数据是否出错
        kHXBResponsShowHUD
        
        NSArray <NSDictionary *>* dataList = responseObject[@"data"][@"dataList"];
        NSMutableArray <HXBFinHomePageViewModel_PlanList *>*planListViewModelArray = [[NSMutableArray alloc]init];
        
        [dataList enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           HXBFinHomePageModel_PlanList *financtingPlanListModel = [[HXBFinHomePageModel_PlanList alloc]init];
            //创建viewModel
            HXBFinHomePageViewModel_PlanList *financtingPlanListViewModel = [[HXBFinHomePageViewModel_PlanList alloc]init];
            //字典转模型
            [financtingPlanListModel yy_modelSetWithDictionary:obj];
            //给viewModel赋值MODEL
            financtingPlanListViewModel.planListModel = financtingPlanListModel;
            [planListViewModelArray addObject:financtingPlanListViewModel];
        }];
        //数据的处理
        [self plan_handleDataWithIsUPData:request.isUPReloadData andData:planListViewModelArray];
        
        if(!self.planListViewModelArray.count) {
            kNetWorkError(@"计划列表 没有数据");
            if(failureBlock) failureBlock(nil);
            return;
        }
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
    [self.planListViewModelArray addObjectsFromArray:viewModelArray];
}

//MARK: 散标列表api
- (void)loanBuyListWithIsUpData: (BOOL)isUPData andSuccessBlock: (void(^)(NSArray<HXBFinHomePageViewModel_LoanList *>* viewModelArray))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock {
    self.loanListAPI.isUPReloadData = isUPData;
    self.loanListAPI.requestUrl =  kHXBFinanc_LoanListURL((long)self.loanListAPI.dataPage);
    self.loanListAPI.requestMethod = NYRequestMethodGet;

    [self.loanListAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        kHXBResponsShowHUD
        //数据
        NSArray <NSDictionary *>* dataList = responseObject[@"data"][@"dataList"];
        
        if (!responseObject || !dataList.count) {
            NSLog(@"✘散标列表请求没有数据");
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
        [self loan_handleDataWithIsUPData:self.loanListAPI.isUPReloadData andViewModel:loanDataListModelArray];
        
        ///没有数据的话，也算出错
        if (!self.loanListViewModelArray.count) {
            kNetWorkError(@"散标列表 没有数据");
            if(failureBlock) failureBlock(nil);
            return;
        }
        ///请求成功
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
        [self.loanListViewModelArray addObjectsFromArray:loan_viewModelArray];
    }
}


///MARK: 债转列表
- (void)loanTruansferListWithIsUPData:(BOOL)isUPData andSuccessBlock:(void (^)(NSArray<HXBFinHomePageViewModel_LoanTruansferViewModel *> *))successDateBlock andFailureBlock:(void (^)(NSError *error, id responseObject))failureBlock {
    self.loanTruansferAPI.isUPReloadData = isUPData;
    self.loanTruansferAPI.requestMethod = NYRequestMethodGet;
    self.loanTruansferAPI.requestUrl = kHXBFin_LoanTruansferURL;
    self.loanTruansferAPI.requestArgument = @{
                                              @"page":@(self.loanTruansferAPI.dataPage),//int	当前页
                                              };
    [self.loanTruansferAPI startWithSuccess:^(HXBBaseRequest *request, id responseObject) {
        if ([responseObject[kResponseStatus] integerValue]) {
            if (failureBlock) {
                failureBlock(nil,responseObject);
            }
            return;
        }
        
        NSArray *data = responseObject[kResponseData][kResponseDataList];
        NSMutableArray <HXBFinHomePageViewModel_LoanTruansferViewModel *>*arrayM = [[NSMutableArray alloc]init];
        [data enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HXBFinHomePageViewModel_LoanTruansferViewModel *viewModel = [[HXBFinHomePageViewModel_LoanTruansferViewModel alloc]init];
            HXBFinHomePageModel_LoanTruansferList *model = [[HXBFinHomePageModel_LoanTruansferList alloc]init];
            [model yy_modelSetWithDictionary:obj];
            viewModel.loanTruansferListModel = model;
            [arrayM addObject:viewModel];
        }];
        
        if (successDateBlock) {
            if (request.isUPReloadData) {
                [self.loanTruansferViewModel removeAllObjects];
            }
            [self.loanTruansferViewModel addObjectsFromArray:arrayM];
            successDateBlock(self.loanTruansferViewModel);
        }
    } failure:^(HXBBaseRequest *request, NSError *error) {
            if (failureBlock) {
                failureBlock(error,nil);
            }
    }];
    
}



#pragma mark - 详情页 数据请求
- (void)planDetaileWithPlanID: (NSString *)financePlanId andSuccessBlock: (void(^)(HXBFinDetailViewModel_PlanDetail* viewModel))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock{
    HXBBaseRequest *planDetaileAPI = [[HXBBaseRequest alloc]init];
    planDetaileAPI.requestUrl = kHXBFinanc_PlanDetaileURL(financePlanId.integerValue);
    planDetaileAPI.requestMethod = NYRequestMethodGet;
    
    [planDetaileAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        ///数据是否出错
        NSString *status = responseObject[kResponseStatus];
        if (status.integerValue) {
            kNetWorkError(@"计划详情页 没有数据");
            if(failureBlock) failureBlock(nil);
            return;
        }
        NSDictionary *planDetaileDic = [responseObject valueForKey:@"data"];
        HXBFinDetailModel_PlanDetail *planDetaileModel = [[HXBFinDetailModel_PlanDetail alloc]init];
        [planDetaileModel yy_modelSetWithDictionary:planDetaileDic];
        HXBFinDetailViewModel_PlanDetail *planDetailViewModel = [[HXBFinDetailViewModel_PlanDetail alloc]init];
        planDetailViewModel.planDetailModel = planDetaileModel;
        ///回调
        if (successDateBlock) successDateBlock(planDetailViewModel);
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (error && failureBlock) {
            kNetWorkError(@"红利计划详情")
            failureBlock(error);
        }
    }];
}

///标的详情页
- (void)loanDetaileWithLoanID: (NSString *)financeLoanId andSuccessBlock: (void(^)(HXBFinDetailViewModel_LoanDetail* viewModel))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock{
    
    self.loanDetaileAPI.requestUrl = kHXBFinanc_LoanDetaileURL(financeLoanId.integerValue);
    self.loanDetaileAPI.requestMethod = NYRequestMethodGet;
    
    [self.loanDetaileAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        
        ///数据是否出错
        NSString *status = responseObject[kResponseStatus];
        if (status.integerValue) {
            kNetWorkError(@"计划详情页 没有数据");
            if(failureBlock) failureBlock(nil);
            return;
        }
        
        NSDictionary *planDetaileDic = [responseObject valueForKey:@"data"];
        HXBFinDatailModel_LoanDetail *loanDetaileModel = [[HXBFinDatailModel_LoanDetail alloc]init];
        [loanDetaileModel yy_modelSetWithDictionary:planDetaileDic];
        HXBFinDetailViewModel_LoanDetail *loanDetailViewModel = [[HXBFinDetailViewModel_LoanDetail alloc]init];
        loanDetailViewModel.loanDetailModel = loanDetaileModel;
        if (!loanDetailViewModel.loanDetailModel) {
            kNetWorkError(@"散标详情 没有数据");
            if(failureBlock) failureBlock(nil);
            return;
        }
        if (successDateBlock) {
            successDateBlock(loanDetailViewModel);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (error && failureBlock) {
            kNetWorkError(@"✘散标计划详情 - 请求没有数据")
            failureBlock(error);
        }
    }];
    
}

/// 债转的详情页
- (void)loanTruansferDetileRequestWithLoanID:(NSString *)loanID andSuccessBlock: (void(^)(HXBFinDetailViewModel_LoanTruansferDetail* viewModel))successDateBlock andFailureBlock: (void(^)(NSError *error,NSDictionary *respons))failureBlock {
    HXBBaseRequest *loanTruansferRequest = [[HXBBaseRequest alloc]init];
    loanTruansferRequest.requestUrl = kHXBFin_LoanTruansfer_DetailURL(loanID.integerValue);
    loanTruansferRequest.requestMethod = NYRequestMethodGet;
    [loanTruansferRequest startWithSuccess:^(HXBBaseRequest *request, id responseObject) {
        if ([responseObject[kResponseStatus] integerValue]) {
            if (failureBlock) {
                failureBlock(nil,responseObject);
            }
            kNetWorkError(@"债转详情");
            return;
        }
        NSDictionary *dataDic = responseObject[kResponseData];
        
        HXBFinDetailViewModel_LoanTruansferDetail *viewModel = [[HXBFinDetailViewModel_LoanTruansferDetail alloc]init];
        HXBFinDetailModel_LoanTruansferDetail *loanTruansferModel = [[HXBFinDetailModel_LoanTruansferDetail alloc]init];
        [loanTruansferModel yy_modelSetWithDictionary:dataDic];
        viewModel.loanTruansferDetailModel = loanTruansferModel;

        if (successDateBlock) {
            successDateBlock(viewModel);
        }
        
    } failure:^(HXBBaseRequest *request, NSError *error) {
        if (failureBlock) {
            failureBlock(error,nil);
        }
    }];
    
}

#pragma mark - 红利计划详情页 - 加入记录
- (void)planAddRecortdWithISUPLoad: (BOOL)isUPLoad andFinancePlanId: (NSString *)financePlanId andOrder: (NSString *)order andSuccessBlock: (void(^)(HXBFinModel_AddRecortdModel_Plan * model))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock {
    self.planAddRecortdAPI.isUPReloadData = isUPLoad;
    self.planAddRecortdAPI.requestMethod = NYRequestMethodGet;
    self.planAddRecortdAPI.requestUrl = kHXBFinanc_Plan_AddRecortdURL(financePlanId);
    
    [self.planAddRecortdAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        kHXBResponsShowHUD
        HXBFinModel_AddRecortdModel_Plan *planAddRecortdModel = [[HXBFinModel_AddRecortdModel_Plan alloc]init];
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
#pragma mark - 散标计划详情 - 加入记录
- (void)loanAddRecortdWithISUPLoad: (BOOL)isUPLoad andFinanceLoanId: (NSString *)financeLoanId andOrder: (NSString *)order andSuccessBlock: (void(^)(FinModel_AddRecortdModel_Loan * model))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock {
    self.loanAddRecortdAPI.requestMethod = NYRequestMethodGet;
    
    self.loanAddRecortdAPI.requestUrl = kHXBFinanc_Loan_AddRecortdURL(financeLoanId);
    [self.loanAddRecortdAPI startWithSuccess:^(HXBBaseRequest *request, id responseObject) {
       kHXBResponsShowHUD
        FinModel_AddRecortdModel_Loan *model = [[FinModel_AddRecortdModel_Loan alloc]init];
        NSDictionary *dic = [responseObject valueForKey:@"data"];
        [model yy_modelSetWithDictionary:dic];
        if (successDateBlock) {
            successDateBlock(model);
        }
    } failure:^(HXBBaseRequest *request, NSError *error) {
         kNetWorkError(@"loan 加入计划 - 网络请求失败")
        if (error) {
            failureBlock(error);
        }
    }];
}
/// 债转详情  加入记录
- (void)loanTruansferAddRecortdWithISUPLoad: (BOOL)isUPLoad andFinanceLoanId: (NSString *)loanTruanserId andOrder: (NSString *)order andSuccessBlock: (void(^)(FinModel_AddRecortdModel_Loan * loanTruansferRecortdModel))successDateBlock andFailureBlock: (void(^)(NSError *error,HXBBaseRequest *request))failureBlock {
    self.loanTruansferAddRecortdAPI.requestMethod = NYRequestMethodGet;
    self.loanTruansferAddRecortdAPI.isUPReloadData = isUPLoad;
    self.loanTruansferAddRecortdAPI.requestArgument = @{
                                              @"page":@(self.loanTruansferAddRecortdAPI.dataPage)
                                              };
    self.loanTruansferAddRecortdAPI.requestUrl = kHXBFinanc_LoanTruansfer_AddRecortdURL(loanTruanserId);
    
    [self.loanTruansferAddRecortdAPI startWithSuccess:^(HXBBaseRequest *request, id responseObject) {
        if ([responseObject[kResponseStatus] integerValue]) {
            if (failureBlock) {
                failureBlock(nil,request);
            }
            return;
        }
        
        FinModel_AddRecortdModel_Loan *model = [[FinModel_AddRecortdModel_Loan alloc]init];
        NSDictionary *dic = [responseObject valueForKey:@"data"];
        [model yy_modelSetWithDictionary:dic];
        
        if (successDateBlock) {
            successDateBlock(model);
        }
    } failure:^(HXBBaseRequest *request, NSError *error) {
        kNetWorkError(@"loan 加入计划 - 网络请求失败")
        if (error) {
            failureBlock(error,nil);
        }
    }];
}

#pragma mark - 购买
/// 计划购买
- (void)planBuyWithPlanID:(NSString *)planID
                andAmount:(NSString *)amount
                cashType : (NSString *)cashType
          andSuccessBlock:(void (^)(HXBFinModel_Buy_Plan *model,HXBFinModel_BuyResoult_PlanModel *resultModel))successDateBlock
          andFailureBlock:(void (^)(NSError *))failureBlock {
    HXBBaseRequest *buyRequest = [[HXBBaseRequest alloc]init];
    buyRequest.requestUrl = kHXBFin_Buy_PlanURL(planID);
    buyRequest.requestMethod = NYRequestMethodPost;
    if (!amount) amount = @"";
    buyRequest.requestArgument = @{
                                   @"amount" : amount
                                   };
    [buyRequest.infoDic setObject:planID forKey:@"planID"];
    [buyRequest.infoDic setObject:amount forKey:@"amount"];
    
    [buyRequest startWithSuccess:^(HXBBaseRequest *request, id responseObject) {
       kHXBResponsShowHUD
       
        NSDictionary *dic = [responseObject valueForKey:@"data"];
        HXBFinModel_Buy_Plan *planBuyModel = [[HXBFinModel_Buy_Plan alloc]init];
        [planBuyModel yy_modelSetWithDictionary:dic];
        [request.infoDic setObject:planBuyModel forKey:@"planBuyModel"];
        if (successDateBlock) {
//            [self plan_buyReslutWithPlanID:buyRequest.infoDic[@"planID"]  andAmount:buyRequest.infoDic[@"amount"] cashType:cashType andSuccessBlock:^(HXBFinModel_BuyResoult_PlanModel *model) {
//                 successDateBlock(request.infoDic[@"planBuyModel"],model);
//            } andFailureBlock:^(NSError *error) {
//                if (failureBlock) {
//                    failureBlock(error);
//                }
//            }];
        }
    } failure:^(HXBBaseRequest *request, NSError *error) {
        kNetWorkError(@"plan 购买 - 网络请求失败")
        if (error) {
            failureBlock(error);
        }
    }];
}

#pragma mark - 购买结果
///确认购买 plan
//cashType 收益方式 HXB(当日提取至红小宝账户),INVEST(收益再投资）
- (void)plan_buyReslutWithPlanID: (NSString *)planID
                       andAmount: (NSString *)amount
                       cashType : (NSString *)cashType
                 andSuccessBlock:(void (^)(HXBFin_Plan_BuyViewModel *model))successDateBlock
                 andFailureBlock:(void (^)(NSError *error, NSInteger status))failureBlock{
    HXBBaseRequest *confirmBuyReslut = [[HXBBaseRequest alloc]init];
    
    if (!amount) amount = @"";
    confirmBuyReslut.requestArgument = @{
                                         @"amount" : amount,
                                         @"cashType" : cashType
                                         };
    
    confirmBuyReslut.requestUrl = kHXBFin_Plan_ConfirmBuyReslutURL(planID);
    confirmBuyReslut.requestMethod = NYRequestMethodPost;
    
    [confirmBuyReslut startWithSuccess:^(HXBBaseRequest *request, id responseObject) {
        NSInteger status = [[responseObject valueForKey:kResponseStatus] integerValue];
        if (status == 3408) {
        
            if (failureBlock) failureBlock(nil,status);
            return;
        }
        if (status == 3100) {
            
            if (failureBlock) failureBlock(nil,status);
            return;
        }
        
        if (status) {
            [HxbHUDProgress showTextWithMessage:responseObject[kResponseMessage]];
            return;
        }
        
        NSDictionary *dataDic = [responseObject valueForKey:kResponseData];
        HXBFinModel_BuyResoult_PlanModel *reslut = [[HXBFinModel_BuyResoult_PlanModel alloc]init];
        
        [reslut yy_modelSetWithDictionary:dataDic];
        HXBFin_Plan_BuyViewModel *planViewModel = [[HXBFin_Plan_BuyViewModel alloc]init];
        planViewModel.buyPlanModel = reslut;
        
        if (successDateBlock) {
            successDateBlock(planViewModel);
        }
    } failure:^(HXBBaseRequest *request, NSError *error) {
        if (failureBlock) failureBlock(nil,0);
    }];
}


///MARK: - loan 购买
- (void)loanBuyWithLoanID:(NSString *)loanID
                andAmount:(NSString *)amount
          andSuccessBlock:(void (^)(HXBFinModel_Buy_LoanModel *model,HXBFinModel_BuyResoult_LoanModel *resultModel))successDateBlock
          andFailureBlock:(void (^)(NSError *error))failureBlock{
    
    HXBBaseRequest *request = [[HXBBaseRequest alloc]init];
    request.requestUrl = kHXBFin_Buy_LoanURL(loanID);
    request.requestMethod = NYRequestMethodPost;
    amount = amount.length ? amount : @"";
    request.requestArgument = @{
                                @"amount" : amount
                                };
    loanID = loanID ? loanID : @"";
    request.infoDic = @{
                        @"loanID": loanID,
                        @"amount" : amount
                        }.mutableCopy;
    [request startWithSuccess:^(HXBBaseRequest *request, id responseObject) {
        kHXBResponsShowHUD
        HXBFinModel_Buy_LoanModel *loanBuyModel = [[HXBFinModel_Buy_LoanModel alloc]init];
        [loanBuyModel yy_modelSetWithDictionary:responseObject[kResponseData]];
        [request.infoDic setObject:loanBuyModel forKey:@"loanBuyModel"];
        
        if (successDateBlock) {
//            [self loan_confirmBuyReslutWithLoanID:request.infoDic[@"loanID"] andAmount:request.infoDic[@"amount"] andSuccessBlock:^(HXBFinModel_BuyResoult_LoanModel *model) {
//                successDateBlock(request.infoDic[@"loanBuyModel"],model);
//            } andFailureBlock:^(NSError *error, NSInteger status) {
//                if (failureBlock) failureBlock(error, 0);
//            }];
        }
    } failure:^(HXBBaseRequest *request, NSError *error) {
        if (failureBlock) failureBlock(error);
    }];
}

///MARK: - loan 购买结果
- (void)loan_confirmBuyReslutWithLoanID: (NSString *)loanID
                              andAmount: (NSString *)amount
                        andSuccessBlock:(void (^)(HXBFinModel_BuyResoult_LoanModel *model))successDateBlock
                        andFailureBlock:(void (^)(NSError *error, NSInteger status))failureBlock {
    HXBBaseRequest *loanBuyReslutRequest = [[HXBBaseRequest alloc]init];
    loanBuyReslutRequest.requestMethod = NYRequestMethodPost;
    loanBuyReslutRequest.requestUrl = kHXBFin_BuyReslut_LoanURL(loanID);
    amount = amount ? amount : @"";
    loanBuyReslutRequest.requestArgument = @{
                                      @"amount" : amount
                                      };
    [loanBuyReslutRequest startWithSuccess:^(HXBBaseRequest *request, id responseObject) {
        NSInteger status = [[responseObject valueForKey:kResponseStatus] integerValue];
        if (status == 3408) {
            if (failureBlock) failureBlock(nil,3408);
            return;
        }
        if (status == 3100) {
            if (failureBlock) failureBlock(nil,3100);
            return;
        }
        
        if (status) {
            [HxbHUDProgress showTextWithMessage:responseObject[kResponseMessage]];
            if (failureBlock) failureBlock(nil,status);
            return;
        }
        
        HXBFinModel_BuyResoult_LoanModel *loanBuyResoult = [[HXBFinModel_BuyResoult_LoanModel alloc]init];
        [loanBuyResoult yy_modelSetWithDictionary:responseObject[kResponseData]];
        
        
        if (successDateBlock) {
            successDateBlock(loanBuyResoult);
        }
        
    } failure:^(HXBBaseRequest *request, NSError *error) {
        if (failureBlock) failureBlock(error,0);
    }];
}

///债转的购买
- (void)loanTruansfer_confirmBuyReslutWithLoanID: (NSString *)loanTruansferID
                        andSuccessBlock:(void (^)(HXBFin_LoanTruansfer_BuyResoutViewModel *model))successDateBlock
                                 andFailureBlock:(void (^)(NSError *error, NSDictionary *response))failureBlock {
    HXBBaseRequest *loanTruansferAPI = [[HXBBaseRequest alloc]init];
    loanTruansferAPI.requestUrl = kHXBFin_BuyReslut_LoanTruansferURL(loanTruansferID);
    loanTruansferAPI.requestMethod = NYRequestMethodGet;
    
    [loanTruansferAPI startWithSuccess:^(HXBBaseRequest *request, id responseObject) {
        if ([responseObject[kResponseStatus] integerValue]) {
            if (failureBlock) {
                failureBlock(nil,responseObject);
            }
            return;
        }
        
        HXBFin_LoanTruansfer_BuyResoutViewModel *loantruansferViewModel = [[HXBFin_LoanTruansfer_BuyResoutViewModel alloc]init];
        HXBFinModel_BuyResout_LoanTruansferModel *loantruansferModel = [[HXBFinModel_BuyResout_LoanTruansferModel alloc]init];
        NSDictionary *dataDic = responseObject[kResponseData];
        BOOL isSuccess = [loantruansferViewModel yy_modelSetWithDictionary:dataDic];
        if (!isSuccess) {
            NSLog(@"🌶字典转模型失败%@",self);
            return;
        }
        loantruansferViewModel.loanTruansferModel = loantruansferModel;
        if (successDateBlock) {
            successDateBlock(loantruansferViewModel);
        }
    } failure:^(HXBBaseRequest *request, NSError *error) {
        
    }];
    
}



@end
