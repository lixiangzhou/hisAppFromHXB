//
//  HXBAccountAlterLoginPasswordViewModel.m
//  hoomxb
//
//  Created by caihongji on 2018/3/1.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBAccountAlterLoginPasswordViewModel.h"

@implementation HXBAccountAlterLoginPasswordViewModel

- (void)mobifyPassword_LoginRequest_requestWithOldPwd: (NSString *)oldPassword
                                            andNewPwd: (NSString *)newPassword
                                      andSuccessBlock: (void(^)())successDateBlock
                                      andFailureBlock: (void(^)(NSError *error))failureBlock
{
    ///请求信息配置
    NYBaseRequest *mobifyPassword_LoginRequest = [[NYBaseRequest alloc] initWithDelegate:self];
    mobifyPassword_LoginRequest.requestUrl = kHXBSetUPAccount_MobifyPassword_LoginRequestURL;
    mobifyPassword_LoginRequest.requestMethod = NYRequestMethodPost;
    mobifyPassword_LoginRequest.requestArgument = @{
                                                    @"oldpwd" : oldPassword,//旧的按钮
                                                    @"newpwd" : newPassword
                                                    };
    mobifyPassword_LoginRequest.showHud = YES;
    [mobifyPassword_LoginRequest loadData:^(NYBaseRequest *request, id responseObject) {
        if (successDateBlock) successDateBlock();
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) failureBlock(error);
    }];
    
    
    
    
}

@end
