//
//  HXBFinanctingRequest.h
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HXBFinHomePageViewModel_PlanList;
@class HXBFinHomePageViewModel_LoanList;
@class HXBFinDetailViewModel_PlanDetail;


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
- (void)planDetaileWithSuccessBlock: (void(^)(NSArray<HXBFinDetailViewModel_PlanDetail *>* viewModelArray))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;
///散标- 数据请求- 详情页

@end




/** ====================== readMe =============================
 * 1. 所有的理财模块的网络请求都在这里了
 */
