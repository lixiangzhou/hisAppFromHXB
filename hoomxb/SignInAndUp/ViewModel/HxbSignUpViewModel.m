//
//  HxbSignUpViewModel.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/2.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbSignUpViewModel.h"
#import "SignUpAPI.h"
#import "SignUpModel.h"

@implementation HxbSignUpViewModel
- (void)signUpRequestSuccessBlock:(void(^)(BOOL signupSuccess,  NSString *message))success FailureBlock:(void(^)(NYBaseRequest *request, NSError *error))failure{
    SignUpAPI *signUpApi = [[SignUpAPI alloc]init];
    [signUpApi startAnimationWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
        SignUpModel *model = [SignUpModel yy_modelWithJSON:responseObject];
        if (model.code == 0) {
            NSString *message = model.message;
            if (success) success(true,message);
        }
        //        model.
        //        if (success) {
        //            success(request,responseObject);
        //        }
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failure) failure(request,error);
    }];

}
@end
