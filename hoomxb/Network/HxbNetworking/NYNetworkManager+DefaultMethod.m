//
//  NYNetworkManager+DefaultMethod.m
//  NYNetwork
//
//  Created by 牛严 on 16/6/30.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import "NYNetworkManager+DefaultMethod.h"
NSString *const RequestSuccess = @"RequestSuccess";
NSString *const RequestFailure = @"RequestFailure";
NSString *const LoginVCDismiss = @"LoginVCDismiss";
@implementation NYNetworkManager (DefaultMethod)

- (void)defaultMethodRequestSuccessWithRequest:(NYBaseRequest *)request
{
//    DLog(@"请求成功-request：%@",request);
    [[NSNotificationCenter defaultCenter] postNotificationName:RequestSuccess object:nil userInfo:nil];
}

//- (void)defaultMethodRequestFaulureWithRequest:(NYBaseRequest *)request
//{
//    if (request.responseStatusCode == 409) {
//        //重复登录，强制下线
//        [[NSNotificationCenter defaultCenter] postNotificationName:ForceLogout object:nil];
//        return;
//    }
////    [NYProgressHUD showToastText:@"网络请求错误"];
//    [[NSNotificationCenter defaultCenter] postNotificationName:RequestFailure object:nil userInfo:nil];
//}

@end
