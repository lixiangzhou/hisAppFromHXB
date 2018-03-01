//
//  HXBSecurityCertificationViewModel.m
//  hoomxb
//
//  Created by hxb on 2018/2/27.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBSecurityCertificationViewModel.h"

@implementation HXBSecurityCertificationViewModel

- (void)securityCertification_RequestWithName: (NSString *)name
                                  andIdCardNo: (NSString *)idCardNo
                                   andTradpwd: (NSString *)tradpwd
                                       andURL: (NSString *)URL
                              andSuccessBlock: (void(^)(BOOL isExist))successBlock
                              andFailureBlock: (void(^)(NSError *error,NSString *message))failureBlock {
    
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestUrl = URL;
    request.requestMethod = NYRequestMethodPost;
    request.requestArgument = @{
                                @"username" : name,
                                @"name" : name,
                                @"idCardNo" : idCardNo,
                                @"identityCard" : idCardNo,
                                @"tradpwd" : tradpwd,
                                @"password" : tradpwd,
                                @"cashPassword" : tradpwd
                                };
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        if (successBlock) {
            successBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) {
            failureBlock(nil,@"实名认证请求失败");
        }
    }];
}

@end

