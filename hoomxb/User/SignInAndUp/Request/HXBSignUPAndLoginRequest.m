//
//  HXBSignUPAndLoginRequest.m
//  hoomxb
//
//  Created by HXB on 2017/5/31.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBSignUPAndLoginRequest.h"
#import "HXBSignUPAndLoginRequest_EnumManager.h"
#import "HXBSignUpAPI.h"///注册api
#import "HXBLoginAPI.h"///登录api
#import "HXBCaptchaAPI.h"///图验api
#import "HXBCheckCaptchaAPI.h"///校验图片验证码
#import "HXBSmscodeAPI.h"///发送短信的接口
#import "HXBCheckMobileAPI.h"///校验手机号
#import "HXBTokenManager.h"///请求token
#import "HXBRealnameAPI.h"///安全认证的API


@implementation HXBSignUPAndLoginRequest
+ (void)signUPRequetWithMobile: (NSString *)mobile///手机号
                    andSmscode: (NSString *)smscode///短信验证码
                   andPassword: (NSString *)password///密码
                 andInviteCode: (NSString *)inviteCode///邀请码
               andSuccessBlock: (void(^)())successBlock
               andFailureBlock: (void(^)(NSError *error))failureBlock {
    HXBSignUpAPI *signUPAPI = [[HXBSignUpAPI alloc]init];
    if (!inviteCode) {
        inviteCode = @"";
    }
    signUPAPI.requestArgument = @{
                                  @"mobile"	: mobile,///           是	string	手机号
                                  @"smscode" : smscode,///	      是	string	短信验证码
                                  @"password" : password,///       是	string	密码
                                  @"inviteCode" : inviteCode///    否	string	邀请码
                                  };
    [signUPAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        kHXBResponsShowHUD;
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
        if ([responseObject valueForKey:@"status"]) {
            NSLog(@"%@",responseObject);
            if (failureBlock) {
                failureBlock(nil);
                [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
            }
            return;
        }
        if (successBlock) {
            successBlock(true);
            KeyChain.phone = mobile;
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
        kNetWorkError(@"登录请求失败");
    }];
}

#pragma mark - 图验
- (void)captchaRequestWithSuccessBlock: (void(^)(id responseObject))successBlock
                       andFailureBlock: (void(^)(NSError *error))failureBlock {
    
    HXBCaptchaAPI *captchaAPI = [[HXBCaptchaAPI alloc]init];
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *URLSTR = [NSString stringWithFormat:@"%@%@",BASEURL,captchaAPI.requestUrl];
    NSURL *url = [NSURL URLWithString:URLSTR];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSMutableURLRequest *requestM = [request mutableCopy];
    //配置userAgent
    NSString *systemVision = [[UIDevice currentDevice] systemVersion];
    NSString *version = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    NSString *userAgent = [NSString stringWithFormat:@"iphone/%@/%@" ,systemVision,version];
    [requestM addValue:userAgent forHTTPHeaderField:@"User-Agent"];
    requestM.HTTPMethod = @"GET";
    //配置token
    [requestM addValue:KeyChain.token forHTTPHeaderField: kHXBToken_X_HxbAuth_Token];
    ///创建请求
    NSURLSessionTask *task = [session dataTaskWithRequest:requestM.copy completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *image = [UIImage imageWithData:data];
                if (successBlock) successBlock(image);
            });
        }else if(error) {
            ///请求token
            [HXBTokenManager downLoadTokenWithURL:nil andDownLoadTokenSucceedBlock:^(NSString *token) {
                ///在请求一次
                ///添加token
                [requestM addValue:kHXBToken_X_HxbAuth_Token forHTTPHeaderField: KeyChain.token];
                NSURLSessionTask *task = [session dataTaskWithRequest:requestM.copy completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    if (data) {
                        //NSData *imageData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            UIImage *image = [UIImage imageWithData:data];
                            if (successBlock) successBlock(image);
                        });
                    }
                }];
                [task resume];
            } andFailureBlock:^(NSError *error) {
                
            }];
        }
    }];
    [task resume];
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
        NSString *status = [responseObject valueForKey:@"status"];
        if (status.integerValue) {
            kNetWorkError(@"验证码 输入错误");
            if (failureBlock) failureBlock(nil);
        }else {
            if (successBlock) successBlock(true);
        }
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        
        if (failureBlock) failureBlock(error);
        kNetWorkError(@"校验图片验证码请求失败");
    }];
}


#pragma mark - 发送短信接口
+ (void)smscodeRequestWithMobile: (NSString *)mobile
                       andAction: (HXBSignUPAndLoginRequest_sendSmscodeType)action
                      andCaptcha: (NSString *)captcha
                 andSuccessBlock: (void(^)(BOOL isSuccessBlock))successBlock
                 andFailureBlock: (void(^)(NSError *error))failureBlock{
    HXBSmscodeAPI *smscodeAPI = [[HXBSmscodeAPI alloc]init];
    NSString *actionStr = [HXBSignUPAndLoginRequest_EnumManager getKeyWithHXBSignUPAndLoginRequest_sendSmscodeType:action];
    smscodeAPI.requestArgument = @{
                                   @"mobile":mobile,///     是	string	用户名
                                   @"action":actionStr,///     是	string	signup(参照通用短信发送类型)
                                   @"captcha":captcha///	是	string	校验图片二维码
                                   };
    [smscodeAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        
        if ([responseObject valueForKey:@"status"]) {
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
                     andSuccessBlock: (void(^)(BOOL isExist))successBlock
                     andFailureBlock: (void(^)(NSError *error))failureBlock {
    
    HXBCheckMobileAPI *checkMobileAPI = [[HXBCheckMobileAPI alloc]init];
    
    
    
    checkMobileAPI.requestArgument = @{
                                       @"mobile":mobile
                                       };
    [checkMobileAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSString *status = [responseObject valueForKey:@"status"];
        if (status.integerValue) {
            if (failureBlock) failureBlock(nil);
            return;
        }
        
        NSString *message = [responseObject valueForKey:@"message"];
        if ([message isEqualToString:@"手机号码已存在"]) {
            successBlock(true);
            return;
        }
        successBlock(false);
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) failureBlock(error);
        kNetWorkError(@"校验手机号 请求失败");
    }];
}

#pragma mark - 安全认证
+ (void)realnameRequestWithUserName: (NSString *)userName
                    andIdentityCard: (NSString *)identityCard
                        andPassword: (NSString *)password
                    andSuccessBlock: (void(^)(BOOL isExist))successBlock
                    andFailureBlock: (void(^)(NSError *error))failureBlock {
    
    NYBaseRequest *realnameApi = [[HXBRealnameAPI alloc]init];
    realnameApi.baseUrl = @"/user/realname";
    realnameApi.requestMethod = NYRequestMethodPost;
    realnameApi.requestArgument = @{
                                    @"userName" : userName,
                                    @"identityCard" : identityCard,
                                    @"password" : password
                                    };
    [realnameApi startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        ///判断是否成功
        kHXBResponsShowHUD
        if (successBlock) {
            successBlock(true);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) failureBlock(nil);
         kNetWorkError(@"安全认证 请求失败")
    }];
    
}

#pragma mark - 忘记密码
+ (void)forgotPasswordRequestWithMobile: (NSString *)mobile
                             andSmscode: (NSString *)smscode
                             andCaptcha: (NSString *)captcha
                            andPassword: (NSString *)password
                        andSuccessBlock: (void(^)(BOOL isExist))successBlock
                        andFailureBlock: (void(^)(NSError *error))failureBlock {
    NYBaseRequest *forgotPasswordAPI = [[NYBaseRequest alloc]init];
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
        if(successBlock) successBlock(true);
        NSLog(@"%@",responseObject);
    } failure:^(NYBaseRequest *request, NSError *error) {
        if(failureBlock) failureBlock(error);
        NSLog(@"%@",error);
    }];
}

@end
