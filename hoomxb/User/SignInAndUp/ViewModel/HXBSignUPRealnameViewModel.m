//
//  HXBSignUPRealnameViewModel.m
//  hoomxb
//
//  Created by lxz on 2018/2/26.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBSignUPRealnameViewModel.h"
#import "HXBModifyTransactionPasswordAgent.h"

@implementation HXBSignUPRealnameViewModel

- (BOOL)erroResponseCodeDeal:(NYBaseRequest *)request {
    if ([request.requestUrl isEqual:kHXBSetTransaction_MobifyPassword_CheckIdentityAuthURL]) {
        return NO;
    }
    return [super erroResponseCodeDeal:request];
}

- (BOOL)erroStateCodeDeal:(NYBaseRequest *)request {
    if ([request.requestUrl isEqual:kHXBSetTransaction_MobifyPassword_CheckIdentityAuthURL]) {
        return NO;
    }
    return [super erroStateCodeDeal:request];
}

- (void)modifyTransactionPasswordWithIdCard:(NSString *)idCard resultBlock:(void(^)(BOOL isSuccess))resultBlock {
    kWeakSelf
    [HXBModifyTransactionPasswordAgent modifyTransactionPasswordWithRequestBlock:^(NYBaseRequest *request) {
        request.requestUrl = kHXBSetTransaction_MobifyPassword_CheckIdentityAuthURL;
        request.requestArgument =  @{ @"identity" : idCard };
        request.hudDelegate = weakSelf;
    } resultBlock:^(BOOL isSuccess, NSError *error) {
        if (isSuccess == NO) {
            NSDictionary *respObj = error.userInfo;
            
            if ([respObj isKindOfClass:[NSDictionary class]]) {
                if (respObj.statusCode != kHXBCode_Enum_RequestOverrun) {
                    [weakSelf showToast:@"请输入正确的身份证号"];
                }
            } else {
                [weakSelf showToast:@"请输入正确的身份证号"];
            }
        }
        resultBlock(isSuccess);
    }];
}

- (void)realNameWithUserName: (NSString *)userName identityCard: (NSString *)identityCard password: (NSString *)password resultBlock: (void(^)(BOOL isSuccess))resultBlock {
    
    NYBaseRequest *realnameApi = [[NYBaseRequest alloc]init];
    realnameApi.requestUrl = kHXBUser_realnameURL;
    realnameApi.requestMethod = NYRequestMethodPost;
    realnameApi.requestArgument = @{
                                    @"name" : userName,
                                    @"idCardNo" : identityCard,
                                    @"tradpwd" : password
                                    };
    
    [realnameApi loadData:^(NYBaseRequest *request, id responseObject) {
        if (resultBlock) {
            resultBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) {
            resultBlock(NO);
        }
    }];
    
}

@end
