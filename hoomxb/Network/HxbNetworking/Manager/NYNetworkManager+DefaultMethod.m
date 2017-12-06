//
//  NYNetworkManager+DefaultMethod.m
//  NYNetwork
//
//  Created by 牛严 on 16/6/30.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import "NYNetworkManager+DefaultMethod.h"
#import "HXBBaseRequest.h"
#import "HXBRootVCManager.h"
@implementation NYNetworkManager (DefaultMethod)

- (void)defaultMethodRequestSuccessWithRequest:(NYBaseRequest *)request
{
    NSLog(@"======================👌👌 开始 👌👌====================================");
    NSLog(@"👌👌URL: %@,  Code =>%ld  ",request.requestUrl,(long)request.responseStatusCode);
    NSLog(@"👌👌请求 体 ----- %@",request.requestArgument);
    NSLog(@"👌👌相应 体 ------%@",request.responseObject);
    NSLog(@"======================👌👌 结束 👌👌====================================");
    
    if ([request.responseObject[@"code"]  isEqual: @"ESOCKETTIMEDOUT"]) {
//        [HxbHUDProgress showTextWithMessage:@"请求超时,请稍后重试"];
        [self showToast:@"请求超时,请稍后重试" withRequest:request];
    }
    
    switch (request.responseStatusCode) {
        case kHXBCode_Enum_NoServerFaile:
        {
//            [HxbHUDProgress showMessageCenter:@"网络连接失败，请稍后再试" inView:nil];
            [self showToast:@"网络连接失败，请稍后再试" withRequest:request];
            return;
        }
    }
    
    if ([request.responseObject[kResponseStatus] integerValue]) {
        NSLog(@" ---------- %@",request.responseObject[kResponseStatus]);
        NSString *status = request.responseObject[kResponseStatus];
        if (status.integerValue == kHXBCode_Enum_ProcessingField) {
            NSDictionary *dic = request.responseObject[kResponseData];
            __block NSString *error = @"";
            [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                NSArray *arr = obj;
                error = arr[0];
            }];
//            [HxbHUDProgress showTextWithMessage:error];
            [self showToast:error withRequest:request];
        } else if(status.integerValue == kHXBCode_Enum_RequestOverrun){
            if ([self handlingSpecialErrorCodes:request]) {
                return;
            }
//            [HxbHUDProgress showTextWithMessage:request.responseObject[kResponseMessage]];
            [self showToast:request.responseObject[kResponseMessage] withRequest:request];
        }

    } else {
        if([request isKindOfClass:[HXBBaseRequest class]]) {
            HXBBaseRequest *requestHxb = (HXBBaseRequest *)request;
            if (request.responseObject[kResponseData][@"dataList"]) {
                [self addRequestPage:requestHxb];
            }
        }
    }
}


/**
 处理不需要提示412问题
 */
- (BOOL)handlingSpecialErrorCodes:(NYBaseRequest *)request {
    if ([request.requestUrl isEqualToString:kHXBUser_checkCardBin]) {
        return YES;
    }
    if ([request.requestUrl isEqualToString:kHXB_Coupon_Best]) {
        return YES;
    }
    return NO;
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
        case kHXBCode_Enum_NotSigin:/// 没有登录
        case kHXBCode_Enum_TokenNotJurisdiction:// token 失效
            [self tokenInvidateProcess];
            return;
        case kHXBCode_Enum_NoServerFaile:
        {
//            [HxbHUDProgress showMessageCenter:@"网络连接失败，请稍后再试" inView:nil];
//            [request.hudDelegate showToast:@"网络连接失败，请稍后再试"];
            [self showToast:@"网络连接失败，请稍后再试" withRequest:request];
            return;
        }
            break;
        default:
            break;
    }
    
    if (!KeyChain.ishaveNet) {
//        [HxbHUDProgress showMessageCenter:@"暂无网络，请稍后再试" inView:nil];
//        [request.hudDelegate showToast:@"暂无网络，请稍后再试"];
        [self showToast:@"暂无网络，请稍后再试" withRequest:request];
        request.error = [NSError errorWithDomain:request.error.domain code:kHXBCode_Enum_NoConnectionNetwork userInfo:@{@"message":@"暂无网络"}];
        return;
    }
    
    NSString *str = request.error.userInfo[@"NSLocalizedDescription"];
    if (str.length > 0) {
        if ([[str substringFromIndex:str.length - 1] isEqualToString:@"。"]) {
            str = [str substringToIndex:str.length - 1];
            if ([str containsString:@"请求超时"]) {
                request.error = [NSError errorWithDomain:request.error.domain code:kHXBCode_Enum_ConnectionTimeOut userInfo:@{@"message":@"连接超时"}];
            }
//            [HxbHUDProgress showMessageCenter:str];
//            [request.hudDelegate showToast:str];
            [self showToast:str withRequest:request];
        } else {
            if (request.error.code == kHXBPurchase_Processing) { // 请求任务取消
            } else {
//                [HxbHUDProgress showMessageCenter:request.error.userInfo[@"NSLocalizedDescription"]];
//                [request.hudDelegate showToast:str];
                [self showToast:str withRequest:request];
            }
        }
    }
}

#pragma mark - Toast
- (void)showToast:(NSString *)toast withRequest:(NYBaseRequest *)request {
    if (request.showToast && [request.hudDelegate respondsToSelector:@selector(showToast:)]) {
        [request.hudDelegate showToast:toast];
    }
}

#pragma mark -
- (void)tokenInvidateProcess {
    // token 失效，静态登出并回到首页
    if (KeyChain.isLogin) {
        /// 退出登录，清空登录信息，回到首页
        KeyChain.isLogin = NO;
        [KeyChain signOut];
        
        //单点登出之后dismiss最上层可能会有的控制器
        [[HXBRootVCManager manager].mainTabbarVC.presentedViewController dismissViewControllerAnimated:NO completion:nil];
        
        // 静态显示主TabVC的HomeVC
        // 当前有tabVC的时候，会在tabVC中得到处理，显示HomeVC
        // 如果没有创建tabVC的时候，不处理该通知，因为只有在tabVC中监听了该通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBBotification_ShowHomeVC object:nil];
    }
}

#pragma mark - 部分页面用到Page++ 的处理

// status == 0
//page++
- (void)addRequestPage: (HXBBaseRequest *)request {
    NSArray *dataArray = request.responseObject[kResponseData][kResponseDataList];
    if(dataArray.count) request.dataPage ++;
    NSLog(@"%@ 🐯page ++ %ld",request,(long)request.dataPage);
}
@end
