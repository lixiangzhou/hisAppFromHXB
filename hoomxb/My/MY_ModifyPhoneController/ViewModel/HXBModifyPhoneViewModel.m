//
//  HXBModifyPhoneViewModel.m
//  hoomxb
//
//  Created by hxb on 2018/2/7.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBModifyPhoneViewModel.h"
#import "HXBSignUPAndLoginRequest_EnumManager.h"
@implementation HXBModifyPhoneViewModel

/**
 修改手机号
 
 @param newPhoneNumber 新的手机号码
 @param newsmscode 短信验证码
 @param captcha 图验
 */
- (void)mobifyPhoneNumberWithNewPhoneNumber:(NSString *)newPhoneNumber andWithNewsmscode:(NSString *)newsmscode  andWithCaptcha:(NSString *)captcha resultBlock: (void(^)(BOOL isSuccess))resultBlock
{
    kWeakSelf
    NYBaseRequest *alterLoginPasswordAPI = [[NYBaseRequest alloc] initWithDelegate:self];
    alterLoginPasswordAPI.requestUrl = kHXBSetTransaction_MobifyPhoneNumber_CashMobileEditURL;
    alterLoginPasswordAPI.requestMethod = NYRequestMethodPost;
    if (!(newPhoneNumber.length && newsmscode.length)) return;
    alterLoginPasswordAPI.requestArgument = @{
                                              @"mobile" : newPhoneNumber,
                                              @"newsmscode" : newsmscode,
                                              @"captcha" : captcha,
                                              @"action" : kTypeKey_newmobile
                                              };
    [alterLoginPasswordAPI loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {

        [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
        weakSelf.modifyPhoneModel = [HXBModifyPhoneModel yy_modelWithDictionary:responseObject[@"data"]];
        if (resultBlock) {
            resultBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) {
            resultBlock(NO);
        }
    }];
}

@end
