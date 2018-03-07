//
//  HXBChooseDiscountCouponViewModel.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/3/7.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBChooseCouponModel.h"
#import "HXBBestCouponModel.h"

@interface HXBChooseDiscountCouponViewModel : HXBBaseViewModel

@property (nonatomic, strong) HXBChooseCouponModel *chooseCouponModel;
@property (nonatomic, strong) HXBBestCouponModel *bestCouponModel;

/**
 选择优惠券列表

 @param params 请求参数
 @param resultBlock 返回数据
 */
- (void)chooseCouponListWithParams: (NSDictionary *)params
                       resultBlock: (void(^)(BOOL isSuccess))resultBlock;


/**
 最优优惠券

 @param params 请求参数
 @param resultBlock 返回数据
 */
- (void)bestCouponListWithParams: (NSDictionary *)params
                     resultBlock: (void(^)(BOOL isSuccess))resultBlock;

@end
