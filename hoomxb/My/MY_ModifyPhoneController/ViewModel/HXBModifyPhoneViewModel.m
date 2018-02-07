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
- (void)mobifyPhoneNumberWithNewPhoneNumber:(NSString *)newPhoneNumber andWithNewsmscode:(NSString *)newsmscode  andWithCaptcha:(NSString *)captcha andSuccessBlock: (void(^)(BOOL isSuccess))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{
    kWeakSelf
    NYBaseRequest *alterLoginPasswordAPI = [[NYBaseRequest alloc] init];
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
        NSLog(@"%@",responseObject);
        NSInteger status =  [responseObject[@"status"] integerValue];
        [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
        if (!status) {
            weakSelf.modifyPhoneModel = [HXBModifyPhoneModel yy_modelWithDictionary:responseObject[@"data"]];
            successDateBlock(YES);
        }
        if (successDateBlock) {
            successDateBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

@end
