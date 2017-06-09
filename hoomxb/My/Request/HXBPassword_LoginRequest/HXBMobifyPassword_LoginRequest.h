//
//  HXBMobifyPassword_LoginRequest.h
//  hoomxb
//
//  Created by HXB on 2017/6/9.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
///修改登录密码
@interface HXBMobifyPassword_LoginRequest : NSObject
/**
 * @param oldPassword 旧密码
 * @param newPassword 新密码
 */
+ (void)mobifyPassword_LoginRequest_requestWithOldPwd: (NSString *)oldPassword
                                            andNewPwd: (NSString *)newPassword
                                      andSuccessBlock: (void(^)())successDateBlock
                                      andFailureBlock: (void(^)(NSError *error))failureBlock;
@end
