//
//  HXBSetGesturePasswordAgent.h
//  hoomxb
//
//  Created by caihongji on 2018/2/25.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBSetGesturePasswordAgent : NSObject

/**
 风险评测

 @param requestBlock 请求回调
 @param resultBlock 结果回调
 */
+ (void)riskModifyScoreRequestWithScore:(void(^)(NYBaseRequest* request)) requestBlock resultBlock:(void(^)(id responseObject, NSError *error))resultBlock;
@end
