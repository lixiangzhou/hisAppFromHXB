//
//  HXBFin_Buy_ViewModel.h
//  hoomxb
//
//  Created by 肖扬 on 2017/9/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel+KEYCHAIN.h"
#import "HXBBankCardModel.h"

typedef void(^successBlock)(NSDictionary *dateDic);
typedef void(^failureBlock)();

@interface HXBFin_Buy_ViewModel : HXBBaseViewModel

@property(nonatomic,strong) HXBBankCardModel *bankCardModel;

// 获取银行卡信息
- (void)requestForBankCardResultBlock: (void(^)(BOOL isSuccess))resultBlock;

/**
 获取充值短验
 @param amount 充值金额
 @param action 判断是否为提现或者充值
 @param type 短信验证码或是语言验证码
 @param callbackBlock 请求回调
 */
- (void)getVerifyCodeRequesWithRechargeAmount:(NSString *)amount andWithType:(NSString *)type  andWithAction:(NSString *)action andCallbackBlock: (void(^)(BOOL isSuccess,NSError *error))callbackBlock;

@end
