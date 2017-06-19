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
@class HXBMYModel_AssetStatistics_Plan;//资金统计的Model plan
@class HXBMYModel_AssetStatistics_Loan;//资金统计的Model loan

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
                   andSuccessBlock: (void(^)(NSArray<HXBMYViewModel_MianPlanViewModel *>* viewModelArray))successDateBlock
                   andFailureBlock: (void(^)(NSError *error))failureBlock;


///资金统计的Request loan
- (void)myLoanAssetStatistics_requestWithSuccessBlock: (void(^)(NSArray <HXBMYModel_AssetStatistics_Loan *>*model))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;


///散标 列表的网络数据请求
- (void)myLoan_requestWithLoanType: (HXBRequestType_MY_LoanRequestType)LoanRequestType
                         andUpData: (BOOL)isUPData
                   andSuccessBlock: (void(^)(NSArray<HXBMYViewModel_MainLoanViewModel *>* viewModelArray))successDateBlock
                   andFailureBlock: (void(^)(NSError *error))failureBlock;

/// 资金记录 接口
- (void)capitalRecord_requestWithScreenType: (HXBRequestType_MY_tradlist)screenType
                               andStartDate: (NSString *)startDate
                                 andEndDate: (NSString *)endDate
                                andIsUPData: (BOOL)isUPData 
                            andSuccessBlock: (void(^)(NSArray<HXBMYViewModel_MainCapitalRecordViewModel *>* viewModelArray))successDateBlock
                            andFailureBlock: (void(^)(NSError *error))failureBlock;
@end
