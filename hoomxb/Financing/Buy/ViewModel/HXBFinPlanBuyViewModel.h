//
//  HXBFinPlanBuyViewModel.h
//  hoomxb
//
//  Created by lxz on 2018/2/26.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBBestCouponModel.h"
#import "HXBFinModel_BuyResoult_PlanModel.h"
#import "HXBBaseViewModel+KEYCHAIN.h"
#import "HXBBaseViewModel+HXBBankCardInfo.h"

@interface HXBFinPlanBuyViewModel : HXBBaseViewModel

/**
 最优优惠券Model
 */
@property (nonatomic, strong) HXBBestCouponModel *bestCouponModel;

/**
 计划购买结果Model
 */
@property (nonatomic, strong) HXBFinModel_BuyResoult_PlanModel *resultModel;
/**
 错误状态码
 */
@property (nonatomic, assign) NSInteger errorCode;

/**
 错误描述
 */
@property (nonatomic, copy) NSString *errorMessage;

/**
 最优优惠券
 
 @param params 请求参数
 @param resultBlock 返回数据
 */
- (void)bestCouponListWithParams: (NSDictionary *)params
                     resultBlock: (void(^)(BOOL isSuccess))resultBlock;


/**
 计划购买

 @param planID 计划id
 @param parameter 请求参数
 @param resultBlock 返回数据
 */
- (void)planBuyReslutWithPlanID: (NSString *)planID
                      parameter: (NSDictionary *)parameter
                    resultBlock: (void(^)(BOOL isSuccess))resultBlock;

/**
 获取充值短验
 @param amount 充值金额
 @param action 判断是否为提现或者充值
 @param type 短信验证码或是语言验证码
 @param callbackBlock 请求回调
 */
- (void)getVerifyCodeRequesWithRechargeAmount:(NSString *)amount andWithType:(NSString *)type  andWithAction:(NSString *)action andCallbackBlock: (void(^)(BOOL isSuccess,NSError *error))callbackBlock;

@end
