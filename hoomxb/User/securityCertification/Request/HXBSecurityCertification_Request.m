//
//  HXBSecurityCertification_Request.m
//  hoomxb
//
//  Created by HXB on 2017/6/22.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBSecurityCertification_Request.h"
#import "HXBBaseRequest.h"
#define kHXBUser_SecureURL @"/account/secure"

@implementation HXBSecurityCertification_Request
+ (void)securityCertification_RequestWithName: (NSString *)name
                                  andIdCardNo: (NSString *)idCardNo
                                   andTradpwd: (NSString *)tradpwd
                              andSuccessBlock: (void(^)(BOOL isExist))successBlock
                              andFailureBlock: (void(^)(NSError *error,NSString *message))failureBlock {
    
    HXBBaseRequest *request = [[HXBBaseRequest alloc]init];
    request.requestUrl = kHXBUser_SecureURL;
    request.requestMethod = NYRequestMethodPost;
    request.requestArgument = @{
                                @"name" : name,
                                @"idCardNo" : idCardNo,
                                @"tradpwd" : tradpwd
                                };
    [request startWithSuccess:^(HXBBaseRequest *request, id responseObject) {
        
        NSString *message = responseObject[kResponseMessage];
        if ([responseObject[kResponseStatus] integerValue] == 1) {
            if (failureBlock) {
                [HxbHUDProgress showTextWithMessage:message];
                failureBlock(nil,message);
            }
            
            NSLog(@"用户已经进行过实名认证。");
            return;
        }
        if (successBlock) {
            successBlock(true);
        }
        
    } failure:^(HXBBaseRequest *request, NSError *error) {
        if (failureBlock) {
            failureBlock(nil,@"实名认证请求失败");
        }
    }];
}


@end
