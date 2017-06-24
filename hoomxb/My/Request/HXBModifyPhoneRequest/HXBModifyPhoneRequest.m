//
//  HXBModifyPhoneRequest.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/24.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBModifyPhoneRequest.h"
#import "HXBSignUPAndLoginRequest_EnumManager.h"
@implementation HXBModifyPhoneRequest


/**
 修改手机号

 @param newPhoneNumber 新的手机号码
 @param newsmscode 短信验证码
 @param captcha 图验
 */
- (void)mobifyPhoneNumberWithNewPhoneNumber:(NSString *)newPhoneNumber andWithNewsmscode:(NSString *)newsmscode  andWithCaptcha:(NSString *)captcha andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{
    NYBaseRequest *alterLoginPasswordAPI = [[NYBaseRequest alloc] init];
    alterLoginPasswordAPI.requestUrl = kHXBSetTransaction_MobifyPhoneNumber_CashMobileEditURL;
    alterLoginPasswordAPI.requestMethod = NYRequestMethodPost;
    alterLoginPasswordAPI.requestArgument = @{
                                              @"mobile" : newPhoneNumber,
                                              @"newsmscode" : newsmscode,
                                              @"captcha" : captcha,
                                              @"action" : kTypeKey_newmobile
                                              };
    [alterLoginPasswordAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
        NSInteger status =  [responseObject[@"status"] integerValue];
        if (status != 0) {
            [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
            if (failureBlock) {
                failureBlock(nil);
            }
            return;
        }
        if (successDateBlock) {
            successDateBlock(responseObject);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        [HxbHUDProgress showTextWithMessage:@"请求失败"];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}


@end
