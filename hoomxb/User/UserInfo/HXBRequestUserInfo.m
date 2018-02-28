//
//  HXBRequestUserInfo.m
//  hoomxb
//
//  Created by HXB on 2017/6/1.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
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

/**
 新增请求用户信息
 
 @param requestBlock 请求回调， 补充request的参数
 @param resultBlock 结果回调
 */
+ (void)downLoadUserInfoWithRequestBlock:(void(^)(NYBaseRequest* request)) requestBlock resultBlock:(void(^)(HXBRequestUserInfoViewModel *viewModel, NSError *error))resultBlock {
    
    NYBaseRequest *userInfoAPI = [[NYBaseRequest alloc]init];
    userInfoAPI.requestUrl = kHXBUser_UserInfoURL;
    userInfoAPI.requestMethod = NYRequestMethodGet;
    if(requestBlock) {
        requestBlock(userInfoAPI);
    }
    [userInfoAPI loadData:^(NYBaseRequest *request, id responseObject) {
        //对数据进行异步缓存
        [PPNetworkCache setHttpCache:responseObject URL:kHXBUser_UserInfoURL parameters:nil];
        HXBUserInfoModel *userInfoModel = [[HXBUserInfoModel alloc]init];
        
        [userInfoModel yy_modelSetWithDictionary:responseObject[@"data"]];
        
        HXBRequestUserInfoViewModel *viewModel = [[HXBRequestUserInfoViewModel alloc]init];
        viewModel.userInfoModel = userInfoModel;
        
        if (resultBlock) {
            resultBlock(viewModel, nil);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if(request.responseObject){
            error = [NSError errorWithDomain:@"" code:kHXBCode_CommonInterfaceErro userInfo:request.responseObject];
        }
        if (resultBlock) {
            resultBlock(nil, error);
        }
    }];
}
@end
