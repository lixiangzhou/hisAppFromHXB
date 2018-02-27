//
//  HXBModifyPhoneViewModel.m
//  hoomxb
//
//  Created by hxb on 2018/2/7.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBModifyPhoneViewModel.h"
#import "HXBSignUPAndLoginRequest_EnumManager.h"
#import "HXBOpenDepositAccountAgent.h"
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

/**
 获取充值短验
 @param mobile 手机号
 @param action 获取短信的事件
 @param captcha 图验(只有在登录错误超过3次才需要输入图验)
 @param callbackBlock 请求回调
 */
- (void)getVerifyCodeRequesWithMobile: (NSString *)mobile
                            andAction: (HXBSignUPAndLoginRequest_sendSmscodeType)action
                           andCaptcha: (NSString *)captcha
                              andType: (NSString *)type
                     andCallbackBlock: (void(^)(BOOL isSuccess,NSError *error))callbackBlock {
    kWeakSelf
    [HXBOpenDepositAccountAgent verifyCodeRequestWithResultBlock:^(NYBaseRequest *request) {
        NSString *actionStr = [HXBSignUPAndLoginRequest_EnumManager getKeyWithHXBSignUPAndLoginRequest_sendSmscodeType:action];
        request.requestArgument = @{
                                    @"mobile":mobile ?: @"",///     是    string    用户名
                                    @"action":actionStr ?: @"",///     是    string    signup(参照通用短信发送类型)
                                    @"captcha":captcha ?: @"",///    是    string    校验图片二维码
                                    @"type":type ?: @""
                                    };
        request.hudDelegate = weakSelf;
        request.showHud = YES;
    } resultBlock:^(id responseObject, NSError *error) {
        if (error) {
            callbackBlock(NO,error);
        }
        else {
            callbackBlock(YES,nil);
        }
    }];
}

@end
