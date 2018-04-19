//
//  HXBFincreditorChangebuyViewModel.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/3/8.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBFin_LoanTruansfer_BuyResoutViewModel.h"
#import "HXBBaseViewModel+HXBBankCardInfo.h"
#import "HXBBaseViewModel+KEYCHAIN.h"

@interface HXBFincreditorChangebuyViewModel : HXBBaseViewModel

/**
 成功的model
 */
@property (nonatomic, strong) HXBFin_LoanTruansfer_BuyResoutViewModel *resultModel;

/**
 错误状态码
 */
@property (nonatomic, assign) NSInteger errorCode;

/**
 错误描述
 */
@property (nonatomic, copy) NSString *errorMessage;

/**
 债权购买结果

 @param loanID 债权id
 @param parameter 购买参数
 @param resultBlock 返回结果
 */
- (void)loanTransformBuyReslutWithLoanID: (NSString *)loanID
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
