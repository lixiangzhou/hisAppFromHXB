//
//  HXBFinLoanBuyViewModel.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/3/8.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBLazyCatRequestModel.h"
#import "HXBBaseViewModel+KEYCHAIN.h"
#import "HXBBaseViewModel+HXBBankCardInfo.h"

@interface HXBFinLoanBuyViewModel : HXBBaseViewModel

/**
 错误状态码
 */
@property (nonatomic, assign) NSInteger errorCode;

/**
 错误描述
 */
@property (nonatomic, copy) NSString *errorMessage;

/**
 散标购买结果Model
 */
@property (nonatomic, strong) HXBLazyCatRequestModel *resultModel;

/**
 散标购买
 
 @param parameter 请求参数
 @param resultBlock 返回数据
 */
- (void)loanBuyReslutWithParameter: (NSDictionary *)parameter
                       resultBlock: (void(^)(BOOL isSuccess))resultBlock;


@end
