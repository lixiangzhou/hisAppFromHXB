//
//  HXBSignUPAndLoginAgent.m
//  hoomxb
//
//  Created by lxz on 2018/3/7.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBSignUPAndLoginAgent.h"

@implementation HXBSignUPAndLoginAgent

+ (void)loginRequet:(void (^)(NYBaseRequest *request))requestBlock withMobile:(NSString *)mobile password:(NSString *)password captcha:(NSString *)captcha resultBlock:(void (^)(BOOL))resultBlock
{
    NYBaseRequest *loginAPI = [[NYBaseRequest alloc]init];
    loginAPI.requestMethod = NYRequestMethodPost;
    loginAPI.requestUrl = kHXBUser_LoginURL;
    if (!captcha) captcha = @"";
    loginAPI.requestArgument = @{
                                 @"mobile" : mobile,///         是    string    用户名
                                 @"password" : password,///     是    string    密码
                                 @"captcha" : captcha,///       否    string    图验(只有在登录错误超过3次才需要输入图验)
                                 };
    if (requestBlock) {
        requestBlock(loginAPI);
    }
    
    [loginAPI loadData:^(NYBaseRequest *request, id responseObject) {

        if ((![mobile isEqualToString:KeyChain.mobile]) && KeyChain.mobile) {
            [KeyChain removeGesture];
            KeyChain.skipGesture = nil;
            KeyChain.skipGestureAlertAppeared = NO;
        }
        KeyChain.gesturePwdCount = @"5";
        KeyChain.mobile = mobile;

        if (resultBlock) {
            resultBlock(YES);
        }
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        
    }];
    
//    [loginAPI loadData:^(NYBaseRequest *request, id responseObject) {
//        //        kHXBResponsShowHUD;
//        if ([responseObject[kResponseStatus] integerValue]) {
//            if ([responseObject[kResponseStatus] integerValue] != kHXBCode_Enum_Captcha) {
//                [HxbHUDProgress showTextWithMessage:responseObject[kResponseMessage]];
//            }
//            if (failureBlock) {
//                failureBlock(nil,responseObject);
//            }
//            return;
//        }
//        if (successBlock) {
//            successBlock(YES);
//            if ((![mobile isEqualToString:KeyChain.mobile]) && KeyChain.mobile) {
//                [KeyChain removeGesture];
//                KeyChain.skipGesture = nil;
//                KeyChain.skipGestureAlertAppeared = NO;
//            }
//            KeyChain.gesturePwdCount = @"5";
//            KeyChain.mobile = mobile;
//        }
//    } failure:^(NYBaseRequest *request, NSError *error) {
//        if (failureBlock) {
//            failureBlock(error,nil);
//        }
//        kNetWorkError(@"登录请求失败");
//    }];
}

@end
