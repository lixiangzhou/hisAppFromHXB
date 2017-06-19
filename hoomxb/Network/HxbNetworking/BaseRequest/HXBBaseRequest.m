//
//  HXBBaseRequest.m
//  hoomxb
//
//  Created by HXB on 2017/6/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseRequest.h"
#import "NYNetworkManager.h"
@interface HXBBaseRequest ()

@end
@implementation HXBBaseRequest
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
    [self startWithHUD:nil];
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

- (void)startWithHUDStr:(NSString *)string Success:(void(^)(HXBBaseRequest *request, id responseObject))success
             failure:(void(^)(HXBBaseRequest *request, NSError *error))failure {
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
