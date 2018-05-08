//
//  HXBSignInViewModel.m
//  hoomxb
//
//  Created by lxz on 2018/3/7.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBSignInViewModel.h"
#import "HXBSignUPAndLoginAgent.h"

@implementation HXBSignInViewModel

- (BOOL)erroStateCodeDeal:(NYBaseRequest *)request {
    if ([request.requestUrl isEqualToString:kHXBUser_LoginURL]
        || [request.requestUrl isEqualToString:kHXBUser_CheckExistMobileURL]) {
        return NO;
    }
    return [super erroStateCodeDeal:request];
}

- (void)loginRequetWithMobile:(NSString *)mobile password:(NSString *)password captcha:(NSString *)captcha resultBlock:(void (^)(BOOL, BOOL))resultBlock
{
    NYBaseRequest *loginAPI = [[NYBaseRequest alloc]initWithDelegate:self];
    loginAPI.requestMethod = NYRequestMethodPost;
    loginAPI.requestUrl = kHXBUser_LoginURL;
    loginAPI.showHud = YES;
    
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
            resultBlock(NO, NO);
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
