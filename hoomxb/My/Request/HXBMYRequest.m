//
//  HXBMYRequest.m
//  hoomxb
//
//  Created by HXB on 2017/5/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMYRequest.h"
//-------资金统计
#import "HXBRequestAPI_MYAssetStatisticsAPI_Plan.h"//plan的资金统计
#import "HXBRequestAPI_MYAssetStatisticsAPI_Loan.h"//loan的资金统计

//plan
#import "HXBMYModel_AssetStatistics_Plan.h"//plan 资金统计的Model 没有ViewModel
#import "HXBMYModel_AssetStatistics_Loan.h"//loan 资金统计的Model  没有ViewModel

// --------- 主界面
#import "HXBRequstAPI_MYMainPlanAPI.h"//主界面 plan API
#import "HXBMYViewModel_MianPlanViewModel.h"//主界面 planViewModel
#import "HXBMYModel_MainPlanModel.h"//主界面的 planModel

#import "HXBRequstAPI_MYMainLoanAPI.h"//主界面的 loan API
#import "HXBMYViewModel_MainLoanViewModel.h"//主界面的 loanViewModel
#import "HXBMyModel_MainLoanModel.h"//主界面的 loanModel

#import "HXBRequestAPI_MYMainCapitalRecordAPI.h"///主界面 资产记录API
#import "HXBMYViewModel_MainCapitalRecordViewModel.h"//主界面 资产记录 ViewMOdel
#import "HXBMYModel_CapitalRecordDetailModel.h"//主界面 资产记录Model ViewModel 里面加入了（这里不再添加)




@interface HXBMYRequest ()
///持有中
@property (nonatomic,strong) NSMutableArray <HXBMYViewModel_MianPlanViewModel *>*hold_Plan_array;
@property (nonatomic,assign) NSInteger holdPlanPage;//用于记录页数的字段
///plan 推出中
@property (nonatomic,strong) NSMutableArray <HXBMYViewModel_MianPlanViewModel *>*exiting_Plan_array;
@property (nonatomic,assign) NSInteger exitingPage;//记录了退出中的页数字段

///plan 已退出
@property (nonatomic,strong) NSMutableArray <HXBMYViewModel_MianPlanViewModel *>*exit_Plan_array;
@property (nonatomic,assign) NSInteger exitPage;//记录了推出的页数字段

///loan 收益中
@property (nonatomic,strong) NSMutableArray <HXBMYViewModel_MainLoanViewModel *>*repaying_Loan_array;
@property (nonatomic,assign) NSInteger repayingPage;
/// loan 投标中
@property (nonatomic,strong) NSMutableArray <HXBMYViewModel_MainLoanViewModel *>*bid_Loan_array;
@property (nonatomic,assign) NSInteger bidPage;
/// loan 已结清
@property (nonatomic,strong) NSMutableArray <HXBMYViewModel_MainLoanViewModel *>*finish_Loan_array;
@property (nonatomic,assign) NSInteger finishPage;
//资产记录
@property (nonatomic,strong) NSMutableArray <HXBMYViewModel_MainCapitalRecordViewModel *>*capitalRecordViewModel_array;
@property (nonatomic,assign) NSInteger capitalRecordPage;
@end


@implementation HXBMYRequest
//创建单利对象
+ (instancetype) sharedMYRequest {
    static dispatch_once_t once;
    static id _instance;
    dispatch_once(&once,^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

- (instancetype) init {
    if (self = [super init]) {
        [self creatArray];
    }
    return self;
}
///创建array
- (void)creatArray {
    self.hold_Plan_array = [[NSMutableArray alloc]init];
    self.exit_Plan_array = [[NSMutableArray alloc]init];
    self.exiting_Plan_array = [[NSMutableArray alloc]init];
    
    self.bid_Loan_array = [[NSMutableArray alloc]init];
    self.repaying_Loan_array = [[NSMutableArray alloc]init];
    self.capitalRecordViewModel_array = [[NSMutableArray alloc]init];
}

#pragma mark - getter
- (NSInteger) exitingPage {
    if (_exitingPage <= 0) {
        _exitingPage = 1;
    }
    return _exitingPage;
}
- (NSInteger) exitPage {
    if (_exitPage <= 0) {
        _exitPage = 1;
    }
    return _exitPage;
}
- (NSInteger) holdPlanPage {
    if (_holdPlanPage < 1) {
        _holdPlanPage = 1;
    }
    return _holdPlanPage;
}
- (NSInteger)repayingPage {
    if (_repayingPage < 1) {
        _repayingPage = 1;
    }
    return _repayingPage;
}
- (NSInteger)bidPage {
    if (_bidPage < 1) {
        _bidPage = 1;
    }
    return _bidPage;
}
- (NSInteger)capitalRecordPage {
    if (_capitalRecordPage < 1) {
        _capitalRecordPage = 1;
    }
    return _capitalRecordPage;
}

#pragma mark - 主要页面的网络请求
///MARK: - 资金统计网络请求
///plan
- (void)myPlanAssetStatistics_requestWithSuccessBlock: (void(^)(HXBMYModel_AssetStatistics_Plan*model))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock {
    HXBRequestAPI_MYAssetStatisticsAPI_Plan *planAssetStatisticsAPI = [[HXBRequestAPI_MYAssetStatisticsAPI_Plan alloc]init];
    NSString *userID = [KeyChainManage sharedInstance].userId;
    if (!userID.length) {
        userID = @"2458531";
    }
    planAssetStatisticsAPI.requestArgument = @{
                                               @"userId" : userID
                                               };
    NSMutableArray *modelArray = [[NSMutableArray alloc]init];
    
    [planAssetStatisticsAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSDictionary *dataList = [[responseObject valueForKey:@"data"] valueForKey:@"dataList"];
        HXBMYModel_AssetStatistics_Plan *planAssetStatisticsModel = [[HXBMYModel_AssetStatistics_Plan alloc]init];
        [planAssetStatisticsModel yy_modelSetWithDictionary:dataList];
        if (successDateBlock) {
            successDateBlock(planAssetStatisticsModel);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    
}

//MARK: ========= 红利计划 主界面的网络数据请求 =========
- (void)myPlan_requestWithPlanType: (HXBRequestType_MY_PlanRequestType)planRequestType
                         andUpData: (BOOL)isUPData
                   andSuccessBlock: (void(^)(NSArray<HXBMYViewModel_MianPlanViewModel *>* viewModelArray))successDateBlock
                   andFailureBlock: (void(^)(NSError *error))failureBlock {
    
    HXBRequstAPI_MYMainPlanAPI *mainPlanAPI = [[HXBRequstAPI_MYMainPlanAPI alloc]init];

    NSString *pageNumberStr = @(planRequestType).description;
    NSInteger page = 0;
    switch (planRequestType) {
        case HXBRequestType_MY_PlanRequestType_EXIT_PLAN:
            page = self.exitPage;
            break;
        case HXBRequestType_MY_PlanRequestType_HOLD_PLAN:
            page = self.holdPlanPage;
            break;
        case HXBRequestType_MY_PlanRequestType_EXITING_PLAN:
            page = self.exitingPage;
            break;
        default:
            break;
    }
    
    mainPlanAPI.requestArgument = @{
                                    @"filter" : pageNumberStr,
                                    @"page" :	@(page).description
                                    };
   
    mainPlanAPI.isUPData = isUPData;
    
    [mainPlanAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSDictionary *responseDic = responseObject[@"data"];
    
        HXBMYModel_MainPlanModel *planModel = [[HXBMYModel_MainPlanModel alloc]init];
        [planModel yy_modelSetWithDictionary:responseDic];
        
        NSMutableArray <HXBMYViewModel_MianPlanViewModel *> *planViewModelArray = [[NSMutableArray alloc]init];
        [planModel.dataList enumerateObjectsUsingBlock:^(HXBMYModel_MainPlanModel_DataList * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HXBMYViewModel_MianPlanViewModel *viewModel = [[HXBMYViewModel_MianPlanViewModel alloc]init];
            viewModel.planModelDataList = obj;
            [planViewModelArray addObject:viewModel];
        }];
        
        NSString *typeStr = planModel.dataList.firstObject.type;
        //数据的处理。。
        HXBRequstAPI_MYMainPlanAPI *planRequest = (HXBRequstAPI_MYMainPlanAPI *)request;
        NSArray *handleData = [self handleResponseArrayWithIsupData:planRequest.isUPData andTypeStr:typeStr andViewModel:planViewModelArray];
        //向外回调
        if (successDateBlock) {
            successDateBlock(handleData);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) {
            kNetWorkError(@"我的 界面 红利计划列表")
            failureBlock (error);
        }
    }];
}
///根据type 区分page
- (NSInteger)getRequestPageWithType: (HXBRequestType_MY_PlanRequestType)type andIsUPData: (BOOL)isUPData{
    switch (type) {
        case HXBRequestType_MY_PlanRequestType_EXIT_PLAN:
            if (isUPData) self.exitPage = 1;
            return self.exitPage;
        case HXBRequestType_MY_PlanRequestType_HOLD_PLAN:
            if(isUPData) self.holdPlanPage = 1;
            return self.holdPlanPage;
        case HXBRequestType_MY_PlanRequestType_EXITING_PLAN:
            if(isUPData) self.exitingPage = 1;
            return self.exitingPage;
    }
}

///根据typeStr 来进行数据的处理
- (NSMutableArray *)handleResponseArrayWithIsupData: (BOOL)isupdata andTypeStr: (NSString *)typeStr andViewModel: (NSArray <HXBMYViewModel_MianPlanViewModel *>*)viewMode {
    HXBRequestType_MY_PlanRequestType type = [HXBRequestType_MYManager myPlan_requestTypeStr:typeStr];
    return [self plan_handleResponseArrayWithIsupData: isupdata andType:type andViewModel:viewMode];
}
///根据返回的类型来 进行数据得分发
- (NSMutableArray *)plan_handleResponseArrayWithIsupData: (BOOL)isupdata andType: (HXBRequestType_MY_PlanRequestType)type andViewModel: (NSArray <HXBMYViewModel_MianPlanViewModel *>*)viewModel{
//    if (!viewModel.firstObject.planModelDataList.status) return nil;
    switch (type) {
        case HXBRequestType_MY_PlanRequestType_EXITING_PLAN://退出中
            if (isupdata) {//如果是下拉刷新 就先清空数再追加
                self.exitingPage = 1;
                [self.exiting_Plan_array removeAllObjects];
            }
            self.exitingPage ++;
            [self.exiting_Plan_array addObjectsFromArray:viewModel];
            return self.exiting_Plan_array;
        
        case HXBRequestType_MY_PlanRequestType_HOLD_PLAN://持有中
            if (isupdata) {
                self.holdPlanPage = 1;
                [self.hold_Plan_array removeAllObjects];
            }
            self.holdPlanPage ++;
            [self.hold_Plan_array addObjectsFromArray:viewModel];
            return self.hold_Plan_array;
            
        case HXBRequestType_MY_PlanRequestType_EXIT_PLAN://已退出
            if (isupdata) {
                self.exitPage = 1;
                [self.exit_Plan_array removeAllObjects];
            }
            self.exitPage ++;
            [self.exit_Plan_array addObjectsFromArray:viewModel];
            return self.exit_Plan_array;
    }
    NSLog(@"🌶  %@，我的 plan 的数组赋值出错",self.class);
    return nil;
}

//MARK:============== loan 主界面的网络数据请求  =========
///资金统计 请求 loan
- (void)myLoanAssetStatistics_requestWithSuccessBlock: (void(^)(NSArray <HXBMYModel_AssetStatistics_Loan *>*model))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock {
    HXBRequestAPI_MYAssetStatisticsAPI_Loan *loanAssetStatisticsAPI = [[HXBRequestAPI_MYAssetStatisticsAPI_Loan alloc]init];
    NSString *userID = [KeyChainManage sharedInstance].userId;
    if (!userID.length) {
        userID = @"2458659";
    }
    loanAssetStatisticsAPI.requestArgument = @{
                                               @"userId" : userID
                                               };
    
    NSMutableArray *modelArray = [[NSMutableArray alloc]init];
    [loanAssetStatisticsAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSArray <NSDictionary *>*dataList = [[responseObject valueForKey:@"data"] valueForKey:@"dataList"];
        [dataList enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HXBMYModel_AssetStatistics_Loan *planAssetStatisticsModel = [[HXBMYModel_AssetStatistics_Loan alloc]init];
            [planAssetStatisticsModel yy_modelSetWithDictionary:obj];
            [modelArray addObject:planAssetStatisticsModel];
        }];
        if (successDateBlock) {
            successDateBlock(modelArray);
        }

    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

/// 散标列表的 请求
- (void)myLoan_requestWithLoanType: (HXBRequestType_MY_LoanRequestType)LoanRequestType
                         andUpData: (BOOL)isUPData
                   andSuccessBlock: (void(^)(NSArray<HXBMYViewModel_MainLoanViewModel *>* viewModelArray))successDateBlock
                   andFailureBlock: (void(^)(NSError *error))failureBlock{
    HXBRequstAPI_MYMainLoanAPI *mainLoanAPI = [[HXBRequstAPI_MYMainLoanAPI alloc]init];
    NSString *userIDStr = [KeyChainManage sharedInstance].userId;
    if (!userIDStr.length) {
        userIDStr = @"2458528";
    }
    __block NSString *loanTypeStr = nil;
    //获取请求类型
    [HXBRequestType_MYManager myLoan_requestType:LoanRequestType andReturnParamBlock:^(NSString *type, NSString *UI_Type) {
        loanTypeStr = type;
    }];
    NSInteger page = 1;
    switch (LoanRequestType) {
        case HXBRequestType_MY_LoanRequestType_REPAYING_LOAN:
            if (isUPData) self.repayingPage = 1;
            page = self.repayingPage;
            break;
        case HXBRequestType_MY_LoanRequestType_BID_LOAN:
            if (isUPData) self.bidPage = 1;
            page = self.bidPage;
            break;
        case HXBRequestType_MY_LoanRequestType_FINISH_LOAN:
            break;
    }
    mainLoanAPI.requestArgument = @{
                                    @"pageNumber" : @(page).description,
                                    @"pageSize" : @"10",
                                    @"userId" : userIDStr,
                                    @"type" :  loanTypeStr,
                                    @"version" : @"1.0",
                                    };
    mainLoanAPI.requestType = LoanRequestType;//后台没有返回给我，所以就自己记录在了api里面
    mainLoanAPI.isUPData = isUPData;
    [mainLoanAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        
        NSMutableArray <HXBMYViewModel_MainLoanViewModel*> *loanViewModelArray = [[NSMutableArray alloc]init];
        NSArray <NSDictionary *>*dataArray = [[responseObject valueForKey:@"data"] valueForKey:@"loanList"];

        HXBRequstAPI_MYMainLoanAPI *mainLoanAPI = (HXBRequstAPI_MYMainLoanAPI *)request;
        [dataArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
            HXBMYViewModel_MainLoanViewModel *viewModel = [[HXBMYViewModel_MainLoanViewModel alloc]init];
            HXBMyModel_MainLoanModel *loanModel = [[HXBMyModel_MainLoanModel alloc]init];
             [loanModel yy_modelSetWithDictionary:dic];
            viewModel.loanModel = loanModel;
            viewModel.requestType = mainLoanAPI.requestType;
            [loanViewModelArray addObject:viewModel];
        }];
        HXBRequstAPI_MYMainLoanAPI *loanRequestAPI = (HXBRequstAPI_MYMainLoanAPI *)request;
        
        //如果block 在外界实现了，并且loanViewModelArray有值
        if (successDateBlock) {
            HXBRequestType_MY_LoanRequestType loanRequestType = mainLoanAPI.requestType;
            //对数据的处理（里面进行了对page的处理，与ViewModelArray 种类 的处理）
            NSArray <HXBMYViewModel_MainLoanViewModel *>*viewModelArray = [self loan_handleLoanViewModelArrayWithIsUPData:loanRequestAPI.isUPData andRequestType:loanRequestType andLoanViewModelArray:loanViewModelArray];
            successDateBlock(viewModelArray);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) {
            kNetWorkError(@"我的 界面 - 散标列表")
            failureBlock(error);
        }
    }];
}
- (NSArray *)loan_handleLoanViewModelArrayWithIsUPData: (BOOL)isUPdata andRequestType: (HXBRequestType_MY_LoanRequestType)loanRequestType andLoanViewModelArray: (NSArray<HXBMYViewModel_MainLoanViewModel*>*)viewModelArray{
    if (!viewModelArray.count) return nil;
    switch (loanRequestType) {
        case HXBRequestType_MY_LoanRequestType_BID_LOAN://投标中
            if (isUPdata) {
                [self.bid_Loan_array removeAllObjects];
                self.bidPage = 1;
            }
            self.bidPage ++;
            [self.bid_Loan_array addObjectsFromArray:viewModelArray];
            return self.bid_Loan_array;
            break;
        case HXBRequestType_MY_LoanRequestType_FINISH_LOAN://已结清
            if (isUPdata) {
                [self.finish_Loan_array removeAllObjects];
                self.finishPage = 1;
            }
            self.finishPage ++;
            [self.finish_Loan_array addObjectsFromArray:viewModelArray];
            return self.finish_Loan_array;
            break;
            case HXBRequestType_MY_LoanRequestType_REPAYING_LOAN://收益中
            if (isUPdata) {
                [self.repaying_Loan_array removeAllObjects];
                self.repayingPage = 1;
            }
            [self.repaying_Loan_array addObjectsFromArray:viewModelArray];
            return self.repaying_Loan_array;
    }
}


#pragma mark - 资金记录 接口
- (void)capitalRecord_requestWithScreenType: (HXBRequestType_MY_tradlist)screenType
                               andStartDate: (NSString *)startDate
                                andEndDate: (NSString *)endDate
                               andIsUPData: (BOOL)isUPData 
                           andSuccessBlock: (void(^)(NSArray<HXBMYViewModel_MainCapitalRecordViewModel *>* viewModelArray))successDateBlock
                           andFailureBlock: (void(^)(NSError *error))failureBlock {
    HXBRequestAPI_MYMainCapitalRecordAPI *capitalRecordAPI = [[HXBRequestAPI_MYMainCapitalRecordAPI alloc]init];
    //如果是下拉刷新的话
    if (isUPData) self.capitalRecordPage = 1;
    
    //页数
    NSString *pageSTR = @(self.capitalRecordPage).description;
    
    capitalRecordAPI.isUPData = isUPData;
    capitalRecordAPI.page = pageSTR;
    capitalRecordAPI.filter = screenType;
//    capitalRecordAPI.planID = @(planid)
    
    [capitalRecordAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        HXBRequestAPI_MYMainCapitalRecordAPI *api = (HXBRequestAPI_MYMainCapitalRecordAPI *)request;
        NSDictionary *data = [responseObject valueForKey:@"data"];
        NSArray <NSDictionary *>*dataList = [data valueForKey:@"dataList"];
        
        NSMutableArray <HXBMYViewModel_MainCapitalRecordViewModel *>* viewModelArray = [[NSMutableArray alloc]init];
        [dataList enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HXBMYModel_CapitalRecordDetailModel *capitalRecordModel = [[HXBMYModel_CapitalRecordDetailModel alloc]init];
            HXBMYViewModel_MainCapitalRecordViewModel *viewModel = [[HXBMYViewModel_MainCapitalRecordViewModel alloc]init];
            //模型转化
            [capitalRecordModel yy_modelSetWithDictionary:obj];
            viewModel.capitalRecordModel = capitalRecordModel;
            [viewModelArray addObject:viewModel];
        }];
       
        if (successDateBlock) {
            NSMutableArray <HXBMYViewModel_MainCapitalRecordViewModel *>*capitalRecordViewModelArray = [self capitalRecord_handleDataWithIsUPData:api.isUPData andViewModelArray:viewModelArray];
            successDateBlock(capitalRecordViewModelArray);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
    }];
}
- (NSMutableArray <HXBMYViewModel_MainCapitalRecordViewModel *>*)capitalRecord_handleDataWithIsUPData: (BOOL)isUPData andViewModelArray: (NSArray <HXBMYViewModel_MainCapitalRecordViewModel *>*)viewModeArray {
    if (isUPData) {
        self.capitalRecordPage = 1;
        [self.capitalRecordViewModel_array removeAllObjects];
    }
    self.capitalRecordPage ++;
    [self.capitalRecordViewModel_array addObjectsFromArray:viewModeArray];
    return self.capitalRecordViewModel_array;
}
kDealloc
@end
