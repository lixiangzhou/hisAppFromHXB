    //
//  NYNetworkManager+DefaultMethod.m
//  NYNetwork
//
//  Created by 牛严 on 16/6/30.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import "NYNetworkManager+DefaultMethod.h"
#import "HXBBaseRequest.h"
NSString *const RequestSuccess = @"RequestSuccess";
NSString *const RequestFailure = @"RequestFailure";
NSString *const LoginVCDismiss = @"LoginVCDismiss";


@implementation NYNetworkManager (DefaultMethod)

- (void)defaultMethodRequestSuccessWithRequest:(NYBaseRequest *)request
{
    NSLog(@"======================👌👌 开始 👌👌====================================");
    NSLog(@"👌👌URL: %@,  Code =>%ld  ",request.requestUrl,(long)request.responseStatusCode);
    NSLog(@"👌👌请求 体 ----- %@",request.requestArgument);
    NSLog(@"👌👌相应 体 ------%@",request.responseObject);
    NSLog(@"======================👌👌 结束 👌👌====================================");
    
    switch ([request.responseObject[kResponseStatus] integerValue]) {
        case kHXBCode_Enum_Captcha://弹出图验、
//            [[NSNotificationCenter defaultCenter] postNotificationName:kHXBBotification_ShowCaptchaVC object:nil];
            break;
        case kHXBCode_Enum_NotSigin:///没有登录{
            KeyChain.isLogin = false;
            break;
        case kHXBCode_Enum_TokenNotJurisdiction://没有权限
            KeyChain.isLogin = false;
            break;
    }
//    DLog(@"请求成功-request：%@",request);
    if ([request.responseObject[kResponseStatus] integerValue]) {
        NSLog(@" ---------- %@",request.responseObject[kResponseStatus]);
        ///未登录状态 弹出登录框
    }else{
        if([request isKindOfClass:[HXBBaseRequest class]]) {
            HXBBaseRequest *requestHxb = (HXBBaseRequest *)request;
            if (request.responseObject[kResponseData][@"dataList"]) {
                [self addRequestPage:requestHxb];
            }
        }
    }
}


#pragma mark - 请求失败
- (void)defaultMethodRequestFaulureWithRequest:(NYBaseRequest *)request
{
    NSLog(@"===================🌶🌶 开始 🌶🌶=====================================");
    NSLog(@"🌶🌶URL: %@,  Code =>%ld  ",request.requestUrl,(long)request.responseStatusCode);
    NSLog(@"🌶🌶请求 体 ----- %@",request.requestArgument);
    NSLog(@"🌶🌶相应 体 ------%@",request.responseObject);
    NSLog(@"======================🌶🌶 结束 🌶🌶====================================");
    
    
    switch (request.responseStatusCode) {
        case kHXBCode_Enum_NotSigin:///没有登录
            if (KeyChain.isLogin) {
                //弹出是否 登录
//                [[KeyChainManage sharedInstance] signOut];
                UITabBarController *tbVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                UINavigationController *NAV = tbVC.selectedViewController;
                UIViewController *VC = NAV.viewControllers.lastObject;
                [HXBAlertManager alertManager_loginAgainAlertWithView:VC.view];
            }
//            [[KeyChainManage sharedInstance] removeAllInfo];
            break;
        case kHXBCode_Enum_TokenNotJurisdiction://没有权限
            /**
             先判断是否为登录状态，如果是，就登出，不是，就显示页面权限
             */
            if (KeyChain.isLogin) {
                UITabBarController *tbVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                UINavigationController *NAV = tbVC.selectedViewController;
                UIViewController *VC = NAV.viewControllers.lastObject;
                [HXBAlertManager alertManager_loginAgainAlertWithView:VC.view];
            }
            break;
        default:
            break;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:RequestFailure object:nil userInfo:nil];
}


#pragma mark - 请求成功，
//MARK: status != 0
//未登录状态 弹出登录框 status 为1 message 为@“请登录后操作”
- (void) showLoginVCWithRequest: (NYBaseRequest *)request {
    if ([request.responseObject[kResponseMessage] isEqualToString:@"请登录后操作"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
    }
}

//MARK: status == 0
//page++
- (void) addRequestPage: (HXBBaseRequest *)request {
    request.dataPage ++;
    NSLog(@"%ld",(long)request.dataPage);
}
@end
