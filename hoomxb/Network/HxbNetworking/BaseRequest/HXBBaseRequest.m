//
//  HXBBaseRequest.m
//  hoomxb
//
//  Created by HXB on 2017/6/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseRequest.h"
#import "NYNetworkManager.h"
#import "NYHTTPConnection.h"
@interface HXBBaseRequest ()

@end
@implementation HXBBaseRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelRequest:) name:kHXBNotification_StopAllRequest object:nil];
    }
    return self;
}
- (void)cancelRequest : (NSNotification *)noit {
//    [self.connection.task cancel];
}
- (NSMutableDictionary *)infoDic {
    if (!_infoDic) {
        _infoDic = [[NSMutableDictionary alloc]init];
    }
    return _infoDic;
}
//其他的Page 的设置在 NYNetworkManager+DefaultMethod 中
- (NSInteger) dataPage {
    if (_dataPage <= 1) _dataPage = 1;
    return _dataPage;
}

- (void) setIsUPReloadData:(BOOL)isUPReloadData {
    _isUPReloadData = isUPReloadData;
    if (isUPReloadData) self.dataPage = 1;
}


- (void)start{
    NSString *str = @"加载中...";
    if (self.isUPReloadData || self.dataPage > 1) {
        str = nil;
    }
    [self startWithHUD:str];
}

- (void)startWithHUD:(NSString *)str
{
    if (!self.isJudgeLogin) {
        [[NYNetworkManager sharedManager] addRequest:self withHUD:str];
        return;
    }
    [[KeyChainManage sharedInstance] isLoginWithInRealTimeBlock:^(BOOL isLogin) {
        if (isLogin) {
            [[NYNetworkManager sharedManager] addRequest:self withHUD:str];
        }else {
            [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
        }
    }];
}

- (void)startWithAnimation
{
    [[NYNetworkManager sharedManager] addRequestWithAnimation:self];
}

- (void)startWithSuccess:(void(^)(HXBBaseRequest *request, id responseObject))success
              failure:(void(^)(HXBBaseRequest *request, NSError *error))failure {
    if (!self.isJudgeLogin) {
        self.success = [success copy];
        self.failure = [failure copy];
        [self start];
        return;
    }
    [[KeyChainManage sharedInstance] isLoginWithInRealTimeBlock:^(BOOL isLogin) {
        if (isLogin) {
            self.success = [success copy];
            self.failure = [failure copy];
            [self start];
        }else {
            [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
        }
    }];
}

- (void)startWithHUDStr:(NSString *)string Success:(void(^)(HXBBaseRequest *request, id responseObject))success failure:(void(^)(HXBBaseRequest *request, NSError *error))failure {
    if (!self.isJudgeLogin) {
        self.success = [success copy];
        self.failure = [failure copy];
        [self startWithHUD:string];
        return;
    }
    [[KeyChainManage sharedInstance] isLoginWithInRealTimeBlock:^(BOOL isLogin) {
        if (isLogin) {
            self.success = [success copy];
            self.failure = [failure copy];
            [self startWithHUD:string];
        }else {
            [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
        }
    }];
   
}

- (void)startAnimationWithSuccess:(void(^)(HXBBaseRequest *request, id responseObject))success
                          failure:(void(^)(HXBBaseRequest *request, NSError *error))failure {
 
    if (!self.isJudgeLogin) {
        self.success = [success copy];
        self.failure = [failure copy];
        [self startWithAnimation];
        return;
    }
    [[KeyChainManage sharedInstance] isLoginWithInRealTimeBlock:^(BOOL isLogin) {
        if (isLogin) {
            self.success = [success copy];
            self.failure = [failure copy];
            [self startWithAnimation];
        }else {
            [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
        }
    }];
    
}


//- (void)hxbRequestWithViewModelClass: (Class)viewModelClass
//                       andModelClass: (Class)modelClass
//                          andSuccess: (void (^)(NSArray *dataArray))successBlock
//                          andFailure: (void (^)(HXBBaseRequest *request, NSError *error))failureBlock {
//    self.viewModelClass = viewModelClass;
//    self.success = [successBlock copy];
//    self.failure = [failureBlock copy];
//    [self startWithAnimation];
//}
@end
