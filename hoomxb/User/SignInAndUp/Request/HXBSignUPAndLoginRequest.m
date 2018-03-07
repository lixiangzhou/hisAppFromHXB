//
//  HXBSignUPAndLoginRequest.m
//  hoomxb
//
//  Created by HXB on 2017/5/31.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBSignUPAndLoginRequest.h"
#import "HXBSignUPAndLoginRequest_EnumManager.h"

#import "HXBTokenManager.h"///请求token
#import "HXBBaseRequest.h"//网络数据请求
#import "NSDate+HXB.h"
#import "HXBBaseUrlManager.h"

@implementation HXBSignUPAndLoginRequest

#pragma mark - 注册校验手机号有HUD展示
+ (void)checkMobileRequestHUDWithMobile: (NSString *)mobile
                     andSuccessBlock: (void(^)(BOOL isExist,NSString *message))successBlock
                     andFailureBlock: (void(^)(NSError *error))failureBlock {
    
    
    NYBaseRequest *checkMobileAPI = [[NYBaseRequest alloc]init];
    checkMobileAPI.requestMethod = NYRequestMethodPost;
    checkMobileAPI.requestUrl = kHXBUser_CheckMobileURL;
    
    checkMobileAPI.requestArgument = @{
                                       @"mobile":mobile
                                       };
    NSLog(@"%@",[KeyChain token]);
    [checkMobileAPI startWithHUDStr:kLoadIngText Success:^(NYBaseRequest *request, id responseObject) {
        NSString *status = [responseObject valueForKey:@"status"];
        NSString *message = @"";
        if (status.integerValue == kHXBCode_Enum_CommonError) {
            NSString *message = [responseObject[@"message"] isEqualToString:@"手机号码已存在"] ? @"该手机号已注册" : responseObject[@"message"];
            [HxbHUDProgress showTextWithMessage:message];
        }
        if (status.integerValue == kHXBCode_Enum_ProcessingField) {
            message = @"请输入正确的手机号码";
        }
        if(successBlock) successBlock(!status.integerValue,message);
        
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) failureBlock(error);
    }];
}

#pragma mark - 忘记密码校验手机号
+ (void)checkExistMobileRequestWithMobile: (NSString *)mobile
                     andSuccessBlock: (void(^)(BOOL isExist))successBlock
                     andFailureBlock: (void(^)(NSError *error, NYBaseRequest *request))failureBlock {
    
    NYBaseRequest *checkMobileAPI = [[NYBaseRequest alloc]init];
    checkMobileAPI.requestMethod = NYRequestMethodPost;
    checkMobileAPI.requestUrl = kHXBUser_CheckExistMobileURL;
    checkMobileAPI.requestArgument = @{
                                       @"mobile":mobile
                                       };
    [checkMobileAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSString *status = [responseObject valueForKey:@"status"];
        if (status.integerValue == kHXBCode_Enum_CommonError) {
            NSString *message = [responseObject[@"message"] isEqualToString:@"手机号码已存在"] ? @"该手机号已注册" : responseObject[@"message"];
            [HxbHUDProgress showTextWithMessage:message];
        }
        if(successBlock) successBlock(!status.integerValue);
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) failureBlock(error,nil);
        kNetWorkError(@"校验手机号 请求失败");
    }];
}

#pragma mark - 实名认证
+ (void)realnameRequestWithUserName: (NSString *)userName
                    andIdentityCard: (NSString *)identityCard
                        andPassword: (NSString *)password
                    andSuccessBlock: (void(^)(BOOL isExist))successBlock
                    andFailureBlock: (void(^)(NSError *error,NYBaseRequest *request))failureBlock {
    
    NYBaseRequest *realnameApi = [[NYBaseRequest alloc]init];
    realnameApi.requestUrl = kHXBUser_realnameURL;
    realnameApi.requestMethod = NYRequestMethodPost;
    realnameApi.requestArgument = @{
                                    @"name" : userName,
                                    @"idCardNo" : identityCard,
                                    @"tradpwd" : password
                                    };
    [realnameApi startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        ///判断是否成功
        kHXBRespons_returnVCError
        if (successBlock) {
            successBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) failureBlock(error,nil);
    }];
    
}

#pragma mark - 忘记密码
+ (void)forgotPasswordRequestWithMobile: (NSString *)mobile
                             andSmscode: (NSString *)smscode
                             andCaptcha: (NSString *)captcha
                            andPassword: (NSString *)password
                        andSuccessBlock: (void(^)(BOOL isExist))successBlock
                        andFailureBlock: (void(^)(NSError *error))failureBlock {
    HXBBaseRequest *forgotPasswordAPI = [[HXBBaseRequest alloc]init];
    forgotPasswordAPI.requestUrl = HXBAccount_ForgotPasswordURL;
    forgotPasswordAPI.requestArgument = @{
                                          @"mobile" : mobile,
                                          @"smscode" : smscode,
                                          @"captcha" : captcha,
                                          @"password" : password
                                          };
    forgotPasswordAPI.requestMethod = NYRequestMethodPost;
    
    [forgotPasswordAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        kHXBResponsShowHUD
        if(successBlock) successBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        if(failureBlock) failureBlock(error);
        NSLog(@"%@",error);
    }];
}
@end
