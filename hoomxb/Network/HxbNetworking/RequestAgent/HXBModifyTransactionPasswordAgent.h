//
//  HXBModifyTransactionPasswordAgent.h
//  hoomxb
//
//  Created by caihongji on 2018/2/6.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBBankCardModel.h"

@interface HXBModifyTransactionPasswordAgent : NSObject

+ (void)modifyTransactionPasswordWithRequestBlock:(void(^)(NYBaseRequest *request))requestBlock
                                      resultBlock:(void (^)(BOOL isSuccess, NSError *error))resultBlock;

/**
 获取银行卡信息

 @param requestBlock 返回请求
 @param resultBlock 返回数据
 */
+ (void)bankCardInfoWithRequestBlock:(void(^)(NYBaseRequest* request)) requestBlock
                         ResultBlock:(void(^)(HXBBankCardModel *viewModel, NSError *error))resultBlock;

@end
