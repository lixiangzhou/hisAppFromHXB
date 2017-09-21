//
//  HXBMYRequest.h
//  hoomxb
//
//  Created by HXB on 2017/5/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBMYViewModel_MianPlanViewModel.h"//主界面 planViewModel
#import "HXBMYViewModel_MainLoanViewModel.h"//主界面的 loanViewModel
#import "HXBMYViewModel_MainCapitalRecordViewModel.h"//主界面 资产记录 ViewMOdel
#import "HXBBaseRequest.h"
#import "HXBMY_LoanTruansferViewModel.h"
@class HXBMYModel_AssetStatistics_Plan;//资金统计的Model plan
@class HXBMYModel_AssetStatistics_Loan;//资金统计的Model loan
@class HXBMYModel_Plan_planRequestModel;///plan 资产目录
@class HXBMYModel_Loan_LoanRequestModel;///loan 资产目录
@class HXBMY_PlanViewModel_LoanRecordViewModel;

///关于个人主页的红利计划的 （账户内）
@interface HXBMYRequest : NSObject
///创建单利对象
+ (instancetype) sharedMYRequest;


#pragma mark - 主要页面的网络请求
///资金统计的Request plan
- (void)myPlanAssetStatistics_requestWithSuccessBlock: (void(^)(HXBMYModel_AssetStatistics_Plan *model))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;

///红利计划 列表的网络数据请求
- (void)myPlan_requestWithPlanType: (HXBRequestType_MY_PlanRequestType)planRequestType
                         andUpData: (BOOL)isUPData
                   andSuccessBlock: (void(^)(NSArray<HXBMYViewModel_MianPlanViewModel *>* viewModelArray, NSInteger totalCount))successDateBlock
                   andFailureBlock: (void(^)(NSError *error))failureBlock;


///资金统计的Request loan
- (void)myLoanAssetStatistics_requestWithSuccessBlock: (void(^)(NSArray <HXBMYModel_AssetStatistics_Loan *>*model))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;


///散标 列表的网络数据请求
- (void)myLoan_requestWithLoanType: (HXBRequestType_MY_LoanRequestType)LoanRequestType
                         andUpData: (BOOL)isUPData
                   andSuccessBlock: (void(^)(NSArray<HXBMYViewModel_MainLoanViewModel *>* viewModelArray, NSInteger totalCount))successDateBlock
                   andFailureBlock: (void(^)(NSError *error))failureBlock;

///转让中 列表的网络数据的请求
- (void)myLoanTruansfer_requestWithLoanTruansferWithIsUPData: (BOOL)isUPData
                                             andSuccessBlock: (void(^)(NSArray<HXBMY_LoanTruansferViewModel *>* viewModelArray))successDateBlock
                                             andFailureBlock: (void(^)(NSError *error,HXBBaseRequest *request))failureBlock;


/// 资金记录 接口
- (void)capitalRecord_requestWithScreenType: (NSString *)screenType
                               andStartDate: (NSString *)startDate
                                 andEndDate: (NSString *)endDate
                                andIsUPData: (BOOL)isUPData 
                            andSuccessBlock: (void(^)(NSArray<HXBMYViewModel_MainCapitalRecordViewModel *>* viewModelArray, NSInteger totalCount))successDateBlock
                            andFailureBlock: (void(^)(NSError *error))failureBlock;


///plan 详情页的 交易记录
- (void)loanRecord_my_Plan_WithIsUPData: (BOOL)isUPData
                      andWithRequestUrl: (NSString *)requestUrl
                              andPlanID: (NSString *)planID
                        andSuccessBlock: (void(^)(NSArray<HXBMY_PlanViewModel_LoanRecordViewModel *>* viewModelArray))successDateBlock
                        andFailureBlock: (void(^)(NSError *error))failureBlock;

/**
 loan  账户内散标资产
 */
- (void)loanAssets_AccountRequestSuccessBlock: (void(^)(HXBMYModel_Loan_LoanRequestModel *viewModel))successDateBlock
                              andFailureBlock: (void(^)(NSError *error))failureBlock;
/**
 plan 账户内计划资产
 */
- (void)planAssets_AccountRequestSuccessBlock: (void(^)(HXBMYModel_Plan_planRequestModel *viewModel))successDateBlock
                              andFailureBlock: (void(^)(NSError *error))failureBlock
                                    andUpData: (BOOL)isUPData;
@end
