//
//  HXBFinPlanBuyViewModel.h
//  hoomxb
//
//  Created by lxz on 2018/2/26.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBBestCouponModel.h"
#import "HXBBankCardModel.h"
#import "HXBBaseViewModel+KEYCHAIN.h"

@interface HXBFinPlanBuyViewModel : HXBBaseViewModel

@property (nonatomic, strong) HXBBestCouponModel *bestCouponModel;
@property (nonatomic, strong) HXBBankCardModel *bankCardModel;

/**
 最优优惠券
 
 @param params 请求参数
 @param resultBlock 返回数据
 */
- (void)bestCouponListWithParams: (NSDictionary *)params
                     resultBlock: (void(^)(BOOL isSuccess))resultBlock;


/**
 获取银行卡信息

 @param resultBlock 返回数据
 */
- (void)bankCardInfoWithResultBlock:(void(^)(BOOL isSuccess))resultBlock;

/**
 获取充值短验
 @param amount 充值金额
 @param action 判断是否为提现或者充值
 @param type 短信验证码或是语言验证码
 @param callbackBlock 请求回调
 */
- (void)getVerifyCodeRequesWithRechargeAmount:(NSString *)amount andWithType:(NSString *)type  andWithAction:(NSString *)action andCallbackBlock: (void(^)(BOOL isSuccess,NSError *error))callbackBlock;

@end
