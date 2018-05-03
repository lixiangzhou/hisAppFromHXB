//
//  HXBFinPlanBuyViewModel.h
//  hoomxb
//
//  Created by lxz on 2018/2/26.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBBestCouponModel.h"
#import "HXBLazyCatRequestModel.h"
#import "HXBBaseViewModel+KEYCHAIN.h"
#import "HXBBaseViewModel+HXBBankCardInfo.h"

@interface HXBFinPlanBuyViewModel : HXBBaseViewModel

/**
 最优优惠券Model
 */
@property (nonatomic, strong) HXBBestCouponModel *bestCouponModel;

/**
 计划购买跳转恒丰银行的model
 */
@property (nonatomic, strong) HXBLazyCatRequestModel *resultModel;


/**
 最优优惠券
 
 @param params 请求参数
 @param resultBlock 返回数据
 */
- (void)bestCouponListWithParams: (NSDictionary *)params
                     resultBlock: (void(^)(BOOL isSuccess))resultBlock;


/**
 计划购买

 @param parameter 请求参数
 @param resultBlock 返回数据
 */
- (void)planBuyReslutWithParameter: (NSDictionary *)parameter
                       resultBlock: (void(^)(BOOL isSuccess))resultBlock;


@end
