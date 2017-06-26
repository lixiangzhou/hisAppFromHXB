                                                                                                                                                                                                                                  //
//  HXBSignUPAndLoginRequest.m
//  hoomxb
//
//  Created by HXB on 2017/5/31.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBSignUPAndLoginRequest.h"
#import "HXBSignUPAndLoginRequest_EnumManager.h"

#import "HXBTokenManager.h"///请求token
#import "HXBBaseRequest.h"//网络数据请求

@implementation HXBSignUPAndLoginRequest

+ (void)signUPRequetWithMobile: (NSString *)mobile///手机号
                    andSmscode: (NSString *)smscode///短信验证码
                   andPassword: (NSString *)password///密码
                 andInviteCode: (NSString *)inviteCode///邀请码
               andSuccessBlock: (void(^)())successBlock
               andFailureBlock: (void(^)(NSError *error))failureBlock {
    HXBBaseRequest *signUPAPI = [[HXBBaseRequest alloc]init];
    signUPAPI.requestMethod = NYRequestMethodPost;
    signUPAPI.requestUrl = kHXBUser_SignUPURL;
    if (!inviteCode) inviteCode = @"";
    
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
    HXBBaseRequest *loginAPI = [[HXBBaseRequest alloc]init];
    loginAPI.requestMethod = NYRequestMethodPost;
    loginAPI.requestUrl = kHXBUser_LoginURL;
    if (!captcha) captcha = @"";
    loginAPI.requestArgument = @{
                                 @"mobile" : mobile,///         是	string	用户名
                                 @"password" : password,///     是	string	密码
                                 @"captcha" : captcha,///       否	string	图验(只有在登录错误超过3次才需要输入图验)
                                 };
    
    [loginAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        kHXBResponsShowHUD;
        if (successBlock) {
            successBlock(true);
            
            [KeyChain setMobile:mobile];
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
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *URLSTR = [NSString stringWithFormat:@"%@%@",BASEURL,@"/captcha"];
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
    HXBBaseRequest *checkCaptchaAPI = [[HXBBaseRequest alloc]init];
    checkCaptchaAPI.requestUrl = kHXBUser_checkCaptchaURL;
    checkCaptchaAPI.requestMethod = NYRequestMethodPost;
    checkCaptchaAPI.requestArgument = @{
                                        @"captcha" : captcha///图验Code
                                        };
    [checkCaptchaAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        kHXBResponsShowHUD;
        if (successBlock) successBlock(true);
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
    HXBBaseRequest *smscodeAPI = [[HXBBaseRequest alloc]init];
    smscodeAPI.requestUrl = kHXBUser_smscodeURL;
    smscodeAPI.requestMethod = NYRequestMethodPost;
    NSString *actionStr = [HXBSignUPAndLoginRequest_EnumManager getKeyWithHXBSignUPAndLoginRequest_sendSmscodeType:action];
    smscodeAPI.requestArgument = @{
                                   @"mobile":mobile,///     是	string	用户名
                                   @"action":actionStr,///     是	string	signup(参照通用短信发送类型)
                                   @"captcha":captcha///	是	string	校验图片二维码
                                   };
    [smscodeAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
//        kHXBResponsShowHUD
        
        if (![[responseObject valueForKey:@"status"] isEqualToString:@"0"]) {
            
            kNetWorkError(@"发送短信 请求失败");
            [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
            if (failureBlock) failureBlock(responseObject);
            return;
        }
        
        if (successBlock) successBlock(true);
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        
        if (failureBlock) failureBlock(error);
        kNetWorkError(@"发送短信 请求失败");
    }];
}


#pragma mark - 注册校验手机号
+ (void)checkMobileRequestWithMobile: (NSString *)mobile
                     andSuccessBlock: (void(^)(BOOL isExist))successBlock
                     andFailureBlock: (void(^)(NSError *error))failureBlock {
    
    HXBBaseRequest *checkMobileAPI = [[HXBBaseRequest alloc]init];
    checkMobileAPI.requestMethod = NYRequestMethodPost;
    checkMobileAPI.requestUrl = kHXBUser_CheckMobileURL;
    
    checkMobileAPI.requestArgument = @{
                                       @"mobile":mobile
                                       };
    NSLog(@"%@",[KeyChain token]);
    [checkMobileAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        
        kHXBResponsShowHUD
        NSString *status = [responseObject valueForKey:@"status"];
        if(successBlock) successBlock(!status.integerValue);
        
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) failureBlock(error);
        kNetWorkError(@"校验手机号 请求失败");
    }];
}

#pragma mark - 忘记密码校验手机号
+ (void)checkExistMobileRequestWithMobile: (NSString *)mobile
                     andSuccessBlock: (void(^)(BOOL isExist))successBlock
                     andFailureBlock: (void(^)(NSError *error))failureBlock {
    
    HXBBaseRequest *checkMobileAPI = [[HXBBaseRequest alloc]init];
    checkMobileAPI.requestMethod = NYRequestMethodPost;
    checkMobileAPI.requestUrl = kHXBUser_CheckExistMobileURL;
    
    checkMobileAPI.requestArgument = @{
                                       @"mobile":mobile
                                       };
    [checkMobileAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        kHXBResponsShowHUD
        NSString *status = [responseObject valueForKey:@"status"];
        if(successBlock) successBlock(!status.integerValue);
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) failureBlock(error);
        kNetWorkError(@"校验手机号 请求失败");
    }];
}

#pragma mark - 实名认证
+ (void)realnameRequestWithUserName: (NSString *)userName
                    andIdentityCard: (NSString *)identityCard
                        andPassword: (NSString *)password
                    andSuccessBlock: (void(^)(BOOL isExist))successBlock
                    andFailureBlock: (void(^)(NSError *error))failureBlock {
    
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
        kHXBResponsShowHUD
        if (successBlock) {
            successBlock(true);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) failureBlock(nil);
        [HxbHUDProgress showTextWithMessage:@"实名认证 请求失败"];
         kNetWorkError(@"实名认证 请求失败")
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
