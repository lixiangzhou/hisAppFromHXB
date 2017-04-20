//
//  HxbSignInViewModel.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbSignInViewModel.h"
#import "LoginAPI.h"

@implementation HxbSignInViewModel

- (void)signInRequestWithUserName:(NSString *)userName Password:(NSString *)password SuccessBlock:(void(^)(NYBaseRequest *request, id responseObject))success FailureBlock:(void(^)(NYBaseRequest *request, NSError *error))failure{
//      [KeyChain removeToken];
    LoginAPI *loginApi = [[LoginAPI alloc] initWithUserName:userName loginPwd:password];
    [loginApi startAnimationWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
        if (success) {
            success(request,responseObject);
        }

    } failure:^(NYBaseRequest *request, NSError *error) {
        failure(request,error);
    }];
}
@end
