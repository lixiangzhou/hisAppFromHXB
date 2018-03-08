//
//  HXBSignUPAndLoginAgent.h
//  hoomxb
//
//  Created by lxz on 2018/3/7.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBSignUPAndLoginAgent : NSObject

+ (void)checkExistMobileRequest:(void (^)(NYBaseRequest *request))requestBlock mobile:(NSString *)mobile resultBlock:(void(^)(BOOL isSuccess, NYBaseRequest *request))resultBlock;

@end
