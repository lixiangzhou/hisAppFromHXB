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
@interface HXBFinanctingRequest : NSObject
//MAKR: 红利计划列表的网络请求
- (void)planBuyListWithIsUpData: (BOOL)isUPData
                andSuccessBlock: (void(^)(NSArray<HXBFinHomePageViewModel_PlanList *>* viewModelArray))successDateBlock
                andFailureBlock: (void(^)(NSError *error))failureBlock;

//MARK: 散标列表的网络数据请求
- (void)loanBuyListWithIsUpData: (BOOL)isUPData andSuccessBlock: (void(^)(NSArray<HXBFinHomePageViewModel_LoanList *>* viewModelArray))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;
@end




/** ====================== readMe =============================
 * 1. 所有的理财模块的网络请求都在这里了
 */
