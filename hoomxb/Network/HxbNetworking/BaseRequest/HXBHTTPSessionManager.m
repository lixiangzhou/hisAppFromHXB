//
//  HXBHTTPSessionManager.m
//  hoomxb
//
//  Created by lxz on 2017/12/4.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBHTTPSessionManager.h"
#import "NYNetworkConfig.h"
#import "HXBRootVCManager.h"
#import "HXBBaseRequest.h"
#import "HXBTokenModel.h"
//typedef void (^HXBIntercepterBlock)(NSURLSessionDataTask *task, id responseObj, NSError *error);

@implementation NSDictionary (HXBResponse)
- (id)data {
    return self[kResponseData];
}

- (NSString *)message {
    return self[kResponseMessage];
}

- (NSInteger)statusCode {
    return [self[kResponseStatus] integerValue];
}

- (BOOL)isSuccess {
    return self.statusCode == kHXBCode_Success;
}
@end


@interface HXBHTTPSessionManager ()
//@property (nonatomic, strong) NSMutableArray <HXBIntercepterBlock> *intercepters;
@end

@implementation HXBHTTPSessionManager

+ (instancetype)hxbManager {
    HXBHTTPSessionManager *manager = [[self alloc] initWithBaseURL:nil sessionConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
    manager.requestSerializer.HTTPShouldHandleCookies = NO;
    manager.responseSerializer.acceptableStatusCodes = [NYNetworkConfig sharedInstance].defaultAcceptableStatusCodes;
    manager.responseSerializer.acceptableContentTypes = [NYNetworkConfig sharedInstance].defaultAcceptableContentTypes;
    //    manager.intercepters = [NSMutableArray<HXBIntercepterBlock> array];
    
    return manager;
}

/// 设置请求信息，发出请求
- (void)startRequest:(NYBaseRequest *)request successBlock:(HXBRequestSuccessBlock)successBlock failureBlock:(HXBRequestFailureBlock)failureBlock {
    request.success = successBlock;
    request.failure = failureBlock;
    
    HXBHTTPSessionManager *manager = [HXBHTTPSessionManager hxbManager];
    
    // 超时
    NSTimeInterval timeInterval = request.timeoutInterval > 0 ? request.timeoutInterval : [NYNetworkConfig sharedInstance].defaultTimeOutInterval;
    manager.requestSerializer.timeoutInterval = timeInterval;
    
    // 请求头
    NSDictionary *headers = [self headerFieldsValueWithRequest:request];
    [headers enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
        [manager.requestSerializer setValue:value forHTTPHeaderField:field];
    }];
    
    // url
    NSString *urlString = @"";
    if (request.baseUrl.length) {
        urlString = [NSURL URLWithString:request.requestUrl relativeToURL:[NSURL URLWithString:request.baseUrl]].absoluteString;
    } else {
        urlString = [NSURL URLWithString:request.requestUrl relativeToURL:[NSURL URLWithString:[NYNetworkConfig sharedInstance].baseUrl]].absoluteString;
    }
    
    // 参数
    NSDictionary *parameters = request.requestArgument;
    
    // 开始请求
    [manager requestWithMethod:request.requestMethod urlString:urlString params:parameters progressBlock:nil successBlock:^(NSURLSessionDataTask *task, id responseObj) {
        [self processSuccessWithRequest:request task:task responseObj:responseObj];
    } failureBlock:^(NSURLSessionDataTask *task, NSError *error) {
        [self processFailureWithRequest:request task:task error:error];
    }];
}

/// 各种请求方法
- (NSURLSessionDataTask *)requestWithMethod:(NYRequestMethod)method urlString:(NSString *)urlString params:(NSDictionary *)params progressBlock:(void (^)(NSProgress *progress))progressBlock successBlock:(void (^)(NSURLSessionDataTask *task, id responseObj))successBlock failureBlock:(void (^)(NSURLSessionDataTask *task, NSError *error))failureBlock {
    NSURLSessionDataTask *task = nil;
    switch (method) {
        case NYRequestMethodGet:
            task = [self GET:urlString parameters:params progress:progressBlock success:successBlock failure:failureBlock]; break;
        case NYRequestMethodPost:
            task = [self POST:urlString parameters:params progress:progressBlock success:successBlock failure:failureBlock]; break;
        case NYRequestMethodPut:
            task = [self PUT:urlString parameters:params success:successBlock failure:failureBlock]; break;
        case NYRequestMethodDelete:
            task = [self DELETE:urlString parameters:params success:successBlock failure:failureBlock]; break;
    }
    return task;
}

#pragma mark - Finish Process
/// 成功回调
- (void)processSuccessWithRequest:(NYBaseRequest *)request task:(NSURLSessionDataTask *)task responseObj:(NSDictionary *)responseObj {
    [self setResponseWithRequest:request task:task responseObj:responseObj error:nil];
    
    NSInteger responseCode = [self responseCode:task];
    
    // 处理通用的响应头和响应体
    [self processResponseCode:responseCode];
    [self processRequestBodyWithRequest:request task:task responseObj:responseObj];
    
    if (request.success) {
        request.success(request, responseObj);
    }
}

/// 失败回调
- (void)processFailureWithRequest:(NYBaseRequest *)request task:(NSURLSessionDataTask *)task error:(NSError *)error {
    [self setResponseWithRequest:request task:task responseObj:nil error:error];
    
    NSInteger responseCode = [self responseCode:task];
    
    if ([self checkSingleLogin:responseCode]) {
        [self processSingleLoginWithRequest:request];
    } else {
        // 处理通用的响应头和响应体
        [self processResponseCode:[self responseCode:task]];
        [self processRequestErrorWithRequest:request task:task error:error];
        
        if (request.failure) {
            request.failure(request, error);
        }
    }
}

/// 成功处理响应体
- (void)processRequestBodyWithRequest:(NYBaseRequest *)request task:(NSURLSessionDataTask *)task responseObj:(NSDictionary *)responseObj {
    if ([responseObj[@"code"]  isEqual: @"ESOCKETTIMEDOUT"]) {
        [HxbHUDProgress showTextWithMessage:@"请求超时,请稍后重试"];
    }
    
    NSInteger statusCode = responseObj.statusCode;
    switch (statusCode) {
        case kHXBCode_Enum_ProcessingField: {
            NSDictionary *data = responseObj.data;
            NSString *error = data.allValues.firstObject;
            [HxbHUDProgress showTextWithMessage:error];
        }
            break;
        case kHXBCode_Enum_RequestOverrun: {
            if ([request.requestUrl isEqualToString:kHXBUser_checkCardBin] ||
                [request.requestUrl isEqualToString:kHXB_Coupon_Best]) {
            } else {
                [HxbHUDProgress showTextWithMessage:responseObj.message];
            }
        }
            break;
        default: {
            if([request isKindOfClass:[HXBBaseRequest class]]) {
                HXBBaseRequest *requestHxb = (HXBBaseRequest *)request;
                if (responseObj.data[@"dataList"]) {
                    NSArray *dataArray = responseObj.data[@"dataList"];
                    if(dataArray.count) requestHxb.dataPage++;
                }
            }
        }
            break;
    }
}

/// 失败处理Error
- (void)processRequestErrorWithRequest:(NYBaseRequest *)request task:(NSURLSessionDataTask *)task error:(NSError *)error {
    NSString *str = error.userInfo[@"NSLocalizedDescription"];
    if (str.length > 0) {
        if ([[str substringFromIndex:str.length - 1] isEqualToString:@"。"]) {
            str = [str substringToIndex:str.length-1];
            [HxbHUDProgress showMessageCenter:str];
            if ([str containsString:@"请求超时"]) {
                request.error = [NSError errorWithDomain:request.error.domain code:kHXBCode_Enum_ConnectionTimeOut userInfo:@{@"message":@"连接超时"}];
            }
        } else {
            if (request.error.code == kHXBPurchase_Processing) { // 请求任务取消
            } else {
                [HxbHUDProgress showMessageCenter:error.userInfo[@"NSLocalizedDescription"]];
            }
        }
    }
}

/// 响应头处理
- (void)processResponseCode:(NSInteger)responseCode {
    switch (responseCode) {
        case kHXBCode_Enum_NotSigin:    // 没有登录
        case kHXBCode_Enum_TokenNotJurisdiction: // token 失效
            //            [self tokenInvidateProcess];
            [self refreshAccessToken:^(NSString *token) {
                if (token) {
                    
                }
            }];
            break;
        case kHXBCode_Enum_NoServerFaile: {
            [HxbHUDProgress showMessageCenter:@"网络连接失败，请稍后再试" inView:nil];
            break;
        }
    }
}

/// 设置请求的 Response 信息
- (void)setResponseWithRequest:(NYBaseRequest *)request task:(NSURLSessionDataTask *)task responseObj:(NSDictionary *)responseObj error:(NSError *)error {
    request.responseStatusCode = [self responseCode:task];
    request.responseHeaderFieldValueDictionary = [self allHeaderFields:task];
    request.responseObject = responseObj;
    request.error = error;
    request.dataTask = task;
}

#pragma mark - Single Login
/// 检查是否进行单点处理
- (BOOL)checkSingleLogin:(NSInteger)responseCode {
    return responseCode == kHXBCode_Enum_TokenNotJurisdiction || responseCode == kHXBCode_Enum_NotSigin;
}

/// 单点登录处理
- (void)processSingleLoginWithRequest:(NYBaseRequest *)request {
    [self refreshAccessToken:^(NSString *token) {
        if (token) {
            KeyChain.token = token;
            [self processTokenInvidate];
            NYBaseRequest *newRequest = [request copyRequest];
//            request.success = nil;
//            request.failure = nil;
            [self startRequest:newRequest successBlock:request.success failureBlock:request.failure];
        } else {
            if (request.failure) {
                request.failure(request, [NSError errorWithDomain:request.error.domain code:kHXBCode_Enum_ConnectionTimeOut userInfo:@{@"message":@"连接超时"}]);
            }
        }
    }];
}

/// 重新请求token
- (void)refreshAccessToken:(void(^)(NSString *token))refresh{
    NSString *tokenURLString = [NSString stringWithFormat:@"%@%@",[NYNetworkConfig sharedInstance].baseUrl,TOKENURL];
    NSURL *tokenURL =[NSURL URLWithString:tokenURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:tokenURL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      if (!data) {
                                          refresh(nil);
                                          return ;
                                      }
                                      NSDictionary *dict = [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil] objectForKey:@"data"];
                                      HXBTokenModel *model = [HXBTokenModel yy_modelWithJSON:dict];
                                      refresh(model.token);
                                  }];
    [task resume];
}

/// token 失效回到首页
- (void)processTokenInvidate {
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


#pragma mark - Helper
- (NSDictionary *)headerFieldsValueWithRequest:(NYBaseRequest *)request
{
    NSMutableDictionary *headers = [[NYNetworkConfig sharedInstance].additionalHeaderFields mutableCopy];
    
    [request.httpHeaderFields enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [headers setObject:obj forKey:key];
    }];
    return headers;
}

- (NSInteger)responseCode:(NSURLSessionDataTask *)task {
    return ((NSHTTPURLResponse *)task.response).statusCode;
}

- (NSDictionary *)allHeaderFields:(NSURLSessionDataTask *)task {
    return ((NSHTTPURLResponse *)task.response).allHeaderFields;
}



@end
