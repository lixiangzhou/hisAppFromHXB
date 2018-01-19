//
//  HXBBaseRequest.m
//  hoomxb
//
//  Created by HXB on 2017/6/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
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
    NSString *str = kLoadIngText;
    if (self.isUPReloadData || self.dataPage > 1) {
        str = nil;
        self.showHud = NO;
    }
    [self startWithHUD:str];
}

- (void)startWithHUD:(NSString *)str
{
    [[NYNetworkManager sharedManager] addRequest:self withHUD:str];
}

- (void)startWithAnimation
{
    [[NYNetworkManager sharedManager] addRequestWithAnimation:self];
}

- (void)startWithSuccess:(void(^)(HXBBaseRequest *request, id responseObject))success
              failure:(void(^)(HXBBaseRequest *request, NSError *error))failure {
    self.success = [success copy];
    self.failure = [failure copy];
    [self start];
}

- (void)startWithHUDStr:(NSString *)string Success:(void(^)(HXBBaseRequest *request, id responseObject))success failure:(void(^)(HXBBaseRequest *request, NSError *error))failure {
    self.success = [success copy];
    self.failure = [failure copy];
    [self startWithHUD:string];
   
}

- (void)startAnimationWithSuccess:(void(^)(HXBBaseRequest *request, id responseObject))success
                          failure:(void(^)(HXBBaseRequest *request, NSError *error))failure {
 
    self.success = [success copy];
    self.failure = [failure copy];
    [self startWithAnimation];
    
}


#pragma mark  以下为重构后需要使用的各种方法
- (void)loadData
{
    NSString *str = kLoadIngText;
    if (self.isUPReloadData || self.dataPage > 1) {
        str = nil;
    }
    
    [self startWithHUD:str];
}

- (void)loadDataWithSuccess:(void(^)(HXBBaseRequest *request, id responseObject))success
                    failure:(void(^)(HXBBaseRequest *request, NSError *error))failure
{
    self.success = [success copy];
    self.failure = [failure copy];
    [self loadData];
}

- (void)loadDataWithHUDStr:(NSString *)string Success:(void(^)(HXBBaseRequest *request, id responseObject))success
                   failure:(void(^)(HXBBaseRequest *request, NSError *error))failure
{
    self.success = [success copy];
    self.failure = [failure copy];
    [self startWithHUD:string];
}

- (void)loadDataAnimationWithSuccess:(void(^)(HXBBaseRequest *request, id responseObject))success
                             failure:(void(^)(HXBBaseRequest *request, NSError *error))failure
{
    self.success = [success copy];
    self.failure = [failure copy];
    [self startWithAnimation];
}
@end
