//
//  HXBRequestUserInfoAPI.m
//  hoomxb
//
//  Created by HXB on 2017/5/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRequestUserInfoAPI.h"

@implementation HXBRequestUserInfoAPI

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"userAssets" : [HXBRequestUserInfoAPI_UserAssets class],
             @"userInfo" : [HXBRequestUserInfoAPI_UserInfo class]
             };
}
- (NSString *)requestUrl {
    return @"/user/info";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodPost;
}

- (void) downLoadUserInfoWithSeccessBlock: (void(^)(NYBaseRequest *request,HXBRequestUserInfoAPI *model))seccessBlock andFailure:(void(^)(NYBaseRequest *request, NSError *error))failureBlock {
    [self startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        [self yy_modelSetWithDictionary:responseObject];
        
        if (seccessBlock) {
            seccessBlock(request,self);
        }
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) {
            failureBlock(request,error);
        }
    }];
}
@end

@implementation HXBRequestUserInfoAPI_UserAssets
@end
@implementation HXBRequestUserInfoAPI_UserInfo
@end
