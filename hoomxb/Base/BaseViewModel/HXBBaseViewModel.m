//
//  HXBBaseViewModel.m
//  hoomxb
//
//  Created by caihongji on 2017/12/29.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBRootVCManager.h"
#import "HXBBaseRequest.h"
#import "HXBBaseRequestManager.h"

@interface HXBBaseViewModel()

@end

@implementation HXBBaseViewModel

- (instancetype)initWithBlock:(HugViewBlock)hugViewBlock {
    self = [super init];
    
    if(self) {
        self.hugViewBlock = hugViewBlock;
    }
    
    return self;
}

- (void)dealloc
{
    [[HXBBaseRequestManager sharedInstance] cancelRequest:self];
    if([self getHugView] == [UIApplication sharedApplication].keyWindow) {
        [self hideProgress];
    }
}

- (UIView*)getHugView {
    UIView* view = nil;
    if(self.hugViewBlock) {
        view = self.hugViewBlock();
    }
#ifndef DEBUG
    if(view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
#endif
    return view;
}

#pragma mark 弹框显示
- (void)showProgress:(NSString*)hudContent {
    UIView* parentView = [self getHugView];
    if(parentView) {
        [HxbHUDProgress showLoadDataHUD:parentView text:hudContent];
    }
    
}

- (void)showToast:(NSString *)toast {
    UIView* parentView = [self getHugView];
    if(parentView) {
        [HxbHUDProgress showMessageCenter:toast inView:parentView];
    }
}

- (void)hideProgress {
    UIView* parentView = [self getHugView];
    if(parentView) {
        [HxbHUDProgress hidenHUD:parentView];
    }
}

#pragma mark 错误码处理
/**
 错误的状态码处理
 
 @param request 请求对象
 @return 是否已经做了处理
 */
- (BOOL)erroStateCodeDeal:(NYBaseRequest *)request {
    NSLog(@"======================👌👌 开始 👌👌====================================");
    NSLog(@"👌👌URL: %@,  Code =>%ld  ",request.requestUrl,(long)request.responseStatusCode);
    NSLog(@"👌👌请求 体 ----- %@",request.requestArgument);
    NSLog(@"👌👌相应 体 ------%@",request.responseObject);
    NSLog(@"======================👌👌 结束 👌👌====================================");
    
    if([self handlingSpecialRequests:request]){
        return NO;
    }
    
    if ([request.responseObject[kResponseStatus] integerValue]) {
        NSLog(@" ---------- %@",request.responseObject[kResponseStatus]);
        NSString *status = request.responseObject[kResponseStatus];
        if (status.integerValue == kHXBCode_Enum_ProcessingField) {
            NSDictionary *dic = request.responseObject[kResponseData];
            __block NSString *error = @"";
            [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                NSArray *arr = obj;
                if([arr isKindOfClass:[NSArray class]] && arr.count>0) {
                    error = arr[0];
                    *stop = YES;
                }
            }];
            [self showToast:error];
            return YES;
        } else if(status.integerValue == kHXBCode_Enum_RequestOverrun){
            if (![self handlingSpecialErrorCodes:request]) {
                [self showToast:request.responseObject[kResponseMessage]];
                return YES;
            }
        } else{
            [self showToast:request.responseObject[kResponseMessage]];
            return YES;
        }
        
    } else {
        if([request isKindOfClass:[HXBBaseRequest class]]) {
            HXBBaseRequest *requestHxb = (HXBBaseRequest *)request;
            if (request.responseObject[kResponseData][@"dataList"]) {
                [self addRequestPage:requestHxb];
            }
        }
    }
    return NO;
}

/**
 闪屏、升级和首页弹窗 不处理异常返回结果
 */
- (BOOL)handlingSpecialRequests:(NYBaseRequest *)request{
    //闪屏、升级和首页弹窗 不处理异常返回结果
    if ([request.requestUrl isEqualToString:kHXBSplash] || [request.requestUrl isEqualToString:kHXBHome_PopView]||[request.requestUrl isEqualToString:kHXBMY_VersionUpdateURL]) {
        return YES;
    }
    return NO;
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

#pragma mark - 部分页面用到Page++ 的处理

// status == 0
//page++
- (void)addRequestPage: (HXBBaseRequest *)request {
    NSArray *dataArray = request.responseObject[kResponseData][kResponseDataList];
    if(dataArray.count) request.dataPage ++;
    NSLog(@"%@ 🐯page ++ %ld",request,(long)request.dataPage);
}

/**
 错误的响应码处理
 
 @param request 请求对象
 @return 是否已经做了处理
 */
- (BOOL)erroResponseCodeDeal:(NYBaseRequest *)request {
    NSLog(@"======================👌👌 开始 👌👌====================================");
    NSLog(@"👌👌URL: %@,  Code =>%ld  ",request.requestUrl,(long)request.responseStatusCode);
    NSLog(@"👌👌请求 体 ----- %@",request.requestArgument);
    NSLog(@"👌👌相应 体 ------%@",request.responseObject);
    NSLog(@"======================👌👌 结束 👌👌====================================");
    
    if([self handlingSpecialRequests:request]){
        return NO;
    }
    
    switch (request.responseStatusCode) {
        case kHXBCode_Enum_NotSigin:/// 没有登录
        {
            [self tokenInvidateProcess];
            return YES;
        }
        case kHXBCode_Enum_NoServerFaile:
        {
            [self showToast:@"网络连接失败，请稍后再试"];
            return YES;
        }
        default:
            break;
    }
    
    if (!KeyChain.ishaveNet) {
        [self showToast:@"暂无网络，请稍后再试"];
        return YES;
    }
    
    NSString *str = request.error.userInfo[@"NSLocalizedDescription"];
    if (str.length > 0) {
        if ([[str substringFromIndex:str.length - 1] isEqualToString:@"。"]) {
            str = [str substringToIndex:str.length - 1];
            if ([str containsString:@"请求超时"]) {
                [self showToast:str];
                return YES;
            }
        } else {
            if (request.error.code != kHXBPurchase_Processing) { // 请求任务取消
                [self showToast:str];
                return YES;
            }
        }
    }
    return NO;
}

- (void)tokenInvidateProcess {
    // token 失效，静态登出并回到首页
    if (KeyChain.isLogin) {
        /// 退出登录，清空登录信息，回到首页
        KeyChain.isLogin = NO;
        
        //单点登出之后dismiss最上层可能会有的控制器
        [[HXBRootVCManager manager].mainTabbarVC.presentedViewController dismissViewControllerAnimated:NO completion:nil];
        
        // 静态显示主TabVC的HomeVC
        // 当前有tabVC的时候，会在tabVC中得到处理，显示HomeVC
        // 如果没有创建tabVC的时候，不处理该通知，因为只有在tabVC中监听了该通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBBotification_ShowHomeVC object:nil];
    }
}

@end
