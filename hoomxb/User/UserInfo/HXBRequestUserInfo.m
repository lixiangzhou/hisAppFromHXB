//
//  HXBRequestUserInfo.m
//  hoomxb
//
//  Created by HXB on 2017/6/1.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRequestUserInfo.h"
#import "HXBBaseRequest.h"

#define kHXBUser_signOutURL @"/logout"
@implementation HXBRequestUserInfo

+ (void)signOut {
    HXBBaseRequest *request = [[HXBBaseRequest alloc]init];
    request.requestUrl = kHXBUser_signOutURL;
    request.requestMethod = NYRequestMethodPost;
    [request startWithSuccess:^(HXBBaseRequest *request, id responseObject) {
    } failure:^(HXBBaseRequest *request, NSError *error) {
    }];
}

///数据请求
+ (void) downLoadUserInfoWithSeccessBlock: (void(^)(HXBRequestUserInfoViewModel *viewModel))seccessBlock andFailure:(void(^)(NSError *error))failureBlock {
    HXBBaseRequest *userInfoAPI = [[HXBBaseRequest alloc]init];
    userInfoAPI.requestUrl = kHXBUser_UserInfoURL;
    userInfoAPI.requestMethod = NYRequestMethodGet;
    [userInfoAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        if ([responseObject[kResponseStatus] integerValue]) {
            kHXBResponsShowHUD
        }
//        NSLog(@"%@",responseObject);
//        NSLog(@"%@",[KeyChain token]);
        HXBUserInfoModel *userInfoModel = [[HXBUserInfoModel alloc]init];
        
        [userInfoModel yy_modelSetWithDictionary:responseObject[@"data"]];
        
        HXBRequestUserInfoViewModel *viewModel = [[HXBRequestUserInfoViewModel alloc]init];
        viewModel.userInfoModel = userInfoModel;
        
        if (seccessBlock) {
            seccessBlock(viewModel);
        }
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        NSLog(@"%@",error);
        if (failureBlock) {
            failureBlock(error);
        }
        kNetWorkError(@"用户请求失败");
    }];
}
@end
