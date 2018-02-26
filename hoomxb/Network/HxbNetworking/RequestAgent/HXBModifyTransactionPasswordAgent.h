//
//  HXBModifyTransactionPasswordAgent.h
//  hoomxb
//
//  Created by caihongji on 2018/2/6.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBModifyTransactionPasswordAgent : NSObject
- (void)modifyTransactionPasswordWithRequestBlock:(void(^)(NYBaseRequest *request))requestBlock resultBlock:(void (^)(BOOL isSuccess, NSError *error))resultBlock;
@end
