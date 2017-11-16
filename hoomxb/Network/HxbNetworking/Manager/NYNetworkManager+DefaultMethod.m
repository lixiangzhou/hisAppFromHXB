//
//  NYNetworkManager+DefaultMethod.m
//  NYNetwork
//
//  Created by 牛严 on 16/6/30.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import "NYNetworkManager+DefaultMethod.h"
#import "HXBBaseRequest.h"

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
    
    switch (request.responseStatusCode) {
        case kHXBCode_Enum_NotSigin:///没有登录
        case kHXBCode_Enum_TokenNotJurisdiction: // token 失效
//            [self tokenInvidateProcess];
            if (KeyChain.isLogin) {
                KeyChain.isLogin = NO;
                [HXBAlertManager alertNeedLoginAgainWithMeaage:@"您的账户在另一台设备登录，您的账户密码可能泄露，如非您本人操作，请及时修改登录密码"];
            }
            return;
        case kHXBCode_Enum_NoServerFaile:
        {
            [HxbHUDProgress showMessageCenter:@"网络连接失败，请稍后再试" inView:nil];
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
            [HxbHUDProgress showTextWithMessage:error];
        } else if(status.integerValue == kHXBCode_Enum_RequestOverrun){
            if ([self handlingSpecialErrorCodes:request]) {
                return;
            }

            [HxbHUDProgress showTextWithMessage:request.responseObject[kResponseMessage]];
        }
//        else if (status.integerValue == kHXBCode_Enum_SingleLogin) {
//            // 单点登录时，显示tabVC的HomeVC，并弹框提示
//            if (KeyChain.isLogin) {
//                // 忽略广告和刷新的请求，因为这种情况不需要手势密码，需要在首页弹框
//                if ([request.requestUrl isEqualToString:kHXBSplash] || [request.requestUrl isEqualToString:kHXBMY_VersionUpdateURL]) {
//                } else {
//                    KeyChain.isLogin = NO;
//                    [HXBAlertManager alertNeedLoginAgainWithMeaage:request.responseObject[kResponseMessage]];
//                }
//            }
//            return;
//        }
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
            if (KeyChain.isLogin) {
                KeyChain.isLogin = NO;
                [HXBAlertManager alertNeedLoginAgainWithMeaage:@"您的账户在另一台设备登录，您的账户密码可能泄露，如非您本人操作，请及时修改登录密码"];
            }
            return;
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

    if ([request.responseObject[@"code"]  isEqual: @"ESOCKETTIMEDOUT"]) {
        [HxbHUDProgress showMessageCenter:@"请求超时,请稍后重试"];
        return;
    }
    
    NSString *str = request.error.userInfo[@"NSLocalizedDescription"];
    if (str.length>0) {
        if ([[str substringFromIndex:str.length-1] isEqualToString:@"。"]) {
            str = [str substringToIndex:str.length-1];
            [HxbHUDProgress showMessageCenter:str];
        } else {
            if (request.error.code == kHXBPurchase_Processing) { // 请求任务取消
            } else {
                [HxbHUDProgress showMessageCenter:request.error.userInfo[@"NSLocalizedDescription"]];
            }
        }
    }
}

- (void)tokenInvidateProcess {
    // token 失效，静态登出并回到首页
    if (KeyChain.isLogin) {
        /// 退出登录，清空登录信息，回到首页
        KeyChain.isLogin = NO;
        [KeyChain signOut];
        
        // 静态显示主TabVC的HomeVC
        // 当前有tabVC的时候，会在tabVC中得到处理，显示HomeVC
        // 如果没有创建tabVC的时候，不处理该通知，因为只有在tabVC中监听了该通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBBotification_ShowHomeVC object:nil];
    }
}

#pragma mark - 部分页面用到Page++ 的处理
// status != 0
//未登录状态 弹出登录框 status 为1 message 为@“请登录后操作”
- (void)showLoginVCWithRequest: (NYBaseRequest *)request {
    if ([request.responseObject[kResponseMessage] isEqualToString:@"请登录后操作"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
    }
}

// status == 0
//page++
- (void)addRequestPage: (HXBBaseRequest *)request {
    NSArray *dataArray = request.responseObject[kResponseData][kResponseDataList];
    if(dataArray.count) request.dataPage ++;
    NSLog(@"%@ 🐯page ++ %ld",request,(long)request.dataPage);
}
@end
