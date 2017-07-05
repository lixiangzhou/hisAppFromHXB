//
//  HXBSetGesturePasswordRequest.h
//  hoomxb
//
//  Created by HXB-C on 2017/7/4.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBSetGesturePasswordRequest : NSObject
/**
 版本更新
 
 @param password 登录密码
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)setGesturePasswordRequestWithPassword:(NSString *)password andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;

/**
 风险测评
 
 @param score 测评分数
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)riskModifyScoreRequestWithScore:(NSString *)score andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;

@end
