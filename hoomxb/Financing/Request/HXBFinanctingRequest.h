//
//  HXBFinanctingRequest.h
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXBFinHomePageViewModel_PlanList;
@interface HXBFinanctingRequest : NSObject
//MAKR: 红利计划列表的网络请求
- (void)planBuyListWithIsUpData: (BOOL)isUPData
                andSuccessBlock: (void(^)(NSArray<HXBFinHomePageViewModel_PlanList *>* viewModelArray))successDateBlock
                andFailureBlock: (void(^)(NSError *error))failureBlock;
@end




/** ====================== readMe =============================
 * 1. 所有的理财模块的网络请求都在这里了
 */
