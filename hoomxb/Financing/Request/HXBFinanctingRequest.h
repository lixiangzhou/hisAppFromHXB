//
//  HXBFinanctingRequest.h
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXBFinHomePageViewModel_PlanList;//红利计划的首页ViewModel
@class HXBFinHomePageViewModel_LoanList;//散标列表页- 一级界面ViewModel
@class HXBFinDetailViewModel_PlanDetail;//红利计划详情页ViewModel
@class HXBFinDetailViewModel_LoanDetail;//散标投递的详情页的ViewModel
@class HXBFinModel_AddRecortdModel_Plan;//理财模块的加入记录接口

static NSString *const HXBFinHomePagePlan_ASC = @"";

///理财界面的所有网络请求页全部都在这里了
@interface HXBFinanctingRequest : NSObject



///单利
+ (instancetype)sharedFinanctingRequest;



#pragma mark - 理财一级界面的数据请求
//MAKR: 红利计划列表的网络请求
///红利计划-数据请求- 一级界面首页
- (void)planBuyListWithIsUpData: (BOOL)isUPData
                andSuccessBlock: (void(^)(NSArray<HXBFinHomePageViewModel_PlanList *>* viewModelArray))successDateBlock
                andFailureBlock: (void(^)(NSError *error))failureBlock;

//MARK: 散标列表的网络数据请求
///散标列表-数据请求- 一级界面首页
- (void)loanBuyListWithIsUpData: (BOOL)isUPData andSuccessBlock: (void(^)(NSArray<HXBFinHomePageViewModel_LoanList *>* viewModelArray))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;



#pragma mark - 理财二级界面 - 详情界面的数据请求
///红利计划-数据请求- 详情页
- (void)planDetaileWithPlanID: (NSString *)financePlanId andSuccessBlock: (void(^)(HXBFinDetailViewModel_PlanDetail* viewModel))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;
///散标- 数据请求- 详情页
- (void)loanDetaileWithLoanID: (NSString *)financeLoanId andSuccessBlock: (void(^)(HXBFinDetailViewModel_LoanDetail* viewModel))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;



#pragma mark - 红利计划详情页 - 加入记录
// 红利计划详情页 - 加入记录
- (void)planAddRecortdWithISUPLoad: (BOOL)isUPLoad andFinancePlanId: (NSString *)financePlanId andOrder: (NSString *)order andSuccessBlock: (void(^)(HXBFinModel_AddRecortdModel_Plan * model))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;
@end

