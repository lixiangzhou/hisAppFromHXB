//
//  HXBFinLoanBuyViewModel.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/3/8.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBFinModel_BuyResoult_LoanModel.h"
#import "HXBBaseViewModel+KEYCHAIN.h"
#import "HXBBaseViewModel+HXBBankCardInfo.h"

@interface HXBFinLoanBuyViewModel : HXBBaseViewModel

/**
 散标购买结果Model
 */
@property (nonatomic, strong) HXBFinModel_BuyResoult_LoanModel *resultModel;

/**
 错误状态码
 */
@property (nonatomic, assign) NSInteger errorCode;

/**
 错误描述
 */
@property (nonatomic, copy) NSString *errorMessage;

/**
 散标购买
 
 @param loanID 散标id
 @param parameter 请求参数
 @param resultBlock 返回数据
 */
- (void)loanBuyReslutWithLoanID: (NSString *)loanID
                      parameter: (NSDictionary *)parameter
                    resultBlock: (void(^)(BOOL isSuccess))resultBlock;

/**
 获取充值短验
 @param amount 充值金额
 @param action 判断是否为提现或者充值
 @param type 短信验证码或是语言验证码
 @param callbackBlock 请求回调
 */
- (void)getVerifyCodeRequesWithRechargeAmount:(NSString *)amount
                                  andWithType:(NSString *)type
                                andWithAction:(NSString *)action
                             andCallbackBlock: (void(^)(BOOL isSuccess,NSError *error))callbackBlock;

@end
