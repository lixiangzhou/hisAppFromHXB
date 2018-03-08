//
//  HXBSign_InAndUPViewModel.m
//  hoomxb
//
//  Created by HXB on 2017/5/31.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBSignUPViewModel.h"
#import "HXBOpenDepositAccountAgent.h"
#import "HXBSignUPAndLoginAgent.h"

@implementation HXBSignUPViewModel

- (BOOL)erroStateCodeDeal:(NYBaseRequest *)request {
    if ([request.requestUrl isEqualToString:kHXBUser_CheckMobileURL]
        || [request.requestUrl isEqualToString:kHXBUser_CheckMobileURL]) {
        return NO;
    }
    return [super erroStateCodeDeal:request];
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

- (void)checkMobileRequestWithMobile: (NSString *)mobile resultBlock:(void(^)(BOOL isSuccess, NSString *message))resultBlock
{
    NYBaseRequest *checkMobileAPI = [[NYBaseRequest alloc]initWithDelegate:self];
    checkMobileAPI.requestMethod = NYRequestMethodPost;
    checkMobileAPI.requestUrl = kHXBUser_CheckMobileURL;
    
    checkMobileAPI.requestArgument = @{
                                       @"mobile":mobile
                                    };
    kWeakSelf
    [checkMobileAPI loadData:^(NYBaseRequest *request, id responseObject) {
        if (resultBlock) {
            resultBlock(YES, nil);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        NSDictionary *resObj = request.responseObject;
        NSString *msg = nil;
        if (resObj) {
            if (resObj.statusCode == kHXBCode_Enum_CommonError) {
                NSString *message = [resObj.message isEqualToString:@"手机号码已存在"] ? @"该手机号已注册" : resObj.message;
                [weakSelf showToast:message];
            } else if (resObj.statusCode == kHXBCode_Enum_ProcessingField) {
                msg = @"请输入正确的手机号码";
            }
        }
        
        if (resultBlock) {
            resultBlock(NO, msg);
        }
    }];
    
}

- (void)checkMobileRequestHUDWithMobile:(NSString *)mobile resultBlock:(void(^)(BOOL isSuccess))resultBlock {
    NYBaseRequest *checkMobileAPI = [[NYBaseRequest alloc]initWithDelegate:self];
    checkMobileAPI.requestMethod = NYRequestMethodPost;
    checkMobileAPI.requestUrl = kHXBUser_CheckMobileURL;
    
    checkMobileAPI.requestArgument = @{
                                       @"mobile":mobile
                                       };
    checkMobileAPI.showHud = YES;
    checkMobileAPI.hudShowContent = kLoadIngText;
    
    kWeakSelf
    [checkMobileAPI loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        if (resultBlock) {
            resultBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        NSDictionary *respObj = request.responseObject;
        if (respObj) {
            if (respObj.statusCode == kHXBCode_Enum_CommonError) {
                NSString *message = [respObj.message isEqualToString:@"手机号码已存在"] ? @"该手机号已注册" : respObj.message;
                [weakSelf showToast:message];
            }
        }
        if (resultBlock) {
            resultBlock(NO);
        }
    }];
}

- (void)checkExistMobile:(NSString *)mobile resultBlock:(void (^)(BOOL))resultBlock
{
    kWeakSelf
    [HXBSignUPAndLoginAgent checkExistMobileRequest:^(NYBaseRequest *request) {
        request.hudDelegate = weakSelf;
    } mobile:mobile resultBlock:^(BOOL isSuccess, NYBaseRequest *request) {
        if (isSuccess == NO) {
            NSDictionary *respObj = request.responseObject;
            if (respObj) {
                if (respObj.statusCode == kHXBCode_Enum_CommonError) {
                    NSString *message = [respObj.message isEqualToString:@"手机号码已存在"] ? @"该手机号已注册" : respObj.message;
                    [weakSelf showToast:message];
                }
            }
        }
        if (resultBlock) {
            resultBlock(isSuccess);
        }
    }];
}
@end
