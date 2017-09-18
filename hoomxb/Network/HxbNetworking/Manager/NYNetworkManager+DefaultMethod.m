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
    
    if ([request.responseObject[@"code"]  isEqual: @"ESOCKETTIMEDOUT"]) {
        [HxbHUDProgress showTextWithMessage:@"请求超时,请稍后重试"];
    }
    
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
        NSString *status = request.responseObject[kResponseStatus];
        if (status.integerValue == 104) {
            NSDictionary *dic = request.responseObject[kResponseData];
            __block NSString *error = @"";
            [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                NSArray *arr = obj;
                error = arr[0];
//                NSLog(@"%@",obj);
//                if (!(error.length > 0)) {
//                    
//                }
            }];
            [HxbHUDProgress showTextWithMessage:error];
        }
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
        case kHXBCode_Enum_TokenNotJurisdiction://没有权限
            if (KeyChain.isLogin) {
                //弹出是否 登录
//                [[KeyChainManage sharedInstance] signOut];
                if ([[UIApplication sharedApplication].keyWindow.rootViewController isKindOfClass:NSClassFromString(@"UITabBarController")]) {
                    UITabBarController *tbVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                    UINavigationController *NAV = tbVC.selectedViewController;
                    UIViewController *VC = NAV.viewControllers.lastObject;
                    [HXBAlertManager alertManager_loginAgainAlertWithView:VC.view];
                }
            }
//            [[KeyChainManage sharedInstance] removeAllInfo];
            break;
       
            /**
             先判断是否为登录状态，如果是，就登出，不是，就显示页面权限
             */
            //跳转登录注册
//            [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
//            break;
            
            case kHXBCode_Enum_RequestOverrun:
        {
            [HxbHUDProgress showMessageCenter:@"系统时间与服务器时间相差过大" inView:nil];
            return;
        }
            break;
            
            case kHXBCode_Enum_NoServerFaile:
        {
            [HxbHUDProgress showMessageCenter:@"网络连接失败，请稍后再试" inView:nil];
            return;
        }
            break;
        default:
            break;
    }
    
    if (!KeyChain.ishaveNet) {
        [HxbHUDProgress showMessageCenter:@"暂无网络，请稍后再试" inView:nil];
        return;
    }
    if (!request.responseStatusCode) {
         [HxbHUDProgress showMessageCenter:@"网络连接失败，请稍后再试" inView:nil];
        return;
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
    NSArray *dataArray = request.responseObject[kResponseData][kResponseDataList];
    if(dataArray.count) request.dataPage ++;
    NSLog(@"%@ 🐯page ++ %ld",request,(long)request.dataPage);
}
@end
