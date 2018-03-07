//
//  HXBSendSmscodeVCViewModel.m
//  hoomxb
//
//  Created by HXB-C on 2018/2/27.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBSendSmscodeVCViewModel.h"
#import "HXBOpenDepositAccountAgent.h"

@implementation HXBSendSmscodeVCViewModel

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


- (void)signUPRequetWithMobile: (NSString *)mobile smscode: (NSString *)smscode password: (NSString *)password inviteCode: (NSString *)inviteCode resultBlock:(void (^)(BOOL isSuccess))resultBlock
{
    NYBaseRequest *signUPAPI = [[NYBaseRequest alloc]initWithDelegate:self];
    signUPAPI.requestMethod = NYRequestMethodPost;
    signUPAPI.requestUrl = kHXBUser_SignUPURL;

    inviteCode = inviteCode ? inviteCode : @"";
    signUPAPI.requestArgument = @{
                                  @"mobile"    : mobile,///           是    string    手机号
                                  @"smscode" : smscode,///          是    string    短信验证码
                                  @"password" : password,///       是    string    密码
                                  @"inviteCode" : inviteCode,///    否    string    邀请码
                                  @"utmSource" : @"",///推广渠道
                                  @"marketSource" : @"ios"///市场来源
                                  };
    
    [signUPAPI loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
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
