//
//  HXBSignUPAndLoginRequest.m
//  hoomxb
//
//  Created by HXB on 2017/5/31.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBSignUPAndLoginRequest.h"
#import "HXBSignUpAPI.h"///注册api
#import "HXBLoginAPI.h"///登录api
#import "HXBCaptchaAPI.h"///图验api
#import "HXBCheckCaptchaAPI.h"///校验图片验证码
#import "HXBSmscodeAPI.h"///发送短信的接口
#import "HXBCheckMobileAPI.h"///校验手机号


@implementation HXBSignUPAndLoginRequest
+ (void)signUPRequetWithMobile: (NSString *)mobile///手机号
                    andSmscode: (NSString *)smscode///短信验证码
                   andPassword: (NSString *)password///密码
                 andInviteCode: (NSString *)inviteCode///邀请码
               andSuccessBlock: (void(^)())successBlock
               andFailureBlock: (void(^)(NSError *error))failureBlock {
    HXBSignUpAPI *signUPAPI = [[HXBSignUpAPI alloc]init];
    signUPAPI.requestArgument = @{
                                  @"mobile"	: mobile,///           是	string	手机号
                                  @"smscode" : smscode,///	      是	string	短信验证码
                                  @"password" : password,///       是	string	密码
                                  @"inviteCode" : inviteCode///    否	string	邀请码
                                  };
    [signUPAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        if (successBlock) successBlock();
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) failureBlock(error);
        kNetWorkError(@"注册接口请求失败");
    }];
}



#pragma mark - 登录请求
+ (void)loginRequetWithfMobile: (NSString *)mobile
                   andPassword: (NSString *)password
                    andCaptcha: (NSString *)captcha
               andSuccessBlock: (void(^)(BOOL isSuccess))successBlock
               andFailureBlock: (void(^)(NSError *error))failureBlock {
    HXBLoginAPI *loginAPI = [[HXBLoginAPI alloc]init];
    if (captcha) {
        loginAPI.requestArgument = @{
                                     @"mobile" : mobile,///         是	string	用户名
                                     @"password" : password,///     是	string	密码
                                     @"captcha" : captcha,///       否	string	图验(只有在登录错误超过3次才需要输入图验)
                                     };
    }else {
        loginAPI.requestArgument = @{
                                     @"mobile" : mobile,///         是	string	用户名
                                     @"password" : password,///     是	string	密码
                                     };
    }
    
  [loginAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
      if (![responseObject valueForKey:@"status"]) {
          kNetWorkError(@"登录请求失败");
          if (failureBlock) {
              failureBlock(nil);
          }
      }
      if (successBlock) {
          successBlock(true);
      }
  } failure:^(NYBaseRequest *request, NSError *error) {
      if (failureBlock) {
          failureBlock(error);
      }
      kNetWorkError(@"登录请求失败");
  }];
}

#pragma mark - 图验
+ (void)captchaRequestWithSuccessBlock: (void(^)(id responseObject))successBlock
                       andFailureBlock: (void(^)(NSError *error))failureBlock {
    HXBCaptchaAPI *captchaAPI = [[HXBCaptchaAPI alloc]init];
  [captchaAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
      if (![responseObject valueForKey:@"status"]) {
          kNetWorkError(@"图验请求失败");
          if (failureBlock) {
              failureBlock(nil);
          }
      }
      if (successBlock) {
          successBlock(responseObject);
      }
  } failure:^(NYBaseRequest *request, NSError *error) {
      if (failureBlock) {
          failureBlock(error);
      }
      kNetWorkError(@"图验请求失败");
  }];
}


#pragma mark - 校验图片验证码
+ (void)checkCaptcharRequestWithCaptcha: (NSString *)captcha
                        andSuccessBlock: (void(^)(BOOL isSuccessBlock))successBlock
                        andFailureBlock: (void(^)(NSError *error))failureBlock{
    HXBCheckCaptchaAPI *checkCaptchaAPI = [[HXBCheckCaptchaAPI alloc]init];
    checkCaptchaAPI.requestArgument = @{
                                        @"captcha" : captcha///图验Code
                                        };
    [checkCaptchaAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        if (![responseObject valueForKey:@"status"]) {
            kNetWorkError(@"校验图片验证码请求失败");
            if (failureBlock) failureBlock(nil);
        }
        
        if (successBlock) successBlock(true);
    } failure:^(NYBaseRequest *request, NSError *error) {
        
        if (failureBlock) failureBlock(error);
        kNetWorkError(@"校验图片验证码请求失败");
    }];
}


#pragma mark - 发送短信接口
+ (void)smscodeRequestWithMobile: (NSString *)mobile
                       andAction: (NSString *)action
                      andCaptcha: (NSString *)captcha
                 andSuccessBlock: (void(^)(BOOL isSuccessBlock))successBlock
                 andFailureBlock: (void(^)(NSError *error))failureBlock{
    HXBSmscodeAPI *smscodeAPI = [[HXBSmscodeAPI alloc]init];
    smscodeAPI.requestArgument = @{
                                   @"mobile":mobile,///     是	string	用户名
                                   @"action":action,///     是	string	signup(参照通用短信发送类型)
                                   @"captcha":captcha///	是	string	校验图片二维码
                                   };
    [smscodeAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        
        if (![responseObject valueForKey:@"status"]) {
            kNetWorkError(@"发送短信 请求失败");
            if (failureBlock) failureBlock(nil);
        }
        
        if (successBlock) successBlock(true);
        
    } failure:^(NYBaseRequest *request, NSError *error) {
       
        if (failureBlock) failureBlock(error);
        kNetWorkError(@"发送短信 请求失败");
    }];
}


#pragma mark - 校验手机号
+ (void)checkMobileRequestWithMobile: (NSString *)mobile
                     andSuccessBlock: (void(^)(BOOL isSuccessBlock))successBlock
                     andFailureBlock: (void(^)(NSError *error))failureBlock {
    
    HXBCheckCaptchaAPI *checkCaptchaAPI = [[HXBCheckCaptchaAPI alloc]init];
    [checkCaptchaAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        if (![responseObject valueForKey:@"status"]) {
            kNetWorkError(@"校验手机号 请求失败");
            if (failureBlock) failureBlock(nil);
        }
        if (successBlock) successBlock(true);
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) failureBlock(error);
        kNetWorkError(@"校验手机号 请求失败");
    }];
}
@end
