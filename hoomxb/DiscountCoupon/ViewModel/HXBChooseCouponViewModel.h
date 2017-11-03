//
//  HXBChooseCouponViewModel.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2017/10/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBChooseCouponModel.h"
#import "HXBBestCouponModel.h"
@interface HXBChooseCouponViewModel : NSObject
// 选择优惠券列表
+ (void)chooseCouponWithparams: (NSDictionary *)params
                   andSuccessBlock: (void(^)(HXBChooseCouponModel *model))successDateBlock
                   andFailureBlock: (void(^)(NSError *error))failureBlock;

// 购买匹配最优优惠券
+ (void)BestCouponWithparams: (NSDictionary *)params
               andSuccessBlock: (void(^)(HXBBestCouponModel *model))successDateBlock
               andFailureBlock: (void(^)(NSError *error))failureBlock;
@end
