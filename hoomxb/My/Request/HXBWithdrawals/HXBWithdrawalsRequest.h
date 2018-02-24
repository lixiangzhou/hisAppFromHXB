//
//  HXBWithdrawalsRequest.h
//  hoomxb
//
//  Created by HXB-C on 2017/6/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBWithdrawalsRequest : NSObject

/**
 获取银行卡列表

 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)bankCardListRequestWithSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;

@end
