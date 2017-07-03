//
//  HXBVersionUpdateRequest.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBVersionUpdateRequest.h"

@implementation HXBVersionUpdateRequest



/**
 版本更新

 @param versionCode app当前版本号
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)versionUpdateRequestWitversionCode:(NSString *)versionCode andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{
    NYBaseRequest *versionUpdateAPI = [[NYBaseRequest alloc] init];
    versionUpdateAPI.requestUrl = kHXBMY_VersionUpdateURL;
    versionUpdateAPI.requestMethod = NYRequestMethodGet;
    versionUpdateAPI.requestArgument = @{
                                            @"versionCode" : versionCode
                                        };
    [versionUpdateAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
        NSInteger status =  [responseObject[@"status"] integerValue];
        if (status != 0) {
            [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
            if (failureBlock) {
                failureBlock(responseObject);
            }
            return;
        }
        if (successDateBlock) {
            successDateBlock(responseObject);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        [HxbHUDProgress showTextWithMessage:@"请求失败"];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}
@end
