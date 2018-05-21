//
//  HXBBaseViewModel.m
//  hoomxb
//
//  Created by caihongji on 2017/12/29.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBRootVCManager.h"
#import "HXBBaseRequestManager.h"
#import "SGInfoAlert.h"
#import "HXBHFBankHudView.h"

@interface HXBBaseViewModel()
@property (nonatomic, strong) MBProgressHUD* mbpView;
@property (nonatomic, strong) HXBHFBankHudView *hfBankView;
@property (nonatomic, strong) NSMutableArray* requestList;
@end

@implementation HXBBaseViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _requestList = [NSMutableArray array];
        _isFilterHugHidden = YES;
    }
    return self;
}

- (instancetype)initWithBlock:(HugViewBlock)hugViewBlock {
    self = [self init];
    
    if(self) {
        self.hugViewBlock = hugViewBlock;
    }
    
    return self;
}

- (void)dealloc
{
    [[HXBBaseRequestManager sharedInstance] cancelRequest:self];
    if([self getHugView] == [UIApplication sharedApplication].keyWindow) {
        [self showMBP:NO withHudContent:nil];
    }
}

- (UIView*)getHugView {
    UIView* view = nil;
    if(self.hugViewBlock) {
        view = self.hugViewBlock();
    }

    return view;
}

#pragma mark 自定义弹窗
- (void)showMBP:(BOOL)isShow withHudContent:(NSString*)hudContent{
    UIView* parentV = [self getHugView];
    if(!parentV) {
        return;
    }
    
    if (!_mbpView) {
        _mbpView = [[MBProgressHUD alloc] initWithView:parentV];
        _mbpView.removeFromSuperViewOnHide = YES;
        _mbpView.contentColor = [UIColor whiteColor];
        _mbpView.bezelView.backgroundColor = [UIColor blackColor];
        _mbpView.label.textColor = [UIColor whiteColor];
    }
    _mbpView.label.text = hudContent;
    if(isShow){
        [parentV addSubview:self.mbpView];
        [parentV bringSubviewToFront:self.mbpView];
        [self.mbpView showAnimated:NO];
    }
    else{
        [self.mbpView hideAnimated:YES];
    }
}

#pragma mark 自定义恒丰银行跳转弹窗
- (void)showHFBankWithContent:(NSString*)content {
    UIView *parentV = [self getHugView];
    if (!_hfBankView) {
        _hfBankView = [[HXBHFBankHudView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _hfBankView.hudContent = content;
    }
    [parentV addSubview:_hfBankView];
    [parentV bringSubviewToFront:_hfBankView];
}

- (void)hiddenHFBank {
    [_hfBankView removeFromSuperview];
}

#pragma mark 弹框显示
- (void)showProgress:(NYBaseRequest *)request showHudCongtent:(NSString *)hudContent {
    [self showMBP:YES withHudContent:hudContent];
}

- (void)showToast:(NSString *)toast {
//    if([toast containsString:@"failure"]) {
//        return;
//    }
    
    UIView* parentView = [self getHugView];
    if(parentView) {
//        [HxbHUDProgress showMessageCenter:toast inView:parentView];
        [SGInfoAlert showInfo:toast bgColor:[UIColor blackColor].CGColor inView:parentView vertical:0.3];
    }
}

- (void)hideProgress:(NYBaseRequest *)request {
    if(self.isFilterHugHidden) {
        if(request.showHud){
            [self showMBP:NO withHudContent:nil];
        }
    }
    else {
        [self showMBP:NO withHudContent:nil];
    }
}

#pragma mark在委托者中操作请求对象
/**
 添加请求到委托者
 
 @param request 请求对象
 */
- (void)addRequestObject:(NYBaseRequest *)request {
    [self.requestList addObject:request];
}

/**
 移除请求从委托者
 
 @param request 请求对象
 */
- (void)removeRequestObject:(NYBaseRequest *)request {
    [self.requestList removeObject:request];
}

/**
 从委托者获取其中的请求列表
 
 @return 请求列表
 */
- (NSArray*)getRequestObjectList {
    return self.requestList;
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
        
        //当errorType字段不存在或者其值等于“TOAST”的时候， 才做错误处理
        NSString *errorType = [[request.responseObject valueForKey:kResponseErrorData] valueForKey:@"errorType"];
        if (!errorType || [errorType isEqualToString:@"TOAST"]) {
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
