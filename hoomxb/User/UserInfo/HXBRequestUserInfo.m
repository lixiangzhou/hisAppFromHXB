//
//  HXBRequestUserInfo.m
//  hoomxb
//
//  Created by HXB on 2017/6/1.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRequestUserInfo.h"
#import "HXBBaseRequest.h"
@implementation HXBRequestUserInfo
///数据请求
+ (void) downLoadUserInfoWithSeccessBlock: (void(^)(HXBRequestUserInfoViewModel *viewModel))seccessBlock andFailure:(void(^)(NSError *error))failureBlock {
     HXBBaseRequest *userInfoAPI = [[HXBBaseRequest alloc]init];
    userInfoAPI.requestUrl = kHXBUser_CheckMobileURL;
    userInfoAPI.requestMethod = NYRequestMethodGet;
    
    [userInfoAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        kHXBResponsShowHUD
        HXBUserInfoModel *userInfoModel = [[HXBUserInfoModel alloc]init];
        [userInfoModel yy_modelSetWithDictionary:responseObject[@"data"]];
        
        HXBRequestUserInfoViewModel *viewModel = [[HXBRequestUserInfoViewModel alloc]init];
        viewModel.userInfoModel = userInfoModel;
        
        if (seccessBlock) {
            seccessBlock(viewModel);
        }
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
        kNetWorkError(@"用户请求失败");
    }];
}
@end
