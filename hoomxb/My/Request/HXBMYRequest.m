//
//  HXBMYRequest.m
//  hoomxb
//
//  Created by HXB on 2017/5/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMYRequest.h"

// --------- 主界面
#import "HXBRequstAPI_MYMainPlanAPI.h"//主界面 plan API
#import "HXBMYViewModel_MianPlanViewModel.h"//主界面 planViewModel
#import "HXBMYModel_MainPlanModel.h"//主界面的 planModel

#import "HXBRequstAPI_MYMainLoanAPI.h"//主界面的 loan API
#import "HXBMYViewModel_MainLoanViewModel.h"//主界面的 loanViewModel
#import "HXBMyModel_MainLoanModel.h"//主界面的 loanModel




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
    if (_holdPlanPage <= 0) {
        _holdPlanPage = 1;
    }
    return _holdPlanPage;
}

#pragma mark - 主要页面的网络请求

//MARK: 红利计划 主界面的网络数据请求
- (void)myPlan_requestWithPlanType: (HXBRequestType_MY_PlanRequestType)planRequestType
                         andUpData: (BOOL)isUPData
                   andSuccessBlock: (void(^)(NSArray<HXBMYViewModel_MianPlanViewModel *>* viewModelArray))successDateBlock
                   andFailureBlock: (void(^)(NSError *error))failureBlock {
    
    HXBRequstAPI_MYMainPlanAPI *mainPlanAPI = [[HXBRequstAPI_MYMainPlanAPI alloc]init];
    NSString *type = [HXBRequestType_MYManager myPlan_requestType:planRequestType];
    NSString *pageNumberStr = @([self getRequestPageWithType:planRequestType andIsUPData:isUPData]).description;
    
    NSString *userIDStr = [KeyChainManage sharedInstance].userId;
    if (!userIDStr.length) {
        NSLog(@"%@, - 没有userID 使用了测试 的userID ： 2458528", self.class);
        userIDStr = @"2458528";
    }
    
    mainPlanAPI.requestArgument = @{
                                    @"type" : type,
                                    @"pageNumber" : pageNumberStr,
                                    @"pageSize" : @20,
                                    @"userId" : userIDStr
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
        //数据的处理
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

//MARK: loan 主界面的网络数据请求
- (void)myLoan_requestWithPlanType: (HXBRequestType_MY_LoanRequestType)loanRequestType
                         andUpData: (BOOL)isUPData
                   andSuccessBlock: (void(^)(NSArray<HXBMYViewModel_MainLoanViewModel *>* viewModelArray))successDateBlock
                   andFailureBlock: (void(^)(NSError *error))failureBlock{
    HXBRequstAPI_MYMainLoanAPI *mainLoanAPI = [[HXBRequstAPI_MYMainLoanAPI alloc]init];
    NSString *userIDStr = [KeyChainManage sharedInstance].userId;
    if (!userIDStr.length) {
        userIDStr = @"2458528";
    }
    __block NSString *loanTypeStr = nil;
    [HXBRequestType_MYManager myLoan_requestType:loanRequestType andReturnParamBlock:^(NSString *type, NSString *UI_Type) {
        loanTypeStr = type;
    }];
    NSInteger page = 1;
    switch (loanRequestType) {
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
                                    @"pageNumber" : @(page),
                                    @"pageSize" : @20,
                                    @"userId" : userIDStr,
                                    @"type" : loanTypeStr,
                                    @"version" : @1.0,
                                    };
 
    mainLoanAPI.isUPData = isUPData;
    [mainLoanAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        
        NSMutableArray <HXBMYViewModel_MainLoanViewModel*> *loanViewModelArray = [[NSMutableArray alloc]init];
//        NSArray <NSDictionary *>*dataArray = [responseObject valueForKey:@"data"];
        NSDictionary *dataArray = [responseObject valueForKey:@"data"];
//        [dataArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
            HXBMYViewModel_MainLoanViewModel *viewModel = [[HXBMYViewModel_MainLoanViewModel alloc]init];
            HXBMyModel_MainLoanModel *loanModel = [[HXBMyModel_MainLoanModel alloc]init];
             [loanModel yy_modelSetWithDictionary:dataArray];
            viewModel.loanModel = loanModel;
            [loanViewModelArray addObject:viewModel];
//        }];
        HXBRequstAPI_MYMainLoanAPI *loanRequestAPI = (HXBRequstAPI_MYMainLoanAPI *)request;
        if (successDateBlock) {
            HXBRequestType_MY_LoanRequestType loanRequestType = loanViewModelArray.firstObject.requestType;
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
            case HXBRequestType_MY_LoanRequestType_REPAYING_LOAN:
            if (isUPdata) {
                [self.repaying_Loan_array removeAllObjects];
                self.repayingPage = 1;
            }
            [self.repaying_Loan_array addObjectsFromArray:viewModelArray];
            return self.repaying_Loan_array;
    }
}


#pragma mark - 资金记录 接口
//- (void)capitalRecord

kDealloc
@end
