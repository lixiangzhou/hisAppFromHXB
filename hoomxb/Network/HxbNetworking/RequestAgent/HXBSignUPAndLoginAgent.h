//
//  HXBSignUPAndLoginAgent.h
//  hoomxb
//
//  Created by lxz on 2018/3/7.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBSignUPAndLoginAgent : NSObject
/**
 * 登录 请求
 * @param  mobile   是    string    用户名
 * @param  password 是    string    密码
 * @param  captcha  否    string    图验(只有在登录错误超过3次才需要输入图验)
 
 */
+ (void)loginRequetWithMobile: (NSString *)mobile password: (NSString *)password captcha: (NSString *)captcha resultBlock:(void(^)(BOOL isSuccess))resultBlock;

@end
