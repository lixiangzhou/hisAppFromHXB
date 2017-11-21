//
//  HXBRequestAccountInfo.h
//  hoomxb
//
//  Created by hxb on 2017/10/30.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBMyRequestAccountModel.h"
#import "HXBMyCouponListModel.h"

@interface HXBRequestAccountInfo : NSObject

/**
   兑换优惠券
 @param code         兑换码
 @param seccessBlock 成功
 @param failureBlock 失败
 */
+ (void)downLoadMyCouponExchangeInfoHUDWithCode:(NSString *)code withSeccessBlock:(void(^)(HXBMyCouponListModel *Model, NSString *message))seccessBlock andFailure: (void(^)(NSError *error))failureBlock;

/**
 我的页面 请求优惠券信息

 @param seccessBlock 成功
 @param failureBlock 失败
 */
+ (void)downLoadAccountInfoNoHUDWithSeccessBlock:(void(^)(HXBMyRequestAccountModel *viewModel))seccessBlock andFailure: (void(^)(NSError *error))failureBlock;


/**
 我的优惠券 请求我的优惠券列表

 @param parameterDict 请求参数字典
 @param seccessBlock 成功
 @param failureBlock 失败
 */
+ (void)downLoadMyAccountListInfoHUDWithParameterDict:(NSDictionary *)parameterDict withSeccessBlock:(void(^)(NSArray<HXBMyCouponListModel *>* modelArray))seccessBlock andFailure: (void(^)(NSError *error))failureBlock;

@end
