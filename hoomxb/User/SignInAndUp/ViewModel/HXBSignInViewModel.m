//
//  HXBSignInViewModel.m
//  hoomxb
//
//  Created by lxz on 2018/3/7.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBSignInViewModel.h"

@implementation HXBSignInViewModel

- (BOOL)erroStateCodeDeal:(NYBaseRequest *)request {
    if ([request.requestUrl isEqualToString:kHXBUser_LoginURL]) {
        return NO;
    }
    return [super erroStateCodeDeal:request];
}

- (void)loginRequetWithMobile:(NSString *)mobile password:(NSString *)password captcha:(NSString *)captcha resultBlock:(void (^)(BOOL, BOOL))resultBlock
{
    HXBBaseRequest *loginAPI = [[HXBBaseRequest alloc]initWithDelegate:self];
    loginAPI.requestMethod = NYRequestMethodPost;
    loginAPI.requestUrl = kHXBUser_LoginURL;
    if (!captcha) captcha = @"";
    loginAPI.requestArgument = @{
                                 @"mobile" : mobile,///         是    string    用户名
                                 @"password" : password,///     是    string    密码
                                 @"captcha" : captcha,///       否    string    图验(只有在登录错误超过3次才需要输入图验)
                                 };

    [loginAPI loadData:^(NYBaseRequest *request, id responseObject) {
        if ((![mobile isEqualToString:KeyChain.mobile]) && KeyChain.mobile) {
            [KeyChain removeGesture];
            KeyChain.skipGesture = nil;
            KeyChain.skipGestureAlertAppeared = NO;
        }
        KeyChain.gesturePwdCount = @"5";
        KeyChain.mobile = mobile;
        
        if (resultBlock) {
            resultBlock(YES, NO);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        NSDictionary *resObj = request.responseObject;
        if (resObj) {
            if (resObj.statusCode != kHXBCode_Enum_Captcha) {
                [self showToast:resObj.message];
                resultBlock(NO, NO);
            } else {
                resultBlock(NO, YES);
            }
        } else {
            [self showToast:@"登录请求失败"];
            resultBlock(NO, NO);
        }
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
