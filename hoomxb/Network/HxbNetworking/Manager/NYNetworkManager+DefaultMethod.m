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
    
//    DLog(@"请求成功-request：%@",request);
    if ([request.responseObject[kResponseStatus] integerValue]) {
        ///未登录状态 弹出登录框
        [self showLoginVCWithRequest:request];
    }else{
        if([request isKindOfClass:[HXBBaseRequest class]]) {
            HXBBaseRequest *requestHxb = (HXBBaseRequest *)request;
            [self addRequestPage:requestHxb];
        }
    }
   
//    [[NSNotificationCenter defaultCenter] postNotificationName:RequestSuccess object:nil userInfo:nil];
}


#pragma mark - 请求失败
- (void)defaultMethodRequestFaulureWithRequest:(NYBaseRequest *)request
{
    if (request.responseStatusCode == 402 || request.responseStatusCode == 401) {
        //重复登录，强制下线
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
        return;
    }
//    [NYProgressHUD showToastText:@"网络请求错误"];
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
}
///对数据进行处理 并返回
//- (void) handleDataWithRequest: (HXBBaseRequest *)request {
//    NSDictionary *dataDic = [request.responseObject valueForKey:kResponseData];
//    NSObject *viewModel = [[request.viewModelClass alloc]init];
//    [request.class yy_modelWithDictionary:dataDic];
//    
//    request.successBlock(<#NSArray *dataArray#>)
//}
@end
