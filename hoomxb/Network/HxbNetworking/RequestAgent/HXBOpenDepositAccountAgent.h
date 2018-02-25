//
//  HXBOpenDepositAccountAgent.h
//  hoomxb
//
//  Created by caihongji on 2018/2/6.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXBCardBinModel;
@interface HXBOpenDepositAccountAgent : NSObject


/**
 卡bin校验

 @param requestBlock 请求配置的block
 @param resultBlock 请求结果回调的block
 */
+ (void)checkCardBinResultRequestWithWithResultBlock:(void(^)(NYBaseRequest* request)) requestBlock resultBlock:(void(^)(HXBCardBinModel *cardBinModel, NSError *error))resultBlock;

@end
