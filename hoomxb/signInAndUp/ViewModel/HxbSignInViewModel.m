//
//  HxbSignInViewModel.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbSignInViewModel.h"
#import "LoginAPI.h"
#import "LoginModel.h"
@implementation HxbSignInViewModel

- (void)signInRequestWithUserName:(NSString *)userName Password:(NSString *)password SuccessBlock:(void(^)(BOOL login,  NSString *message))success FailureBlock:(void(^)(NYBaseRequest *request, NSError *error))failure{
//      [KeyChain removeToken];
    LoginAPI *loginApi = [[LoginAPI alloc] initWithUserName:userName loginPwd:password];
    [loginApi startAnimationWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
        LoginModel *model = [LoginModel yy_modelWithJSON:responseObject];
        if (model.code == 0) {
            NSString *message = model.message;
            success(YES,message);
        }
//        model.
//        if (success) {
//            success(request,responseObject);
//        }

    } failure:^(NYBaseRequest *request, NSError *error) {
        failure(request,error);
    }];
}
@end
