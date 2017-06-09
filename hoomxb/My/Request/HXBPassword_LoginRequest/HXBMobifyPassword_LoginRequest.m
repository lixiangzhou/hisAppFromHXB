//
//  HXBMobifyPassword_LoginRequest.m
//  hoomxb
//
//  Created by HXB on 2017/6/9.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//


#import "HXBMobifyPassword_LoginRequest.h"
#import "NYBaseRequest.h"//请求工具类
@implementation HXBMobifyPassword_LoginRequest
- (void)mobifyPassword_LoginRequest_requestWithOldPwd: (NSString *)oldPassword
                                            andNewPwd: (NSString *)newPassword
                                      andSuccessBlock: (void(^)())successDateBlock
                                      andFailureBlock: (void(^)(NSError *error))failureBlock
{
    ///请求信息配置
    NYBaseRequest *mobifyPassword_LoginRequest = [[NYBaseRequest alloc]init];
    mobifyPassword_LoginRequest.requestUrl = kHXBSetUPAccount_MobifyPassword_LoginRequestURL;
    mobifyPassword_LoginRequest.requestMethod = NYRequestMethodPost;
    mobifyPassword_LoginRequest.requestArgument = @{
                                                    @"oldpwd" : oldPassword,//旧的按钮
                                                    @"newpwd" : newPassword
                                                    };
    
    [mobifyPassword_LoginRequest startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        if ([responseObject valueForKey:@"status"]) {
            kNetWorkError(@"修改登录密码失败");
            if (failureBlock) failureBlock(nil);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        
    }];
    
    
    
    
}
@end
