//
//  HXBSignUPAndLoginAgent.m
//  hoomxb
//
//  Created by lxz on 2018/3/7.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBSignUPAndLoginAgent.h"

@implementation HXBSignUPAndLoginAgent

+ (void)checkExistMobileRequest:(void (^)(NYBaseRequest *request))requestBlock mobile:(NSString *)mobile resultBlock:(void(^)(BOOL isSuccess, NYBaseRequest *request))resultBlock {
    
    NYBaseRequest *checkMobileAPI = [[NYBaseRequest alloc]init];
    checkMobileAPI.requestMethod = NYRequestMethodPost;
    checkMobileAPI.requestUrl = kHXBUser_CheckExistMobileURL;
    checkMobileAPI.requestArgument = @{
                                       @"mobile":mobile
                                       };
    if (requestBlock) {
        requestBlock(checkMobileAPI);
    }
    
    [checkMobileAPI loadData:^(NYBaseRequest *request, id responseObject) {
        if (resultBlock) {
            resultBlock(YES, request);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) {
            resultBlock(NO, request);
        }
    }];
    
//    [checkMobileAPI loadData:^(NYBaseRequest *request, id responseObject) {
//        NSString *status = [responseObject valueForKey:@"status"];
//        if (status.integerValue == kHXBCode_Enum_CommonError) {
//            NSString *message = [responseObject[@"message"] isEqualToString:@"手机号码已存在"] ? @"该手机号已注册" : responseObject[@"message"];
//            [HxbHUDProgress showTextWithMessage:message];
//        }
//        if(successBlock) successBlock(!status.integerValue);
//
//    } failure:^(NYBaseRequest *request, NSError *error) {
//        if (failureBlock) failureBlock(error,nil);
//        kNetWorkError(@"校验手机号 请求失败");
//    }];
}

@end
