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

 @param parameter 购买参数
 @param resultBlock 返回结果
 */
- (void)loanTransformBuyReslutWithParameter : (NSDictionary *)parameter
                                resultBlock : (void(^)(BOOL isSuccess))resultBlock;


@end
