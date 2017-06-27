//
//  HXBWithdrawalsRequest.h
//  hoomxb
//
//  Created by HXB-C on 2017/6/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBWithdrawalsRequest : NSObject
/**
 提现
 
 @param requestArgument 提现传入的请求参数字典
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)withdrawalsRequestWithRequestArgument:(NSMutableDictionary *)requestArgument andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;
@end
