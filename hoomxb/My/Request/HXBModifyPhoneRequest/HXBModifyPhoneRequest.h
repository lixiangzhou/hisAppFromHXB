//
//  HXBModifyPhoneRequest.h
//  hoomxb
//
//  Created by HXB-C on 2017/6/24.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBModifyPhoneRequest : NSObject
/**
 修改手机号
 
 @param newPhoneNumber 新的手机号码
 @param newsmscode 短信验证码
 @param captcha 图验
 */
- (void)mobifyPhoneNumberWithNewPhoneNumber:(NSString *)newPhoneNumber andWithNewsmscode:(NSString *)newsmscode  andWithCaptcha:(NSString *)captcha andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;

@end
