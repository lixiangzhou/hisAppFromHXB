    //
//  NYHTTPConnection.m
//  NYNetwork
//
//  Created by 牛严 on 16/6/28.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import "NYHTTPConnection.h"
#import "NYNetworkConfig.h"

#import "HXBTokenModel.h"
#import <objc/runtime.h>
#import "HxbHTTPSessionManager.h"
#import "HXBBaseUrlManager.h"
#import "HXBRootVCManager.h"
#define Config [NYNetworkConfig sharedInstance]



@interface NYHTTPConnection ()

@property (nonatomic, strong, readwrite) NYBaseRequest *request;

@property (nonatomic, strong, readwrite) NSURLSessionDataTask *task;

@property (nonatomic, copy) ConnectionSuccessBlock success;

@property (nonatomic, copy) ConnectionFailureBlock failture;

@property (strong, nonatomic) NSMutableDictionary<NSNumber *, NSURLSessionTask *> *dispatchTable;

@property (nonatomic, strong) HxbHTTPSessionManager *manager;
@end

@implementation NYHTTPConnection

+ (instancetype)init
{
    return [[self alloc]init];
}

/**
 *  生成headerFieldValueDic
 *
 *  @param request 处理的请求
 *
 */
- (NSDictionary *)headerFieldsValueWithRequest:(NYBaseRequest *)request
{
    NSMutableDictionary *headers = [Config.additionalHeaderFields mutableCopy];

    [request.requestHeaderFieldValueDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [headers setObject:obj forKey:key];
    }];
    return headers;
}

//配置及处理sessionManager
- (void)connectWithRequest:(NYBaseRequest *)request success:(ConnectionSuccessBlock)success failure:(ConnectionFailureBlock)failure
{
    self.success = success;
    self.failture = failure;
    //现在的初始化代码
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];
    //    HxbHTTPSessionManager *manager = [HxbHTTPSessionManager manager]; //以前初始化代码

//-------------------------------------------request----------------------------------------
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSLog(@"manager = %@",manager);
    manager.requestSerializer.timeoutInterval = 30;
    
    NSDictionary *headers = [self headerFieldsValueWithRequest:request];
      [manager.requestSerializer setHTTPShouldHandleCookies:NO];
    
    [headers enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
        [manager.requestSerializer setValue:value forHTTPHeaderField:field];
    }];
    
//--------------------------------------------response----------------------------------------
    if (request.responseSerializerType == NYResponseSerializerTypeHTTP) {
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }else if (request.responseSerializerType == NYResponseSerializerTypeJson){
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    manager.responseSerializer.acceptableStatusCodes = Config.defaultAcceptableStatusCodes;
    manager.responseSerializer.acceptableContentTypes = Config.defaultAcceptableContentTypes;
    
    NSString *urlString = @"";
    if (request.baseUrl.length) {
        urlString = [NSURL URLWithString:request.requestUrl relativeToURL:[NSURL URLWithString:request.baseUrl]].absoluteString;
    }else{
        urlString = [NSURL URLWithString:request.requestUrl relativeToURL:[NSURL URLWithString:Config.baseUrl]].absoluteString;
    }
    NSDictionary *parameters = request.requestArgument;
    
//------------------------------------------AFHTTPSessionManage---------------------------
    
    void (^successBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self requestHandleSuccess:request responseObject:responseObject];
        [self.dispatchTable removeObjectForKey:@(task.taskIdentifier)];
    };
    
    void (^failureBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)task.response;
        ///获取code码，如果是401 那么表示token失效
        if([httpResponse statusCode] == kHXBCode_Enum_TokenNotJurisdiction){
            [self getNewTokenWithRequest:request andWithError:error];
        } else {
            [self requestHandleFailure:request error:error];
        }
        [self.dispatchTable removeObjectForKey:@(task.taskIdentifier)];
    };
    

    NSURLSessionDataTask *task = nil;
    switch (request.requestMethod) {
        case NYRequestMethodGet:
        {
            task = [manager GET:urlString parameters:parameters progress:nil success:successBlock failure:failureBlock];
        }
            break;
        case NYRequestMethodPost:
        {
            task = [manager POST:urlString parameters:parameters progress:nil success:successBlock failure:failureBlock];
        }
            break;
        case NYRequestMethodPut:
        {
            task = [manager PUT:urlString parameters:parameters success:successBlock failure:failureBlock];
        }
            break;
        case NYRequestMethodDelete:
        {
            task = [manager DELETE:urlString parameters:parameters success:successBlock failure:failureBlock];
        }
            break;
        default:{
            NSLog(@"unsupported request method");
        }
            break;
    }
    [self.dispatchTable setObject:task forKey:@(task.taskIdentifier)];
    self.task = task;
    request.connection = self;
}

- (void)requestHandleSuccess:(NYBaseRequest *)request responseObject:(id)object
{
    if (self.success) {
        self.success(self,object);
    }
}

- (void)requestHandleFailure:(NYBaseRequest *)request error:(NSError *)error
{
    if (self.failture) {
        self.failture(self,error);
    }
}

#pragma mark Get/Set Method
- (NSDictionary *)dispatchTable
{
    if (!_dispatchTable) {
        _dispatchTable = [NSMutableDictionary dictionary];
    }
    return _dispatchTable;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma - mark token失效
- (void)getNewTokenWithRequest:(NYBaseRequest *)request andWithError:(NSError *)error{

    //删除token 让客户登录
    [[KeyChainManage sharedInstance] removeToken];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
    
        //调用refreshAccesstoken方法，刷新access token。
        [self refreshAccessToken:^(NSData *data) {
            if (!data) {
                if (self.failture) {
                    self.failture(self,error);
                }
                return ;
            }
            NSDictionary *dic = [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil] objectForKey:@"data"];
            HXBTokenModel *model = [HXBTokenModel yy_modelWithJSON:dic];
            NSLog(@"😝😝😝😝😝%@",model.token);
            kNetWorkError(@"token失效");
            
            [KeyChain setToken:model.token];
            
            //退出登录
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UINavigationController *tabbarSelectedVC = (UINavigationController *)[HXBRootVCManager manager].mainTabbarVC.selectedViewController;
                //记录回到首页之前是否有顶部控制器
                NSInteger viewControllersCount = tabbarSelectedVC.viewControllers.count;
                //回到首页
                [self tokenInvidateProcess];
                
                if (viewControllersCount>1) {
                    if (self.failture) {
                        self.failture(self,error);
                    }
                } else {
                    [self connectWithRequest:request success:self.success failure:self.failture];
                }
            });
        }];
    });
}


- (void)tokenInvidateProcess {
    // token 失效，静态登出并回到首页
    if (KeyChain.isLogin) {
        /// 退出登录，清空登录信息，回到首页
        KeyChain.isLogin = NO;
//        [KeyChain signOut];
        
        //单点登出之后dismiss最上层可能会有的控制器
        [[HXBRootVCManager manager].mainTabbarVC.presentedViewController dismissViewControllerAnimated:NO completion:nil];
        // 静态显示主TabVC的HomeVC
        // 当前有tabVC的时候，会在tabVC中得到处理，显示HomeVC
        // 如果没有创建tabVC的时候，不处理该通知，因为只有在tabVC中监听了该通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBBotification_ShowHomeVC object:nil];
    }
}

#pragma mark - 获取最顶端控制器
- (UIViewController *)topControllerWithRootController:(UIViewController *)rootController {
    if ([rootController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarVC = (UITabBarController *)rootController;
        return [self topControllerWithRootController:tabBarVC.selectedViewController];
    } else if ([rootController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationVC = (UINavigationController *)rootController;
        return [self topControllerWithRootController:navigationVC.visibleViewController];
    } else if (rootController.presentedViewController) {
        return [self topControllerWithRootController:rootController.presentedViewController];
    } else {
        return rootController;
    }
}

#pragma - mark 获取token
- (void)refreshAccessToken:(void(^)(NSData *data))refresh{
    NSString *tokenURLString = [NSString stringWithFormat:@"%@%@",[HXBBaseUrlManager manager].baseUrl,TOKENURL];
    NSURL *tokenURL =[NSURL URLWithString:tokenURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:tokenURL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      if (error) {
                                          data = nil;
                                      }
                                      NSLog(@"data:%@",response);
                                      NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
                                      refresh(data);
                                  }];
    
    [task resume];
}

@end
