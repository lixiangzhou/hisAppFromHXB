//
//  HXBFinanctingRequest.h
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBBaseRequest.h"
#import "HXBFinModel_BuyResoult_LoanModel.h"///购买结果
@class HXBFinHomePageViewModel_PlanList;//红利计划的首页ViewModel
@class HXBFinHomePageViewModel_LoanList;//散标列表页- 一级界面ViewModel
@class HXBFinDetailViewModel_PlanDetail;//红利计划详情页ViewModel
@class HXBFinDetailViewModel_LoanDetail;//散标投递的详情页的ViewModel
@class HXBFinModel_AddRecortdModel_Plan;//理财模块的加入记录接口
@class FinModel_AddRecortdModel_Loan;   //加入记录model
@class HXBFinModel_BuyResoult_PlanModel;//购买
@class HXBFinModel_Buy_Plan;
@class HXBFinModel_BuyResoult_LoanModel;
@class HXBFinModel_Buy_LoanModel;
@class HXBFin_Plan_BuyViewModel;
@class HXBFinHomePageViewModel_LoanTruansferViewModel;///债转viewmodel
@class HXBFinDetailViewModel_LoanTruansferDetail;//债转的详情的viewModel
@class HXBFin_LoanTruansfer_BuyResoutViewModel;
@class HXBFinModel_AddRecortdModel_LoanTruansfer;
static NSString *const HXBFinHomePagePlan_ASC = @"";

///理财界面的所有网络请求页全部都在这里了
@interface HXBFinanctingRequest : NSObject

///单利
+ (instancetype)sharedFinanctingRequest;


#pragma mark - 理财一级界面的数据请求
/**
 将数据转为模型
 
 @param dataList 数据数组
 @return 模型数组
 */
- (NSMutableArray <HXBFinHomePageViewModel_PlanList *>*)plan_dataProcessingWitharr:(NSArray *)dataList;
//MARK: 红利计划列表的网络请求
///红利计划-数据请求- 一级界面首页
- (void)planBuyListWithIsUpData: (BOOL)isUPData
                andSuccessBlock: (void(^)(NSArray<HXBFinHomePageViewModel_PlanList *>* viewModelArray,NSInteger totalCount))successDateBlock
                andFailureBlock: (void(^)(NSError *error))failureBlock;

//MARK: 散标列表的网络数据请求
///散标列表-数据请求- 一级界面首页
- (void)loanBuyListWithIsUpData: (BOOL)isUPData andSuccessBlock: (void(^)(NSArray<HXBFinHomePageViewModel_LoanList *>* viewModelArray,NSInteger totalCount))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;

//MARK:债权转让 列表
///债权转让列表页
- (void)loanTruansferListWithIsUPData: (BOOL)isUPData andSuccessBlock: (void (^)(NSArray<HXBFinHomePageViewModel_LoanTruansferViewModel *>* viewModelArray,NSInteger totalCount))successDateBlock andFailureBlock: (void(^)(NSError *error,id responsObject))failureBlock;


#pragma mark - 理财二级界面 - 详情界面的数据请求
///红利计划-数据请求- 详情页
- (void)planDetaileWithPlanID: (NSString *)financePlanId andSuccessBlock: (void(^)(HXBFinDetailViewModel_PlanDetail* viewModel))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;
///散标- 数据请求- 详情页
- (void)loanDetaileWithLoanID: (NSString *)financeLoanId andSuccessBlock: (void(^)(HXBFinDetailViewModel_LoanDetail* viewModel))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;
///债转详情
- (void)loanTruansferDetileRequestWithLoanID:(NSString *)loanID andSuccessBlock: (void(^)(HXBFinDetailViewModel_LoanTruansferDetail* viewModel))successDateBlock andFailureBlock: (void(^)(NSError *error,NSDictionary *respons))failureBlock;


#pragma mark - 红利计划详情页 - 加入记录
// 红利计划详情页 - 加入记录
- (void)planAddRecortdWithISUPLoad: (BOOL)isUPLoad andFinancePlanId: (NSString *)financePlanId andOrder: (NSString *)order andSuccessBlock: (void(^)(HXBFinModel_AddRecortdModel_Plan * model))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;

// 散标详情页 加入记录
- (void)loanAddRecortdWithISUPLoad: (BOOL)isUPLoad andFinanceLoanId: (NSString *)financeLoanId andOrder: (NSString *)order andSuccessBlock: (void(^)(FinModel_AddRecortdModel_Loan * model))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;
/// 债转详情  加入记录
- (void)loanTruansferAddRecortdWithISUPLoad: (BOOL)isUPLoad andFinanceLoanId: (NSString *)financeLoanId andOrder: (NSString *)order andSuccessBlock: (void(^)(NSArray< HXBFinModel_AddRecortdModel_LoanTruansfer *> *loanTruansferRecortdModel))successDateBlock andFailureBlock: (void(^)(NSError *error,HXBBaseRequest *request))failureBlock ;


#pragma mark - 购买
/// 计划 购买
//- (void)planBuyWithPlanID:(NSString *)planID
//                andAmount:(NSString *)amount
//          andSuccessBlock:(void (^)(HXBFinModel_Buy_Plan *model,HXBFinModel_BuyResoult_PlanModel *resultModel))successDateBlock
//          andFailureBlock:(void (^)(NSError *))failureBlock;

/// 计划 购买 结果返回
- (void)plan_buyReslutWithPlanID: (NSString *)planID
                       andAmount: (NSString *)amount
                       cashType : (NSString *)cashType
                 andSuccessBlock:(void (^)(HXBFin_Plan_BuyViewModel *model))successDateBlock
                 andFailureBlock:(void (^)(NSError *error, NSInteger status))failureBlock;


/// loan 购买请求 返回了购买结果
- (void)loan_confirmBuyReslutWithLoanID: (NSString *)loanID
                              andAmount: (NSString *)amount
                        andSuccessBlock:(void (^)(HXBFinModel_BuyResoult_LoanModel *model))successDateBlock
                        andFailureBlock:(void (^)(NSError *error, NSInteger status))failureBlock;

#pragma mark --- 请求参数改为字典
// 红利 购买结果
- (void)plan_buyReslutWithPlanID: (NSString *)planID
                      parameter :(NSDictionary *)parameter
                 andSuccessBlock:(void (^)(HXBFinModel_BuyResoult_PlanModel *model))successDateBlock
                 andFailureBlock:(void (^)(NSString *errorMessgae, NSInteger status))failureBlock;
// 散标 购买结果
- (void)loan_confirmBuyReslutWithLoanID: (NSString *)loanID
                              parameter :(NSDictionary *)parameter
                        andSuccessBlock:(void (^)(HXBFinModel_BuyResoult_LoanModel *model))successDateBlock
                        andFailureBlock:(void (^)(NSString *errorMessage, NSInteger status))failureBlock;
/// 债权 购买结果
- (void)loanTruansfer_confirmBuyReslutWithLoanID: (NSString *)loanTruansferID
                                      parameter :(NSDictionary *)parameter
                                 andSuccessBlock:(void (^)(HXBFin_LoanTruansfer_BuyResoutViewModel *model))successDateBlock
                                 andFailureBlock:(void (^)(NSString *errorMessage, NSInteger status))failureBlock;

@end

