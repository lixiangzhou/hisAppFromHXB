//
//  HXBMYRequest.h
//  hoomxb
//
//  Created by HXB on 2017/5/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBRequestType_MYManager.h"//关于我的界面的 网络 相关的枚举管理类
@class HXBMYViewModel_MianPlanViewModel;//我的plan 主界面的ViewModel
@class HXBMYViewModel_MainLoanViewModel;//我的loan 主界面的ViewModel

@class HXBMYViewModel_MainCapitalRecordViewModel;//资产记录的viewmodel

@class HXBMYModel_AssetStatistics_Plan;//资金统计的Model plan
@class HXBMYModel_AssetStatistics_Loan;//资金统计的Model loan

///关于个人主页的红利计划的 （账户内）
@interface HXBMYRequest : NSObject
///创建单利对象
+ (instancetype) sharedMYRequest;


#pragma mark - 主要页面的网络请求
///资金统计的Request plan
- (void)myPlanAssetStatistics_requestWithSuccessBlock: (void(^)(HXBMYModel_AssetStatistics_Plan *model))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;
//MARK: 红利计划 主界面的网络数据请求
- (void)myPlan_requestWithPlanType: (HXBRequestType_MY_PlanRequestType)planRequestType
                         andUpData: (BOOL)isUPData
                   andSuccessBlock: (void(^)(NSArray<HXBMYViewModel_MianPlanViewModel *>* viewModelArray))successDateBlock
                   andFailureBlock: (void(^)(NSError *error))failureBlock;


///资金统计的Request loan
- (void)myLoanAssetStatistics_requestWithSuccessBlock: (void(^)(NSArray <HXBMYModel_AssetStatistics_Loan *>*model))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;


//MARK: 红利计划 主界面的网络数据请求
- (void)myLoan_requestWithPlanType: (HXBRequestType_MY_LoanRequestType)planRequestType
                         andUpData: (BOOL)isUPData
                   andSuccessBlock: (void(^)(NSArray<HXBMYViewModel_MainLoanViewModel *>* viewModelArray))successDateBlock
                   andFailureBlock: (void(^)(NSError *error))failureBlock;

//MARK: 资金记录 接口
- (void)capitalRecord_requestWithScreenType: (NSString *)screenType
                               andStartDate: (NSString *)startDate
                                 andEndDate: (NSString *)endDate
                                andIsUPData: (BOOL)isUPData 
                            andSuccessBlock: (void(^)(NSArray<HXBMYViewModel_MainCapitalRecordViewModel *>* viewModelArray))successDateBlock
                            andFailureBlock: (void(^)(NSError *error))failureBlock;
@end
