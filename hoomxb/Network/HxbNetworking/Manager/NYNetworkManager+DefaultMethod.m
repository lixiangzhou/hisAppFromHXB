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
    
    switch ([request.responseObject[kResponseStatus] integerValue]) {
        case kHXBCode_Enum_Captcha://弹出图验、
            [[NSNotificationCenter defaultCenter] postNotificationName:kHXBBotification_ShowCaptchaVC object:nil];
            break;
            
        default:
            break;
    }
//    DLog(@"请求成功-request：%@",request);
    if ([request.responseObject[kResponseStatus] integerValue]) {
        NSLog(@" ---------- %@",request.responseObject[kResponseStatus]);
        ///未登录状态 弹出登录框
        [self showLoginVCWithRequest:request];
    }else{
        if([request isKindOfClass:[HXBBaseRequest class]]) {
            HXBBaseRequest *requestHxb = (HXBBaseRequest *)request;
            if (request.responseObject[kResponseData][@"dataList"]) {
                [self addRequestPage:requestHxb];
            }
        }
    }
   
//    [[NSNotificationCenter defaultCenter] postNotificationName:RequestSuccess object:nil userInfo:nil];
}


#pragma mark - 请求失败
- (void)defaultMethodRequestFaulureWithRequest:(NYBaseRequest *)request
{
    switch (request.responseStatusCode) {
        
        case kHXBCode_Enum_NotSigin:///没有登录
             [[KeyChainManage sharedInstance] removeAllInfo];
            break;
        case kHXBCode_Enum_TokenNotJurisdiction://没有权限
             [[KeyChainManage sharedInstance] removeAllInfo];
             [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
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
///对数据进行处理 并返回
//- (void) handleDataWithRequest: (HXBBaseRequest *)request {
//    NSDictionary *dataDic = [request.responseObject valueForKey:kResponseData];
//    NSObject *viewModel = [[request.viewModelClass alloc]init];
//    [request.class yy_modelWithDictionary:dataDic];
//    
//    request.successBlock(<#NSArray *dataArray#>)
//}
@end
